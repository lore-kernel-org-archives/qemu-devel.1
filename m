Received: from eggs.gnu.org ([2001:4830:134:3::10]:50046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD9-0006Fc-ER
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000m9-Cl
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:27 -0600
Message-Id: <20180215192829.9944-5-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
References: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] rbd: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the rbd driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, the block layer defaults this driver to
use request_alignment of 512, and I did not change that.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/rbd.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 8474b0ba117..b3a613023c1 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -870,27 +870,23 @@ failed:
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

@@ -1140,8 +1136,8 @@ static BlockDriver bdrv_rbd = {
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
