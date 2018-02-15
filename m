Received: from eggs.gnu.org ([2001:4830:134:3::10]:50071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPDA-0006Gs-3p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000mV-GN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:24 -0600
Message-Id: <20180215192829.9944-2-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
References: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] block: Support byte-based aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Add new sector-based aio callbacks for read and write,
to match the fact that bdrv_aio_pdiscard is already byte-based.

Ideally, drivers should be converted to use coroutine callbacks
rather than aio; but that is not quite as trivial (if we do that
conversion, the null-aio driver will disappear), so for the
short term, converting the signature but keeping things with aio
is easier.  Once all drivers are converted, the sector-based aio
callbacks will be removed.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h |  6 ++++++
 block/io.c                | 37 +++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5ae7738cf8d..c882dc4232d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -137,9 +137,15 @@ struct BlockDriver {
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
index 4d3d1f640a3..84a4caa72b7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -934,9 +934,11 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
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
@@ -946,8 +948,13 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };

-        acb = bs->drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
-                                      bdrv_co_io_em_complete, &co);
+        if (drv->bdrv_aio_preadv) {
+            acb = bs->drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
+                                           bdrv_co_io_em_complete, &co);
+        } else {
+            acb = bs->drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
+                                          bdrv_co_io_em_complete, &co);
+        }
         if (acb == NULL) {
             return -EIO;
         } else {
@@ -982,9 +989,11 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
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
@@ -999,8 +1008,16 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };

-        acb = bs->drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
-                                       bdrv_co_io_em_complete, &co);
+        if (drv->bdrv_aio_pwritev) {
+            acb = bs->drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
+                                            flags & bs->supported_write_flags,
+                                            bdrv_co_io_em_complete, &co);
+            flags &= ~bs->supported_write_flags;
+        } else {
+            assert(!bs->supported_write_flags);
+            acb = bs->drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
+                                           bdrv_co_io_em_complete, &co);
+        }
         if (acb == NULL) {
             ret = -EIO;
         } else {
-- 
2.14.3
