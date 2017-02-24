Received: from eggs.gnu.org ([2001:4830:134:3::10]:37886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxW-0006IR-Ra
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxV-0004ux-RL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:10 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 24 Feb 2017 12:47:00 -0500
Message-Id: <20170224174700.30816-4-jcody@redhat.com>
In-Reply-To: <20170224174700.30816-1-jcody@redhat.com>
References: <20170224174700.30816-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: tianqing <tianqing@unitedstack.com>

Rbd can do readv and writev directly, so wo do not need to transform
iov to buf or vice versa any more.

Signed-off-by: tianqing <tianqing@unitedstack.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 80 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a57b3e3..22e8e69 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -62,6 +62,13 @@
 #define RBD_MAX_SNAP_NAME_SIZE 128
 #define RBD_MAX_SNAPS 100
 
+/* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
+#ifdef LIBRBD_SUPPORTS_IOVEC
+#define LIBRBD_USE_IOVEC 1
+#else
+#define LIBRBD_USE_IOVEC 0
+#endif
+
 typedef enum {
     RBD_AIO_READ,
     RBD_AIO_WRITE,
@@ -310,6 +317,17 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
     return ret;
 }
 
+static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
+{
+    if (LIBRBD_USE_IOVEC) {
+        RBDAIOCB *acb = rcb->acb;
+        iov_memset(acb->qiov->iov, acb->qiov->niov, offs, 0,
+                   acb->qiov->size - offs);
+    } else {
+        memset(rcb->buf + offs, 0, rcb->size - offs);
+    }
+}
+
 static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -426,11 +444,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
         }
     } else {
         if (r < 0) {
-            memset(rcb->buf, 0, rcb->size);
+            qemu_rbd_memset(rcb, 0);
             acb->ret = r;
             acb->error = 1;
         } else if (r < rcb->size) {
-            memset(rcb->buf + r, 0, rcb->size - r);
+            qemu_rbd_memset(rcb, r);
             if (!acb->error) {
                 acb->ret = rcb->size;
             }
@@ -441,10 +459,13 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
 
     g_free(rcb);
 
-    if (acb->cmd == RBD_AIO_READ) {
-        qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
+    if (!LIBRBD_USE_IOVEC) {
+        if (acb->cmd == RBD_AIO_READ) {
+            qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
+        }
+        qemu_vfree(acb->bounce);
     }
-    qemu_vfree(acb->bounce);
+
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
 
     qemu_aio_unref(acb);
@@ -655,7 +676,6 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     RBDAIOCB *acb;
     RADOSCB *rcb = NULL;
     rbd_completion_t c;
-    char *buf;
     int r;
 
     BDRVRBDState *s = bs->opaque;
@@ -664,27 +684,29 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->cmd = cmd;
     acb->qiov = qiov;
     assert(!qiov || qiov->size == size);
-    if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
-        acb->bounce = NULL;
-    } else {
-        acb->bounce = qemu_try_blockalign(bs, qiov->size);
-        if (acb->bounce == NULL) {
-            goto failed;
+
+    rcb = g_new(RADOSCB, 1);
+
+    if (!LIBRBD_USE_IOVEC) {
+        if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
+            acb->bounce = NULL;
+        } else {
+            acb->bounce = qemu_try_blockalign(bs, qiov->size);
+            if (acb->bounce == NULL) {
+                goto failed;
+            }
         }
+        if (cmd == RBD_AIO_WRITE) {
+            qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
+        }
+        rcb->buf = acb->bounce;
     }
+
     acb->ret = 0;
     acb->error = 0;
     acb->s = s;
 
-    if (cmd == RBD_AIO_WRITE) {
-        qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
-    }
-
-    buf = acb->bounce;
-
-    rcb = g_new(RADOSCB, 1);
     rcb->acb = acb;
-    rcb->buf = buf;
     rcb->s = acb->s;
     rcb->size = size;
     r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
@@ -694,10 +716,18 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
 
     switch (cmd) {
     case RBD_AIO_WRITE:
-        r = rbd_aio_write(s->image, off, size, buf, c);
+#ifdef LIBRBD_SUPPORTS_IOVEC
+            r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
+#else
+            r = rbd_aio_write(s->image, off, size, rcb->buf, c);
+#endif
         break;
     case RBD_AIO_READ:
-        r = rbd_aio_read(s->image, off, size, buf, c);
+#ifdef LIBRBD_SUPPORTS_IOVEC
+            r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
+#else
+            r = rbd_aio_read(s->image, off, size, rcb->buf, c);
+#endif
         break;
     case RBD_AIO_DISCARD:
         r = rbd_aio_discard_wrapper(s->image, off, size, c);
@@ -712,14 +742,16 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     if (r < 0) {
         goto failed_completion;
     }
-
     return &acb->common;
 
 failed_completion:
     rbd_aio_release(c);
 failed:
     g_free(rcb);
-    qemu_vfree(acb->bounce);
+    if (!LIBRBD_USE_IOVEC) {
+        qemu_vfree(acb->bounce);
+    }
+
     qemu_aio_unref(acb);
     return NULL;
 }
-- 
2.9.3
