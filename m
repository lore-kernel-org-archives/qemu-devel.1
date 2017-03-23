Received: from eggs.gnu.org ([2001:4830:134:3::10]:45683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9ct-000879-HA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cr-0000Tg-N9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cr-0000TQ-Eq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FB6164A55
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:20 +0100
Message-Id: <20170323204544.12015-28-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 27/51] ram: Use the RAMState bytes_transferred
 parameter
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

Somewhere it was passed by reference, just use it from RAMState.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 75 +++++++++++++++++++++------------------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 872ea23..3ae00e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -494,12 +494,10 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  */
 static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
                             ram_addr_t current_addr, RAMBlock *block,
-                            ram_addr_t offset, bool last_stage,
-                            uint64_t *bytes_transferred)
+                            ram_addr_t offset, bool last_stage)
 {
     int encoded_len = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
@@ -555,7 +553,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
     bytes_xbzrle += encoded_len + 1 + 2;
     rs->xbzrle_pages++;
     rs->xbzrle_bytes += bytes_xbzrle;
-    *bytes_transferred += bytes_xbzrle;
+    rs->bytes_transferred += bytes_xbzrle;
 
     return 1;
 }
@@ -727,20 +725,18 @@ static void migration_bitmap_sync(RAMState *rs)
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @p: pointer to the page
- * @bytes_transferred: increase it with the number of transferred bytes
  */
 static int save_zero_page(RAMState *rs, QEMUFile *f, RAMBlock *block,
-                          ram_addr_t offset,
-                          uint8_t *p, uint64_t *bytes_transferred)
+                          ram_addr_t offset, uint8_t *p)
 {
     int pages = -1;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
         rs->zero_pages++;
-        *bytes_transferred += save_page_header(f, block,
-                                               offset | RAM_SAVE_FLAG_COMPRESS);
+        rs->bytes_transferred +=
+            save_page_header(f, block, offset | RAM_SAVE_FLAG_COMPRESS);
         qemu_put_byte(f, 0);
-        *bytes_transferred += 1;
+        rs->bytes_transferred += 1;
         pages = 1;
     }
 
@@ -771,11 +767,9 @@ static void ram_release_pages(MigrationState *ms, const char *rbname,
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  */
 static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
-                         PageSearchStatus *pss, bool last_stage,
-                         uint64_t *bytes_transferred)
+                         PageSearchStatus *pss, bool last_stage)
 {
     int pages = -1;
     uint64_t bytes_xmit;
@@ -793,7 +787,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
     ret = ram_control_save_page(f, block->offset,
                            offset, TARGET_PAGE_SIZE, &bytes_xmit);
     if (bytes_xmit) {
-        *bytes_transferred += bytes_xmit;
+        rs->bytes_transferred += bytes_xmit;
         pages = 1;
     }
 
@@ -813,7 +807,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
             }
         }
     } else {
-        pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
+        pages = save_zero_page(rs, f, block, offset, p);
         if (pages > 0) {
             /* Must let xbzrle know, otherwise a previous (now 0'd) cached
              * page would be stale
@@ -823,7 +817,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
         } else if (!rs->ram_bulk_stage &&
                    !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(rs, f, &p, current_addr, block,
-                                     offset, last_stage, bytes_transferred);
+                                     offset, last_stage);
             if (!last_stage) {
                 /* Can't send this cached data async, since the cache page
                  * might get updated before it gets to the wire
@@ -835,7 +829,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
 
     /* XBZRLE overflow or normal page */
     if (pages == -1) {
-        *bytes_transferred += save_page_header(f, block,
+        rs->bytes_transferred += save_page_header(f, block,
                                                offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
             qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE,
@@ -844,7 +838,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
         } else {
             qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
         }
-        *bytes_transferred += TARGET_PAGE_SIZE;
+        rs->bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         rs->norm_pages++;
     }
@@ -912,8 +906,7 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
 }
 
 static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
-                                           RAMBlock *block, ram_addr_t offset,
-                                           uint64_t *bytes_transferred)
+                                           RAMBlock *block, ram_addr_t offset)
 {
     int idx, thread_count, bytes_xmit = -1, pages = -1;
 
@@ -930,7 +923,7 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
                 qemu_mutex_unlock(&comp_param[idx].mutex);
                 pages = 1;
                 rs->norm_pages++;
-                *bytes_transferred += bytes_xmit;
+                rs->bytes_transferred += bytes_xmit;
                 break;
             }
         }
@@ -956,12 +949,10 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  */
 static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
                                     QEMUFile *f,
-                                    PageSearchStatus *pss, bool last_stage,
-                                    uint64_t *bytes_transferred)
+                                    PageSearchStatus *pss, bool last_stage)
 {
     int pages = -1;
     uint64_t bytes_xmit = 0;
@@ -975,7 +966,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
     ret = ram_control_save_page(f, block->offset,
                                 offset, TARGET_PAGE_SIZE, &bytes_xmit);
     if (bytes_xmit) {
-        *bytes_transferred += bytes_xmit;
+        rs->bytes_transferred += bytes_xmit;
         pages = 1;
     }
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
@@ -995,7 +986,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
          */
         if (block != rs->last_sent_block) {
             flush_compressed_data(rs, f);
-            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
                 bytes_xmit = save_page_header(f, block, offset |
@@ -1003,7 +994,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
                 blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
                                                  migrate_compress_level());
                 if (blen > 0) {
-                    *bytes_transferred += bytes_xmit + blen;
+                    rs->bytes_transferred += bytes_xmit + blen;
                     rs->norm_pages++;
                     pages = 1;
                 } else {
@@ -1016,10 +1007,9 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             }
         } else {
             offset |= RAM_SAVE_FLAG_CONTINUE;
-            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p);
             if (pages == -1) {
-                pages = compress_page_with_multi_thread(rs, f, block, offset,
-                                                        bytes_transferred);
+                pages = compress_page_with_multi_thread(rs, f, block, offset);
             } else {
                 ram_release_pages(ms, block->idstr, pss->offset, pages);
             }
@@ -1296,13 +1286,11 @@ err:
  * @f: QEMUFile where to send the data
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
  */
 static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                                 PageSearchStatus *pss,
                                 bool last_stage,
-                                uint64_t *bytes_transferred,
                                 ram_addr_t dirty_ram_abs)
 {
     int res = 0;
@@ -1311,12 +1299,9 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
     if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
         unsigned long *unsentmap;
         if (compression_switch && migrate_use_compression()) {
-            res = ram_save_compressed_page(rs, ms, f, pss,
-                                           last_stage,
-                                           bytes_transferred);
+            res = ram_save_compressed_page(rs, ms, f, pss, last_stage);
         } else {
-            res = ram_save_page(rs, ms, f, pss, last_stage,
-                                bytes_transferred);
+            res = ram_save_page(rs, ms, f, pss, last_stage);
         }
 
         if (res < 0) {
@@ -1354,13 +1339,11 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
  * @f: QEMUFile where to send the data
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
  */
 static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
                               PageSearchStatus *pss,
                               bool last_stage,
-                              uint64_t *bytes_transferred,
                               ram_addr_t dirty_ram_abs)
 {
     int tmppages, pages = 0;
@@ -1368,7 +1351,7 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
 
     do {
         tmppages = ram_save_target_page(rs, ms, f, pss, last_stage,
-                                        bytes_transferred, dirty_ram_abs);
+                                        dirty_ram_abs);
         if (tmppages < 0) {
             return tmppages;
         }
@@ -1393,14 +1376,12 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
  * @rs: current RAM state
  * @f: QEMUFile where to send the data
  * @last_stage: if we are at the completion stage
- * @bytes_transferred: increase it with the number of transferred bytes
  *
  * On systems where host-page-size > target-page-size it will send all the
  * pages in a host page that are dirty.
  */
 
-static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
-                                   uint64_t *bytes_transferred)
+static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
 {
     PageSearchStatus pss;
     MigrationState *ms = migrate_get_current();
@@ -1432,8 +1413,7 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
         }
 
         if (found) {
-            pages = ram_save_host_page(rs, ms, f, &pss,
-                                       last_stage, bytes_transferred,
+            pages = ram_save_host_page(rs, ms, f, &pss, last_stage,
                                        dirty_ram_abs);
         }
     } while (!pages && again);
@@ -2136,7 +2116,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
-        pages = ram_find_and_save_block(rs, f, false, &rs->bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, false);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2206,8 +2186,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     while (true) {
         int pages;
 
-        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
-                                        &rs->bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state());
         /* no more blocks to sent */
         if (pages == 0) {
             break;
-- 
2.9.3
