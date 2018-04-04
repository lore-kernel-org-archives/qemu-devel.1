Received: from eggs.gnu.org ([2001:4830:134:3::10]:59077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f3eK4-00082R-T5
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f3eJy-0007sA-Ud
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:03:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1f3eJy-0007rz-QL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:03:10 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180403061040.GD26441@xz-mi> (Peter Xu's message of "Tue, 3 Apr
	2018 14:10:40 +0800")
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
	<20180403061040.GD26441@xz-mi>
Reply-To: quintela@redhat.com
Date: Wed, 04 Apr 2018 11:02:56 +0200
Message-ID: <87zi2jz6m7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, qemu-devel@nongnu.org, amit.shah@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Sun, Apr 01, 2018 at 12:25:36AM +0530, Balamuruhan S wrote:
>> expected_downtime value is not accurate with dirty_pages_rate * page_size,
>> using ram_bytes_remaining would yeild it correct.
>> 
>> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> ---
>>  migration/migration.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 58bd382730..4e43dc4f92 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2245,8 +2245,7 @@ static void migration_update_counters(MigrationState *s,
>>       * recalculate. 10000 is a small enough number for our purposes
>>       */
>>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
>> -        s->expected_downtime = ram_counters.dirty_pages_rate *
>> -            qemu_target_page_size() / bandwidth;
>> +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
>
> This field was removed in e4ed1541ac ("savevm: New save live migration
> method: pending", 2012-12-20), in which remaing RAM was used.

Unrelated O:-)

> And it was added back in 90f8ae724a ("migration: calculate
> expected_downtime", 2013-02-22), in which dirty rate was used.

We didn't want to update the field if there haven't been enough activity.

> However I didn't find a clue on why we changed from using remaining
> RAM to using dirty rate...  So I'll leave this question to Juan.
>
> Besides, I'm a bit confused on when we'll want such a value.  AFAIU
> precopy is mostly used by setting up the target downtime before hand,
> so we should already know the downtime before hand.  Then why we want
> to observe such a thing?

What that field means is how much time the system needs to send
everything that is pending.

I.e. if expected_downtime = 2seconds, it means that with current dirty
rate, if we set a downtime of 2 or bigger it is going to finish
migration.

It is a help for upper layers to decide that:
- they want a 1second downtime
- system calculates with current load that they need a 2second downtime

So they can decide:
- change the downtime to 2seconds (easy)
- change the apps running on the guest to dirty less memory (It dependes
  on the guest, app, etc).

I don't know if anyone is using it at all.

Later, Juan.
