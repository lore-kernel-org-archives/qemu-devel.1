Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4N-0006bm-Q6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4H-0001JM-Ly
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:03 +0200
Message-Id: <20180515154033.19899-8-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/37] block: Drop last of the sector-based aio
 callbacks
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

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers with aio callbacks are using the
byte-based interfaces, we can remove the sector-based versions.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  6 ----
 block/io.c                | 84 ++++++++++++++++++++---------------------------
 2 files changed, 36 insertions(+), 54 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e772e3502b..0bba7ed024 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -141,15 +141,9 @@ struct BlockDriver {
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
 
     /* aio */
-    BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
-    BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
diff --git a/block/io.c b/block/io.c
index 407bc25df4..6b110b207a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -925,31 +925,14 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
         return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
     }
 
-    /* FIXME - no need to calculate these if .bdrv_aio_preadv exists */
-    sector_num = offset >> BDRV_SECTOR_BITS;
-    nb_sectors = bytes >> BDRV_SECTOR_BITS;
-
-    if (!drv->bdrv_aio_preadv) {
-        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
-    }
-
-    if (drv->bdrv_co_readv) {
-        return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
-    } else {
+    if (drv->bdrv_aio_preadv) {
         BlockAIOCB *acb;
         CoroutineIOCompletion co = {
             .coroutine = qemu_coroutine_self(),
         };
 
-        if (drv->bdrv_aio_preadv) {
-            acb = drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
-                                       bdrv_co_io_em_complete, &co);
-        } else {
-            acb = drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
-                                      bdrv_co_io_em_complete, &co);
-        }
+        acb = drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
+                                   bdrv_co_io_em_complete, &co);
         if (acb == NULL) {
             return -EIO;
         } else {
@@ -957,6 +940,16 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
             return co.ret;
         }
     }
+
+    sector_num = offset >> BDRV_SECTOR_BITS;
+    nb_sectors = bytes >> BDRV_SECTOR_BITS;
+
+    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    assert(drv->bdrv_co_readv);
+
+    return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
 }
 
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
@@ -981,45 +974,40 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
         goto emulate_flags;
     }
 
-    /* FIXME - no need to calculate these if .bdrv_aio_pwritev exists */
-    sector_num = offset >> BDRV_SECTOR_BITS;
-    nb_sectors = bytes >> BDRV_SECTOR_BITS;
-
-    if (!drv->bdrv_aio_pwritev) {
-        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
-    }
-
-    if (drv->bdrv_co_writev_flags) {
-        ret = drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qiov,
-                                        flags & bs->supported_write_flags);
-        flags &= ~bs->supported_write_flags;
-    } else if (drv->bdrv_co_writev) {
-        assert(!bs->supported_write_flags);
-        ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov);
-    } else {
+    if (drv->bdrv_aio_pwritev) {
         BlockAIOCB *acb;
         CoroutineIOCompletion co = {
             .coroutine = qemu_coroutine_self(),
         };
 
-        if (drv->bdrv_aio_pwritev) {
-            acb = drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
-                                        flags & bs->supported_write_flags,
-                                        bdrv_co_io_em_complete, &co);
-            flags &= ~bs->supported_write_flags;
-        } else {
-            assert(!bs->supported_write_flags);
-            acb = drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
-                                       bdrv_co_io_em_complete, &co);
-        }
+        acb = drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
+                                    flags & bs->supported_write_flags,
+                                    bdrv_co_io_em_complete, &co);
+        flags &= ~bs->supported_write_flags;
         if (acb == NULL) {
             ret = -EIO;
         } else {
             qemu_coroutine_yield();
             ret = co.ret;
         }
+        goto emulate_flags;
+    }
+
+    sector_num = offset >> BDRV_SECTOR_BITS;
+    nb_sectors = bytes >> BDRV_SECTOR_BITS;
+
+    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+
+    if (drv->bdrv_co_writev_flags) {
+        ret = drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qiov,
+                                        flags & bs->supported_write_flags);
+        flags &= ~bs->supported_write_flags;
+    } else {
+        assert(drv->bdrv_co_writev);
+        assert(!bs->supported_write_flags);
+        ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov);
     }
 
 emulate_flags:
-- 
2.13.6
