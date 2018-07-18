Received: from eggs.gnu.org ([2001:4830:134:3::10]:52967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hl-Hm
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000I3-Kl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000Fb-3F
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:53 +0300
Message-Id: <20180718154200.26777-11-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 10/17] background snapshots: adapt the page
 queueing code for using page copies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

The background snapshot uses memeory page copying to seal the page
memory content. The patch adapts the migration infrastructure to save
copies of the pages.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/migration.c |  2 +-
 migration/ram.c       | 59 ++++++++++++++++++++++++++++++++-----------
 migration/ram.h       |  3 ++-
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 87096d23ef..131d0904e4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1716,7 +1716,7 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
         return;
     }
 
-    if (ram_save_queue_pages(rbname, start, len)) {
+    if (ram_save_queue_pages(NULL, rbname, start, len, NULL)) {
         mark_source_rp_bad(ms);
     }
 }
diff --git a/migration/ram.c b/migration/ram.c
index dc7dfe0726..3c4ccd85b4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -976,7 +976,12 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
-    p = block->host + offset;
+    if (pss->page_copy) {
+        p = pss->page_copy;
+    } else {
+        p = block->host + offset;
+    }
+
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
     /* In doubt sent page as normal */
@@ -1003,13 +1008,18 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     } else {
         pages = save_zero_page(rs, block, offset, p);
         if (pages > 0) {
-            /* Must let xbzrle know, otherwise a previous (now 0'd) cached
-             * page would be stale
-             */
-            xbzrle_cache_zero_page(rs, current_addr);
-            ram_release_pages(block->idstr, offset, pages);
+            if (pss->page_copy) {
+                qemu_madvise(p, TARGET_PAGE_SIZE, MADV_DONTNEED);
+            } else {
+                /* Must let xbzrle know, otherwise a previous (now 0'd) cached
+                 * page would be stale
+                 */
+                xbzrle_cache_zero_page(rs, current_addr);
+                ram_release_pages(block->idstr, offset, pages);
+            }
         } else if (!rs->ram_bulk_stage &&
-                   !migration_in_postcopy() && migrate_use_xbzrle()) {
+                   !migration_in_postcopy() && migrate_use_xbzrle() &&
+                   !migrate_background_snapshot()) {
             pages = save_xbzrle_page(rs, &p, current_addr, block,
                                      offset, last_stage);
             if (!last_stage) {
@@ -1026,9 +1036,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
         ram_counters.transferred +=
             save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
-            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                                  migrate_release_ram() &
-                                  migration_in_postcopy());
+            bool may_free = migrate_background_snapshot() ||
+                            (migrate_release_ram() &&
+                             migration_in_postcopy());
+            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE, may_free);
         } else {
             qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         }
@@ -1269,7 +1280,8 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
  * @rs: current RAM state
  * @offset: used to return the offset within the RAMBlock
  */
-static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
+static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
+                              void **page_copy)
 {
     RAMBlock *block = NULL;
 
@@ -1279,10 +1291,14 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
+        *page_copy = entry->page_copy;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
             entry->offset += TARGET_PAGE_SIZE;
+            if (entry->page_copy) {
+                entry->page_copy += TARGET_PAGE_SIZE / sizeof(void *);
+            }
         } else {
             memory_region_unref(block->mr);
             QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
@@ -1309,9 +1325,10 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
     RAMBlock  *block;
     ram_addr_t offset;
     bool dirty;
+    void *page_copy;
 
     do {
-        block = unqueue_page(rs, &offset);
+        block = unqueue_page(rs, &offset, &page_copy);
         /*
          * We're sending this page, and since it's postcopy nothing else
          * will dirty it, and we must make sure it doesn't get sent again
@@ -1349,6 +1366,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
          */
         pss->block = block;
         pss->page = offset >> TARGET_PAGE_BITS;
+        pss->page_copy = page_copy;
     }
 
     return !!block;
@@ -1386,17 +1404,25 @@ static void migration_page_queue_free(RAMState *rs)
  *
  * @rbname: Name of the RAMBLock of the request. NULL means the
  *          same that last one.
+ * @block: RAMBlock to use. block and rbname have mutualy exclusive
+ *         semantic with higher priority of the block.
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
+ * @page_copy: the address the page should be written from
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len, void *page_copy)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
 
     ram_counters.postcopy_requests++;
+
     rcu_read_lock();
-    if (!rbname) {
+
+    if (block) {
+        ramblock = block;
+    } else if (!rbname) {
         /* Reuse last RAMBlock */
         ramblock = rs->last_req_rb;
 
@@ -1431,6 +1457,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     new_entry->rb = ramblock;
     new_entry->offset = start;
     new_entry->len = len;
+    new_entry->page_copy = page_copy;
 
     memory_region_ref(ramblock->mr);
     qemu_mutex_lock(&rs->src_page_req_mutex);
@@ -1468,7 +1495,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
          * xbzrle can do better than compression.
          */
         if (migrate_use_compression() &&
-            (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+            (rs->ram_bulk_stage || !migrate_use_xbzrle()) &&
+            !migrate_background_snapshot()) {
             res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
@@ -1706,6 +1734,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     pss.block = rs->last_seen_block;
     pss.page = rs->last_page;
     pss.complete_round = false;
+    pss.page_copy = NULL;
 
     if (!pss.block) {
         pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
diff --git a/migration/ram.h b/migration/ram.h
index 4c463597a5..c3679ba65e 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -46,7 +46,8 @@ int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len, void *page_copy);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
                            unsigned long pages);
-- 
2.17.0
