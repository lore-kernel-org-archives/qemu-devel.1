Received: from eggs.gnu.org ([2001:4830:134:3::10]:56746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176a-00014O-PO
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176Y-0005BK-3T
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:52 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:45356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176X-0005Ay-Rq
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:50 -0400
Received: by mail-pl0-x231.google.com with SMTP id n15-v6so1193068plp.12
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:49 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:41 +0800
Message-Id: <20180327091043.30220-9-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 08/10] migration: move calling
 save_zero_page to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

save_zero_page() is always our first approach to try, move it to
the common place before calling ram_save_compressed_page
and ram_save_page

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 105 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 46 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ce3ef4382d..771763985d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1040,15 +1040,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
     XBZRLE_cache_lock();
-    pages = save_zero_page(rs, block, offset);
-    if (pages > 0) {
-        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
-         * page would be stale
-         */
-        xbzrle_cache_zero_page(rs, current_addr);
-        ram_release_pages(block->idstr, offset, pages);
-    } else if (!rs->ram_bulk_stage &&
-               !migration_in_postcopy() && migrate_use_xbzrle()) {
+    if (!rs->ram_bulk_stage && !migration_in_postcopy() &&
+        migrate_use_xbzrle()) {
         pages = save_xbzrle_page(rs, &p, current_addr, block,
                                  offset, last_stage);
         if (!last_stage) {
@@ -1196,40 +1189,23 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
 
     p = block->host + offset;
 
-    /* When starting the process of a new block, the first page of
-     * the block should be sent out before other pages in the same
-     * block, and all the pages in last block should have been sent
-     * out, keeping this order is important, because the 'cont' flag
-     * is used to avoid resending the block name.
-     */
     if (block != rs->last_sent_block) {
-        flush_compressed_data(rs);
-        pages = save_zero_page(rs, block, offset);
-        if (pages > 0) {
-            ram_release_pages(block->idstr, offset, pages);
-        } else {
-            /*
-             * Make sure the first page is sent out before other pages.
-             *
-             * we post it as normal page as compression will take much
-             * CPU resource.
-             */
-            ram_counters.transferred += save_page_header(rs, rs->f, block,
-                                            offset | RAM_SAVE_FLAG_PAGE);
-            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                                  migrate_release_ram() &
-                                  migration_in_postcopy());
-            ram_counters.transferred += TARGET_PAGE_SIZE;
-            ram_counters.normal++;
-            pages = 1;
-        }
+        /*
+         * Make sure the first page is sent out before other pages.
+         *
+         * we post it as normal page as compression will take much
+         * CPU resource.
+         */
+        ram_counters.transferred += save_page_header(rs, rs->f, block,
+                                        offset | RAM_SAVE_FLAG_PAGE);
+        qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
+                              migrate_release_ram() &
+                              migration_in_postcopy());
+        ram_counters.transferred += TARGET_PAGE_SIZE;
+        ram_counters.normal++;
+        pages = 1;
     } else {
-        pages = save_zero_page(rs, block, offset);
-        if (pages == -1) {
-            pages = compress_page_with_multi_thread(rs, block, offset);
-        } else {
-            ram_release_pages(block->idstr, offset, pages);
-        }
+        pages = compress_page_with_multi_thread(rs, block, offset);
     }
 
     return pages;
@@ -1471,6 +1447,24 @@ err:
     return -1;
 }
 
+static bool save_page_use_compression(RAMState *rs)
+{
+    if (!migrate_use_compression()) {
+        return false;
+    }
+
+    /*
+     * If xbzrle is on, stop using the data compression after first
+     * round of migration even if compression is enabled. In theory,
+     * xbzrle can do better than compression.
+     */
+    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
+        return true;
+    }
+
+    return false;
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -1492,12 +1486,31 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
     }
 
     /*
-     * If xbzrle is on, stop using the data compression after first
-     * round of migration even if compression is enabled. In theory,
-     * xbzrle can do better than compression.
+     * When starting the process of a new block, the first page of
+     * the block should be sent out before other pages in the same
+     * block, and all the pages in last block should have been sent
+     * out, keeping this order is important, because the 'cont' flag
+     * is used to avoid resending the block name.
      */
-    if (migrate_use_compression() &&
-        (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+    if (block != rs->last_sent_block && save_page_use_compression(rs)) {
+            flush_compressed_data(rs);
+    }
+
+    res = save_zero_page(rs, block, offset);
+    if (res > 0) {
+        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
+         * page would be stale
+         */
+        if (!save_page_use_compression(rs)) {
+            XBZRLE_cache_lock();
+            xbzrle_cache_zero_page(rs, block->offset + offset);
+            XBZRLE_cache_unlock();
+        }
+        ram_release_pages(block->idstr, offset, res);
+        return res;
+    }
+
+    if (save_page_use_compression(rs)) {
         return ram_save_compressed_page(rs, pss, last_stage);
     }
 
-- 
2.14.3
