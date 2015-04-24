# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

def random_petition
  rand_id = rand(Petition.count)
  Petition.where("id >= :rand_id", {rand_id: rand_id}).first
end

start = Time.now
total_signatures = 0

100.times do |petition|
    signature_count = rand(10000)
    petition = random_petition
    puts "Adding #{signature_count} signatures to #{petition.name}"
    total_signatures += signature_count

    puts petition.status
    #  Only add signatures to live
    next if not petition.status == "live"

    signature_count.times do |count|

      if count.modulo(100).zero?
        puts count
      end

      #signature = NewSignature.create({
      signature = Signature.create({
        :petition_id => petition[:id],
        :person_name => Faker::Name.name,
        :person_email => Faker::Internet.free_email(@person_name),
        :person_city => Faker::Address.city,
        :visible => rand(10) > 8 ? true: false,
        :special => rand(100000) > 99990 ? true: false,
        :subscribe => rand(2) > 1 ? true: false,
        :created_at => Faker::Time.between(20.days.ago, Time.now, :morning),
        :updated_at => Faker::Time.between(10.days.ago, Time.now, :afternoon),
        :signed_at => Faker::Time.between(20.days.ago, Time.now, :evening),
        :confirmed_at => Faker::Time.between(20.days.ago, Time.now),
        :confirmed => rand(10) > 8 ? true: false,
        #:description => Faker::Lorem.sentence,
      })
      signature.save
    end
end

puts Time.now - start, total_signatures
