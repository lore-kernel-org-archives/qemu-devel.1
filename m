Received: from eggs.gnu.org ([209.51.188.92]:46122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtAxp-0000Df-Fa
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtAxn-0000ON-5n
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtAxl-0000Mc-1M
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:45:29 -0500
Date: Mon, 11 Feb 2019 12:45:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190211124519.GD2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-3-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204130958.18904-3-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] migration: Introduce ignore-shared
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, wrfsh@yandex-team.ru

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> We want to use local migration to update QEMU for running guests.
> In this case we don't need to migrate shared (file backed) RAM.
> So, add a capability to ignore such blocks during live migration.
> 
> Also, move qemu_ram_foreach_migratable_block (and rename) to the
> migration code, because it requires access to the migration capabilities.
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

You could split this patch into the one that introduces the capability
and then the one that wires it up.  We could also remove the x- at some
point.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  exec.c                    |  19 -------
>  include/exec/cpu-common.h |   1 -
>  migration/migration.c     |   9 ++++
>  migration/migration.h     |   5 +-
>  migration/postcopy-ram.c  |  12 ++---
>  migration/ram.c           | 110 +++++++++++++++++++++++++++++---------
>  migration/rdma.c          |   2 +-
>  qapi/migration.json       |   5 +-
>  stubs/ram-block.c         |  15 ++++++
>  9 files changed, 123 insertions(+), 55 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index a61d501568..91bfe5fb62 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3984,25 +3984,6 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
>      return ret;
>  }
>  
> -int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaque)
> -{
> -    RAMBlock *block;
> -    int ret = 0;
> -
> -    rcu_read_lock();
> -    RAMBLOCK_FOREACH(block) {
> -        if (!qemu_ram_is_migratable(block)) {
> -            continue;
> -        }
> -        ret = func(block, opaque);
> -        if (ret) {
> -            break;
> -        }
> -    }
> -    rcu_read_unlock();
> -    return ret;
> -}
> -
>  /*
>   * Unmap pages of memory from start to start+length such that
>   * they a) read as 0, b) Trigger whatever fault mechanism
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index bdae5446d7..403463d7bb 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -122,7 +122,6 @@ extern struct MemoryRegion io_mem_notdirty;
>  typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
>  
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> -int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaque);
>  int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
>  
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 37e06b76dc..c40776a40c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1983,6 +1983,15 @@ bool migrate_dirty_bitmaps(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
>  }
>  
> +bool migrate_ignore_shared(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED];
> +}
> +
>  bool migrate_use_events(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index dcd05d9f87..2c88f8a555 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -261,6 +261,7 @@ bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
>  bool migrate_dirty_bitmaps(void);
> +bool migrate_ignore_shared(void);
>  
>  bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
> @@ -301,8 +302,10 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>  void dirty_bitmap_mig_before_vm_start(void);
>  void init_dirty_bitmap_incoming_migration(void);
>  
> +int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> +
>  #define qemu_ram_foreach_block \
> -  #warning "Use qemu_ram_foreach_block_migratable in migration code"
> +  #warning "Use foreach_not_ignored_block in migration code"
>  
>  void migration_make_urgent_request(void);
>  void migration_consume_urgent_request(void);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index b098816221..e2aa57a701 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -374,7 +374,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
>      }
>  
>      /* We don't support postcopy with shared RAM yet */
> -    if (qemu_ram_foreach_migratable_block(test_ramblock_postcopiable, NULL)) {
> +    if (foreach_not_ignored_block(test_ramblock_postcopiable, NULL)) {
>          goto out;
>      }
>  
> @@ -508,7 +508,7 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>   */
>  int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>  {
> -    if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
> +    if (foreach_not_ignored_block(init_range, NULL)) {
>          return -1;
>      }
>  
> @@ -550,7 +550,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>              return -1;
>          }
>  
> -        if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
> +        if (foreach_not_ignored_block(cleanup_range, mis)) {
>              return -1;
>          }
>  
> @@ -617,7 +617,7 @@ static int nhp_range(RAMBlock *rb, void *opaque)
>   */
>  int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
>  {
> -    if (qemu_ram_foreach_migratable_block(nhp_range, mis)) {
> +    if (foreach_not_ignored_block(nhp_range, mis)) {
>          return -1;
>      }
>  
> @@ -628,7 +628,7 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
>  
>  /*
>   * Mark the given area of RAM as requiring notification to unwritten areas
> - * Used as a  callback on qemu_ram_foreach_migratable_block.
> + * Used as a  callback on foreach_not_ignored_block.
>   *   host_addr: Base of area to mark
>   *   offset: Offset in the whole ram arena
>   *   length: Length of the section
> @@ -1122,7 +1122,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>      mis->have_fault_thread = true;
>  
>      /* Mark so that we get notified of accesses to unwritten areas */
> -    if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
> +    if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
>          error_report("ram_block_enable_notify failed");
>          return -1;
>      }
> diff --git a/migration/ram.c b/migration/ram.c
> index 59191c1ed2..01315edd66 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -159,18 +159,44 @@ out:
>      return ret;
>  }
>  
> +static bool ramblock_is_ignored(RAMBlock *block)
> +{
> +    return !qemu_ram_is_migratable(block) ||
> +           (migrate_ignore_shared() && qemu_ram_is_shared(block));
> +}
> +
>  /* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else
> +
>  #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>      INTERNAL_RAMBLOCK_FOREACH(block)                   \
>          if (!qemu_ram_is_migratable(block)) {} else
>  
>  #undef RAMBLOCK_FOREACH
>  
> +int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> +{
> +    RAMBlock *block;
> +    int ret = 0;
> +
> +    rcu_read_lock();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        ret = func(block, opaque);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
>  static void ramblock_recv_map_init(void)
>  {
>      RAMBlock *rb;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          assert(!rb->receivedmap);
>          rb->receivedmap = bitmap_new(rb->max_length >> qemu_target_page_bits());
>      }
> @@ -1545,7 +1571,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>      unsigned long *bitmap = rb->bmap;
>      unsigned long next;
>  
> -    if (!qemu_ram_is_migratable(rb)) {
> +    if (ramblock_is_ignored(rb)) {
>          return size;
>      }
>  
> @@ -1594,7 +1620,7 @@ uint64_t ram_pagesize_summary(void)
>      RAMBlock *block;
>      uint64_t summary = 0;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          summary |= block->page_size;
>      }
>  
> @@ -1664,7 +1690,7 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          migration_bitmap_sync_range(rs, block, 0, block->used_length);
>      }
>      ram_counters.remaining = ram_bytes_remaining();
> @@ -2388,7 +2414,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
>      size_t pagesize_bits =
>          qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
>  
> -    if (!qemu_ram_is_migratable(pss->block)) {
> +    if (ramblock_is_ignored(pss->block)) {
>          error_report("block %s should not be migrated !", pss->block->idstr);
>          return 0;
>      }
> @@ -2486,19 +2512,30 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
>      }
>  }
>  
> -uint64_t ram_bytes_total(void)
> +static uint64_t ram_bytes_total_common(bool count_ignored)
>  {
>      RAMBlock *block;
>      uint64_t total = 0;
>  
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> -        total += block->used_length;
> +    if (count_ignored) {
> +        RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +            total += block->used_length;
> +        }
> +    } else {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            total += block->used_length;
> +        }
>      }
>      rcu_read_unlock();
>      return total;
>  }
>  
> +uint64_t ram_bytes_total(void)
> +{
> +    return ram_bytes_total_common(false);
> +}
> +
>  static void xbzrle_load_setup(void)
>  {
>      XBZRLE.decoded_buf = g_malloc(TARGET_PAGE_SIZE);
> @@ -2547,7 +2584,7 @@ static void ram_save_cleanup(void *opaque)
>       */
>      memory_global_dirty_log_stop();
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          g_free(block->bmap);
>          block->bmap = NULL;
>          g_free(block->unsentmap);
> @@ -2610,7 +2647,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>  {
>      struct RAMBlock *block;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          unsigned long *bitmap = block->bmap;
>          unsigned long range = block->used_length >> TARGET_PAGE_BITS;
>          unsigned long run_start = find_next_zero_bit(bitmap, range, 0);
> @@ -2688,7 +2725,7 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>      struct RAMBlock *block;
>      int ret;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          PostcopyDiscardState *pds =
>              postcopy_discard_send_init(ms, block->idstr);
>  
> @@ -2896,7 +2933,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      rs->last_sent_block = NULL;
>      rs->last_page = 0;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
>          unsigned long *bitmap = block->bmap;
>          unsigned long *unsentmap = block->unsentmap;
> @@ -3062,7 +3099,7 @@ static void ram_list_init_bitmaps(void)
>  
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
> -        RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
>              block->bmap = bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> @@ -3117,7 +3154,7 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
>       * about dirty page logging as well.
>       */
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          pages += bitmap_count_one(block->bmap,
>                                    block->used_length >> TARGET_PAGE_BITS);
>      }
> @@ -3176,7 +3213,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      rcu_read_lock();
>  
> -    qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
> +    qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SIZE);
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          qemu_put_byte(f, strlen(block->idstr));
> @@ -3185,6 +3222,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
>              qemu_put_be64(f, block->page_size);
>          }
> +        if (migrate_ignore_shared()) {
> +            qemu_put_be64(f, block->mr->addr);
> +            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
> +        }
>      }
>  
>      rcu_read_unlock();
> @@ -3443,7 +3484,7 @@ static inline RAMBlock *ram_block_from_stream(QEMUFile *f, int flags)
>          return NULL;
>      }
>  
> -    if (!qemu_ram_is_migratable(block)) {
> +    if (ramblock_is_ignored(block)) {
>          error_report("block %s should not be migrated !", id);
>          return NULL;
>      }
> @@ -3698,7 +3739,7 @@ int colo_init_ram_cache(void)
>      RAMBlock *block;
>  
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          block->colo_cache = qemu_anon_ram_alloc(block->used_length,
>                                                  NULL,
>                                                  false);
> @@ -3719,7 +3760,7 @@ int colo_init_ram_cache(void)
>      if (ram_bytes_total()) {
>          RAMBlock *block;
>  
> -        RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
>  
>              block->bmap = bitmap_new(pages);
> @@ -3734,7 +3775,7 @@ int colo_init_ram_cache(void)
>  
>  out_locked:
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          if (block->colo_cache) {
>              qemu_anon_ram_free(block->colo_cache, block->used_length);
>              block->colo_cache = NULL;
> @@ -3751,14 +3792,14 @@ void colo_release_ram_cache(void)
>      RAMBlock *block;
>  
>      memory_global_dirty_log_stop();
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          g_free(block->bmap);
>          block->bmap = NULL;
>      }
>  
>      rcu_read_lock();
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          if (block->colo_cache) {
>              qemu_anon_ram_free(block->colo_cache, block->used_length);
>              block->colo_cache = NULL;
> @@ -3794,7 +3835,7 @@ static int ram_load_cleanup(void *opaque)
>  {
>      RAMBlock *rb;
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          if (ramblock_is_pmem(rb)) {
>              pmem_persist(rb->host, rb->used_length);
>          }
> @@ -3803,7 +3844,7 @@ static int ram_load_cleanup(void *opaque)
>      xbzrle_load_cleanup();
>      compress_threads_load_cleanup();
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          g_free(rb->receivedmap);
>          rb->receivedmap = NULL;
>      }
> @@ -4003,7 +4044,7 @@ static void colo_flush_ram_cache(void)
>  
>      memory_global_dirty_log_sync();
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          migration_bitmap_sync_range(ram_state, block, 0, block->used_length);
>      }
>      rcu_read_unlock();
> @@ -4146,6 +4187,23 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                              ret = -EINVAL;
>                          }
>                      }
> +                    if (migrate_ignore_shared()) {
> +                        hwaddr addr = qemu_get_be64(f);
> +                        bool ignored = qemu_get_byte(f);
> +                        if (ignored != ramblock_is_ignored(block)) {
> +                            error_report("RAM block %s should %s be migrated",
> +                                         id, ignored ? "" : "not");
> +                            ret = -EINVAL;
> +                        }
> +                        if (ramblock_is_ignored(block) &&
> +                            block->mr->addr != addr) {
> +                            error_report("Mismatched GPAs for block %s "
> +                                         "%" PRId64 "!= %" PRId64,
> +                                         id, (uint64_t)addr,
> +                                         (uint64_t)block->mr->addr);
> +                            ret = -EINVAL;
> +                        }
> +                    }
>                      ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
>                                            block->idstr);
>                  } else {
> @@ -4216,7 +4274,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  static bool ram_has_postcopy(void *opaque)
>  {
>      RAMBlock *rb;
> -    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          if (ramblock_is_pmem(rb)) {
>              info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
>                           "is not supported now!", rb->idstr, rb->host);
> @@ -4236,7 +4294,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
>  
>      trace_ram_dirty_bitmap_sync_start();
>  
> -    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          qemu_savevm_send_recv_bitmap(file, block->idstr);
>          trace_ram_dirty_bitmap_request(block->idstr);
>          ramblock_count++;
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 7eb38ee764..3cb579cc99 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
>  
>      assert(rdma->blockmap == NULL);
>      memset(local, 0, sizeof *local);
> -    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
> +    foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>      trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
>      rdma->dest_blocks = g_new0(RDMADestBlock,
>                                 rdma->local_ram_blocks.nb_blocks);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7a795ecc16..7105570cd3 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -409,13 +409,16 @@
>  #           devices (and thus take locks) immediately at the end of migration.
>  #           (since 3.0)
>  #
> +# @x-ignore-shared: If enabled, QEMU will not migrate shared memory (since 4.0)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> -           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' ] }
> +           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> +           'x-ignore-shared' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> index cfa5d8678f..73c0a3ee08 100644
> --- a/stubs/ram-block.c
> +++ b/stubs/ram-block.c
> @@ -2,6 +2,21 @@
>  #include "exec/ramlist.h"
>  #include "exec/cpu-common.h"
>  
> +void *qemu_ram_get_host_addr(RAMBlock *rb)
> +{
> +    return 0;
> +}
> +
> +ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
> +{
> +    return 0;
> +}
> +
> +ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
> +{
> +    return 0;
> +}
> +
>  void ram_block_notifier_add(RAMBlockNotifier *n)
>  {
>  }
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
