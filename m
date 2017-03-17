Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cooYA-0001bC-H1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cooY6-0005Fc-Hy
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cooY6-0005Ek-98
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F30564A52
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:51:54 +0000 (UTC)
Date: Fri, 17 Mar 2017 09:51:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317095149.GA2396@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-24-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-24-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/31] ram: Move migration_bitmap_rcu into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Once there, rename the type to be shorter.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 79 ++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index c14293c..d39d185 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -132,6 +132,19 @@ out:
>      return ret;
>  }
>  
> +struct RAMBitmap {
> +    struct rcu_head rcu;
> +    /* Main migration bitmap */
> +    unsigned long *bmap;
> +    /* bitmap of pages that haven't been sent even once
> +     * only maintained and used in postcopy at the moment
> +     * where it's used to send the dirtymap at the start
> +     * of the postcopy phase
> +     */
> +    unsigned long *unsentmap;
> +};
> +typedef struct RAMBitmap RAMBitmap;
> +

I'm OK with this; although I can see the idea of naming it BitmapRcu,
given that the actual bmap is inside that and most of the rest of the type
is just the rcu wrapper.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  /* State of RAM for migration */
>  struct RAMState {
>      /* Last block that we have visited searching for dirty pages */
> @@ -180,6 +193,8 @@ struct RAMState {
>      uint64_t migration_dirty_pages;
>      /* protects modification of the bitmap */
>      QemuMutex bitmap_mutex;
> +    /* Ram Bitmap protected by RCU */
> +    RAMBitmap *ram_bitmap;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -236,18 +251,6 @@ struct PageSearchStatus {
>  };
>  typedef struct PageSearchStatus PageSearchStatus;
>  
> -static struct BitmapRcu {
> -    struct rcu_head rcu;
> -    /* Main migration bitmap */
> -    unsigned long *bmap;
> -    /* bitmap of pages that haven't been sent even once
> -     * only maintained and used in postcopy at the moment
> -     * where it's used to send the dirtymap at the start
> -     * of the postcopy phase
> -     */
> -    unsigned long *unsentmap;
> -} *migration_bitmap_rcu;
> -
>  struct CompressParam {
>      bool done;
>      bool quit;
> @@ -554,7 +557,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>  
>      unsigned long next;
>  
> -    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>      if (rs->ram_bulk_stage && nr > base) {
>          next = nr + 1;
>      } else {
> @@ -569,7 +572,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
>  {
>      bool ret;
>      int nr = addr >> TARGET_PAGE_BITS;
> -    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +    unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>  
>      ret = test_and_clear_bit(nr, bitmap);
>  
> @@ -583,7 +586,7 @@ static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
>                                          ram_addr_t length)
>  {
>      unsigned long *bitmap;
> -    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>      rs-> migration_dirty_pages +=
>          cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
>  }
> @@ -1115,14 +1118,14 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms, PageSearchStatus *
>           */
>          if (block) {
>              unsigned long *bitmap;
> -            bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +            bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>              dirty = test_bit(*ram_addr_abs >> TARGET_PAGE_BITS, bitmap);
>              if (!dirty) {
>                  trace_get_queued_page_not_dirty(
>                      block->idstr, (uint64_t)offset,
>                      (uint64_t)*ram_addr_abs,
>                      test_bit(*ram_addr_abs >> TARGET_PAGE_BITS,
> -                         atomic_rcu_read(&migration_bitmap_rcu)->unsentmap));
> +                         atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
>              } else {
>                  trace_get_queued_page(block->idstr,
>                                        (uint64_t)offset,
> @@ -1276,7 +1279,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>          if (res < 0) {
>              return res;
>          }
> -        unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
> +        unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
>          if (unsentmap) {
>              clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
>          }
> @@ -1440,7 +1443,7 @@ void free_xbzrle_decoded_buf(void)
>      xbzrle_decoded_buf = NULL;
>  }
>  
> -static void migration_bitmap_free(struct BitmapRcu *bmap)
> +static void migration_bitmap_free(struct RAMBitmap *bmap)
>  {
>      g_free(bmap->bmap);
>      g_free(bmap->unsentmap);
> @@ -1449,11 +1452,13 @@ static void migration_bitmap_free(struct BitmapRcu *bmap)
>  
>  static void ram_migration_cleanup(void *opaque)
>  {
> +    RAMState *rs = opaque;
> +
>      /* caller have hold iothread lock or is in a bh, so there is
>       * no writing race against this migration_bitmap
>       */
> -    struct BitmapRcu *bitmap = migration_bitmap_rcu;
> -    atomic_rcu_set(&migration_bitmap_rcu, NULL);
> +    struct RAMBitmap *bitmap = rs->ram_bitmap;
> +    atomic_rcu_set(&rs->ram_bitmap, NULL);
>      if (bitmap) {
>          memory_global_dirty_log_stop();
>          call_rcu(bitmap, migration_bitmap_free, rcu);
> @@ -1488,9 +1493,9 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
>      /* called in qemu main thread, so there is
>       * no writing race against this migration_bitmap
>       */
> -    if (migration_bitmap_rcu) {
> -        struct BitmapRcu *old_bitmap = migration_bitmap_rcu, *bitmap;
> -        bitmap = g_new(struct BitmapRcu, 1);
> +    if (ram_state.ram_bitmap) {
> +        struct RAMBitmap *old_bitmap = ram_state.ram_bitmap, *bitmap;
> +        bitmap = g_new(struct RAMBitmap, 1);
>          bitmap->bmap = bitmap_new(new);
>  
>          /* prevent migration_bitmap content from being set bit
> @@ -1508,7 +1513,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
>           */
>          bitmap->unsentmap = NULL;
>  
> -        atomic_rcu_set(&migration_bitmap_rcu, bitmap);
> +        atomic_rcu_set(&ram_state.ram_bitmap, bitmap);
>          qemu_mutex_unlock(&ram_state.bitmap_mutex);
>          ram_state.migration_dirty_pages += new - old;
>          call_rcu(old_bitmap, migration_bitmap_free, rcu);
> @@ -1529,7 +1534,7 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
>      char linebuf[129];
>  
>      if (!todump) {
> -        todump = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +        todump = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
>      }
>  
>      for (cur = 0; cur < ram_pages; cur += linelen) {
> @@ -1559,7 +1564,7 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
>  void ram_postcopy_migrated_memory_release(MigrationState *ms)
>  {
>      struct RAMBlock *block;
> -    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +    unsigned long *bitmap = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
>  
>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>          unsigned long first = block->offset >> TARGET_PAGE_BITS;
> @@ -1591,7 +1596,7 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
>      unsigned long current;
>      unsigned long *unsentmap;
>  
> -    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
> +    unsentmap = atomic_rcu_read(&ram_state.ram_bitmap)->unsentmap;
>      for (current = start; current < end; ) {
>          unsigned long one = find_next_bit(unsentmap, end, current);
>  
> @@ -1680,8 +1685,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>          return;
>      }
>  
> -    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> -    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
> +    bitmap = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
> +    unsentmap = atomic_rcu_read(&ram_state.ram_bitmap)->unsentmap;
>  
>      if (unsent_pass) {
>          /* Find a sent page */
> @@ -1836,7 +1841,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      /* This should be our last sync, the src is now paused */
>      migration_bitmap_sync(&ram_state);
>  
> -    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
> +    unsentmap = atomic_rcu_read(&ram_state.ram_bitmap)->unsentmap;
>      if (!unsentmap) {
>          /* We don't have a safe way to resize the sentmap, so
>           * if the bitmap was resized it will be NULL at this
> @@ -1857,7 +1862,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      /*
>       * Update the unsentmap to be unsentmap = unsentmap | dirty
>       */
> -    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +    bitmap = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
>      bitmap_or(unsentmap, unsentmap, bitmap,
>                 last_ram_offset() >> TARGET_PAGE_BITS);
>  
> @@ -1950,16 +1955,16 @@ static int ram_state_init(RAMState *rs)
>      bytes_transferred = 0;
>      ram_state_reset(rs);
>  
> -    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
> +    rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
>          ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
> -        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> -        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> +        rs->ram_bitmap->bmap = bitmap_new(ram_bitmap_pages);
> +        bitmap_set(rs->ram_bitmap->bmap, 0, ram_bitmap_pages);
>  
>          if (migrate_postcopy_ram()) {
> -            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> -            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +            rs->ram_bitmap->unsentmap = bitmap_new(ram_bitmap_pages);
> +            bitmap_set(rs->ram_bitmap->unsentmap, 0, ram_bitmap_pages);
>          }
>      }
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
