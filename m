Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d2-00028v-M7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d1-00060l-I9
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 14:25:04 -0500
Message-Id: <20180424192506.149089-5-eblake@redhat.com>
In-Reply-To: <20180424192506.149089-1-eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] rbd: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

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

---
v2: override new block layer default alignment [Kevin]
---
 block/rbd.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index c9359d0ad84..638ecf8d986 100644
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
-{
-    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
-                         RBD_AIO_READ);
-}
-
-static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
-                                       int64_t sector_num,
-                                       QEMUIOVector *qiov,
-                                       int nb_sectors,
+static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
+                                       uint64_t offset, uint64_t bytes,
+                                       QEMUIOVector *qiov, int flags,
                                        BlockCompletionFunc *cb,
                                        void *opaque)
 {
-    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
+    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
+                         RBD_AIO_READ);
+}
+
+static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
+                                        uint64_t offset, uint64_t bytes,
+                                        QEMUIOVector *qiov, int flags,
+                                        BlockCompletionFunc *cb,
+                                        void *opaque)
+{
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
2.14.3
