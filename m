Received: from eggs.gnu.org ([2001:4830:134:3::10]:53931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KU-0007d3-AC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KQ-0003mL-9f
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KP-0003lN-V3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:02 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D876580B56
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:51:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:14 +0100
Message-Id: <20170315135021.6978-25-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 24/31] ram: Move bytes_transferred into RAMState
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d39d185..f9933b2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -191,6 +191,8 @@ struct RAMState {
     uint64_t xbzrle_overflows;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* total number of bytes transferred */
+    uint64_t bytes_transferred;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -240,6 +242,11 @@ static ram_addr_t ram_save_remaining(void)
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
@@ -844,9 +851,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
     return bytes_sent;
 }
 
-static uint64_t bytes_transferred;
-
-static void flush_compressed_data(QEMUFile *f)
+static void flush_compressed_data(RAMState *rs, QEMUFile *f)
 {
     int idx, len, thread_count;
 
@@ -867,7 +872,7 @@ static void flush_compressed_data(QEMUFile *f)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(f, comp_param[idx].file);
-            bytes_transferred += len;
+            rs->bytes_transferred += len;
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
     }
@@ -963,7 +968,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
          * is used to avoid resending the block name.
          */
         if (block != rs->last_sent_block) {
-            flush_compressed_data(f);
+            flush_compressed_data(rs, f);
             pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
@@ -1039,7 +1044,7 @@ static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
                  */
-                flush_compressed_data(f);
+                flush_compressed_data(rs, f);
                 compression_switch = false;
             }
         }
@@ -1410,7 +1415,7 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
         ram_state.zero_pages += pages;
     } else {
         ram_state.norm_pages += pages;
-        bytes_transferred += size;
+        ram_state.bytes_transferred += size;
         qemu_update_position(f, size);
     }
 }
@@ -1420,11 +1425,6 @@ uint64_t ram_bytes_remaining(void)
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
@@ -1952,7 +1952,6 @@ static int ram_state_init(RAMState *rs)
 
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
-    bytes_transferred = 0;
     ram_state_reset(rs);
 
     rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
@@ -2047,7 +2046,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
-        pages = ram_find_and_save_block(rs, f, false, &bytes_transferred);
+        pages = ram_find_and_save_block(rs, f, false, &rs->bytes_transferred);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2069,7 +2068,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(f);
+    flush_compressed_data(rs, f);
     rcu_read_unlock();
 
     /*
@@ -2079,7 +2078,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    bytes_transferred += 8;
+    rs->bytes_transferred += 8;
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
@@ -2109,14 +2108,14 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
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
