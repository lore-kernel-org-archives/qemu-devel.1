Received: from eggs.gnu.org ([2001:4830:134:3::10]:58583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d5-0002Cc-WD
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d4-000632-Qm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 14:25:06 -0500
Message-Id: <20180424192506.149089-7-eblake@redhat.com>
In-Reply-To: <20180424192506.149089-1-eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] block: Drop last of the sector-based
 aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers with aio callbacks are using the
byte-based interfaces, we can remove the sector-based versions.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rearrange conditionals to put byte-based code first [Kevin]
---
 include/block/block_int.h |  6 ----
 block/io.c                | 86 ++++++++++++++++++++---------------------------
 2 files changed, 37 insertions(+), 55 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e772e3502b1..0bba7ed024a 100644
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
index 407bc25df41..6b110b207a0 100644
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
+    if (drv->bdrv_aio_pwritev) {
+        BlockAIOCB *acb;
+        CoroutineIOCompletion co = {
+            .coroutine = qemu_coroutine_self(),
+        };
+
+        acb = drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
+                                    flags & bs->supported_write_flags,
+                                    bdrv_co_io_em_complete, &co);
+        flags &= ~bs->supported_write_flags;
+        if (acb == NULL) {
+            ret = -EIO;
+        } else {
+            qemu_coroutine_yield();
+            ret = co.ret;
+        }
+        goto emulate_flags;
+    }
+
     sector_num = offset >> BDRV_SECTOR_BITS;
     nb_sectors = bytes >> BDRV_SECTOR_BITS;

-    if (!drv->bdrv_aio_pwritev) {
-        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
-    }
+    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);

     if (drv->bdrv_co_writev_flags) {
         ret = drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qiov,
                                         flags & bs->supported_write_flags);
         flags &= ~bs->supported_write_flags;
-    } else if (drv->bdrv_co_writev) {
+    } else {
+        assert(drv->bdrv_co_writev);
         assert(!bs->supported_write_flags);
         ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov);
-    } else {
-        BlockAIOCB *acb;
-        CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-        };
-
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
-        if (acb == NULL) {
-            ret = -EIO;
-        } else {
-            qemu_coroutine_yield();
-            ret = co.ret;
-        }
     }

 emulate_flags:
-- 
2.14.3
