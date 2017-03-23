Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cL-0007cX-4z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cI-0008WO-Ml
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cI-0008W1-E9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71A0D804EF
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:45:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:44:56 +0100
Message-Id: <20170323204544.12015-4-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/51] ram: Create RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

We create a struct where to put all the ram state

Start with the following fields:

last_seen_block, last_sent_block, last_offset, last_version and
ram_bulk_stage are globals that are really related together.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Fix typo and warnings

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 140 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 21047c5..a6e90d7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -142,6 +142,23 @@ out:
     return ret;
 }
 
+/* State of RAM for migration */
+struct RAMState {
+    /* Last block that we have visited searching for dirty pages */
+    RAMBlock *last_seen_block;
+    /* Last block from where we have sent data */
+    RAMBlock *last_sent_block;
+    /* Last offset we have sent data from */
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
@@ -217,16 +234,8 @@ uint64_t xbzrle_mig_pages_overflow(void)
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
@@ -444,6 +453,7 @@ static void mig_throttle_guest_down(void)
 /**
  * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
  *
+ * @rs: current RAM state
  * @current_addr: address for the zero page
  *
  * Update the xbzrle cache to reflect a page that's been sent as all 0.
@@ -452,9 +462,9 @@ static void mig_throttle_guest_down(void)
  * As a bonus, if the page wasn't in the cache it gets added so that
  * when a small write is made into the 0'd page it gets XBZRLE sent.
  */
-static void xbzrle_cache_zero_page(ram_addr_t current_addr)
+static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
 {
-    if (ram_bulk_stage || !migrate_use_xbzrle()) {
+    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
         return;
     }
 
@@ -552,13 +562,14 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
  *
  * Returns the byte offset within memory region of the start of a dirty page
  *
+ * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
  * @start: starting address (typically so we can continue from previous page)
  * @ram_addr_abs: pointer into which to store the address of the dirty page
  *                within the global ram_addr space
  */
 static inline
-ram_addr_t migration_bitmap_find_dirty(RAMBlock *rb,
+ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                        ram_addr_t start,
                                        ram_addr_t *ram_addr_abs)
 {
@@ -571,7 +582,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMBlock *rb,
     unsigned long next;
 
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    if (ram_bulk_stage && nr > base) {
+    if (rs->ram_bulk_stage && nr > base) {
         next = nr + 1;
     } else {
         next = find_next_bit(bitmap, size, nr);
@@ -761,6 +772,7 @@ static void ram_release_pages(MigrationState *ms, const char *rbname,
  *          >=0 - Number of pages written - this might legally be 0
  *                if xbzrle noticed the page was the same.
  *
+ * @rs: current RAM state
  * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -768,8 +780,9 @@ static void ram_release_pages(MigrationState *ms, const char *rbname,
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
@@ -795,7 +808,7 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
 
     current_addr = block->offset + offset;
 
-    if (block == last_sent_block) {
+    if (block == rs->last_sent_block) {
         offset |= RAM_SAVE_FLAG_CONTINUE;
     }
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
@@ -812,9 +825,9 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
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
@@ -946,6 +959,7 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
  *
  * Returns the number of pages written.
  *
+ * @rs: current RAM state
  * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -953,7 +967,8 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
+                                    QEMUFile *f,
                                     PageSearchStatus *pss, bool last_stage,
                                     uint64_t *bytes_transferred)
 {
@@ -987,7 +1002,7 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
          * out, keeping this order is important, because the 'cont' flag
          * is used to avoid resending the block name.
          */
-        if (block != last_sent_block) {
+        if (block != rs->last_sent_block) {
             flush_compressed_data(f);
             pages = save_zero_page(f, block, offset, p, bytes_transferred);
             if (pages == -1) {
@@ -1029,19 +1044,20 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
  *
  * Returns if a page is found
  *
+ * @rs: current RAM state
  * @f: QEMUFile where to send the data
  * @pss: data about the state of the current dirty page scan
  * @again: set to false if the search has scanned the whole of RAM
  * @ram_addr_abs: pointer into which to store the address of the dirty page
  *                within the global ram_addr space
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
@@ -1058,7 +1074,7 @@ static bool find_dirty_block(QEMUFile *f, PageSearchStatus *pss,
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
             /* Flag that we've looped */
             pss->complete_round = true;
-            ram_bulk_stage = false;
+            rs->ram_bulk_stage = false;
             if (migrate_use_xbzrle()) {
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
@@ -1125,12 +1141,14 @@ static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
  *
  * Returns if a queued page is found
  *
+ * @rs: current RAM state
  * @ms: current migration state
  * @pss: data about the state of the current dirty page scan
  * @ram_addr_abs: pointer into which to store the address of the dirty page
  *                within the global ram_addr space
  */
-static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
+static bool get_queued_page(RAMState *rs, MigrationState *ms,
+                            PageSearchStatus *pss,
                             ram_addr_t *ram_addr_abs)
 {
     RAMBlock  *block;
@@ -1171,7 +1189,7 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
          * in (migration_bitmap_find_and_reset_dirty) that every page is
          * dirty, that's no longer true.
          */
-        ram_bulk_stage = false;
+        rs->ram_bulk_stage = false;
 
         /*
          * We want the background search to continue from the queued page
@@ -1282,6 +1300,7 @@ err:
  *
  * Returns the umber of pages written
  *
+ * @rs: current RAM state
  * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @pss: data about the page we want to send
@@ -1289,7 +1308,7 @@ err:
  * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
  */
-static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                                 PageSearchStatus *pss,
                                 bool last_stage,
                                 uint64_t *bytes_transferred,
@@ -1301,11 +1320,11 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
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
 
@@ -1321,7 +1340,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
          * to the stream.
          */
         if (res > 0) {
-            last_sent_block = pss->block;
+            rs->last_sent_block = pss->block;
         }
     }
 
@@ -1339,6 +1358,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
  *
  * Returns the number of pages written or negative on error
  *
+ * @rs: current RAM state
  * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @pss: data about the page we want to send
@@ -1346,7 +1366,7 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
  * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
  */
-static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
+static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                               PageSearchStatus *pss,
                               bool last_stage,
                               uint64_t *bytes_transferred,
@@ -1356,7 +1376,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
     size_t pagesize = qemu_ram_pagesize(pss->block);
 
     do {
-        tmppages = ram_save_target_page(ms, f, pss, last_stage,
+        tmppages = ram_save_target_page(rs, ms, f, pss, last_stage,
                                         bytes_transferred, dirty_ram_abs);
         if (tmppages < 0) {
             return tmppages;
@@ -1379,6 +1399,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
  *
  * Returns the number of pages written where zero means no dirty pages
  *
+ * @rs: current RAM state
  * @f: QEMUFile where to send the data
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
@@ -1387,7 +1408,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
  * pages in a host page that are dirty.
  */
 
-static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
+static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
                                    uint64_t *bytes_transferred)
 {
     PageSearchStatus pss;
@@ -1402,8 +1423,8 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
         return pages;
     }
 
-    pss.block = last_seen_block;
-    pss.offset = last_offset;
+    pss.block = rs->last_seen_block;
+    pss.offset = rs->last_offset;
     pss.complete_round = false;
 
     if (!pss.block) {
@@ -1412,22 +1433,22 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
 
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
@@ -1509,13 +1530,13 @@ static void ram_migration_cleanup(void *opaque)
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
@@ -1847,12 +1868,13 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
  */
 static int postcopy_chunk_hostpages(MigrationState *ms)
 {
+    RAMState *rs = &ram_state;
     struct RAMBlock *block;
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
-    last_seen_block = NULL;
-    last_sent_block = NULL;
-    last_offset     = 0;
+    rs->last_seen_block = NULL;
+    rs->last_sent_block = NULL;
+    rs->last_offset     = 0;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first = block->offset >> TARGET_PAGE_BITS;
@@ -1971,7 +1993,7 @@ err:
     return ret;
 }
 
-static int ram_save_init_globals(void)
+static int ram_save_init_globals(RAMState *rs)
 {
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
@@ -2017,7 +2039,7 @@ static int ram_save_init_globals(void)
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
     bytes_transferred = 0;
-    reset_ram_globals();
+    ram_state_reset(rs);
 
     migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
     /* Skip setting bitmap if there is no RAM */
@@ -2064,11 +2086,12 @@ static int ram_save_init_globals(void)
  */
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
@@ -2106,14 +2129,15 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
  */
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
@@ -2126,7 +2150,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
-        pages = ram_find_and_save_block(f, false, &bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, false, &bytes_transferred);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2180,6 +2204,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
  */
 static int ram_save_complete(QEMUFile *f, void *opaque)
 {
+    RAMState *rs = opaque;
+
     rcu_read_lock();
 
     if (!migration_in_postcopy(migrate_get_current())) {
@@ -2194,7 +2220,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     while (true) {
         int pages;
 
-        pages = ram_find_and_save_block(f, !migration_in_colo_state(),
+        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
                                         &bytes_transferred);
         /* no more blocks to sent */
         if (pages == 0) {
@@ -2778,5 +2804,5 @@ static SaveVMHandlers savevm_ram_handlers = {
 void ram_mig_init(void)
 {
     qemu_mutex_init(&XBZRLE.lock);
-    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, NULL);
+    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_state);
 }
-- 
2.9.3
