Received: from eggs.gnu.org ([2001:4830:134:3::10]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1fYL1i-0003WE-M2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1fYL1d-0000hg-Lq
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:43:10 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:40417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liliang.opensource@gmail.com>)
	id 1fYL1d-0000gW-CB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:43:05 -0400
Received: by mail-pl0-x236.google.com with SMTP id t6-v6so1849062plo.7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 17:43:04 -0700 (PDT)
From: Liang Li <liliang.opensource@gmail.com>
Date: Thu, 28 Jun 2018 08:42:57 +0800
Message-ID: <20180628004254.GA27504@localhost>
References: <CAJhGHyAMGjZe+QR3BQtA1cVxkz=isQbx6kWjNR6fa5LmW3rQUg@mail.gmail.com>
	<20180416150011.55916-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416150011.55916-1-jiangshanlai@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V5] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peng Tao <bergwolf@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Mon, Apr 16, 2018 at 11:00:11PM +0800, Lai Jiangshan wrote:
> 
>  migration/migration.c | 22 ++++++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/ram.c       | 27 ++++++++++++++++++---------
>  qapi/migration.json   |  6 +++++-
>  4 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 52a5092add..110b40f6d4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -736,6 +736,19 @@ static bool migrate_caps_check(bool *cap_list,
>              return false;
>          }
>  
> +        if (cap_list[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY]) {
> +            /* Bypass and postcopy are quite conflicting ways
> +             * to get memory in the destination.  And there
> +             * is not code to discriminate the differences and
> +             * handle the conflicts currently.  It should be possible
> +             * to fix, but it is generally useless when both ways
> +             * are used together.
> +             */
> +            error_setg(errp, "Bypass is not currently compatible "
> +                       "with postcopy");
> +            return false;
> +        }
> +
>          /* This check is reasonably expensive, so only when it's being
>           * set the first time, also it's only the destination that needs
>           * special support.
> @@ -1509,6 +1522,15 @@ bool migrate_release_ram(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
>  }
>  
> +bool migrate_bypass_shared_memory(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY];
> +}
> +
>  bool migrate_postcopy_ram(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 8d2f320c48..cfd2513ef0 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -206,6 +206,7 @@ MigrationState *migrate_get_current(void);
>  
>  bool migrate_postcopy(void);
>  
> +bool migrate_bypass_shared_memory(void);
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 0e90efa092..bca170c386 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -780,6 +780,11 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>      unsigned long *bitmap = rb->bmap;
>      unsigned long next;
>  
> +    /* when this ramblock is requested bypassing */
> +    if (!bitmap) {
> +        return size;
> +    }
> +
>      if (rs->ram_bulk_stage && start > 0) {
>          next = start + 1;
>      } else {
> @@ -850,7 +855,9 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      RAMBLOCK_FOREACH(block) {
> -        migration_bitmap_sync_range(rs, block, 0, block->used_length);
> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
> +            migration_bitmap_sync_range(rs, block, 0, block->used_length);
> +        }
>      }
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
> @@ -2132,18 +2139,12 @@ static int ram_state_init(RAMState **rsp)
>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>  
> -    /*
> -     * Count the total number of pages used by ram blocks not including any
> -     * gaps due to alignment or unplugs.
> -     */
> -    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
> -
>      ram_state_reset(*rsp);
>  
>      return 0;
>  }
>  
> -static void ram_list_init_bitmaps(void)
> +static void ram_list_init_bitmaps(RAMState *rs)
>  {
>      RAMBlock *block;
>      unsigned long pages;
> @@ -2151,9 +2152,17 @@ static void ram_list_init_bitmaps(void)
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +            if (migrate_bypass_shared_memory() && qemu_ram_is_shared(block)) {
> +                continue;
> +            }
>              pages = block->max_length >> TARGET_PAGE_BITS;
>              block->bmap = bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> +            /*
> +             * Count the total number of pages used by ram blocks not
> +             * including any gaps due to alignment or unplugs.
> +             */
> +            rs->migration_dirty_pages += pages;
Hi Jiangshan,

I think you should use 'block->used_length >> TARGET_PAGE_BITS' instead of pages
here.

As I have said before, we should skip dirty logging the related operations of
the shared memory to speed up the live migration process, and more important,
skipping dirty log can avoid splitting the EPT entry from 2M/1G to 4K if transparent
hugpage is used, and thus avoid performance degradation after migration. 

Some other things we should pay attention to is that some virtio devices may
change the vring status when the source qemu process exit, we have some find
in the previous version of QEMU, e.g. 2.6.


thanks!
Liang

>              if (migrate_postcopy_ram()) {
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
> @@ -2169,7 +2178,7 @@ static void ram_init_bitmaps(RAMState *rs)
>      qemu_mutex_lock_ramlist();
>      rcu_read_lock();
>  
> -    ram_list_init_bitmaps();
> +    ram_list_init_bitmaps(rs);
>      memory_global_dirty_log_start();
>      migration_bitmap_sync(rs);
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9d0bf82cf4..45326480bd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -357,13 +357,17 @@
>  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>  #                 (since 2.12)
>  #
> +# @bypass-shared-memory: the shared memory region will be bypassed on migration.
> +#          This feature allows the memory region to be reused by new qemu(s)
> +#          or be migrated separately. (since 2.13)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> -           'dirty-bitmaps' ] }
> +           'dirty-bitmaps', 'bypass-shared-memory' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.15.1 (Apple Git-101)
> 
> 
