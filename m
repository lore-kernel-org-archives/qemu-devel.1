Received: from eggs.gnu.org ([2001:4830:134:3::10]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNf7z-0000ok-VO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNf7v-0005jy-9F
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:53:00 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Jun 2017 08:52:49 -0400
Message-ID: <20170621125249.8805-4-paul.durrant@citrix.com>
In-Reply-To: <20170621125249.8805-1-paul.durrant@citrix.com>
References: <20170621125249.8805-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch allocates an IOThread object for each xen_disk instance and
sets the AIO context appropriately on connect. This allows processing
of I/O to proceed in parallel.

The patch also adds tracepoints into xen_disk to make it possible to
follow the state transtions of an instance in the log.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

v2:
 - explicitly acquire and release AIO context in qemu_aio_complete() and
   blk_bh()
---
 hw/block/trace-events |  7 ++++++
 hw/block/xen_disk.c   | 69 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 65e83dc258..608b24ba66 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -10,3 +10,10 @@ virtio_blk_submit_multireq(void *mrb, int start, int num_reqs, uint64_t offset,
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
index 0e6513708e..8548195195 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -27,10 +27,13 @@
 #include "hw/xen/xen_backend.h"
 #include "xen_blkif.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/iothread.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
 
 /* ------------------------------------------------------------- */
 
@@ -128,6 +131,9 @@ struct XenBlkDev {
     DriveInfo           *dinfo;
     BlockBackend        *blk;
     QEMUBH              *bh;
+
+    IOThread            *iothread;
+    AioContext          *ctx;
 };
 
 /* ------------------------------------------------------------- */
@@ -599,9 +605,12 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
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
@@ -610,13 +619,13 @@ static void qemu_aio_complete(void *opaque, int ret)
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
 
-    if (ioreq->blkdev->feature_grant_copy) {
+    if (blkdev->feature_grant_copy) {
         switch (ioreq->req.operation) {
         case BLKIF_OP_READ:
             /* in case of failure ioreq->aio_errors is increased */
@@ -638,7 +647,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     }
 
     ioreq->status = ioreq->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    if (!ioreq->blkdev->feature_grant_copy) {
+    if (!blkdev->feature_grant_copy) {
         ioreq_unmap(ioreq);
     }
     ioreq_finish(ioreq);
@@ -650,16 +659,19 @@ static void qemu_aio_complete(void *opaque, int ret)
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
@@ -917,17 +929,40 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
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
+    Object *obj;
+    char *name;
+    Error *err = NULL;
+
+    trace_xen_disk_alloc(xendev->name);
 
     QLIST_INIT(&blkdev->inflight);
     QLIST_INIT(&blkdev->finished);
     QLIST_INIT(&blkdev->freelist);
-    blkdev->bh = qemu_bh_new(blk_bh, blkdev);
+
+    obj = object_new(TYPE_IOTHREAD);
+    name = g_strdup_printf("iothread-%s", xendev->name);
+
+    object_property_add_child(object_get_objects_root(), name, obj, &err);
+    assert(!err);
+
+    g_free(name);
+
+    user_creatable_complete(obj, &err);
+    assert(!err);
+
+    blkdev->iothread = (IOThread *)object_dynamic_cast(obj, TYPE_IOTHREAD);
+    blkdev->ctx = iothread_get_aio_context(blkdev->iothread);
+    blkdev->bh = aio_bh_new(blkdev->ctx, blk_bh, blkdev);
+
     if (xen_mode != XEN_EMULATE) {
         batch_maps = 1;
     }
@@ -954,6 +989,8 @@ static int blk_init(struct XenDevice *xendev)
     int info = 0;
     char *directiosafe = NULL;
 
+    trace_xen_disk_init(xendev->name);
+
     /* read xenstore entries */
     if (blkdev->params == NULL) {
         char *h = NULL;
@@ -1069,6 +1106,8 @@ static int blk_connect(struct XenDevice *xendev)
     unsigned int i;
     uint32_t *domids;
 
+    trace_xen_disk_connect(xendev->name);
+
     /* read-only ? */
     if (blkdev->directiosafe) {
         qflags = BDRV_O_NOCACHE | BDRV_O_NATIVE_AIO;
@@ -1288,6 +1327,8 @@ static int blk_connect(struct XenDevice *xendev)
         blkdev->persistent_gnt_count = 0;
     }
 
+    blk_set_aio_context(blkdev->blk, blkdev->ctx);
+
     xen_be_bind_evtchn(&blkdev->xendev);
 
     xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
@@ -1301,13 +1342,20 @@ static void blk_disconnect(struct XenDevice *xendev)
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
@@ -1341,6 +1389,8 @@ static int blk_free(struct XenDevice *xendev)
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     struct ioreq *ioreq;
 
+    trace_xen_disk_free(xendev->name);
+
     if (blkdev->blk || blkdev->sring) {
         blk_disconnect(xendev);
     }
@@ -1358,6 +1408,7 @@ static int blk_free(struct XenDevice *xendev)
     g_free(blkdev->dev);
     g_free(blkdev->devtype);
     qemu_bh_delete(blkdev->bh);
+    object_unparent(OBJECT(blkdev->iothread));
     return 0;
 }
 
-- 
2.11.0
