Received: from eggs.gnu.org ([2001:4830:134:3::10]:50048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD9-0006Fe-Fv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000mJ-EB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:28 -0600
Message-Id: <20180215192829.9944-6-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
References: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] vxhs: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the vxhs driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, the block layer defaults this driver to
use request_alignment of 512, and I did not change that.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
I was unable to get this to compile, as I do not have the vxhs
devel headers installed.  By inspection, it should work, but
a careful review is appreciated.
---
 block/vxhs.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8672c..c478ae26035 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -424,21 +424,17 @@ static const AIOCBInfo vxhs_aiocb_info = {
  * and is passed to QNIO. When QNIO completes the work,
  * it will be passed back through the callback.
  */
-static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
-                               QEMUIOVector *qiov, int nb_sectors,
+static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, uint64_t offset,
+                               QEMUIOVector *qiov, uint64_t size,
                                BlockCompletionFunc *cb, void *opaque,
                                VDISKAIOCmd iodir)
 {
     VXHSAIOCB *acb = NULL;
     BDRVVXHSState *s = bs->opaque;
-    size_t size;
-    uint64_t offset;
     int iio_flags = 0;
     int ret = 0;
     void *dev_handle = s->vdisk_hostinfo.dev_handle;

-    offset = sector_num * BDRV_SECTOR_SIZE;
-    size = nb_sectors * BDRV_SECTOR_SIZE;
     acb = qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);

     /*
@@ -451,11 +447,11 @@ static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
     switch (iodir) {
     case VDISK_AIO_WRITE:
             ret = iio_writev(dev_handle, acb, qiov->iov, qiov->niov,
-                             offset, (uint64_t)size, iio_flags);
+                             offset, size, iio_flags);
             break;
     case VDISK_AIO_READ:
             ret = iio_readv(dev_handle, acb, qiov->iov, qiov->niov,
-                            offset, (uint64_t)size, iio_flags);
+                            offset, size, iio_flags);
             break;
     default:
             trace_vxhs_aio_rw_invalid(iodir);
@@ -474,22 +470,20 @@ errout:
     return NULL;
 }

-static BlockAIOCB *vxhs_aio_readv(BlockDriverState *bs,
-                                   int64_t sector_num, QEMUIOVector *qiov,
-                                   int nb_sectors,
+static BlockAIOCB *vxhs_aio_preadv(BlockDriverState *bs,
+                                   uint64_t offset, uint64_t bytes,
+                                   QEMUIOVector *qiov, int flags,
                                    BlockCompletionFunc *cb, void *opaque)
 {
-    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors, cb,
-                       opaque, VDISK_AIO_READ);
+    return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_READ);
 }

-static BlockAIOCB *vxhs_aio_writev(BlockDriverState *bs,
-                                   int64_t sector_num, QEMUIOVector *qiov,
-                                   int nb_sectors,
-                                   BlockCompletionFunc *cb, void *opaque)
+static BlockAIOCB *vxhs_aio_pwritev(BlockDriverState *bs,
+                                    uint64_t offset, uint64_t bytes,
+                                    QEMUIOVector *qiov, int flags,
+                                    BlockCompletionFunc *cb, void *opaque)
 {
-    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors,
-                       cb, opaque, VDISK_AIO_WRITE);
+    return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_WRITE);
 }

 static void vxhs_close(BlockDriverState *bs)
@@ -563,8 +557,8 @@ static BlockDriver bdrv_vxhs = {
     .bdrv_parse_filename          = vxhs_parse_filename,
     .bdrv_close                   = vxhs_close,
     .bdrv_getlength               = vxhs_getlength,
-    .bdrv_aio_readv               = vxhs_aio_readv,
-    .bdrv_aio_writev              = vxhs_aio_writev,
+    .bdrv_aio_preadv              = vxhs_aio_preadv,
+    .bdrv_aio_pwritev             = vxhs_aio_pwritev,
 };

 static void bdrv_vxhs_init(void)
-- 
2.14.3
