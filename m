Received: from eggs.gnu.org ([2001:4830:134:3::10]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrG-0002qB-Gj
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrC-00063I-Eh
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ePdrC-00062H-5v
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:06 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 14 Dec 2017 16:27:58 -0800
Message-Id: <1513297683-14295-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/6] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

This patch allocates an IOThread object for each xen_disk instance and
sets the AIO context appropriately on connect. This allows processing
of I/O to proceed in parallel.

The patch also adds tracepoints into xen_disk to make it possible to
follow the state transtions of an instance in the log.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/block/trace-events |  7 +++++++
 hw/block/xen_disk.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index cb6767b..962a3bf 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -10,3 +10,10 @@ virtio_blk_submit_multireq(void *vdev, void *mrb, int start, int num_reqs, uint6
 # hw/block/hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
+
+# hw/block/xen_disk.c
+xen_disk_alloc(char *name) "%s"
+xen_disk_init(char *name) "%s"
+xen_disk_connect(char *name) "%s"
+xen_disk_disconnect(char *name) "%s"
+xen_disk_free(char *name) "%s"
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index e431bd8..f74fcd4 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -27,10 +27,12 @@
 #include "hw/xen/xen_backend.h"
 #include "xen_blkif.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/iothread.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "trace.h"
 
 /* ------------------------------------------------------------- */
 
@@ -125,6 +127,9 @@ struct XenBlkDev {
     DriveInfo           *dinfo;
     BlockBackend        *blk;
     QEMUBH              *bh;
+
+    IOThread            *iothread;
+    AioContext          *ctx;
 };
 
 /* ------------------------------------------------------------- */
@@ -596,9 +601,12 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
 static void qemu_aio_complete(void *opaque, int ret)
 {
     struct ioreq *ioreq = opaque;
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+
+    aio_context_acquire(blkdev->ctx);
 
     if (ret != 0) {
-        xen_pv_printf(&ioreq->blkdev->xendev, 0, "%s I/O error\n",
+        xen_pv_printf(&blkdev->xendev, 0, "%s I/O error\n",
                       ioreq->req.operation == BLKIF_OP_READ ? "read" : "write");
         ioreq->aio_errors++;
     }
@@ -607,10 +615,10 @@ static void qemu_aio_complete(void *opaque, int ret)
     if (ioreq->presync) {
         ioreq->presync = 0;
         ioreq_runio_qemu_aio(ioreq);
-        return;
+        goto done;
     }
     if (ioreq->aio_inflight > 0) {
-        return;
+        goto done;
     }
 
     if (xen_feature_grant_copy) {
@@ -647,16 +655,19 @@ static void qemu_aio_complete(void *opaque, int ret)
         }
     case BLKIF_OP_READ:
         if (ioreq->status == BLKIF_RSP_OKAY) {
-            block_acct_done(blk_get_stats(ioreq->blkdev->blk), &ioreq->acct);
+            block_acct_done(blk_get_stats(blkdev->blk), &ioreq->acct);
         } else {
-            block_acct_failed(blk_get_stats(ioreq->blkdev->blk), &ioreq->acct);
+            block_acct_failed(blk_get_stats(blkdev->blk), &ioreq->acct);
         }
         break;
     case BLKIF_OP_DISCARD:
     default:
         break;
     }
-    qemu_bh_schedule(ioreq->blkdev->bh);
+    qemu_bh_schedule(blkdev->bh);
+
+done:
+    aio_context_release(blkdev->ctx);
 }
 
 static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
@@ -913,17 +924,29 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
 static void blk_bh(void *opaque)
 {
     struct XenBlkDev *blkdev = opaque;
+
+    aio_context_acquire(blkdev->ctx);
     blk_handle_requests(blkdev);
+    aio_context_release(blkdev->ctx);
 }
 
 static void blk_alloc(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
+    Error *err = NULL;
+
+    trace_xen_disk_alloc(xendev->name);
 
     QLIST_INIT(&blkdev->inflight);
     QLIST_INIT(&blkdev->finished);
     QLIST_INIT(&blkdev->freelist);
-    blkdev->bh = qemu_bh_new(blk_bh, blkdev);
+
+    blkdev->iothread = iothread_create(xendev->name, &err);
+    assert(!err);
+
+    blkdev->ctx = iothread_get_aio_context(blkdev->iothread);
+    blkdev->bh = aio_bh_new(blkdev->ctx, blk_bh, blkdev);
+
     if (xen_mode != XEN_EMULATE) {
         batch_maps = 1;
     }
@@ -950,6 +973,8 @@ static int blk_init(struct XenDevice *xendev)
     int info = 0;
     char *directiosafe = NULL;
 
+    trace_xen_disk_init(xendev->name);
+
     /* read xenstore entries */
     if (blkdev->params == NULL) {
         char *h = NULL;
@@ -1062,6 +1087,8 @@ static int blk_connect(struct XenDevice *xendev)
     unsigned int i;
     uint32_t *domids;
 
+    trace_xen_disk_connect(xendev->name);
+
     /* read-only ? */
     if (blkdev->directiosafe) {
         qflags = BDRV_O_NOCACHE | BDRV_O_NATIVE_AIO;
@@ -1287,6 +1314,8 @@ static int blk_connect(struct XenDevice *xendev)
         blkdev->persistent_gnt_count = 0;
     }
 
+    blk_set_aio_context(blkdev->blk, blkdev->ctx);
+
     xen_be_bind_evtchn(&blkdev->xendev);
 
     xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
@@ -1300,13 +1329,20 @@ static void blk_disconnect(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
 
+    trace_xen_disk_disconnect(xendev->name);
+
+    aio_context_acquire(blkdev->ctx);
+
     if (blkdev->blk) {
+        blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
         blk_detach_dev(blkdev->blk, blkdev);
         blk_unref(blkdev->blk);
         blkdev->blk = NULL;
     }
     xen_pv_unbind_evtchn(&blkdev->xendev);
 
+    aio_context_release(blkdev->ctx);
+
     if (blkdev->sring) {
         xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
                         blkdev->nr_ring_ref);
@@ -1345,6 +1381,8 @@ static int blk_free(struct XenDevice *xendev)
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     struct ioreq *ioreq;
 
+    trace_xen_disk_free(xendev->name);
+
     blk_disconnect(xendev);
 
     while (!QLIST_EMPTY(&blkdev->freelist)) {
@@ -1360,6 +1398,7 @@ static int blk_free(struct XenDevice *xendev)
     g_free(blkdev->dev);
     g_free(blkdev->devtype);
     qemu_bh_delete(blkdev->bh);
+    iothread_destroy(blkdev->iothread);
     return 0;
 }
 
-- 
1.9.1
