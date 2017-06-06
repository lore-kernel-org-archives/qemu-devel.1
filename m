Received: from eggs.gnu.org ([2001:4830:134:3::10]:37687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIIay-0000C2-V3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIIav-0002CJ-2X
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIIau-0002CD-Sm
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8455C0587E2
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:48:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com> (Eric Blake's
	message of "Fri, 2 Jun 2017 10:15:41 -0500")
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-4-quintela@redhat.com>
	<6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 06 Jun 2017 19:48:35 +0200
Message-ID: <87a85l57nw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Print statistics about the
 number of remaining target pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 06/01/2017 05:08 PM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 4 +++-
>>  migration/ram.c       | 4 ++--
>>  migration/ram.h       | 2 +-
>>  qapi-schema.json      | 6 +++++-
>>  4 files changed, 11 insertions(+), 5 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index ea3d41c..2c13217 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -518,7 +518,9 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>>      }
>>  
>>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>> -        info->ram->remaining = ram_bytes_remaining();
>> +        info->ram->remaining_pages = ram_pages_remaining();
>> +        info->ram->remaining = ram_pages_remaining() *
>> +            qemu_target_page_size();
>
> Why not the opposite direction, of:
>
> info->ram->remaining_pages = ram_bytes_remaining() /
> qemu_target_page_size();
> info->ram->remaining = ram_bytes_remaining();
>
> ?
>
>> +++ b/migration/ram.h
>> @@ -41,7 +41,7 @@ uint64_t xbzrle_mig_pages_cache_miss(void);
>>  double xbzrle_mig_cache_miss_rate(void);
>>  uint64_t xbzrle_mig_pages_overflow(void);
>>  uint64_t ram_bytes_transferred(void);
>> -uint64_t ram_bytes_remaining(void);
>> +uint64_t ram_pages_remaining(void);
>>  uint64_t ram_dirty_sync_count(void);
>>  uint64_t ram_dirty_pages_rate(void);
>>  uint64_t ram_postcopy_requests(void);
>
> I know we already have a mishmash of which interfaces are byte-based vs.
> page-based, but using byte-based everywhere seems like a better goal,
> and this feels like we are going backwards from that goal.

Ok, just dropped this bit.

And let the rest of the series the same.

Later, Juan.
