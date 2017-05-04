Received: from eggs.gnu.org ([2001:4830:134:3::10]:45283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFz-0008F7-Rn
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFs-0000br-EP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DFs-0000bM-3u
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1709EC04B941
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:40:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:44 +0200
Message-Id: <20170504094053.2329-2-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] ram: Split dirty bitmap by RAMBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Both the ram bitmap and the unsent bitmap are split by RAMBlock.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Peter Xu <peterx@redhat.com>

--

Fix compilation when DEBUG_POSTCOPY is enabled (thanks Hailiang)
---
 include/exec/ram_addr.h          |  13 +-
 include/migration/migration.h    |   3 +-
 include/migration/postcopy-ram.h |   3 -
 migration/postcopy-ram.c         |   5 +-
 migration/ram.c                  | 271 +++++++++++++++------------------------
 5 files changed, 118 insertions(+), 177 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index dbe2f08..140efa8 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -39,6 +39,14 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     size_t page_size;
+    /* dirty bitmap used during migration */
+    unsigned long *bmap;
+    /* bitmap of pages that haven't been sent even once
+     * only maintained and used in postcopy at the moment
+     * where it's used to send the dirtymap at the start
+     * of the postcopy phase
+     */
+    unsigned long *unsentmap;
 };
 
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
@@ -360,16 +368,15 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
 
 
 static inline
-uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
-                                               RAMBlock *rb,
+uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                ram_addr_t start,
                                                ram_addr_t length,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
-    start = rb->offset + start;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
+    unsigned long *dest = rb->bmap;
 
     /* start address is aligned at the start of a word? */
     if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) {
diff --git a/include/migration/migration.h b/include/migration/migration.h
index ba1a16c..e29cb01 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -266,7 +266,8 @@ uint64_t xbzrle_mig_pages_cache_miss(void);
 double xbzrle_mig_cache_miss_rate(void);
 
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
-void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
+void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
+                           unsigned long pages);
 /* For outgoing discard bitmap */
 int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
index 8e036b9..4c25f03 100644
--- a/include/migration/postcopy-ram.h
+++ b/include/migration/postcopy-ram.h
@@ -43,12 +43,9 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis);
 
 /*
  * Called at the start of each RAMBlock by the bitmap code.
- * 'offset' is the bitmap offset of the named RAMBlock in the migration
- * bitmap.
  * Returns a new PDS
  */
 PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
-                                                 unsigned long offset,
                                                  const char *name);
 
 /*
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 85fd8d7..e3f4a37 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -33,7 +33,6 @@
 
 struct PostcopyDiscardState {
     const char *ramblock_name;
-    uint64_t offset; /* Bitmap entry for the 1st bit of this RAMBlock */
     uint16_t cur_entry;
     /*
      * Start and length of a discard range (bytes)
@@ -717,14 +716,12 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
  * returns: a new PDS.
  */
 PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
-                                                 unsigned long offset,
                                                  const char *name)
 {
     PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
 
     if (res) {
         res->ramblock_name = name;
-        res->offset = offset;
     }
 
     return res;
@@ -745,7 +742,7 @@ void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardState *pds,
 {
     size_t tp_size = qemu_target_page_size();
     /* Convert to byte offsets within the RAM block */
-    pds->start_list[pds->cur_entry] = (start - pds->offset) * tp_size;
+    pds->start_list[pds->cur_entry] = start  * tp_size;
     pds->length_list[pds->cur_entry] = length * tp_size;
     trace_postcopy_discard_send_range(pds->ramblock_name, start, length);
     pds->cur_entry++;
diff --git a/migration/ram.c b/migration/ram.c
index f48664e..1f03469 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -138,19 +138,6 @@ out:
     return ret;
 }
 
-struct RAMBitmap {
-    struct rcu_head rcu;
-    /* Main migration bitmap */
-    unsigned long *bmap;
-    /* bitmap of pages that haven't been sent even once
-     * only maintained and used in postcopy at the moment
-     * where it's used to send the dirtymap at the start
-     * of the postcopy phase
-     */
-    unsigned long *unsentmap;
-};
-typedef struct RAMBitmap RAMBitmap;
-
 /*
  * An outstanding page request, on the source, having been received
  * and queued
@@ -220,8 +207,6 @@ struct RAMState {
     uint64_t postcopy_requests;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
-    /* Ram Bitmap protected by RCU */
-    RAMBitmap *ram_bitmap;
     /* The RAMBlock used in the last src_page_requests */
     RAMBlock *last_req_rb;
     /* Queue of outstanding page requests from the destination */
@@ -614,22 +599,17 @@ static inline
 unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                           unsigned long start)
 {
-    unsigned long base = rb->offset >> TARGET_PAGE_BITS;
-    unsigned long nr = base + start;
-    uint64_t rb_size = rb->used_length;
-    unsigned long size = base + (rb_size >> TARGET_PAGE_BITS);
-    unsigned long *bitmap;
-
+    unsigned long size = rb->used_length >> TARGET_PAGE_BITS;
+    unsigned long *bitmap = rb->bmap;
     unsigned long next;
 
-    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    if (rs->ram_bulk_stage && nr > base) {
-        next = nr + 1;
+    if (rs->ram_bulk_stage && start > 0) {
+        next = start + 1;
     } else {
-        next = find_next_bit(bitmap, size, nr);
+        next = find_next_bit(bitmap, size, start);
     }
 
-    return next - base;
+    return next;
 }
 
 static inline bool migration_bitmap_clear_dirty(RAMState *rs,
@@ -637,10 +617,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
                                                 unsigned long page)
 {
     bool ret;
-    unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    unsigned long nr = (rb->offset >> TARGET_PAGE_BITS) + page;
 
-    ret = test_and_clear_bit(nr, bitmap);
+    ret = test_and_clear_bit(page, rb->bmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
@@ -651,10 +629,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
 static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
                                         ram_addr_t start, ram_addr_t length)
 {
-    unsigned long *bitmap;
-    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     rs->migration_dirty_pages +=
-        cpu_physical_memory_sync_dirty_bitmap(bitmap, rb, start, length,
+        cpu_physical_memory_sync_dirty_bitmap(rb, start, length,
                                               &rs->num_dirty_pages_period);
 }
 
@@ -1153,17 +1129,13 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
          * search already sent it.
          */
         if (block) {
-            unsigned long *bitmap;
             unsigned long page;
 
-            bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-            page = (block->offset + offset) >> TARGET_PAGE_BITS;
-            dirty = test_bit(page, bitmap);
+            page = offset >> TARGET_PAGE_BITS;
+            dirty = test_bit(page, block->bmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
-                    page,
-                    test_bit(page,
-                             atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
+                       page, test_bit(page, block->unsentmap));
             } else {
                 trace_get_queued_page(block->idstr, (uint64_t)offset, page);
             }
@@ -1301,16 +1273,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
 
     /* Check the pages is dirty and if it is send it */
     if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
-        unsigned long *unsentmap;
         /*
          * If xbzrle is on, stop using the data compression after first
          * round of migration even if compression is enabled. In theory,
          * xbzrle can do better than compression.
          */
-        unsigned long page =
-            (pss->block->offset >> TARGET_PAGE_BITS) + pss->page;
-        if (migrate_use_compression()
-            && (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+        if (migrate_use_compression() &&
+            (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
@@ -1319,9 +1288,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (res < 0) {
             return res;
         }
-        unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
-        if (unsentmap) {
-            clear_bit(page, unsentmap);
+        if (pss->block->unsentmap) {
+            clear_bit(pss->page, pss->block->unsentmap);
         }
     }
 
@@ -1451,25 +1419,20 @@ void free_xbzrle_decoded_buf(void)
     xbzrle_decoded_buf = NULL;
 }
 
-static void migration_bitmap_free(RAMBitmap *bmap)
-{
-    g_free(bmap->bmap);
-    g_free(bmap->unsentmap);
-    g_free(bmap);
-}
-
 static void ram_migration_cleanup(void *opaque)
 {
-    RAMState *rs = opaque;
+    RAMBlock *block;
 
     /* caller have hold iothread lock or is in a bh, so there is
      * no writing race against this migration_bitmap
      */
-    RAMBitmap *bitmap = rs->ram_bitmap;
-    atomic_rcu_set(&rs->ram_bitmap, NULL);
-    if (bitmap) {
-        memory_global_dirty_log_stop();
-        call_rcu(bitmap, migration_bitmap_free, rcu);
+    memory_global_dirty_log_stop();
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+        g_free(block->unsentmap);
+        block->unsentmap = NULL;
     }
 
     XBZRLE_cache_lock();
@@ -1501,27 +1464,22 @@ static void ram_state_reset(RAMState *rs)
  * of; it won't bother printing lines that are all this value.
  * If 'todump' is null the migration bitmap is dumped.
  */
-void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
+void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
+                           unsigned long pages)
 {
-    unsigned long ram_pages = last_ram_page();
-    RAMState *rs = &ram_state;
     int64_t cur;
     int64_t linelen = 128;
     char linebuf[129];
 
-    if (!todump) {
-        todump = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    }
-
-    for (cur = 0; cur < ram_pages; cur += linelen) {
+    for (cur = 0; cur < pages; cur += linelen) {
         int64_t curb;
         bool found = false;
         /*
          * Last line; catch the case where the line length
          * is longer than remaining ram
          */
-        if (cur + linelen > ram_pages) {
-            linelen = ram_pages - cur;
+        if (cur + linelen > pages) {
+            linelen = pages - cur;
         }
         for (curb = 0; curb < linelen; curb++) {
             bool thisbit = test_bit(cur + curb, todump);
@@ -1539,14 +1497,12 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 
 void ram_postcopy_migrated_memory_release(MigrationState *ms)
 {
-    RAMState *rs = &ram_state;
     struct RAMBlock *block;
-    unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        unsigned long first = block->offset >> TARGET_PAGE_BITS;
-        unsigned long range = first + (block->used_length >> TARGET_PAGE_BITS);
-        unsigned long run_start = find_next_zero_bit(bitmap, range, first);
+        unsigned long *bitmap = block->bmap;
+        unsigned long range = block->used_length >> TARGET_PAGE_BITS;
+        unsigned long run_start = find_next_zero_bit(bitmap, range, 0);
 
         while (run_start < range) {
             unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
@@ -1573,16 +1529,13 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
  */
 static int postcopy_send_discard_bm_ram(MigrationState *ms,
                                         PostcopyDiscardState *pds,
-                                        unsigned long start,
-                                        unsigned long length)
+                                        RAMBlock *block)
 {
-    RAMState *rs = &ram_state;
-    unsigned long end = start + length; /* one after the end */
+    unsigned long end = block->used_length >> TARGET_PAGE_BITS;
     unsigned long current;
-    unsigned long *unsentmap;
+    unsigned long *unsentmap = block->unsentmap;
 
-    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
-    for (current = start; current < end; ) {
+    for (current = 0; current < end; ) {
         unsigned long one = find_next_bit(unsentmap, end, current);
 
         if (one <= end) {
@@ -1625,18 +1578,15 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
     int ret;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        unsigned long first = block->offset >> TARGET_PAGE_BITS;
-        PostcopyDiscardState *pds = postcopy_discard_send_init(ms,
-                                                               first,
-                                                               block->idstr);
+        PostcopyDiscardState *pds =
+            postcopy_discard_send_init(ms, block->idstr);
 
         /*
          * Postcopy sends chunks of bitmap over the wire, but it
          * just needs indexes at this point, avoids it having
          * target page specific code.
          */
-        ret = postcopy_send_discard_bm_ram(ms, pds, first,
-                                    block->used_length >> TARGET_PAGE_BITS);
+        ret = postcopy_send_discard_bm_ram(ms, pds, block);
         postcopy_discard_send_finish(ms, pds);
         if (ret) {
             return ret;
@@ -1667,12 +1617,10 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                                           PostcopyDiscardState *pds)
 {
     RAMState *rs = &ram_state;
-    unsigned long *bitmap;
-    unsigned long *unsentmap;
+    unsigned long *bitmap = block->bmap;
+    unsigned long *unsentmap = block->unsentmap;
     unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
-    unsigned long first = block->offset >> TARGET_PAGE_BITS;
-    unsigned long len = block->used_length >> TARGET_PAGE_BITS;
-    unsigned long last = first + (len - 1);
+    unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
     unsigned long run_start;
 
     if (block->page_size == TARGET_PAGE_SIZE) {
@@ -1680,18 +1628,15 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
         return;
     }
 
-    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
-
     if (unsent_pass) {
         /* Find a sent page */
-        run_start = find_next_zero_bit(unsentmap, last + 1, first);
+        run_start = find_next_zero_bit(unsentmap, pages, 0);
     } else {
         /* Find a dirty page */
-        run_start = find_next_bit(bitmap, last + 1, first);
+        run_start = find_next_bit(bitmap, pages, 0);
     }
 
-    while (run_start <= last) {
+    while (run_start < pages) {
         bool do_fixup = false;
         unsigned long fixup_start_addr;
         unsigned long host_offset;
@@ -1711,9 +1656,9 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
             /* Find the end of this run */
             unsigned long run_end;
             if (unsent_pass) {
-                run_end = find_next_bit(unsentmap, last + 1, run_start + 1);
+                run_end = find_next_bit(unsentmap, pages, run_start + 1);
             } else {
-                run_end = find_next_zero_bit(bitmap, last + 1, run_start + 1);
+                run_end = find_next_zero_bit(bitmap, pages, run_start + 1);
             }
             /*
              * If the end isn't at the start of a host page, then the
@@ -1770,11 +1715,10 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
 
         if (unsent_pass) {
             /* Find the next sent page for the next iteration */
-            run_start = find_next_zero_bit(unsentmap, last + 1,
-                                           run_start);
+            run_start = find_next_zero_bit(unsentmap, pages, run_start);
         } else {
             /* Find the next dirty page for the next iteration */
-            run_start = find_next_bit(bitmap, last + 1, run_start);
+            run_start = find_next_bit(bitmap, pages, run_start);
         }
     }
 }
@@ -1791,34 +1735,22 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
  * Returns zero on success
  *
  * @ms: current migration state
+ * @block: block we want to work with
  */
-static int postcopy_chunk_hostpages(MigrationState *ms)
+static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
 {
-    RAMState *rs = &ram_state;
-    struct RAMBlock *block;
-
-    /* Easiest way to make sure we don't resume in the middle of a host-page */
-    rs->last_seen_block = NULL;
-    rs->last_sent_block = NULL;
-    rs->last_page = 0;
-
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        unsigned long first = block->offset >> TARGET_PAGE_BITS;
-
-        PostcopyDiscardState *pds =
-                         postcopy_discard_send_init(ms, first, block->idstr);
-
-        /* First pass: Discard all partially sent host pages */
-        postcopy_chunk_hostpages_pass(ms, true, block, pds);
-        /*
-         * Second pass: Ensure that all partially dirty host pages are made
-         * fully dirty.
-         */
-        postcopy_chunk_hostpages_pass(ms, false, block, pds);
-
-        postcopy_discard_send_finish(ms, pds);
-    } /* ram_list loop */
-
+    PostcopyDiscardState *pds =
+        postcopy_discard_send_init(ms, block->idstr);
+
+    /* First pass: Discard all partially sent host pages */
+    postcopy_chunk_hostpages_pass(ms, true, block, pds);
+    /*
+     * Second pass: Ensure that all partially dirty host pages are made
+     * fully dirty.
+     */
+    postcopy_chunk_hostpages_pass(ms, false, block, pds);
+
+    postcopy_discard_send_finish(ms, pds);
     return 0;
 }
 
@@ -1840,43 +1772,49 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
 int ram_postcopy_send_discard_bitmap(MigrationState *ms)
 {
     RAMState *rs = &ram_state;
+    RAMBlock *block;
     int ret;
-    unsigned long *bitmap, *unsentmap;
 
     rcu_read_lock();
 
     /* This should be our last sync, the src is now paused */
     migration_bitmap_sync(rs);
 
-    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
-    if (!unsentmap) {
-        /* We don't have a safe way to resize the sentmap, so
-         * if the bitmap was resized it will be NULL at this
-         * point.
+    /* Easiest way to make sure we don't resume in the middle of a host-page */
+    rs->last_seen_block = NULL;
+    rs->last_sent_block = NULL;
+    rs->last_page = 0;
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
+        unsigned long *bitmap = block->bmap;
+        unsigned long *unsentmap = block->unsentmap;
+
+        if (!unsentmap) {
+            /* We don't have a safe way to resize the sentmap, so
+             * if the bitmap was resized it will be NULL at this
+             * point.
+             */
+            error_report("migration ram resized during precopy phase");
+            rcu_read_unlock();
+            return -EINVAL;
+        }
+        /* Deal with TPS != HPS and huge pages */
+        ret = postcopy_chunk_hostpages(ms, block);
+        if (ret) {
+            rcu_read_unlock();
+            return ret;
+        }
+
+        /*
+         * Update the unsentmap to be unsentmap = unsentmap | dirty
          */
-        error_report("migration ram resized during precopy phase");
-        rcu_read_unlock();
-        return -EINVAL;
-    }
-
-    /* Deal with TPS != HPS and huge pages */
-    ret = postcopy_chunk_hostpages(ms);
-    if (ret) {
-        rcu_read_unlock();
-        return ret;
-    }
-
-    /*
-     * Update the unsentmap to be unsentmap = unsentmap | dirty
-     */
-    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    bitmap_or(unsentmap, unsentmap, bitmap, last_ram_page());
-
-
-    trace_ram_postcopy_send_discard_bitmap();
+        bitmap_or(unsentmap, unsentmap, bitmap, pages);
 #ifdef DEBUG_POSTCOPY
-    ram_debug_dump_bitmap(unsentmap, true);
+        ram_debug_dump_bitmap(unsentmap, true, pages);
 #endif
+    }
+    trace_ram_postcopy_send_discard_bitmap();
 
     ret = postcopy_each_ram_send_discard(ms);
     rcu_read_unlock();
@@ -1918,8 +1856,6 @@ err:
 
 static int ram_state_init(RAMState *rs)
 {
-    unsigned long ram_bitmap_pages;
-
     memset(rs, 0, sizeof(*rs));
     qemu_mutex_init(&rs->bitmap_mutex);
     qemu_mutex_init(&rs->src_page_req_mutex);
@@ -1961,16 +1897,19 @@ static int ram_state_init(RAMState *rs)
     rcu_read_lock();
     ram_state_reset(rs);
 
-    rs->ram_bitmap = g_new0(RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        ram_bitmap_pages = last_ram_page();
-        rs->ram_bitmap->bmap = bitmap_new(ram_bitmap_pages);
-        bitmap_set(rs->ram_bitmap->bmap, 0, ram_bitmap_pages);
+        RAMBlock *block;
 
-        if (migrate_postcopy_ram()) {
-            rs->ram_bitmap->unsentmap = bitmap_new(ram_bitmap_pages);
-            bitmap_set(rs->ram_bitmap->unsentmap, 0, ram_bitmap_pages);
+        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+            unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
+
+            block->bmap = bitmap_new(pages);
+            bitmap_set(block->bmap, 0, pages);
+            if (migrate_postcopy_ram()) {
+                block->unsentmap = bitmap_new(pages);
+                bitmap_set(block->unsentmap, 0, pages);
+            }
         }
     }
 
-- 
2.9.3
