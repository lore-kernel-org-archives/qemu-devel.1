Received: from eggs.gnu.org ([2001:4830:134:3::10]:53457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Jx-000799-6T
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Js-0003DA-Ua
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9Js-0003CL-LM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE40A81244
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:49:51 +0100
Message-Id: <20170315135021.6978-2-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/31] ram: move more fields into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

last_seen_block, last_sent_block, last_offset, last_version and
ram_bulk_stage are globals that are really related together.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 136 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 79 insertions(+), 57 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 719425b..c20a539 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -136,6 +136,23 @@ out:
     return ret;
 }
 
+/* State of RAM for migration */
+struct RAMState {
+    /* Last block that we have visited searching for dirty pages */
+    RAMBlock    *last_seen_block;
+    /* Last block from where we have sent data */
+    RAMBlock *last_sent_block;
+    /* Last offeset we have sent data from */
+    ram_addr_t last_offset;
+    /* last ram version we have seen */
+    uint32_t last_version;
+    /* We are in the first round */
+    bool ram_bulk_stage;
+};
+typedef struct RAMState RAMState;
+
+static RAMState ram_state;
+
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
     uint64_t dup_pages;
@@ -211,16 +228,8 @@ uint64_t xbzrle_mig_pages_overflow(void)
     return acct_info.xbzrle_overflows;
 }
 
-/* This is the last block that we have visited serching for dirty pages
- */
-static RAMBlock *last_seen_block;
-/* This is the last block from where we have sent data */
-static RAMBlock *last_sent_block;
-static ram_addr_t last_offset;
 static QemuMutex migration_bitmap_mutex;
 static uint64_t migration_dirty_pages;
-static uint32_t last_version;
-static bool ram_bulk_stage;
 
 /* used by the search for pages to send */
 struct PageSearchStatus {
@@ -437,9 +446,9 @@ static void mig_throttle_guest_down(void)
  * As a bonus, if the page wasn't in the cache it gets added so that
  * when a small write is made into the 0'd page it gets XBZRLE sent
  */
-static void xbzrle_cache_zero_page(ram_addr_t current_addr)
+static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
 {
-    if (ram_bulk_stage || !migrate_use_xbzrle()) {
+    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
         return;
     }
 
@@ -539,7 +548,7 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
  * Returns: byte offset within memory region of the start of a dirty page
  */
 static inline
-ram_addr_t migration_bitmap_find_dirty(RAMBlock *rb,
+ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                        ram_addr_t start,
                                        ram_addr_t *ram_addr_abs)
 {
@@ -552,7 +561,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMBlock *rb,
     unsigned long next;
 
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    if (ram_bulk_stage && nr > base) {
+    if (rs->ram_bulk_stage && nr > base) {
         next = nr + 1;
     } else {
         next = find_next_bit(bitmap, size, nr);
@@ -740,6 +749,7 @@ static void ram_release_pages(MigrationState *ms, const char *block_name,
  *          >=0 - Number of pages written - this might legally be 0
  *                if xbzrle noticed the page was the same.
  *
+ * @rs: The RAM state
  * @ms: The current migration state.
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -747,8 +757,9 @@ static void ram_release_pages(MigrationState *ms, const char *block_name,
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
-                         bool last_stage, uint64_t *bytes_transferred)
+static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
+                         PageSearchStatus *pss, bool last_stage,
+                         uint64_t *bytes_transferred)
 {
     int pages = -1;
     uint64_t bytes_xmit;
@@ -774,7 +785,7 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
 
     current_addr = block->offset + offset;
 
-    if (block == last_sent_block) {
+    if (block == rs->last_sent_block) {
         offset |= RAM_SAVE_FLAG_CONTINUE;
     }
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
@@ -791,9 +802,9 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
             /* Must let xbzrle know, otherwise a previous (now 0'd) cached
              * page would be stale
              */
-            xbzrle_cache_zero_page(current_addr);
+            xbzrle_cache_zero_page(rs, current_addr);
             ram_release_pages(ms, block->idstr, pss->offset, pages);
-        } else if (!ram_bulk_stage &&
+        } else if (!rs->ram_bulk_stage &&
                    !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(f, &p, current_addr, block,
                                      offset, last_stage, bytes_transferred);
@@ -925,6 +936,7 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
  *
  * Returns: Number of pages written.
  *
+ * @rs: The RAM state
  * @ms: The current migration state.
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -932,7 +944,8 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
+                                    QEMUFile *f,
                                     PageSearchStatus *pss, bool last_stage,
                                     uint64_t *bytes_transferred)
 {
@@ -966,7 +979,7 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
          * out, keeping this order is important, because the 'cont' flag
          * is used to avoid resending the block name.
          */
-        if (block != last_sent_block) {
+        if (block != rs->last_sent_block) {
             flush_compressed_data(f);
             pages = save_zero_page(f, block, offset, p, bytes_transferred);
             if (pages == -1) {
@@ -1008,19 +1021,20 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
  *
  * Returns: True if a page is found
  *
+ * @rs: The RAM state
  * @f: Current migration stream.
  * @pss: Data about the state of the current dirty page scan.
  * @*again: Set to false if the search has scanned the whole of RAM
  * *ram_addr_abs: Pointer into which to store the address of the dirty page
  *               within the global ram_addr space
  */
-static bool find_dirty_block(QEMUFile *f, PageSearchStatus *pss,
+static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
                              bool *again, ram_addr_t *ram_addr_abs)
 {
-    pss->offset = migration_bitmap_find_dirty(pss->block, pss->offset,
+    pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
                                               ram_addr_abs);
-    if (pss->complete_round && pss->block == last_seen_block &&
-        pss->offset >= last_offset) {
+    if (pss->complete_round && pss->block == rs->last_seen_block &&
+        pss->offset >= rs->last_offset) {
         /*
          * We've been once around the RAM and haven't found anything.
          * Give up.
@@ -1037,7 +1051,7 @@ static bool find_dirty_block(QEMUFile *f, PageSearchStatus *pss,
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
             /* Flag that we've looped */
             pss->complete_round = true;
-            ram_bulk_stage = false;
+            rs->ram_bulk_stage = false;
             if (migrate_use_xbzrle()) {
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
@@ -1097,13 +1111,14 @@ static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
  * Unqueue a page from the queue fed by postcopy page requests; skips pages
  * that are already sent (!dirty)
  *
+ *      rs: The RAM state
  *      ms:      MigrationState in
  *     pss:      PageSearchStatus structure updated with found block/offset
  * ram_addr_abs: global offset in the dirty/sent bitmaps
  *
  * Returns:      true if a queued page is found
  */
-static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
+static bool get_queued_page(RAMState *rs, MigrationState *ms, PageSearchStatus *pss,
                             ram_addr_t *ram_addr_abs)
 {
     RAMBlock  *block;
@@ -1144,7 +1159,7 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
          * in (migration_bitmap_find_and_reset_dirty) that every page is
          * dirty, that's no longer true.
          */
-        ram_bulk_stage = false;
+        rs->ram_bulk_stage = false;
 
         /*
          * We want the background search to continue from the queued page
@@ -1248,6 +1263,7 @@ err:
  * ram_save_target_page: Save one target page
  *
  *
+ * @rs: The RAM state
  * @f: QEMUFile where to send the data
  * @block: pointer to block that contains the page we want to send
  * @offset: offset inside the block for the page;
@@ -1257,7 +1273,7 @@ err:
  *
  * Returns: Number of pages written.
  */
-static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                                 PageSearchStatus *pss,
                                 bool last_stage,
                                 uint64_t *bytes_transferred,
@@ -1269,11 +1285,11 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
     if (migration_bitmap_clear_dirty(dirty_ram_abs)) {
         unsigned long *unsentmap;
         if (compression_switch && migrate_use_compression()) {
-            res = ram_save_compressed_page(ms, f, pss,
+            res = ram_save_compressed_page(rs, ms, f, pss,
                                            last_stage,
                                            bytes_transferred);
         } else {
-            res = ram_save_page(ms, f, pss, last_stage,
+            res = ram_save_page(rs, ms, f, pss, last_stage,
                                 bytes_transferred);
         }
 
@@ -1289,7 +1305,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
          * to the stream.
          */
         if (res > 0) {
-            last_sent_block = pss->block;
+            rs->last_sent_block = pss->block;
         }
     }
 
@@ -1307,6 +1323,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
  *
  * Returns: Number of pages written.
  *
+ * @rs: The RAM state
  * @f: QEMUFile where to send the data
  * @block: pointer to block that contains the page we want to send
  * @offset: offset inside the block for the page; updated to last target page
@@ -1315,7 +1332,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
  * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
  */
-static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                               PageSearchStatus *pss,
                               bool last_stage,
                               uint64_t *bytes_transferred,
@@ -1325,7 +1342,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
     size_t pagesize = qemu_ram_pagesize(pss->block);
 
     do {
-        tmppages = ram_save_target_page(ms, f, pss, last_stage,
+        tmppages = ram_save_target_page(rs, ms, f, pss, last_stage,
                                         bytes_transferred, dirty_ram_abs);
         if (tmppages < 0) {
             return tmppages;
@@ -1349,6 +1366,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
  * Returns:  The number of pages written
  *           0 means no dirty pages
  *
+ * @rs: The RAM state
  * @f: QEMUFile where to send the data
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
@@ -1357,7 +1375,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
  * pages in a host page that are dirty.
  */
 
-static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
+static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
                                    uint64_t *bytes_transferred)
 {
     PageSearchStatus pss;
@@ -1372,8 +1390,8 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
         return pages;
     }
 
-    pss.block = last_seen_block;
-    pss.offset = last_offset;
+    pss.block = rs->last_seen_block;
+    pss.offset = rs->last_offset;
     pss.complete_round = false;
 
     if (!pss.block) {
@@ -1382,22 +1400,22 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
 
     do {
         again = true;
-        found = get_queued_page(ms, &pss, &dirty_ram_abs);
+        found = get_queued_page(rs, ms, &pss, &dirty_ram_abs);
 
         if (!found) {
             /* priority queue empty, so just search for something dirty */
-            found = find_dirty_block(f, &pss, &again, &dirty_ram_abs);
+            found = find_dirty_block(rs, f, &pss, &again, &dirty_ram_abs);
         }
 
         if (found) {
-            pages = ram_save_host_page(ms, f, &pss,
+            pages = ram_save_host_page(rs, ms, f, &pss,
                                        last_stage, bytes_transferred,
                                        dirty_ram_abs);
         }
     } while (!pages && again);
 
-    last_seen_block = pss.block;
-    last_offset = pss.offset;
+    rs->last_seen_block = pss.block;
+    rs->last_offset = pss.offset;
 
     return pages;
 }
@@ -1479,13 +1497,13 @@ static void ram_migration_cleanup(void *opaque)
     XBZRLE_cache_unlock();
 }
 
-static void reset_ram_globals(void)
+static void ram_state_reset(RAMState *rs)
 {
-    last_seen_block = NULL;
-    last_sent_block = NULL;
-    last_offset = 0;
-    last_version = ram_list.version;
-    ram_bulk_stage = true;
+    rs->last_seen_block = NULL;
+    rs->last_sent_block = NULL;
+    rs->last_offset = 0;
+    rs->last_version = ram_list.version;
+    rs->ram_bulk_stage = true;
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -1800,9 +1818,9 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
     struct RAMBlock *block;
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
-    last_seen_block = NULL;
-    last_sent_block = NULL;
-    last_offset     = 0;
+    ram_state.last_seen_block = NULL;
+    ram_state.last_sent_block = NULL;
+    ram_state.last_offset     = 0;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first = block->offset >> TARGET_PAGE_BITS;
@@ -1913,7 +1931,7 @@ err:
     return ret;
 }
 
-static int ram_save_init_globals(void)
+static int ram_save_init_globals(RAMState *rs)
 {
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
@@ -1959,7 +1977,7 @@ static int ram_save_init_globals(void)
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
     bytes_transferred = 0;
-    reset_ram_globals();
+    ram_state_reset(rs);
 
     migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
     /* Skip setting bitmap if there is no RAM */
@@ -1997,11 +2015,12 @@ static int ram_save_init_globals(void)
 
 static int ram_save_setup(QEMUFile *f, void *opaque)
 {
+    RAMState *rs = opaque;
     RAMBlock *block;
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_save_init_globals() < 0) {
+        if (ram_save_init_globals(rs) < 0) {
             return -1;
          }
     }
@@ -2031,14 +2050,15 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
 static int ram_save_iterate(QEMUFile *f, void *opaque)
 {
+    RAMState *rs = opaque;
     int ret;
     int i;
     int64_t t0;
     int done = 0;
 
     rcu_read_lock();
-    if (ram_list.version != last_version) {
-        reset_ram_globals();
+    if (ram_list.version != rs->last_version) {
+        ram_state_reset(rs);
     }
 
     /* Read version before ram_list.blocks */
@@ -2051,7 +2071,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
-        pages = ram_find_and_save_block(f, false, &bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, false, &bytes_transferred);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2096,6 +2116,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 /* Called with iothread lock */
 static int ram_save_complete(QEMUFile *f, void *opaque)
 {
+    RAMState *rs = opaque;
+    
     rcu_read_lock();
 
     if (!migration_in_postcopy(migrate_get_current())) {
@@ -2110,7 +2132,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     while (true) {
         int pages;
 
-        pages = ram_find_and_save_block(f, !migration_in_colo_state(),
+        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
                                         &bytes_transferred);
         /* no more blocks to sent */
         if (pages == 0) {
@@ -2675,5 +2697,5 @@ static SaveVMHandlers savevm_ram_handlers = {
 void ram_mig_init(void)
 {
     qemu_mutex_init(&XBZRLE.lock);
-    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, NULL);
+    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_state);
 }
-- 
2.9.3
