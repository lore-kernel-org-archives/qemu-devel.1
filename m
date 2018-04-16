Received: from eggs.gnu.org ([2001:4830:134:3::10]:49939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f8D0u-0002pn-7M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f8D0s-0006Sv-UD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:54:20 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1f8D0s-0006SJ-Mq
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 18:54:18 -0400
Received: by mail-io0-x242.google.com with SMTP id g9so1342548iob.11
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 15:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409173003.GI2449@work-vm>
References: <20180401084848.36725-1-jiangshanlai@gmail.com>
	<20180404114709.45118-1-jiangshanlai@gmail.com>
	<20180409173003.GI2449@work-vm>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 17 Apr 2018 06:54:17 +0800
Message-ID: <CAJhGHyBU7w-5dfTXq6cOqsQs8mzKDpP20BE+mrx7kM=Qe5ooJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V4] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Tue, Apr 10, 2018 at 1:30 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

>>
>> +bool migrate_bypass_shared_memory(void)
>> +{
>> +    MigrationState *s;
>> +
>> +    /* it is not workable with postcopy yet. */
>> +    if (migrate_postcopy_ram()) {
>> +        return false;
>> +    }
>
> Please change this to work in the same way as the check for
> postcopy+compress in migration.c migrate_caps_check.


done in V5.

>
>> +    s = migrate_get_current();
>> +
>> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY];
>> +}
>> +
>>  bool migrate_postcopy_ram(void)
>>  {
>>      MigrationState *s;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 8d2f320c48..cfd2513ef0 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -206,6 +206,7 @@ MigrationState *migrate_get_current(void);
>>
>>  bool migrate_postcopy(void);
>>
>> +bool migrate_bypass_shared_memory(void);
>>  bool migrate_release_ram(void);
>>  bool migrate_postcopy_ram(void);
>>  bool migrate_zero_blocks(void);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 0e90efa092..bca170c386 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -780,6 +780,11 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>      unsigned long *bitmap = rb->bmap;
>>      unsigned long next;
>>
>> +    /* when this ramblock is requested bypassing */
>> +    if (!bitmap) {
>> +        return size;
>> +    }
>> +
>>      if (rs->ram_bulk_stage && start > 0) {
>>          next = start + 1;
>>      } else {
>> @@ -850,7 +855,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH(block) {
>> -        migration_bitmap_sync_range(rs, block, 0, block->used_length);
>> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
>> +            migration_bitmap_sync_range(rs, block, 0, block->used_length);
>> +        }
>>      }
>>      rcu_read_unlock();
>>      qemu_mutex_unlock(&rs->bitmap_mutex);
>> @@ -2132,18 +2139,12 @@ static int ram_state_init(RAMState **rsp)
>>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>>
>> -    /*
>> -     * Count the total number of pages used by ram blocks not including any
>> -     * gaps due to alignment or unplugs.
>> -     */
>> -    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>> -
>>      ram_state_reset(*rsp);
>>
>>      return 0;
>>  }
>>
>> -static void ram_list_init_bitmaps(void)
>> +static void ram_list_init_bitmaps(RAMState *rs)
>>  {
>>      RAMBlock *block;
>>      unsigned long pages;
>> @@ -2151,9 +2152,17 @@ static void ram_list_init_bitmaps(void)
>>      /* Skip setting bitmap if there is no RAM */
>>      if (ram_bytes_total()) {
>
> I think you need to add here a :
>    rs->migration_dirty_pages = 0;

In ram_state_init(),
*rsp = g_try_new0(RAMState, 1);
so the state is always reset.

>
> I don't see anywhere else that initialises it, and there is the case of
> a migration that fails, followed by a 2nd attempt.
>
>>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +            if (migrate_bypass_shared_memory() && qemu_ram_is_shared(block)) {
>> +                continue;
>> +            }
>>              pages = block->max_length >> TARGET_PAGE_BITS;
>>              block->bmap = bitmap_new(pages);
>>              bitmap_set(block->bmap, 0, pages);
>> +            /*
>> +             * Count the total number of pages used by ram blocks not
>> +             * including any gaps due to alignment or unplugs.
>> +             */
>> +            rs->migration_dirty_pages += pages;
>>              if (migrate_postcopy_ram()) {
>>                  block->unsentmap = bitmap_new(pages);
>>                  bitmap_set(block->unsentmap, 0, pages);
>> @@ -2169,7 +2178,7 @@ static void ram_init_bitmaps(RAMState *rs)
>>      qemu_mutex_lock_ramlist();
>>      rcu_read_lock();
>>
>> -    ram_list_init_bitmaps();
>> +    ram_list_init_bitmaps(rs);
>>      memory_global_dirty_log_start();
>>      migration_bitmap_sync(rs);
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 9d0bf82cf4..45326480bd 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -357,13 +357,17 @@
>>  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>>  #                 (since 2.12)
>>  #
>> +# @bypass-shared-memory: the shared memory region will be bypassed on migration.
>> +#          This feature allows the memory region to be reused by new qemu(s)
>> +#          or be migrated separately. (since 2.13)
>> +#
>>  # Since: 1.2
>>  ##
>>  { 'enum': 'MigrationCapability',
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>>             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
>> -           'dirty-bitmaps' ] }
>> +           'dirty-bitmaps', 'bypass-shared-memory' ] }
>>
>>  ##
>>  # @MigrationCapabilityStatus:
>> --
>> 2.14.3 (Apple Git-98)
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
