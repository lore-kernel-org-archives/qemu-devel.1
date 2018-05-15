Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4G-0006Sg-VN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4F-0001HL-Dp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:39:58 +0200
Message-Id: <20180515154033.19899-3-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/37] block: Support byte-based aio callbacks
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
byte-based.  Add new sector-based aio callbacks for read and write,
to match the fact that bdrv_aio_pdiscard is already byte-based.

Ideally, drivers should be converted to use coroutine callbacks
rather than aio; but that is not quite as trivial (and if we were
to do that conversion, the null-aio driver would disappear), so for
the short term, converting the signature but keeping things with
aio is easier.  However, we CAN declare that a driver that uses
the byte-based aio interfaces now defaults to byte-based
operations, and must explicitly provide a refresh_limits override
to stick with larger alignments (making the alignment issues more
obvious directly in the drivers touched in the next few patches).

Once all drivers are converted, the sector-based aio callbacks will
be removed; in the meantime, a FIXME comment is added due to a
slight inefficiency that will be touched up as part of that later
cleanup.

Simplify some instances of 'bs->drv' into 'drv' while touching this,
since the local variable already exists to reduce typing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  6 ++++++
 block/io.c                | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c4dd1d4bb8..e772e3502b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -144,9 +144,15 @@ struct BlockDriver {
     BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
         BlockCompletionFunc *cb, void *opaque);
+    BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
         BlockCompletionFunc *cb, void *opaque);
+    BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
diff --git a/block/io.c b/block/io.c
index bd9a19a9c4..407bc25df4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -92,7 +92,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 
     /* Default alignment based on whether driver has byte interface */
-    bs->bl.request_alignment = drv->bdrv_co_preadv ? 1 : 512;
+    bs->bl.request_alignment = (drv->bdrv_co_preadv ||
+                                drv->bdrv_aio_preadv) ? 1 : 512;
 
     /* Take some limits from the children as a default */
     if (bs->file) {
@@ -924,12 +925,15 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
         return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
     }
 
+    /* FIXME - no need to calculate these if .bdrv_aio_preadv exists */
     sector_num = offset >> BDRV_SECTOR_BITS;
     nb_sectors = bytes >> BDRV_SECTOR_BITS;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    if (!drv->bdrv_aio_preadv) {
+        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    }
 
     if (drv->bdrv_co_readv) {
         return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
@@ -939,8 +943,13 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };
 
-        acb = bs->drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
+        if (drv->bdrv_aio_preadv) {
+            acb = drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
+                                       bdrv_co_io_em_complete, &co);
+        } else {
+            acb = drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
                                       bdrv_co_io_em_complete, &co);
+        }
         if (acb == NULL) {
             return -EIO;
         } else {
@@ -972,12 +981,15 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
         goto emulate_flags;
     }
 
+    /* FIXME - no need to calculate these if .bdrv_aio_pwritev exists */
     sector_num = offset >> BDRV_SECTOR_BITS;
     nb_sectors = bytes >> BDRV_SECTOR_BITS;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    if (!drv->bdrv_aio_pwritev) {
+        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    }
 
     if (drv->bdrv_co_writev_flags) {
         ret = drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qiov,
@@ -992,8 +1004,16 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };
 
-        acb = bs->drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
+        if (drv->bdrv_aio_pwritev) {
+            acb = drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
+                                        flags & bs->supported_write_flags,
+                                        bdrv_co_io_em_complete, &co);
+            flags &= ~bs->supported_write_flags;
+        } else {
+            assert(!bs->supported_write_flags);
+            acb = drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
                                        bdrv_co_io_em_complete, &co);
+        }
         if (acb == NULL) {
             ret = -EIO;
         } else {
-- 
2.13.6
