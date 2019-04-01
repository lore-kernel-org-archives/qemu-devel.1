Received: from eggs.gnu.org ([209.51.188.92]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhd-0007Os-PI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhc-0006j7-75
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:13 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  1 Apr 2019 15:06:03 +0300
Message-Id: <1554120365-39119-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/3] block: include base when checking image
 chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com, berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

This patch is used in the 'block/stream: introduce a bottom node'
that is following. Instead of the base node, the caller may pass
the node that has the base as its backing image to the new function
bdrv_is_allocated_above_inclusive() and get rid of the dependency
on the base that may change during commit/stream parallel jobs.
If the specified base is not found in the backing image chain, the
function fails.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/io.c            | 32 +++++++++++++++++++++++++++-----
 include/block/block.h |  5 ++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b..7edeeb2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2317,7 +2317,8 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
  * Return true if (a prefix of) the given range is allocated in any image
- * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
+ * between BASE and TOP (TOP included). To check the BASE image, set the
+ * 'base_included' to 'true'. The BASE can be NULL to check if the given
  * offset is allocated in any image of the chain.  Return false otherwise,
  * or negative errno on failure.
  *
@@ -2329,16 +2330,18 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * but 'pnum' will only be 0 when end of file is reached.
  *
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum)
+static int bdrv_do_is_allocated_above(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      bool base_included, int64_t offset,
+                                      int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n = bytes;
+    assert(base || !base_included);
 
     intermediate = top;
-    while (intermediate && intermediate != base) {
+    while (base_included || intermediate != base) {
         int64_t pnum_inter;
         int64_t size_inter;
 
@@ -2360,6 +2363,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n = pnum_inter;
         }
 
+        if (intermediate == base) {
+            break;
+        }
+
         intermediate = backing_bs(intermediate);
     }
 
@@ -2367,6 +2374,21 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
+int bdrv_is_allocated_above(BlockDriverState *top,
+                            BlockDriverState *base,
+                            int64_t offset, int64_t bytes, int64_t *pnum)
+{
+    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
+}
+
+int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      int64_t offset, int64_t bytes,
+                                      int64_t *pnum)
+{
+    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
diff --git a/include/block/block.h b/include/block/block.h
index c7a2619..a7846d9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -448,7 +448,10 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum);
-
+int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      int64_t offset, int64_t bytes,
+                                      int64_t *pnum);
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
-- 
1.8.3.1
