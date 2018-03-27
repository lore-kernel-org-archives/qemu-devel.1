Received: from eggs.gnu.org ([2001:4830:134:3::10]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176P-0000w5-Vo
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176O-00053R-Cz
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:41 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:41949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176O-00051e-55
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:40 -0400
Received: by mail-pg0-x232.google.com with SMTP id t10so707091pgv.8
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:40 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:38 +0800
Message-Id: <20180327091043.30220-6-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 05/10] migration: introduce
 control_save_page()
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

Abstract the common function control_save_page() to cleanup the code,
no logic is changed

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 174 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 89 insertions(+), 85 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e85191c1cb..fc1fde7bb7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -976,6 +976,44 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
     ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
 }
 
+/*
+ * @pages: the number of pages written by the control path,
+ *        < 0 - error
+ *        > 0 - number of pages written
+ *
+ * Return true if the pages has been saved, otherwise false is returned.
+ */
+static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
+                              int *pages)
+{
+    uint64_t bytes_xmit = 0;
+    int ret;
+
+    *pages = -1;
+    ret = ram_control_save_page(rs->f, block->offset, offset, TARGET_PAGE_SIZE,
+                                &bytes_xmit);
+    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
+        return false;
+    }
+
+    if (bytes_xmit) {
+        ram_counters.transferred += bytes_xmit;
+        *pages = 1;
+    }
+
+    if (ret == RAM_SAVE_CONTROL_DELAYED) {
+        return true;
+    }
+
+    if (bytes_xmit > 0) {
+        ram_counters.normal++;
+    } else if (bytes_xmit == 0) {
+        ram_counters.duplicate++;
+    }
+
+    return true;
+}
+
 /**
  * ram_save_page: send the given page to the stream
  *
@@ -992,56 +1030,36 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
 static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 {
     int pages = -1;
-    uint64_t bytes_xmit;
-    ram_addr_t current_addr;
     uint8_t *p;
-    int ret;
     bool send_async = true;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
+    ram_addr_t current_addr = block->offset + offset;
 
     p = block->host + offset;
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
-    /* In doubt sent page as normal */
-    bytes_xmit = 0;
-    ret = ram_control_save_page(rs->f, block->offset,
-                           offset, TARGET_PAGE_SIZE, &bytes_xmit);
-    if (bytes_xmit) {
-        ram_counters.transferred += bytes_xmit;
-        pages = 1;
+    if (control_save_page(rs, block, offset, &pages)) {
+        return pages;
     }
 
     XBZRLE_cache_lock();
-
-    current_addr = block->offset + offset;
-
-    if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-        if (ret != RAM_SAVE_CONTROL_DELAYED) {
-            if (bytes_xmit > 0) {
-                ram_counters.normal++;
-            } else if (bytes_xmit == 0) {
-                ram_counters.duplicate++;
-            }
-        }
-    } else {
-        pages = save_zero_page(rs, block, offset);
-        if (pages > 0) {
-            /* Must let xbzrle know, otherwise a previous (now 0'd) cached
-             * page would be stale
+    pages = save_zero_page(rs, block, offset);
+    if (pages > 0) {
+        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
+         * page would be stale
+         */
+        xbzrle_cache_zero_page(rs, current_addr);
+        ram_release_pages(block->idstr, offset, pages);
+    } else if (!rs->ram_bulk_stage &&
+               !migration_in_postcopy() && migrate_use_xbzrle()) {
+        pages = save_xbzrle_page(rs, &p, current_addr, block,
+                                 offset, last_stage);
+        if (!last_stage) {
+            /* Can't send this cached data async, since the cache page
+             * might get updated before it gets to the wire
              */
-            xbzrle_cache_zero_page(rs, current_addr);
-            ram_release_pages(block->idstr, offset, pages);
-        } else if (!rs->ram_bulk_stage &&
-                   !migration_in_postcopy() && migrate_use_xbzrle()) {
-            pages = save_xbzrle_page(rs, &p, current_addr, block,
-                                     offset, last_stage);
-            if (!last_stage) {
-                /* Can't send this cached data async, since the cache page
-                 * might get updated before it gets to the wire
-                 */
-                send_async = false;
-            }
+            send_async = false;
         }
     }
 
@@ -1176,63 +1194,49 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
                                     bool last_stage)
 {
     int pages = -1;
-    uint64_t bytes_xmit = 0;
     uint8_t *p;
-    int ret;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
     p = block->host + offset;
 
-    ret = ram_control_save_page(rs->f, block->offset,
-                                offset, TARGET_PAGE_SIZE, &bytes_xmit);
-    if (bytes_xmit) {
-        ram_counters.transferred += bytes_xmit;
-        pages = 1;
+    if (control_save_page(rs, block, offset, &pages)) {
+        return pages;
     }
-    if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-        if (ret != RAM_SAVE_CONTROL_DELAYED) {
-            if (bytes_xmit > 0) {
-                ram_counters.normal++;
-            } else if (bytes_xmit == 0) {
-                ram_counters.duplicate++;
-            }
+
+    /* When starting the process of a new block, the first page of
+     * the block should be sent out before other pages in the same
+     * block, and all the pages in last block should have been sent
+     * out, keeping this order is important, because the 'cont' flag
+     * is used to avoid resending the block name.
+     */
+    if (block != rs->last_sent_block) {
+        flush_compressed_data(rs);
+        pages = save_zero_page(rs, block, offset);
+        if (pages > 0) {
+            ram_release_pages(block->idstr, offset, pages);
+        } else {
+            /*
+             * Make sure the first page is sent out before other pages.
+             *
+             * we post it as normal page as compression will take much
+             * CPU resource.
+             */
+            ram_counters.transferred += save_page_header(rs, rs->f, block,
+                                            offset | RAM_SAVE_FLAG_PAGE);
+            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
+                                  migrate_release_ram() &
+                                  migration_in_postcopy());
+            ram_counters.transferred += TARGET_PAGE_SIZE;
+            ram_counters.normal++;
+            pages = 1;
         }
     } else {
-        /* When starting the process of a new block, the first page of
-         * the block should be sent out before other pages in the same
-         * block, and all the pages in last block should have been sent
-         * out, keeping this order is important, because the 'cont' flag
-         * is used to avoid resending the block name.
-         */
-        if (block != rs->last_sent_block) {
-            flush_compressed_data(rs);
-            pages = save_zero_page(rs, block, offset);
-            if (pages > 0) {
-                ram_release_pages(block->idstr, offset, pages);
-            } else {
-                /*
-                 * Make sure the first page is sent out before other pages.
-                 *
-                 * we post it as normal page as compression will take much
-                 * CPU resource.
-                 */
-                ram_counters.transferred += save_page_header(rs, rs->f, block,
-                                                offset | RAM_SAVE_FLAG_PAGE);
-                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                                      migrate_release_ram() &
-                                      migration_in_postcopy());
-                ram_counters.transferred += TARGET_PAGE_SIZE;
-                ram_counters.normal++;
-                pages = 1;
-            }
+        pages = save_zero_page(rs, block, offset);
+        if (pages == -1) {
+            pages = compress_page_with_multi_thread(rs, block, offset);
         } else {
-            pages = save_zero_page(rs, block, offset);
-            if (pages == -1) {
-                pages = compress_page_with_multi_thread(rs, block, offset);
-            } else {
-                ram_release_pages(block->idstr, offset, pages);
-            }
+            ram_release_pages(block->idstr, offset, pages);
         }
     }
 
-- 
2.14.3
