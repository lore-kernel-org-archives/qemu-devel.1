Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJWK-0002IL-EK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJWH-0000PD-Lm
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:40 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 20 Jun 2017 09:47:56 -0400
Message-ID: <20170620134756.9632-4-paul.durrant@citrix.com>
In-Reply-To: <20170620134756.9632-1-paul.durrant@citrix.com>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] xen-disk: use an IOThread per instance
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
---
 hw/block/trace-events |  7 +++++++
 hw/block/xen_disk.c   | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

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
index a9942d32db..ec1085c802 100644
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
@@ -923,11 +929,31 @@ static void blk_bh(void *opaque)
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
@@ -954,6 +980,8 @@ static int blk_init(struct XenDevice *xendev)
     int info = 0;
     char *directiosafe = NULL;
 
+    trace_xen_disk_init(xendev->name);
+
     /* read xenstore entries */
     if (blkdev->params == NULL) {
         char *h = NULL;
@@ -1069,6 +1097,8 @@ static int blk_connect(struct XenDevice *xendev)
     unsigned int i;
     uint32_t *domids;
 
+    trace_xen_disk_connect(xendev->name);
+
     /* read-only ? */
     if (blkdev->directiosafe) {
         qflags = BDRV_O_NOCACHE | BDRV_O_NATIVE_AIO;
@@ -1285,6 +1315,8 @@ static int blk_connect(struct XenDevice *xendev)
         blkdev->persistent_gnt_count = 0;
     }
 
+    blk_set_aio_context(blkdev->blk, blkdev->ctx);
+
     xen_be_bind_evtchn(&blkdev->xendev);
 
     xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
@@ -1298,13 +1330,20 @@ static void blk_disconnect(struct XenDevice *xendev)
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
@@ -1338,6 +1377,8 @@ static int blk_free(struct XenDevice *xendev)
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     struct ioreq *ioreq;
 
+    trace_xen_disk_free(xendev->name);
+
     if (blkdev->blk || blkdev->sring) {
         blk_disconnect(xendev);
     }
@@ -1355,6 +1396,7 @@ static int blk_free(struct XenDevice *xendev)
     g_free(blkdev->dev);
     g_free(blkdev->devtype);
     qemu_bh_delete(blkdev->bh);
+    object_unparent(OBJECT(blkdev->iothread));
     return 0;
 }
 
-- 
2.11.0
