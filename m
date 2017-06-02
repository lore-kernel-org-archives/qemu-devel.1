Received: from eggs.gnu.org ([2001:4830:134:3::10]:35003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGpYl-0000sS-5i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGpYj-0007IN-DV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGpYj-0007HY-50
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A74A85365
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 16:36:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com> (Eric Blake's
	message of "Fri, 2 Jun 2017 10:15:41 -0500")
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-4-quintela@redhat.com>
	<6d275b7f-5f31-0f41-21e4-4d1abe96d7f7@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 02 Jun 2017 18:36:16 +0200
Message-ID: <87y3tas5xb.fsf@secure.mitica>
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

On migration, everything is on pages (TARGET_PAGE_SIZE).  It is the real
unit and the easier to calculate.  So, we can have:
- number of dirty pages independent of the statistics
  notice that migration code really use that number, it don't use almost
  none of the others.
- put number of dirty bytes and be dividing/multiplying all around
- change the statistics and also print the number of bytes.

I know that you are changing the interfaces for block devices to be byte
based, but (I guess) you have more options of sector size.  On
migration, everything is on TARGET_PAGE_SIZE, or multiples, and the code
of multiples is not clear that works in all cases :-(

I.e. I am not sure that everything works when you had a 4kb guest on a
64 kb host (or the other way around).

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

On migration, the only one that is really byte based is the compression
one and the xbzrle one, because they don't use multiple of target page
size.  The other ones are indiferent.


>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 4b50b65..ff1c048 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -601,6 +601,9 @@
>>  # @page-size: The number of bytes per page for the various page-based
>>  #        statistics (since 2.10)
>>  #
>> +# @remaining-pages: amount of pages remaining to be transferred to the target VM
>> +#        (since 2.10)
>> +#
>>  # Since: 0.14.0
>>  ##
>>  { 'struct': 'MigrationStats',
>> @@ -608,7 +611,8 @@
>>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>>             'mbps' : 'number', 'dirty-sync-count' : 'int',
>> -           'postcopy-requests' : 'int', 'page-size' : 'int' } }
>> +           'postcopy-requests' : 'int', 'page-size' : 'int',
>> +           'remaining-pages' : 'int' } }
>
> We already have 'remaining'; why do we need a redundant stat
> 'remaining-pages'?

See next patch.  I have that other stat, or I have to use a different
place for statistics for dirty number of pages.  Notice that it kind of
make sense because that is the only stat that is used for migration
code.

So far:
- I can't be consistent, there are already things that are on bytes, and
  things that are on target_page_size
- All stats can be used on Migration stats *except* for dirty number of
  pages.

As far as I know:
- I can export the number of remaining pages, like this patch does
  (information is reduntdant, but that already happens, notice 'normal':
  number of pages, and 'normal-bytes': number of bytes).
- I can have the dirty_number_pages as a different variable in
  ram_stats, so it don't feel like the other counters.

As far as I can see one way is bad and the other is worse, none is good.
For me this movement makes it a bit more consistent, but the difference
is not big.

Suggestions?

Independently of this patch, that is for statistics, in migration code
it is more natural to use pages, otherwise we need to be dividing the
"offset" between the page size, as the basic unit is the dirty bitmap
that is in pages.

Later, Juan.
