Received: from eggs.gnu.org ([2001:4830:134:3::10]:34669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I36-00068v-PJ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I35-00048H-L5
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:56 -0500
Message-Id: <20170418013356.3578-32-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 31/31] block: Drop unused
 .bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers have been updated to provide the
byte-based .bdrv_co_block_status(), we can delete the sector-based
interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h |  3 ---
 block/io.c                | 59 ++++++++++++++++++++---------------------------
 2 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8f20bc3..25197d7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -174,9 +174,6 @@ struct BlockDriver {
      * BDRV_BLOCK_DATA, _ZERO, _OFFSET_VALID, and _RAW, and only
      * according to the current BDS.
      */
-    int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file);
     int64_t coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,
         int64_t offset, int64_t bytes, int64_t *pnum,
         BlockDriverState **file);
diff --git a/block/io.c b/block/io.c
index 361eeb8..0488d08 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1719,6 +1719,7 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     int64_t n; /* bytes */
     int64_t ret, ret2;
     BlockDriverState *tmp_file;
+    int64_t aligned_offset, aligned_bytes;

     total_size = bdrv_getlength(bs);
     if (total_size < 0) {
@@ -1738,7 +1739,7 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         bytes = n;
     }

-    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
+    if (!bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (bs->drv->protocol_name) {
@@ -1752,45 +1753,35 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     }
     *file = NULL;
     bdrv_inc_in_flight(bs);
-    if (bs->drv->bdrv_co_get_block_status) {
-        int count; /* sectors */

-        assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-        ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                                bytes >> BDRV_SECTOR_BITS,
-                                                &count, file);
-        *pnum = count * BDRV_SECTOR_SIZE;
-    } else {
-        /* Round out to request_alignment boundaries */
-        int64_t aligned_offset, aligned_bytes;
-
-        aligned_offset = QEMU_ALIGN_DOWN(offset, bs->bl.request_alignment);
-        aligned_bytes = ROUND_UP(offset + bytes,
-                                 bs->bl.request_alignment) - aligned_offset;
-        ret = bs->drv->bdrv_co_block_status(bs, aligned_offset, aligned_bytes,
-                                            &n, file);
-        /* Clamp pnum and ret to original request */
-        if (aligned_offset != offset && ret >= 0) {
-            int sectors = DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) -
-                DIV_ROUND_UP(aligned_offset, BDRV_SECTOR_SIZE);
-
-            assert(n >= offset - aligned_offset);
-            n -= offset - aligned_offset;
-            if (sectors) {
-                ret += sectors * BDRV_SECTOR_SIZE;
-            }
-        }
-        if (ret >= 0 && n > bytes) {
-            assert(aligned_bytes != bytes);
-            n = bytes;
-        }
-        *pnum = n;
-    }
+    /* Round out to request_alignment boundaries */
+    aligned_offset = QEMU_ALIGN_DOWN(offset, bs->bl.request_alignment);
+    aligned_bytes = ROUND_UP(offset + bytes,
+                             bs->bl.request_alignment) - aligned_offset;
+    ret = bs->drv->bdrv_co_block_status(bs, aligned_offset, aligned_bytes,
+                                        &n, file);
     if (ret < 0) {
         *pnum = 0;
         goto out;
     }

+    /* Clamp pnum and ret to original request */
+    if (aligned_offset != offset && ret >= 0) {
+        int sectors = DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) -
+            DIV_ROUND_UP(aligned_offset, BDRV_SECTOR_SIZE);
+
+        assert(n >= offset - aligned_offset);
+        n -= offset - aligned_offset;
+        if (sectors) {
+            ret += sectors * BDRV_SECTOR_SIZE;
+        }
+    }
+    if (n > bytes) {
+        assert(aligned_bytes != bytes);
+        n = bytes;
+    }
+    *pnum = n;
+
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
         ret = bdrv_block_status(*file, ret & BDRV_BLOCK_OFFSET_MASK,
-- 
2.9.3
