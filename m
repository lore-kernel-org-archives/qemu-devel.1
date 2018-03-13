Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1evep3-00031W-0P
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1evep1-0007if-Mf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:13 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1evep1-0007hZ-E3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:11 -0400
Received: by mail-pf0-x22f.google.com with SMTP id 68so5534434pfx.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 00:58:11 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 13 Mar 2018 15:57:37 +0800
Message-Id: <20180313075739.11194-7-xiaoguangrong@tencent.com>
In-Reply-To: <20180313075739.11194-1-xiaoguangrong@tencent.com>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 6/8] migration: move calling save_zero_page to
 the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

save_zero_page() is always our first approach to try, move it to
the common place before calling ram_save_compressed_page
and ram_save_page

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 106 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 839665d866..9627ce18e9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1021,15 +1021,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
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
+           migrate_use_xbzrle()) {
         pages = save_xbzrle_page(rs, &p, current_addr, block,
                                  offset, last_stage);
         if (!last_stage) {
@@ -1172,40 +1165,23 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
 
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
@@ -1447,6 +1423,25 @@ err:
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
+
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -1472,12 +1467,31 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         }
 
         /*
-         * If xbzrle is on, stop using the data compression after first
-         * round of migration even if compression is enabled. In theory,
-         * xbzrle can do better than compression.
+         * When starting the process of a new block, the first page of
+         * the block should be sent out before other pages in the same
+         * block, and all the pages in last block should have been sent
+         * out, keeping this order is important, because the 'cont' flag
+         * is used to avoid resending the block name.
          */
-        if (migrate_use_compression() &&
-            (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+        if (block != rs->last_sent_block && save_page_use_compression(rs)) {
+            flush_compressed_data(rs);
+        }
+
+        res = save_zero_page(rs, block, offset);
+        if (res > 0) {
+            /* Must let xbzrle know, otherwise a previous (now 0'd) cached
+             * page would be stale
+             */
+            if (!save_page_use_compression(rs)) {
+                XBZRLE_cache_lock();
+                xbzrle_cache_zero_page(rs, block->offset + offset);
+                XBZRLE_cache_unlock();
+            }
+            ram_release_pages(block->idstr, offset, res);
+            goto page_saved;
+        }
+
+        if (save_page_use_compression(rs)) {
             res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
-- 
2.14.3
