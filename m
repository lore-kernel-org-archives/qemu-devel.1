Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0631774a38=bala24@linux.vnet.ibm.com>)
	id 1f3Pjb-00044K-8Z
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0631774a38=bala24@linux.vnet.ibm.com>)
	id 1f3PjY-0005Pi-0j
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:28:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0631774a38=bala24@linux.vnet.ibm.com>)
	id 1f3PjX-0005NO-OO
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:28:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w33HSOEI024501
	for <qemu-devel@nongnu.org>; Tue, 3 Apr 2018 13:28:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4b6mhdvw-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 13:28:32 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 3 Apr 2018 13:28:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Apr 2018 23:00:00 +0530
From: bala24 <bala24@linux.vnet.ibm.com>
In-Reply-To: <20180403061040.GD26441@xz-mi>
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
	<20180403061040.GD26441@xz-mi>
Message-Id: <4b9793192f7007913e7fb9bb210524fb@linux.vnet.ibm.com>
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
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

On 2018-04-03 11:40, Peter Xu wrote:
> On Sun, Apr 01, 2018 at 12:25:36AM +0530, Balamuruhan S wrote:
>> expected_downtime value is not accurate with dirty_pages_rate * 
>> page_size,
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
>> @@ -2245,8 +2245,7 @@ static void 
>> migration_update_counters(MigrationState *s,
>>       * recalculate. 10000 is a small enough number for our purposes
>>       */
>>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
>> -        s->expected_downtime = ram_counters.dirty_pages_rate *
>> -            qemu_target_page_size() / bandwidth;
>> +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
> 
> This field was removed in e4ed1541ac ("savevm: New save live migration
> method: pending", 2012-12-20), in which remaing RAM was used.
> 
> And it was added back in 90f8ae724a ("migration: calculate
> expected_downtime", 2013-02-22), in which dirty rate was used.
> 
> However I didn't find a clue on why we changed from using remaining
> RAM to using dirty rate...  So I'll leave this question to Juan.
> 
> Besides, I'm a bit confused on when we'll want such a value.  AFAIU
> precopy is mostly used by setting up the target downtime before hand,
> so we should already know the downtime before hand.  Then why we want
> to observe such a thing?

Thanks Peter Xu for reviewing,

I tested precopy migration with 16M hugepage backed ppc guest and 
granularity
of page size in migration is 4K so any page dirtied would result in 4096 
pages
to be transmitted again, this led for migration to continue endless,

default migrate_parameters:
downtime-limit: 300 milliseconds

info migrate:
expected downtime: 1475 milliseconds

Migration status: active
total time: 130874 milliseconds
expected downtime: 1475 milliseconds
setup: 3475 milliseconds
transferred ram: 18197383 kbytes
throughput: 866.83 mbps
remaining ram: 376892 kbytes
total ram: 8388864 kbytes
duplicate: 1678265 pages
skipped: 0 pages
normal: 4536795 pages
normal bytes: 18147180 kbytes
dirty sync count: 6
page size: 4 kbytes
dirty pages rate: 39044 pages

In order to complete migration I configured downtime-limit to 1475
milliseconds but still migration was endless. Later calculated expected
downtime by remaining ram 376892 Kbytes / 866.83 mbps yeilded 3478.34
milliseconds and configuring it as downtime-limit succeeds the migration
to complete. This led to the conclusion that expected downtime is not
accurate.

Regards,
Balamuruhan S

> 
> Thanks,
