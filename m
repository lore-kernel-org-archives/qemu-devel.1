Received: from eggs.gnu.org ([2001:4830:134:3::10]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BO-0006fP-UB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BN-0000C3-8L
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7BM-0000Bn-Vb
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 138BD3DBE2
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:10:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:09:10 +0200
Message-Id: <20170406130913.2232-52-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 51/54] ram: Use ramblock and page offset
 instead of absolute offset
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

This removes the needto pass also the absolute offset.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 65 ++++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4132503..fc1f08f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -609,12 +609,10 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
  * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
  * @start: page where we start the search
- * @page_abs: pointer into where to store the dirty page
  */
 static inline
 unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
-                                          unsigned long start,
-                                          unsigned long *page_abs)
+                                          unsigned long start)
 {
     unsigned long base = rb->offset >> TARGET_PAGE_BITS;
     unsigned long nr = base + start;
@@ -631,17 +629,18 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
         next = find_next_bit(bitmap, size, nr);
     }
 
-    *page_abs = next;
     return next - base;
 }
 
 static inline bool migration_bitmap_clear_dirty(RAMState *rs,
-                                                unsigned long page_abs)
+                                                RAMBlock *rb,
+                                                unsigned long page)
 {
     bool ret;
     unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
+    unsigned long nr = (rb->offset >> TARGET_PAGE_BITS) + page;
 
-    ret = test_and_clear_bit(page_abs, bitmap);
+    ret = test_and_clear_bit(nr, bitmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
@@ -1053,13 +1052,10 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
  * @again: set to false if the search has scanned the whole of RAM
- * @page_abs: pointer into where to store the dirty page
  */
-static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
-                             bool *again, unsigned long *page_abs)
+static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
 {
-    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page,
-                                            page_abs);
+    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
         pss->page >= rs->last_page) {
         /*
@@ -1106,10 +1102,8 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
  *
  * @rs: current RAM state
  * @offset: used to return the offset within the RAMBlock
- * @page_abs: pointer into where to store the dirty page
  */
-static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
-                              unsigned long *page_abs)
+static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
 {
     RAMBlock *block = NULL;
 
@@ -1119,7 +1113,6 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
-        *page_abs = (entry->offset + entry->rb->offset) >> TARGET_PAGE_BITS;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
@@ -1144,17 +1137,15 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
  *
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
- * @page_abs: pointer into where to store the dirty page
  */
-static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
-                            unsigned long *page_abs)
+static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
 {
     RAMBlock  *block;
     ram_addr_t offset;
     bool dirty;
 
     do {
-        block = unqueue_page(rs, &offset, page_abs);
+        block = unqueue_page(rs, &offset);
         /*
          * We're sending this page, and since it's postcopy nothing else
          * will dirty it, and we must make sure it doesn't get sent again
@@ -1163,16 +1154,18 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
          */
         if (block) {
             unsigned long *bitmap;
+            unsigned long page;
+
             bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-            dirty = test_bit(*page_abs, bitmap);
+            page = (block->offset + offset) >> TARGET_PAGE_BITS;
+            dirty = test_bit(page, bitmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
-                    *page_abs,
-                    test_bit(*page_abs,
+                    page,
+                    test_bit(page,
                              atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
             } else {
-                trace_get_queued_page(block->idstr, (uint64_t)offset,
-                                     *page_abs);
+                trace_get_queued_page(block->idstr, (uint64_t)offset, page);
             }
         }
 
@@ -1300,22 +1293,22 @@ err:
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @page_abs: page number of the dirty page
  */
 static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
-                                bool last_stage, unsigned long page_abs)
+                                bool last_stage)
 {
     int res = 0;
 
     /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(rs, page_abs)) {
+    if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
         unsigned long *unsentmap;
         /*
          * If xbzrle is on, stop using the data compression after first
          * round of migration even if compression is enabled. In theory,
          * xbzrle can do better than compression.
          */
-
+        unsigned long page =
+            (pss->block->offset >> TARGET_PAGE_BITS) + pss->page;
         if (migrate_use_compression()
             && (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
@@ -1328,7 +1321,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         }
         unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
         if (unsentmap) {
-            clear_bit(page_abs, unsentmap);
+            clear_bit(page, unsentmap);
         }
     }
 
@@ -1350,25 +1343,22 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @page_abs: Page number of the dirty page
  */
 static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
-                              bool last_stage,
-                              unsigned long page_abs)
+                              bool last_stage)
 {
     int tmppages, pages = 0;
     size_t pagesize_bits =
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
 
     do {
-        tmppages = ram_save_target_page(rs, pss, last_stage, page_abs);
+        tmppages = ram_save_target_page(rs, pss, last_stage);
         if (tmppages < 0) {
             return tmppages;
         }
 
         pages += tmppages;
         pss->page++;
-        page_abs++;
     } while (pss->page & (pagesize_bits - 1));
 
     /* The offset we leave with is the last one we looked at */
@@ -1395,7 +1385,6 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     PageSearchStatus pss;
     int pages = 0;
     bool again, found;
-    unsigned long page_abs; /* Page number of the dirty page */
 
     /* No dirty page as there is zero RAM */
     if (!ram_bytes_total()) {
@@ -1412,15 +1401,15 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 
     do {
         again = true;
-        found = get_queued_page(rs, &pss, &page_abs);
+        found = get_queued_page(rs, &pss);
 
         if (!found) {
             /* priority queue empty, so just search for something dirty */
-            found = find_dirty_block(rs, &pss, &again, &page_abs);
+            found = find_dirty_block(rs, &pss, &again);
         }
 
         if (found) {
-            pages = ram_save_host_page(rs, &pss, last_stage, page_abs);
+            pages = ram_save_host_page(rs, &pss, last_stage);
         }
     } while (!pages && again);
 
-- 
2.9.3
