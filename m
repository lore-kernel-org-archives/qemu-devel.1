Received: from eggs.gnu.org ([2001:4830:134:3::10]:58519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cYBfD-0002Ka-0A
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cYBf7-0005jG-VG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:06:30 -0500
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:35808
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cYBf7-0005iA-C3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:06:25 -0500
References: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
	<20170116155113.21034-3-pbutsykin@virtuozzo.com>
	<20170127113947.GC3323@work-vm>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <588F3A49.4040202@virtuozzo.com>
Date: Mon, 30 Jan 2017 16:06:17 +0300
MIME-Version: 1.0
In-Reply-To: <20170127113947.GC3323@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: discard non-dirty ram pages
 after the start of postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, amit.shah@redhat.com, den@openvz.org

On 27.01.2017 14:39, Dr. David Alan Gilbert wrote:
> * Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
>> After the start of postcopy migration there are some non-dirty pages which have
>> already been migrated. These pages are no longer needed on the source vm so that
>> we can free them and it doen't hurt to complete the migration.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   include/migration/migration.h |  1 +
>>   migration/migration.c         |  2 ++
>>   migration/ram.c               | 25 +++++++++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index d7bd404365..0d9b81545c 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -279,6 +279,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
>>   int ram_discard_range(MigrationIncomingState *mis, const char *block_name,
>>                         uint64_t start, size_t length);
>>   int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>> +void ram_postcopy_migrated_memory_discard(MigrationState *ms);
>>
>>   /**
>>    * @migrate_add_blocker - prevent migration from proceeding
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 391db6f28b..20490ed020 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1662,6 +1662,8 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>>        */
>>       qemu_savevm_send_ping(ms->to_dst_file, 4);
>>
>> +    ram_postcopy_migrated_memory_discard(ms);
>> +
>
> Did you intend this to be selected based on your capability flag?
>

I did, but apparently lost..

>
>>       ret = qemu_file_get_error(ms->to_dst_file);
>>       if (ret) {
>>           error_report("postcopy_start: Migration stream errored");
>> diff --git a/migration/ram.c b/migration/ram.c
>> index b0322a0b5c..8a6b614b0d 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1546,6 +1546,31 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
>>
>>   /* **** functions for postcopy ***** */
>>
>> +void ram_postcopy_migrated_memory_discard(MigrationState *ms)
>> +{
>> +    struct RAMBlock *block;
>> +    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
>> +
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        unsigned long first = block->offset >> TARGET_PAGE_BITS;
>> +        unsigned long range = first + (block->used_length >> TARGET_PAGE_BITS);
>> +        unsigned long run_start = find_next_zero_bit(bitmap, range, first);
>> +
>> +        while (run_start < range) {
>> +            unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
>> +            uint8_t *addr = block->host + (run_start << TARGET_PAGE_BITS);
>> +            size_t chunk_size = (run_end - run_start) << TARGET_PAGE_BITS;
>> +
>> +            if (qemu_madvise(addr, chunk_size, QEMU_MADV_DONTNEED) < 0) {
>> +                error_report("migrate: madvise DONTNEED failed %p %ld: %s",
>> +                             addr, chunk_size, strerror(errno));
>> +            }
>
> can you use your ram_discard_page here, it keeps all the use of madvise together.

ok.

>> +
>> +            run_start = find_next_zero_bit(bitmap, range, run_end + 1);
>> +        }
>> +    }
>> +}
>
> Dave
>
>>   /*
>>    * Callback from postcopy_each_ram_send_discard for each RAMBlock
>>    * Note: At this point the 'unsentmap' is the processed bitmap combined
>> --
>> 2.11.0
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
