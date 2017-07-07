Received: from eggs.gnu.org ([2001:4830:134:3::10]:41167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkn-0004W4-9q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkm-0007Vc-58
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:17 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:18 +0200
Message-Id: <1499447335-6125-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 003/100] block: Simplify use of BDRV_BLOCK_RAW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The lone caller that cares about a return of BDRV_BLOCK_RAW
(namely, io.c:bdrv_co_get_block_status) completely replaces the
return value, so there is no point in passing BDRV_BLOCK_DATA.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c        | 2 +-
 block/mirror.c        | 2 +-
 block/raw-format.c    | 2 +-
 block/vpc.c           | 2 +-
 include/block/block.h | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 8c09c3d..524bd54 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -253,7 +253,7 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
 {
     *pnum = nb_sectors;
     *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 68744a1..61a862d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1058,7 +1058,7 @@ static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
 {
     *pnum = nb_sectors;
     *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }
 
diff --git a/block/raw-format.c b/block/raw-format.c
index 0d185fe..1ea8c2d 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -259,7 +259,7 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
     *pnum = nb_sectors;
     *file = bs->file->bs;
     sector_num += s->offset / BDRV_SECTOR_SIZE;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }
 
diff --git a/block/vpc.c b/block/vpc.c
index 4240ba9..b313c68 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -701,7 +701,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
     if (be32_to_cpu(footer->type) == VHD_FIXED) {
         *pnum = nb_sectors;
         *file = bs->file->bs;
-        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
                (sector_num << BDRV_SECTOR_BITS);
     }
 
diff --git a/include/block/block.h b/include/block/block.h
index 4c149ad..afe1b61 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -132,9 +132,9 @@ typedef struct HDGeometry {
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this layer
  *
  * Internal flag:
- * BDRV_BLOCK_RAW: used internally to indicate that the request was
- *                 answered by a passthrough driver such as raw and that the
- *                 block layer should recompute the answer from bs->file.
+ * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
+ *                 that the block layer recompute the answer from the returned
+ *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
  *
  * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
  * represent the offset in the returned BDS that is allocated for the
-- 
1.8.3.1
