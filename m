Received: from eggs.gnu.org ([2001:4830:134:3::10]:46042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dJ-00006F-SR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dI-0000it-OY
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dI-0000ih-GM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7817481F07
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:40 +0100
Message-Id: <20170323204544.12015-48-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 47/51] ram: Change offset field in
 PageSearchStatus to page
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

We are moving everything to work on pages, not addresses.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 57b776b..ef3b428 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -298,8 +298,8 @@ uint64_t ram_postcopy_requests(void)
 struct PageSearchStatus {
     /* Current block being searched */
     RAMBlock    *block;
-    /* Current offset to search from */
-    ram_addr_t   offset;
+    /* Current page to search from */
+    unsigned long page;
     /* Set once we wrap around */
     bool         complete_round;
 };
@@ -610,16 +610,16 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
  *
  * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
- * @start: starting address (typically so we can continue from previous page)
+ * @start: page where we start the search
  * @page: pointer into where to store the dirty page
  */
 static inline
-ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
-                                       ram_addr_t start,
-                                       unsigned long *page)
+unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
+                                          unsigned long start,
+                                          unsigned long *page)
 {
     unsigned long base = rb->offset >> TARGET_PAGE_BITS;
-    unsigned long nr = base + (start >> TARGET_PAGE_BITS);
+    unsigned long nr = base + start;
     uint64_t rb_size = rb->used_length;
     unsigned long size = base + (rb_size >> TARGET_PAGE_BITS);
     unsigned long *bitmap;
@@ -634,7 +634,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     }
 
     *page = next;
-    return (next - base) << TARGET_PAGE_BITS;
+    return next - base;
 }
 
 static inline bool migration_bitmap_clear_dirty(RAMState *rs,
@@ -812,7 +812,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     int ret;
     bool send_async = true;
     RAMBlock *block = pss->block;
-    ram_addr_t offset = pss->offset;
+    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
     p = block->host + offset;
 
@@ -844,7 +844,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
              * page would be stale
              */
             xbzrle_cache_zero_page(rs, current_addr);
-            ram_release_pages(block->idstr, pss->offset, pages);
+            ram_release_pages(block->idstr, offset, pages);
         } else if (!rs->ram_bulk_stage &&
                    !migration_in_postcopy() && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(rs, &p, current_addr, block,
@@ -987,7 +987,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
     uint8_t *p;
     int ret, blen;
     RAMBlock *block = pss->block;
-    ram_addr_t offset = pss->offset;
+    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
     p = block->host + offset;
 
@@ -1031,14 +1031,14 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
                 }
             }
             if (pages > 0) {
-                ram_release_pages(block->idstr, pss->offset, pages);
+                ram_release_pages(block->idstr, offset, pages);
             }
         } else {
             pages = save_zero_page(rs, block, offset, p);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(rs, block, offset);
             } else {
-                ram_release_pages(block->idstr, pss->offset, pages);
+                ram_release_pages(block->idstr, offset, pages);
             }
         }
     }
@@ -1060,10 +1060,9 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
 static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
                              bool *again, unsigned long *page)
 {
-    pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
-                                              page);
+    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page, page);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
-        pss->offset >= rs->last_page) {
+        pss->page >= rs->last_page) {
         /*
          * We've been once around the RAM and haven't found anything.
          * Give up.
@@ -1071,9 +1070,9 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
         *again = false;
         return false;
     }
-    if (pss->offset >= pss->block->used_length) {
+    if ((pss->page << TARGET_PAGE_BITS) >= pss->block->used_length) {
         /* Didn't find anything in this RAM Block */
-        pss->offset = 0;
+        pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
             /* Hit the end of the list */
@@ -1196,7 +1195,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
          * it just requested.
          */
         pss->block = block;
-        pss->offset = offset;
+        pss->page = offset >> TARGET_PAGE_BITS;
     }
 
     return !!block;
@@ -1351,7 +1350,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
                               unsigned long page)
 {
     int tmppages, pages = 0;
-    size_t pagesize = qemu_ram_pagesize(pss->block);
+    size_t pagesize_bits =
+        qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
 
     do {
         tmppages = ram_save_target_page(rs, pss, last_stage, page);
@@ -1360,12 +1360,12 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
         }
 
         pages += tmppages;
-        pss->offset += TARGET_PAGE_SIZE;
+        pss->page++;
         page++;
-    } while (pss->offset & (pagesize - 1));
+    } while (pss->page & (pagesize_bits - 1));
 
     /* The offset we leave with is the last one we looked at */
-    pss->offset -= TARGET_PAGE_SIZE;
+    pss->page--;
     return pages;
 }
 
@@ -1396,7 +1396,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     }
 
     pss.block = rs->last_seen_block;
-    pss.offset = rs->last_page << TARGET_PAGE_BITS;
+    pss.page = rs->last_page;
     pss.complete_round = false;
 
     if (!pss.block) {
@@ -1418,7 +1418,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     } while (!pages && again);
 
     rs->last_seen_block = pss.block;
-    rs->last_page = pss.offset >> TARGET_PAGE_BITS;
+    rs->last_page = pss.page;
 
     return pages;
 }
-- 
2.9.3
