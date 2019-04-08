Received: from eggs.gnu.org ([209.51.188.92]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYud-0003Gl-W6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYub-0003wg-DR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:22:31 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  8 Apr 2019 21:22:19 +0300
Message-Id: <1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 1/3] block: include base when checking image
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
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

This patch is used in the 'block/stream: introduce a bottom node'
that is following. Instead of the base node, the caller may pass
the node that has the base as its backing image to the function
bdrv_is_allocated_above() with a new parameter include_base = true
and get rid of the dependency on the base that may change during
commit/stream parallel jobs. Now, if the specified base is not
found in the backing image chain, the QEMU will crash.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/commit.c        |  2 +-
 block/io.c            | 14 +++++++++++---
 block/mirror.c        |  2 +-
 block/replication.c   |  2 +-
 block/stream.c        |  2 +-
 include/block/block.h |  3 ++-
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index ba60fef..1bd5284 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -177,7 +177,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
+        ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base), false,
                                       offset, COMMIT_BUFFER_SIZE, &n);
         copy = (ret == 1);
         trace_commit_one_iteration(s, offset, n, ret);
diff --git a/block/io.c b/block/io.c
index dfc153b..1ed4164 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2317,7 +2317,8 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
  * Return true if (a prefix of) the given range is allocated in any image
- * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
+ * between BASE and TOP (TOP included). To check the BASE image, set the
+ * 'include_base' to 'true'. The BASE can be NULL to check if the given
  * offset is allocated in any image of the chain.  Return false otherwise,
  * or negative errno on failure.
  *
@@ -2331,14 +2332,17 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum)
+                            bool include_base, int64_t offset,
+                            int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n = bytes;
 
+    assert(base || !include_base);
+
     intermediate = top;
-    while (intermediate && intermediate != base) {
+    while (include_base || intermediate != base) {
         int64_t pnum_inter;
         int64_t size_inter;
 
@@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n = pnum_inter;
         }
 
+        if (intermediate == base) {
+            break;
+        }
+
         intermediate = backing_bs(intermediate);
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb..923548f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -807,7 +807,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }
 
-        ret = bdrv_is_allocated_above(bs, base, offset, bytes, &count);
+        ret = bdrv_is_allocated_above(bs, base, false, offset, bytes, &count);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/replication.c b/block/replication.c
index 3d4dedd..fc8d2ad 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -272,7 +272,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     while (remaining_sectors > 0) {
         int64_t count;
 
-        ret = bdrv_is_allocated_above(top->bs, base->bs,
+        ret = bdrv_is_allocated_above(top->bs, base->bs, false,
                                       sector_num * BDRV_SECTOR_SIZE,
                                       remaining_sectors * BDRV_SECTOR_SIZE,
                                       &count);
diff --git a/block/stream.c b/block/stream.c
index bfaebb8..0920092 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -162,7 +162,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), base,
+            ret = bdrv_is_allocated_above(backing_bs(bs), base, false,
                                           offset, n, &n);
 
             /* Finish early if end of backing file has been reached */
diff --git a/include/block/block.h b/include/block/block.h
index c7a2619..f98e858 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -447,7 +447,8 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum);
+                            bool include_base, int64_t offset, int64_t bytes,
+                            int64_t *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
-- 
1.8.3.1
