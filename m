Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BN-0006eX-WE
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BJ-0000Ac-02
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7BI-0000AM-Mk
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6E136AADE
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:10:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:09:07 +0200
Message-Id: <20170406130913.2232-49-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 48/54] ram: Use page number instead of an
 address for the bitmap operations
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

We use an unsigned long for the page number.  Notice that our bitmaps
already got that for the index, so we have that limit.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

rename page to page_abs everywhere.
fix trace types for pages

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 76 ++++++++++++++++++++++----------------------------
 migration/trace-events |  4 +--
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1ef142f..52ab14b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -609,13 +609,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
  * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
  * @start: starting address (typically so we can continue from previous page)
- * @ram_addr_abs: pointer into which to store the address of the dirty page
- *                within the global ram_addr space
+ * @page_abs: pointer into where to store the dirty page
  */
 static inline
 ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                        ram_addr_t start,
-                                       ram_addr_t *ram_addr_abs)
+                                       unsigned long *page_abs)
 {
     unsigned long base = rb->offset >> TARGET_PAGE_BITS;
     unsigned long nr = base + (start >> TARGET_PAGE_BITS);
@@ -632,17 +631,17 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
         next = find_next_bit(bitmap, size, nr);
     }
 
-    *ram_addr_abs = next << TARGET_PAGE_BITS;
+    *page_abs = next;
     return (next - base) << TARGET_PAGE_BITS;
 }
 
-static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
+static inline bool migration_bitmap_clear_dirty(RAMState *rs,
+                                                unsigned long page_abs)
 {
     bool ret;
-    int nr = addr >> TARGET_PAGE_BITS;
     unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
 
-    ret = test_and_clear_bit(nr, bitmap);
+    ret = test_and_clear_bit(page_abs, bitmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
@@ -1054,14 +1053,13 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
  * @again: set to false if the search has scanned the whole of RAM
- * @ram_addr_abs: pointer into which to store the address of the dirty page
- *                within the global ram_addr space
+ * @page_abs: pointer into where to store the dirty page
  */
 static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
-                             bool *again, ram_addr_t *ram_addr_abs)
+                             bool *again, unsigned long *page_abs)
 {
     pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
-                                              ram_addr_abs);
+                                              page_abs);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
         pss->offset >= rs->last_offset) {
         /*
@@ -1108,11 +1106,10 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
  *
  * @rs: current RAM state
  * @offset: used to return the offset within the RAMBlock
- * @ram_addr_abs: pointer into which to store the address of the dirty page
- *                within the global ram_addr space
+ * @page_abs: pointer into where to store the dirty page
  */
 static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
-                              ram_addr_t *ram_addr_abs)
+                              unsigned long *page_abs)
 {
     RAMBlock *block = NULL;
 
@@ -1122,8 +1119,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
-        *ram_addr_abs = (entry->offset + entry->rb->offset) &
-                        TARGET_PAGE_MASK;
+        *page_abs = (entry->offset + entry->rb->offset) >> TARGET_PAGE_BITS;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
@@ -1148,18 +1144,17 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
  *
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
- * @ram_addr_abs: pointer into which to store the address of the dirty page
- *                within the global ram_addr space
+ * @page_abs: pointer into where to store the dirty page
  */
 static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
-                            ram_addr_t *ram_addr_abs)
+                            unsigned long *page_abs)
 {
     RAMBlock  *block;
     ram_addr_t offset;
     bool dirty;
 
     do {
-        block = unqueue_page(rs, &offset, ram_addr_abs);
+        block = unqueue_page(rs, &offset, page_abs);
         /*
          * We're sending this page, and since it's postcopy nothing else
          * will dirty it, and we must make sure it doesn't get sent again
@@ -1169,17 +1164,15 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
         if (block) {
             unsigned long *bitmap;
             bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-            dirty = test_bit(*ram_addr_abs >> TARGET_PAGE_BITS, bitmap);
+            dirty = test_bit(*page_abs, bitmap);
             if (!dirty) {
-                trace_get_queued_page_not_dirty(
-                    block->idstr, (uint64_t)offset,
-                    (uint64_t)*ram_addr_abs,
-                    test_bit(*ram_addr_abs >> TARGET_PAGE_BITS,
-                         atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
+                trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
+                    *page_abs,
+                    test_bit(*page_abs,
+                             atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
             } else {
-                trace_get_queued_page(block->idstr,
-                                      (uint64_t)offset,
-                                      (uint64_t)*ram_addr_abs);
+                trace_get_queued_page(block->idstr, (uint64_t)offset,
+                                     *page_abs);
             }
         }
 
@@ -1307,15 +1300,15 @@ err:
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
+ * @page_abs: page number of the dirty page
  */
 static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
-                                bool last_stage, ram_addr_t dirty_ram_abs)
+                                bool last_stage, unsigned long page_abs)
 {
     int res = 0;
 
     /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
+    if (migration_bitmap_clear_dirty(rs, page_abs)) {
         unsigned long *unsentmap;
         /*
          * If xbzrle is on, stop using the data compression after first
@@ -1335,7 +1328,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         }
         unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
         if (unsentmap) {
-            clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
+            clear_bit(page_abs, unsentmap);
         }
     }
 
@@ -1357,24 +1350,24 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
+ * @page_abs: Page number of the dirty page
  */
 static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
                               bool last_stage,
-                              ram_addr_t dirty_ram_abs)
+                              unsigned long page_abs)
 {
     int tmppages, pages = 0;
     size_t pagesize = qemu_ram_pagesize(pss->block);
 
     do {
-        tmppages = ram_save_target_page(rs, pss, last_stage, dirty_ram_abs);
+        tmppages = ram_save_target_page(rs, pss, last_stage, page_abs);
         if (tmppages < 0) {
             return tmppages;
         }
 
         pages += tmppages;
         pss->offset += TARGET_PAGE_SIZE;
-        dirty_ram_abs += TARGET_PAGE_SIZE;
+        page_abs++;
     } while (pss->offset & (pagesize - 1));
 
     /* The offset we leave with is the last one we looked at */
@@ -1401,8 +1394,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     PageSearchStatus pss;
     int pages = 0;
     bool again, found;
-    ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
-                                 ram_addr_t space */
+    unsigned long page_abs; /* Page number of the dirty page */
 
     /* No dirty page as there is zero RAM */
     if (!ram_bytes_total()) {
@@ -1419,15 +1411,15 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 
     do {
         again = true;
-        found = get_queued_page(rs, &pss, &dirty_ram_abs);
+        found = get_queued_page(rs, &pss, &page_abs);
 
         if (!found) {
             /* priority queue empty, so just search for something dirty */
-            found = find_dirty_block(rs, &pss, &again, &dirty_ram_abs);
+            found = find_dirty_block(rs, &pss, &again, &page_abs);
         }
 
         if (found) {
-            pages = ram_save_host_page(rs, &pss, last_stage, dirty_ram_abs);
+            pages = ram_save_host_page(rs, &pss, last_stage, page_abs);
         }
     } while (!pages && again);
 
diff --git a/migration/trace-events b/migration/trace-events
index 7372ce2..9514044 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -63,8 +63,8 @@ put_qtailq_end(const char *name, const char *reason) "%s %s"
 qemu_file_fclose(void) ""
 
 # migration/ram.c
-get_queued_page(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr) "%s/%" PRIx64 " ram_addr=%" PRIx64
-get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr, int sent) "%s/%" PRIx64 " ram_addr=%" PRIx64 " (sent=%d)"
+get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/%" PRIx64 " page_abs=%lu"
+get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/%" PRIx64 " page_abs=%lu (sent=%d)"
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
-- 
2.9.3
