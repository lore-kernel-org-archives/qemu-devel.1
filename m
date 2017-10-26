Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3M-0000bQ-Kn
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3G-00023H-Gy
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:19 +0200
Message-Id: <20171026131741.5059-14-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/35] block: Switch
 bdrv_co_get_block_status_above() to byte-based
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

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 68 ++++++++++++++++++++++----------------------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3a9a4c5db9..61b3477cd1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1976,33 +1976,26 @@ early_out:
     return ret;
 }
 
-static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
-        BlockDriverState *base,
-        bool want_zero,
-        int64_t sector_num,
-        int nb_sectors,
-        int *pnum,
-        BlockDriverState **file)
+static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
+                                                   BlockDriverState *base,
+                                                   bool want_zero,
+                                                   int64_t offset,
+                                                   int64_t bytes,
+                                                   int64_t *pnum,
+                                                   int64_t *map,
+                                                   BlockDriverState **file)
 {
     BlockDriverState *p;
-    int64_t ret = 0;
+    int ret = 0;
     bool first = true;
-    int64_t map = 0;
 
     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        int64_t count;
-
-        ret = bdrv_co_block_status(p, want_zero,
-                                   sector_num * BDRV_SECTOR_SIZE,
-                                   nb_sectors * BDRV_SECTOR_SIZE, &count,
-                                   &map, file);
+        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
+                                   file);
         if (ret < 0) {
             break;
         }
-        assert(QEMU_IS_ALIGNED(count | map, BDRV_SECTOR_SIZE));
-        ret |= map;
-        *pnum = count >> BDRV_SECTOR_BITS;
         if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
             /*
              * Reading beyond the end of the file continues to read
@@ -2010,47 +2003,35 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
              * unallocated length we learned from an earlier
              * iteration.
              */
-            *pnum = nb_sectors;
+            *pnum = bytes;
         }
         if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
             break;
         }
-        /* [sector_num, pnum] unallocated on this layer, which could be only
-         * the first part of [sector_num, nb_sectors].  */
-        nb_sectors = MIN(nb_sectors, *pnum);
+        /* [offset, pnum] unallocated on this layer, which could be only
+         * the first part of [offset, bytes].  */
+        bytes = MIN(bytes, *pnum);
         first = false;
     }
     return ret;
 }
 
 /* Coroutine wrapper for bdrv_get_block_status_above() */
-static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
+static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
-    int n = 0;
-    int64_t ret;
 
-    ret = bdrv_co_get_block_status_above(data->bs, data->base,
-                                         data->want_zero,
-                                         data->offset >> BDRV_SECTOR_BITS,
-                                         data->bytes >> BDRV_SECTOR_BITS,
-                                         &n,
-                                         data->file);
-    if (ret < 0) {
-        assert(INT_MIN <= ret);
-        data->ret = ret;
-    } else {
-        *data->pnum = n * BDRV_SECTOR_SIZE;
-        *data->map = ret & BDRV_BLOCK_OFFSET_MASK;
-        data->ret = ret & ~BDRV_BLOCK_OFFSET_MASK;
-    }
+    data->ret = bdrv_co_block_status_above(data->bs, data->base,
+                                           data->want_zero,
+                                           data->offset, data->bytes,
+                                           data->pnum, data->map, data->file);
     data->done = true;
 }
 
 /*
- * Synchronous wrapper around bdrv_co_get_block_status_above().
+ * Synchronous wrapper around bdrv_co_block_status_above().
  *
- * See bdrv_co_get_block_status_above() for details.
+ * See bdrv_co_block_status_above() for details.
  */
 static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           BlockDriverState *base,
@@ -2074,10 +2055,9 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
 
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
-        bdrv_get_block_status_above_co_entry(&data);
+        bdrv_block_status_above_co_entry(&data);
     } else {
-        co = qemu_coroutine_create(bdrv_get_block_status_above_co_entry,
-                                   &data);
+        co = qemu_coroutine_create(bdrv_block_status_above_co_entry, &data);
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-- 
2.13.6
