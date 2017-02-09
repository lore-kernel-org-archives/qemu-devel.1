Received: from eggs.gnu.org ([2001:4830:134:3::10]:52739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbkHh-00034P-QQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbkHc-0005LX-MC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cbkHc-0005LK-Da
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:40:52 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  9 Feb 2017 16:40:47 +0800
Message-Id: <20170209084047.7897-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: Report real progress in VQ aio poll
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>

In virtio_queue_host_notifier_aio_poll, not all "!virtio_queue_empty()"
cases are making true progress.

Currently the offending one is virtio-scsi event queue, whose handler
does nothing if no event is pending. As a result aio_poll() will spin on
the "non-empty" VQ and take 100% host CPU.

Fix this by reporting actual progress from virtio queue aio handlers.

Reported-by: Ed Swierk <eswierk@skyportsystems.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/dataplane/virtio-blk.c |  4 ++--
 hw/block/virtio-blk.c           | 12 ++++++++++--
 hw/scsi/virtio-scsi-dataplane.c | 14 +++++++-------
 hw/scsi/virtio-scsi.c           | 14 +++++++++++---
 hw/virtio/virtio.c              | 15 +++++++++------
 include/hw/virtio/virtio-blk.h  |  2 +-
 include/hw/virtio/virtio-scsi.h |  6 +++---
 include/hw/virtio/virtio.h      |  4 ++--
 8 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index d1f9f63..5556f0e 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -147,7 +147,7 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
     g_free(s);
 }
 
-static void virtio_blk_data_plane_handle_output(VirtIODevice *vdev,
+static bool virtio_blk_data_plane_handle_output(VirtIODevice *vdev,
                                                 VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
@@ -155,7 +155,7 @@ static void virtio_blk_data_plane_handle_output(VirtIODevice *vdev,
     assert(s->dataplane);
     assert(s->dataplane_started);
 
-    virtio_blk_handle_vq(s, vq);
+    return virtio_blk_handle_vq(s, vq);
 }
 
 /* Context: QEMU global mutex held */
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 702eda8..baaa195 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -581,10 +581,11 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
     return 0;
 }
 
-void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
+bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
 {
     VirtIOBlockReq *req;
     MultiReqBuffer mrb = {};
+    bool progress = false;
 
     blk_io_plug(s->blk);
 
@@ -592,6 +593,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
         virtio_queue_set_notification(vq, 0);
 
         while ((req = virtio_blk_get_request(s, vq))) {
+            progress = true;
             if (virtio_blk_handle_request(req, &mrb)) {
                 virtqueue_detach_element(req->vq, &req->elem, 0);
                 virtio_blk_free_request(req);
@@ -607,6 +609,12 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     }
 
     blk_io_unplug(s->blk);
+    return progress;
+}
+
+static void virtio_blk_handle_output_do(VirtIOBlock *s, VirtQueue *vq)
+{
+    virtio_blk_handle_vq(s, vq);
 }
 
 static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
@@ -622,7 +630,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
-    virtio_blk_handle_vq(s, vq);
+    virtio_blk_handle_output_do(s, vq);
 }
 
 static void virtio_blk_dma_restart_bh(void *opaque)
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 6b8d0f0..74c95e0 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -49,35 +49,35 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     }
 }
 
-static void virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
+static bool virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
                                               VirtQueue *vq)
 {
     VirtIOSCSI *s = (VirtIOSCSI *)vdev;
 
     assert(s->ctx && s->dataplane_started);
-    virtio_scsi_handle_cmd_vq(s, vq);
+    return virtio_scsi_handle_cmd_vq(s, vq);
 }
 
-static void virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
+static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
                                                VirtQueue *vq)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
     assert(s->ctx && s->dataplane_started);
-    virtio_scsi_handle_ctrl_vq(s, vq);
+    return virtio_scsi_handle_ctrl_vq(s, vq);
 }
 
-static void virtio_scsi_data_plane_handle_event(VirtIODevice *vdev,
+static bool virtio_scsi_data_plane_handle_event(VirtIODevice *vdev,
                                                 VirtQueue *vq)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
     assert(s->ctx && s->dataplane_started);
-    virtio_scsi_handle_event_vq(s, vq);
+    return virtio_scsi_handle_event_vq(s, vq);
 }
 
 static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueue *vq, int n,
-                                  void (*fn)(VirtIODevice *vdev, VirtQueue *vq))
+                                  VirtIOHandleAIOOutput fn)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(s)));
     int rc;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce19eff..b01030b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -436,13 +436,16 @@ static inline void virtio_scsi_release(VirtIOSCSI *s)
     }
 }
 
-void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
+bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
+    bool progress = false;
 
     while ((req = virtio_scsi_pop_req(s, vq))) {
+        progress = true;
         virtio_scsi_handle_ctrl_req(s, req);
     }
+    return progress;
 }
 
 static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
@@ -591,10 +594,11 @@ static void virtio_scsi_handle_cmd_req_submit(VirtIOSCSI *s, VirtIOSCSIReq *req)
     scsi_req_unref(sreq);
 }
 
-void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
+bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req, *next;
     int ret = 0;
+    bool progress = false;
 
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
 
@@ -602,6 +606,7 @@ void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
         virtio_queue_set_notification(vq, 0);
 
         while ((req = virtio_scsi_pop_req(s, vq))) {
+            progress = true;
             ret = virtio_scsi_handle_cmd_req_prepare(s, req);
             if (!ret) {
                 QTAILQ_INSERT_TAIL(&reqs, req, next);
@@ -624,6 +629,7 @@ void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
     QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
         virtio_scsi_handle_cmd_req_submit(s, req);
     }
+    return progress;
 }
 
 static void virtio_scsi_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
@@ -752,11 +758,13 @@ out:
     virtio_scsi_release(s);
 }
 
-void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
+bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     if (s->events_dropped) {
         virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
+        return true;
     }
+    return false;
 }
 
 static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6365706..2461c06 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -97,7 +97,7 @@ struct VirtQueue
 
     uint16_t vector;
     VirtIOHandleOutput handle_output;
-    VirtIOHandleOutput handle_aio_output;
+    VirtIOHandleAIOOutput handle_aio_output;
     VirtIODevice *vdev;
     EventNotifier guest_notifier;
     EventNotifier host_notifier;
@@ -1287,14 +1287,16 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     virtio_queue_update_rings(vdev, n);
 }
 
-static void virtio_queue_notify_aio_vq(VirtQueue *vq)
+static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
 {
     if (vq->vring.desc && vq->handle_aio_output) {
         VirtIODevice *vdev = vq->vdev;
 
         trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
-        vq->handle_aio_output(vdev, vq);
+        return vq->handle_aio_output(vdev, vq);
     }
+
+    return false;
 }
 
 static void virtio_queue_notify_vq(VirtQueue *vq)
@@ -2125,16 +2127,17 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
 {
     EventNotifier *n = opaque;
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
+    bool progress;
 
     if (virtio_queue_empty(vq)) {
         return false;
     }
 
-    virtio_queue_notify_aio_vq(vq);
+    progress = virtio_queue_notify_aio_vq(vq);
 
     /* In case the handler function re-enabled notifications */
     virtio_queue_set_notification(vq, 0);
-    return true;
+    return progress;
 }
 
 static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
@@ -2146,7 +2149,7 @@ static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
 }
 
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
-                                                VirtIOHandleOutput handle_output)
+                                                VirtIOHandleAIOOutput handle_output)
 {
     if (handle_output) {
         vq->handle_aio_output = handle_output;
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 9734b4c..d3c8a6f 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -80,6 +80,6 @@ typedef struct MultiReqBuffer {
     bool is_write;
 } MultiReqBuffer;
 
-void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
+bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
 
 #endif
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 7375196..f536f77 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -126,9 +126,9 @@ void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
                                 VirtIOHandleOutput cmd);
 
 void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp);
-void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq);
-void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq);
-void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq);
+bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq);
+bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq);
+bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq);
 void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req);
 void virtio_scsi_free_req(VirtIOSCSIReq *req);
 void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 525da24..0863a25 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -154,6 +154,7 @@ void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
 
 typedef void (*VirtIOHandleOutput)(VirtIODevice *, VirtQueue *);
+typedef bool (*VirtIOHandleAIOOutput)(VirtIODevice *, VirtQueue *);
 
 VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
                             VirtIOHandleOutput handle_output);
@@ -284,8 +285,7 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
 EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
 void virtio_queue_host_notifier_read(EventNotifier *n);
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
-                                                void (*fn)(VirtIODevice *,
-                                                           VirtQueue *));
+                                                VirtIOHandleAIOOutput handle_output);
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
 
-- 
2.9.3
