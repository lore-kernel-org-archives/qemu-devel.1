Received: from eggs.gnu.org ([2001:4830:134:3::10]:34003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2D-0005HB-SD
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2C-0003hR-Vh
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:34 -0500
Message-Id: <20170418013356.3578-10-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 09/31] block: Switch
 bdrv_co_get_block_status_above() to byte-based
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

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/block/io.c b/block/io.c
index f7ece8d..10bc011 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1819,11 +1819,11 @@ out:
     return ret;
 }

-static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
+static int64_t coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
         BlockDriverState *base,
-        int64_t sector_num,
-        int nb_sectors,
-        int *pnum,
+        int64_t offset,
+        int64_t bytes,
+        int64_t *pnum,
         BlockDriverState **file)
 {
     BlockDriverState *p;
@@ -1831,41 +1831,32 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        int64_t count;
-
-        ret = bdrv_co_block_status(p, sector_num * BDRV_SECTOR_SIZE,
-                                   nb_sectors * BDRV_SECTOR_SIZE, &count,
-                                   file);
-        *pnum = count >> BDRV_SECTOR_BITS;
+        ret = bdrv_co_block_status(p, offset, bytes, pnum, file);
         if (ret < 0 || ret & BDRV_BLOCK_ALLOCATED) {
             break;
         }
-        /* [sector_num, pnum] unallocated on this layer, which could be only
-         * the first part of [sector_num, nb_sectors].  */
-        nb_sectors = MIN(nb_sectors, *pnum);
+        /* [offset, pnum] unallocated on this layer, which could be only
+         * the first part of [offset, bytes].  */
+        bytes = MIN(bytes, *pnum);
     }
     return ret;
 }

 /* Coroutine wrapper for bdrv_get_block_status_above() */
-static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
+static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
-    int n;

-    data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
-                                               data->offset >> BDRV_SECTOR_BITS,
-                                               data->bytes >> BDRV_SECTOR_BITS,
-                                               &n,
-                                               data->file);
-    *data->pnum = n * BDRV_SECTOR_SIZE;
+    data->ret = bdrv_co_block_status_above(data->bs, data->base,
+                                           data->offset, data->bytes,
+                                           data->pnum, data->file);
     data->done = true;
 }

 /*
- * Synchronous wrapper around bdrv_co_get_block_status_above().
+ * Synchronous wrapper around bdrv_co_block_status_above().
  *
- * See bdrv_co_get_block_status_above() for details.
+ * See bdrv_co_block_status_above() for details.
  */
 int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     BlockDriverState *base,
@@ -1887,10 +1878,9 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,

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
2.9.3
