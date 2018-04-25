Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdn-0003f7-W3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdm-00034y-0D
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdl-00034l-Rn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:45 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:22 +0100
Message-Id: <20180425200326.72337-13-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 12/16] migration: move some code to
 ram_save_host_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Move some code from ram_save_target_page() to ram_save_host_page()
to make it be more readable for latter patches that dramatically
clean ram_save_target_page() up

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180330075128.26919-7-xiaoguangrong@tencent.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 79c7958993..c3628b020e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1483,38 +1483,23 @@ err:
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
@@ -1543,12 +1528,22 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
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
2.17.0
