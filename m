Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d6-0007nN-5P
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d5-0004lv-3X
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:53 -0500
Message-Id: <20170703221456.30817-13-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/15] block: Switch
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to earlier changes
---
 block/io.c | 48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/block/io.c b/block/io.c
index 697db75..85353fa 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1865,12 +1865,12 @@ out:
     return ret;
 }

-static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
+static int64_t coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
         BlockDriverState *base,
         bool allocation,
-        int64_t sector_num,
-        int nb_sectors,
-        int *pnum,
+        int64_t offset,
+        int64_t bytes,
+        int64_t *pnum,
         BlockDriverState **file)
 {
     BlockDriverState *p;
@@ -1879,17 +1879,10 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        int64_t count;
-
-        ret = bdrv_co_block_status(p, allocation,
-                                   sector_num * BDRV_SECTOR_SIZE,
-                                   nb_sectors * BDRV_SECTOR_SIZE, &count,
-                                   file);
+        ret = bdrv_co_block_status(p, allocation, offset, bytes, pnum, file);
         if (ret < 0) {
             break;
         }
-        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-        *pnum = count >> BDRV_SECTOR_BITS;
         if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
             /*
              * Reading beyond the end of the file continues to read
@@ -1897,39 +1890,35 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
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
-    int n;

-    data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
-                                               data->allocation,
-                                               data->offset >> BDRV_SECTOR_BITS,
-                                               data->bytes >> BDRV_SECTOR_BITS,
-                                               &n,
-                                               data->file);
-    *data->pnum = n * BDRV_SECTOR_SIZE;
+    data->ret = bdrv_co_block_status_above(data->bs, data->base,
+                                           data->allocation,
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
 static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
                                               BlockDriverState *base,
@@ -1952,10 +1941,9 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,

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
2.9.4
