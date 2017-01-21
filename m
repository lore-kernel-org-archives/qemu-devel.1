Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1cUvad-0004P2-Mr
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 08:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jazeltq@gmail.com>) id 1cUvac-0000wd-4L
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 08:20:19 -0500
From: jazeltq@gmail.com
Date: Sat, 21 Jan 2017 21:19:09 +0800
Message-Id: <20170121131909.17230-1-jazeltq@gmail.com>
In-Reply-To: <148499718699.28.5734417610995647444@b042e9bf0dd0>
References: <148499718699.28.5734417610995647444@b042e9bf0dd0>
Subject: [Qemu-devel] [RFC v4] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jdurgin@redhat.com, jcody@redhat.com, jdillama@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

From: tianqing <tianqing@unitedstack.com>

Rbd can do readv and writev directly, so wo do not need to transform
iov to buf or vice versa any more.

Signed-off-by: tianqing <tianqing@unitedstack.com>
---
 block/rbd.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a57b3e3..0cbd9e3 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -73,7 +73,12 @@ typedef struct RBDAIOCB {
     BlockAIOCB common;
     int64_t ret;
     QEMUIOVector *qiov;
+/* Note:
+ * The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h.
+ */
+#ifndef LIBRBD_SUPPORTS_IOVEC
     char *bounce;
+#endif
     RBDAIOCmd cmd;
     int error;
     struct BDRVRBDState *s;
@@ -83,7 +88,9 @@ typedef struct RADOSCB {
     RBDAIOCB *acb;
     struct BDRVRBDState *s;
     int64_t size;
+#ifndef LIBRBD_SUPPORTS_IOVEC
     char *buf;
+#endif
     int64_t ret;
 } RADOSCB;
 
@@ -426,11 +433,21 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
         }
     } else {
         if (r < 0) {
+#ifndef LIBRBD_SUPPORTS_IOVEC
             memset(rcb->buf, 0, rcb->size);
+#else
+            iov_memset(acb->qiov->iov, acb->qiov->niov, 0, 0, acb->qiov->size);
+#endif
             acb->ret = r;
             acb->error = 1;
         } else if (r < rcb->size) {
+#ifndef LIBRBD_SUPPORTS_IOVEC
             memset(rcb->buf + r, 0, rcb->size - r);
+#else
+            iov_memset(acb->qiov->iov, acb->qiov->niov,
+                       r, 0, acb->qiov->size - r);
+#endif
+
             if (!acb->error) {
                 acb->ret = rcb->size;
             }
@@ -441,10 +458,12 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
 
     g_free(rcb);
 
+#ifndef LIBRBD_SUPPORTS_IOVEC
     if (acb->cmd == RBD_AIO_READ) {
         qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
     }
     qemu_vfree(acb->bounce);
+#endif
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
 
     qemu_aio_unref(acb);
@@ -655,8 +674,10 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     RBDAIOCB *acb;
     RADOSCB *rcb = NULL;
     rbd_completion_t c;
-    char *buf;
     int r;
+#ifndef LIBRBD_SUPPORTS_IOVEC
+    char *buf = NULL;
+#endif
 
     BDRVRBDState *s = bs->opaque;
 
@@ -664,6 +685,8 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->cmd = cmd;
     acb->qiov = qiov;
     assert(!qiov || qiov->size == size);
+#ifndef LIBRBD_SUPPORTS_IOVEC
+
     if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
         acb->bounce = NULL;
     } else {
@@ -672,19 +695,21 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
             goto failed;
         }
     }
-    acb->ret = 0;
-    acb->error = 0;
-    acb->s = s;
-
     if (cmd == RBD_AIO_WRITE) {
         qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
     }
-
     buf = acb->bounce;
+#endif
+    acb->ret = 0;
+    acb->error = 0;
+    acb->s = s;
 
     rcb = g_new(RADOSCB, 1);
+
     rcb->acb = acb;
+#ifndef LIBRBD_SUPPORTS_IOVEC
     rcb->buf = buf;
+#endif
     rcb->s = acb->s;
     rcb->size = size;
     r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
@@ -694,10 +719,18 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
 
     switch (cmd) {
     case RBD_AIO_WRITE:
+#ifndef LIBRBD_SUPPORTS_IOVEC
         r = rbd_aio_write(s->image, off, size, buf, c);
+#else
+        r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
+#endif
         break;
     case RBD_AIO_READ:
+#ifndef LIBRBD_SUPPORTS_IOVEC
         r = rbd_aio_read(s->image, off, size, buf, c);
+#else
+        r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
+#endif
         break;
     case RBD_AIO_DISCARD:
         r = rbd_aio_discard_wrapper(s->image, off, size, c);
@@ -719,7 +752,9 @@ failed_completion:
     rbd_aio_release(c);
 failed:
     g_free(rcb);
+#ifndef LIBRBD_SUPPORTS_IOVEC
     qemu_vfree(acb->bounce);
+#endif
     qemu_aio_unref(acb);
     return NULL;
 }
-- 
2.10.2
