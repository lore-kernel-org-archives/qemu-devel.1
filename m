Received: from eggs.gnu.org ([2001:4830:134:3::10]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dL-0000B9-V7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dK-0000jJ-Is
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dK-0000j5-9r
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44F54C04B31F
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:41 +0100
Message-Id: <20170323204544.12015-49-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 48/51] ram: Use ramblock and page offset
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
 migration/ram.c        | 56 ++++++++++++++++++++++----------------------------
 migration/trace-events |  2 +-
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ef3b428..3f283ba 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -611,12 +611,10 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
  * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
  * @start: page where we start the search
- * @page: pointer into where to store the dirty page
  */
 static inline
 unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
-                                          unsigned long start,
-                                          unsigned long *page)
+                                          unsigned long start)
 {
     unsigned long base = rb->offset >> TARGET_PAGE_BITS;
     unsigned long nr = base + start;
@@ -633,17 +631,18 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
         next = find_next_bit(bitmap, size, nr);
     }
 
-    *page = next;
     return next - base;
 }
 
 static inline bool migration_bitmap_clear_dirty(RAMState *rs,
+                                                RAMBlock *rb,
                                                 unsigned long page)
 {
     bool ret;
     unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
+    unsigned long nr = (rb->offset >> TARGET_PAGE_BITS) + page;
 
-    ret = test_and_clear_bit(page, bitmap);
+    ret = test_and_clear_bit(nr, bitmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
@@ -1057,10 +1056,9 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
  * @again: set to false if the search has scanned the whole of RAM
  * @page: pointer into where to store the dirty page
  */
-static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
-                             bool *again, unsigned long *page)
+static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
 {
-    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page, page);
+    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
         pss->page >= rs->last_page) {
         /*
@@ -1110,8 +1108,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
  * @offset: used to return the offset within the RAMBlock
  * @page: pointer into where to store the dirty page
  */
-static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
-                              unsigned long *page)
+static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
 {
     RAMBlock *block = NULL;
 
@@ -1121,7 +1118,6 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
-        *page = (entry->offset + entry->rb->offset) >> TARGET_PAGE_BITS;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
@@ -1148,15 +1144,14 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
  * @pss: data about the state of the current dirty page scan
  * @page: pointer into where to store the dirty page
  */
-static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
-                            unsigned long *page)
+static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
 {
     RAMBlock  *block;
     ram_addr_t offset;
     bool dirty;
 
     do {
-        block = unqueue_page(rs, &offset, page);
+        block = unqueue_page(rs, &offset);
         /*
          * We're sending this page, and since it's postcopy nothing else
          * will dirty it, and we must make sure it doesn't get sent again
@@ -1165,16 +1160,18 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
          */
         if (block) {
             unsigned long *bitmap;
+            unsigned long page;
+
             bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-            dirty = test_bit(*page, bitmap);
+            page = (block->offset + offset) >> TARGET_PAGE_BITS;
+            dirty = test_bit(page, bitmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
-                    *page,
-                    test_bit(*page,
+                    page,
+                    test_bit(page,
                              atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
             } else {
-                trace_get_queued_page(block->idstr, (uint64_t)offset,
-                                     *page);
+                trace_get_queued_page(block->idstr, (uint64_t)offset, page);
             }
         }
 
@@ -1300,16 +1297,17 @@ err:
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @page: page number of the dirty page
  */
 static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
-                                bool last_stage, unsigned long page)
+                                bool last_stage)
 {
     int res = 0;
 
     /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(rs, page)) {
+    if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
         unsigned long *unsentmap;
+        unsigned long page =
+            (pss->block->offset >> TARGET_PAGE_BITS) + pss->page;
         if (!rs->preffer_xbzrle && migrate_use_compression()) {
             res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
@@ -1343,25 +1341,22 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
  * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @page: Page number of the dirty page
  */
 static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
-                              bool last_stage,
-                              unsigned long page)
+                              bool last_stage)
 {
     int tmppages, pages = 0;
     size_t pagesize_bits =
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
 
     do {
-        tmppages = ram_save_target_page(rs, pss, last_stage, page);
+        tmppages = ram_save_target_page(rs, pss, last_stage);
         if (tmppages < 0) {
             return tmppages;
         }
 
         pages += tmppages;
         pss->page++;
-        page++;
     } while (pss->page & (pagesize_bits - 1));
 
     /* The offset we leave with is the last one we looked at */
@@ -1388,7 +1383,6 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     PageSearchStatus pss;
     int pages = 0;
     bool again, found;
-    unsigned long page; /* Page number of the dirty page */
 
     /* No dirty page as there is zero RAM */
     if (!ram_bytes_total()) {
@@ -1405,15 +1399,15 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 
     do {
         again = true;
-        found = get_queued_page(rs, &pss, &page);
+        found = get_queued_page(rs, &pss);
 
         if (!found) {
             /* priority queue empty, so just search for something dirty */
-            found = find_dirty_block(rs, &pss, &again, &page);
+            found = find_dirty_block(rs, &pss, &again);
         }
 
         if (found) {
-            pages = ram_save_host_page(rs, &pss, last_stage, page);
+            pages = ram_save_host_page(rs, &pss, last_stage);
         }
     } while (!pages && again);
 
diff --git a/migration/trace-events b/migration/trace-events
index 7372ce2..0a3f033 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -63,7 +63,7 @@ put_qtailq_end(const char *name, const char *reason) "%s %s"
 qemu_file_fclose(void) ""
 
 # migration/ram.c
-get_queued_page(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr) "%s/%" PRIx64 " ram_addr=%" PRIx64
+get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page) "%s/%" PRIx64 " page=%lu"
 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr, int sent) "%s/%" PRIx64 " ram_addr=%" PRIx64 " (sent=%d)"
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
-- 
2.9.3
