Received: from eggs.gnu.org ([2001:4830:134:3::10]:51230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnUoS-0005A4-6N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnUoN-0000Q9-1h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnUoM-0000Pr-QE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:35:14 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9C19C1F47F8
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 18:35:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170313171214.GO4799@redhat.com> (Daniel P. Berrange's message
	of "Mon, 13 Mar 2017 17:12:14 +0000")
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-8-quintela@redhat.com>
	<20170313163429.GK4799@redhat.com> <87o9x5unns.fsf@secure.mitica>
	<20170313171214.GO4799@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Mar 2017 19:35:12 +0100
Message-ID: <87bmt5uisf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/16] migration: Create x-multifd-group
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 05:49:59PM +0100, Juan Quintela wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>> > On Mon, Mar 13, 2017 at 01:44:25PM +0100, Juan Quintela wrote:
>> >> Indicates how many pages we are going to send in each bach to a multifd
>> >> thread.
>> >
>> >
>> >> diff --git a/qapi-schema.json b/qapi-schema.json
>> >> index b7cb26d..33a6267 100644
>> >> --- a/qapi-schema.json
>> >> +++ b/qapi-schema.json
>> >> @@ -988,6 +988,9 @@
>> >>  # @x-multifd-threads: Number of threads used to migrate data in parallel
>> >>  #                     The default value is 2 (since 2.9)
>> >>  #
>> >> +# @x-multifd-group: Number of pages sent together to a thread
>> >> +#                     The default value is 16 (since 2.9)
>> >> +#
>> >>  # Since: 2.4
>> >>  ##
>> >>  { 'enum': 'MigrationParameter',
>> >> @@ -995,7 +998,7 @@
>> >>             'cpu-throttle-initial', 'cpu-throttle-increment',
>> >>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>> >>             'downtime-limit', 'x-checkpoint-delay',
>> >> -           'x-multifd-threads'] }
>> >> +           'x-multifd-threads', 'x-multifd-group'] }
>> >>  
>> >>  ##
>> >>  # @migrate-set-parameters:
>> >> @@ -1062,6 +1065,9 @@
>> >>  # @x-multifd-threads: Number of threads used to migrate data in parallel
>> >>  #                     The default value is 2 (since 2.9)
>> >>  #
>> >> +# @x-multifd-group: Number of pages sent together in a bunch
>> >> +#                     The default value is 16 (since 2.9)
>> >> +#
>> >
>> > How is this parameter supposed to be used ? Or to put it another way,
>> > what are the benefits / effects of changing it from its default
>> > value and can an application usefully decide what value to set ? I'm
>> > loathe to see us expose another "black magic" parameter where you can't
>> > easily determine what values to set, without predicting future guest
>> > workloads
>> 
>> We have multiple threads, we can send to each thread the number of pages
>> that it needs to send one by one, two by two, n x n.  The bigger the
>> number, the less locking to do, and then less contention.  But if it is
>> too big, we could probably end with too few distribution.  Reason to add
>> this parameter is that if we send page by page, we end spending too much
>> time in locking.
>
> The question is how is an application like OpenStack / oVirt supposed to
> know what the right number of pages is to get the right tradeoff between
> lock contention & distribution ? Lock contention may well change over
> time as the QEMU impl is improved, so the right answer for setting this
> parameter might vary depending on QEMU version.  IMHO, you should just
> pick a sensible default value and not expose this to applications.

It is still a x-<field>.  It is good for testing.  I agree that if there
is a sensible default, we should stick with it.

Thanks, Juan.
