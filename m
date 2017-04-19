Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whz-00048S-ER
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0why-00078U-FQ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0why-00078E-71
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1818A75EAA
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:53 +0200
Message-Id: <20170419205923.8808-30-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 29/59] ram: Move bytes_transferred into RAMState
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
 migration/ram.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f6ae17f..7fbaa52 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -198,6 +198,8 @@ struct RAMState {
     uint64_t xbzrle_overflows;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* total number of bytes transferred */
+    uint64_t bytes_transferred;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -247,6 +249,11 @@ static ram_addr_t ram_save_remaining(void)
     return ram_state.migration_dirty_pages;
 }
 
+uint64_t ram_bytes_transferred(void)
+{
+    return ram_state.bytes_transferred;
+}
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -871,9 +878,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
     return bytes_sent;
 }
 
-static uint64_t bytes_transferred;
-
-static void flush_compressed_data(QEMUFile *f)
+static void flush_compressed_data(RAMState *rs, QEMUFile *f)
 {
     int idx, len, thread_count;
 
@@ -894,7 +899,7 @@ static void flush_compressed_data(QEMUFile *f)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(f, comp_param[idx].file);
-            bytes_transferred += len;
+            rs->bytes_transferred += len;
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
     }
@@ -990,7 +995,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
          * is used to avoid resending the block name.
          */
         if (block != rs->last_sent_block) {
-            flush_compressed_data(f);
+            flush_compressed_data(rs, f);
             pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
@@ -1066,7 +1071,7 @@ static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
                  */
-                flush_compressed_data(f);
+                flush_compressed_data(rs, f);
                 compression_switch = false;
             }
         }
@@ -1450,7 +1455,7 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
         rs->zero_pages += pages;
     } else {
         rs->norm_pages += pages;
-        bytes_transferred += size;
+        rs->bytes_transferred += size;
         qemu_update_position(f, size);
     }
 }
@@ -1460,11 +1465,6 @@ uint64_t ram_bytes_remaining(void)
     return ram_save_remaining() * TARGET_PAGE_SIZE;
 }
 
-uint64_t ram_bytes_transferred(void)
-{
-    return bytes_transferred;
-}
-
 uint64_t ram_bytes_total(void)
 {
     RAMBlock *block;
@@ -2027,7 +2027,6 @@ static int ram_state_init(RAMState *rs)
 
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
-    bytes_transferred = 0;
     ram_state_reset(rs);
 
     rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
@@ -2139,7 +2138,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
-        pages = ram_find_and_save_block(rs, f, false, &bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, false, &rs->bytes_transferred);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2161,7 +2160,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(f);
+    flush_compressed_data(rs, f);
     rcu_read_unlock();
 
     /*
@@ -2171,7 +2170,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    bytes_transferred += 8;
+    rs->bytes_transferred += 8;
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
@@ -2210,14 +2209,14 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         int pages;
 
         pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
-                                        &bytes_transferred);
+                                        &rs->bytes_transferred);
         /* no more blocks to sent */
         if (pages == 0) {
             break;
         }
     }
 
-    flush_compressed_data(f);
+    flush_compressed_data(rs, f);
     ram_control_after_iterate(f, RAM_CONTROL_FINISH);
 
     rcu_read_unlock();
-- 
2.9.3
