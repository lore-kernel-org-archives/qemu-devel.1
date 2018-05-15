Received: from eggs.gnu.org ([2001:4830:134:3::10]:38489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4G-0006SR-Qe
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4F-0001HV-GM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:01 +0200
Message-Id: <20180515154033.19899-6-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/37] rbd: Switch to byte-based callbacks
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
byte-based.  Make the change for the last few sector-based callbacks
in the rbd driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, as I don't know if RBD is tolerant of
non-sector AIO operations, I went with the conservate approach
of adding .bdrv_refresh_limits to override the block layer
defaults back to the pre-patch value of 512.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a14b42fcde..a16431e267 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -231,6 +231,13 @@ done:
 }
 
 
+static void qemu_rbd_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    /* XXX Does RBD support AIO on less than 512-byte alignment? */
+    bs->bl.request_alignment = 512;
+}
+
+
 static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
                              Error **errp)
 {
@@ -899,27 +906,23 @@ failed:
     return NULL;
 }
 
-static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
-                                      int64_t sector_num,
-                                      QEMUIOVector *qiov,
-                                      int nb_sectors,
-                                      BlockCompletionFunc *cb,
-                                      void *opaque)
+static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
+                                       uint64_t offset, uint64_t bytes,
+                                       QEMUIOVector *qiov, int flags,
+                                       BlockCompletionFunc *cb,
+                                       void *opaque)
 {
-    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
+    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
                          RBD_AIO_READ);
 }
 
-static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
-                                       int64_t sector_num,
-                                       QEMUIOVector *qiov,
-                                       int nb_sectors,
-                                       BlockCompletionFunc *cb,
-                                       void *opaque)
+static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
+                                        uint64_t offset, uint64_t bytes,
+                                        QEMUIOVector *qiov, int flags,
+                                        BlockCompletionFunc *cb,
+                                        void *opaque)
 {
-    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
+    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
                          RBD_AIO_WRITE);
 }
 
@@ -1158,6 +1161,7 @@ static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
+    .bdrv_refresh_limits    = qemu_rbd_refresh_limits,
     .bdrv_file_open         = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
@@ -1170,8 +1174,8 @@ static BlockDriver bdrv_rbd = {
     .bdrv_truncate          = qemu_rbd_truncate,
     .protocol_name          = "rbd",
 
-    .bdrv_aio_readv         = qemu_rbd_aio_readv,
-    .bdrv_aio_writev        = qemu_rbd_aio_writev,
+    .bdrv_aio_preadv        = qemu_rbd_aio_preadv,
+    .bdrv_aio_pwritev       = qemu_rbd_aio_pwritev,
 
 #ifdef LIBRBD_SUPPORTS_AIO_FLUSH
     .bdrv_aio_flush         = qemu_rbd_aio_flush,
-- 
2.13.6
