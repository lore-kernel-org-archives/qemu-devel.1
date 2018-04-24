Received: from eggs.gnu.org ([2001:4830:134:3::10]:58560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d3-0002AB-RC
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d2-00061b-G5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 14:25:05 -0500
Message-Id: <20180424192506.149089-6-eblake@redhat.com>
In-Reply-To: <20180424192506.149089-1-eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] vxhs: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the vxhs driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, as I don't know if VxHS is tolerant of
non-sector AIO operations, I went with the conservative approach
of adding .bdrv_refresh_limits to override the block layer
defaults back to the pre-patch value of 512.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
I was unable to get this to compile, as I do not have the vxhs
devel headers installed.  By inspection, it should work, but
a careful review is appreciated.

v2: override new block layer default alignment [Kevin]
---
 block/vxhs.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8672c..64be5324dd5 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -216,6 +216,12 @@ static void vxhs_parse_filename(const char *filename, QDict *options,
     }
 }

+static void vxhs_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    /* XXX Does VXHS support AIO on less than 512-byte alignment? */
+    bs->bl.request_alignment = 512;
+}
+
 static int vxhs_init_and_ref(void)
 {
     if (vxhs_ref++ == 0) {
@@ -424,21 +430,17 @@ static const AIOCBInfo vxhs_aiocb_info = {
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
@@ -451,11 +453,11 @@ static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
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
@@ -474,22 +476,20 @@ errout:
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
@@ -561,10 +561,11 @@ static BlockDriver bdrv_vxhs = {
     .instance_size                = sizeof(BDRVVXHSState),
     .bdrv_file_open               = vxhs_open,
     .bdrv_parse_filename          = vxhs_parse_filename,
+    .bdrv_refresh_limits          = vxhs_refresh_limits,
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
