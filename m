Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AE-0005Nx-QL
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AD-00080q-MM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7AD-0007zj-E1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76F27EEF06
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:25 +0200
Message-Id: <20170406130913.2232-7-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/54] ram: Move bitmap_sync_count into RAMState
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a59140b..935311d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -45,8 +45,6 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 
-static uint64_t bitmap_sync_count;
-
 /***********************************************************/
 /* ram save/restore */
 
@@ -154,6 +152,8 @@ struct RAMState {
     bool ram_bulk_stage;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
+    /* How many times we have synchronized the bitmap */
+    uint64_t bitmap_sync_count;
 };
 typedef struct RAMState RAMState;
 
@@ -471,7 +471,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
     cache_insert(XBZRLE.cache, current_addr, ZERO_TARGET_PAGE,
-                 bitmap_sync_count);
+                 rs->bitmap_sync_count);
 }
 
 #define ENCODING_FLAG_XBZRLE 0x1
@@ -483,6 +483,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
  *          0 means that page is identical to the one already sent
  *          -1 means that xbzrle would be longer than normal
  *
+ * @rs: current RAM state
  * @f: QEMUFile where to send the data
  * @current_data: pointer to the address of the page contents
  * @current_addr: addr of the page
@@ -491,7 +492,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
+static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
                             ram_addr_t current_addr, RAMBlock *block,
                             ram_addr_t offset, bool last_stage,
                             uint64_t *bytes_transferred)
@@ -499,11 +500,11 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
     int encoded_len = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
 
-    if (!cache_is_cached(XBZRLE.cache, current_addr, bitmap_sync_count)) {
+    if (!cache_is_cached(XBZRLE.cache, current_addr, rs->bitmap_sync_count)) {
         acct_info.xbzrle_cache_miss++;
         if (!last_stage) {
             if (cache_insert(XBZRLE.cache, current_addr, *current_data,
-                             bitmap_sync_count) == -1) {
+                             rs->bitmap_sync_count) == -1) {
                 return -1;
             } else {
                 /* update *current_data when the page has been
@@ -658,7 +659,7 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     int64_t bytes_xfer_now;
 
-    bitmap_sync_count++;
+    rs->bitmap_sync_count++;
 
     if (!bytes_xfer_prev) {
         bytes_xfer_prev = ram_bytes_transferred();
@@ -720,9 +721,9 @@ static void migration_bitmap_sync(RAMState *rs)
         start_time = end_time;
         num_dirty_pages_period = 0;
     }
-    s->dirty_sync_count = bitmap_sync_count;
+    s->dirty_sync_count = rs->bitmap_sync_count;
     if (migrate_use_events()) {
-        qapi_event_send_migration_pass(bitmap_sync_count, NULL);
+        qapi_event_send_migration_pass(rs->bitmap_sync_count, NULL);
     }
 }
 
@@ -829,7 +830,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
             ram_release_pages(ms, block->idstr, pss->offset, pages);
         } else if (!rs->ram_bulk_stage &&
                    !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
-            pages = save_xbzrle_page(f, &p, current_addr, block,
+            pages = save_xbzrle_page(rs, f, &p, current_addr, block,
                                      offset, last_stage, bytes_transferred);
             if (!last_stage) {
                 /* Can't send this cached data async, since the cache page
@@ -1999,7 +2000,7 @@ static int ram_save_init_globals(RAMState *rs)
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
     rs->dirty_rate_high_cnt = 0;
-    bitmap_sync_count = 0;
+    rs->bitmap_sync_count = 0;
     migration_bitmap_sync_init();
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
