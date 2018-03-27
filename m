Received: from eggs.gnu.org ([2001:4830:134:3::10]:56705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176S-0000yn-OP
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176R-00057q-8Z
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:44 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176R-00057d-3B
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:43 -0400
Received: by mail-pg0-x244.google.com with SMTP id t12so701897pgp.13
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:43 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:39 +0800
Message-Id: <20180327091043.30220-7-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 06/10] migration: move some code
 ram_save_host_page
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

Move some code from ram_save_target_page() to ram_save_host_page()
to make it be more readable for latter patches that dramatically
clean ram_save_target_page() up

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fc1fde7bb7..104d3d3e9f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1485,38 +1485,23 @@ err:
  * Returns the number of pages written
  *
  * @rs: current RAM state
- * @ms: current migration state
  * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
  */
 static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
                                 bool last_stage)
 {
-    int res = 0;
-
-    /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
-        /*
-         * If xbzrle is on, stop using the data compression after first
-         * round of migration even if compression is enabled. In theory,
-         * xbzrle can do better than compression.
-         */
-        if (migrate_use_compression() &&
-            (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
-            res = ram_save_compressed_page(rs, pss, last_stage);
-        } else {
-            res = ram_save_page(rs, pss, last_stage);
-        }
-
-        if (res < 0) {
-            return res;
-        }
-        if (pss->block->unsentmap) {
-            clear_bit(pss->page, pss->block->unsentmap);
-        }
+    /*
+     * If xbzrle is on, stop using the data compression after first
+     * round of migration even if compression is enabled. In theory,
+     * xbzrle can do better than compression.
+     */
+    if (migrate_use_compression() &&
+        (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+        return ram_save_compressed_page(rs, pss, last_stage);
     }
 
-    return res;
+    return ram_save_page(rs, pss, last_stage);
 }
 
 /**
@@ -1545,12 +1530,22 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
 
     do {
+        /* Check the pages is dirty and if it is send it */
+        if (!migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
+            pss->page++;
+            continue;
+        }
+
         tmppages = ram_save_target_page(rs, pss, last_stage);
         if (tmppages < 0) {
             return tmppages;
         }
 
         pages += tmppages;
+        if (pss->block->unsentmap) {
+            clear_bit(pss->page, pss->block->unsentmap);
+        }
+
         pss->page++;
     } while ((pss->page & (pagesize_bits - 1)) &&
              offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
-- 
2.14.3
