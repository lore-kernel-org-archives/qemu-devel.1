Received: from eggs.gnu.org ([2001:4830:134:3::10]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colAA-0006Bf-Ih
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colA8-00073f-SF
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1colA8-00073Q-K5
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 17 Mar 2017 14:14:47 +0800
Message-Id: <20170317061447.16243-3-famz@redhat.com>
In-Reply-To: <20170317061447.16243-1-famz@redhat.com>
References: <20170317061447.16243-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v3 2/2] virtio-scsi: Fix
 acquire/release in dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>

After the AioContext lock push down, there is a race between
virtio_scsi_dataplane_start and those "assert(s->ctx &&
s->dataplane_started)", because the latter doesn't isn't wrapped in
aio_context_acquire.

Reproducer is simply booting a Fedora guest with an empty
virtio-scsi-dataplane controller:

    qemu-system-x86_64 \
      -drive if=none,id=root,format=raw,file=Fedora-Cloud-Base-25-1.3.x86_64.raw \
      -device virtio-scsi \
      -device scsi-disk,drive=root,bootindex=1 \
      -object iothread,id=io \
      -device virtio-scsi-pci,iothread=io \
      -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 2048 \
      --enable-kvm

Fix this by moving acquire/release pairs from virtio_scsi_handle_*_vq to
their callers - and wrap the broken assertions in.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
 hw/scsi/virtio-scsi.c           | 27 ++++++++++++++-------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 74c95e0..944ea4e 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -52,28 +52,40 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
 static bool virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
                                               VirtQueue *vq)
 {
-    VirtIOSCSI *s = (VirtIOSCSI *)vdev;
+    bool progress;
+    VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    virtio_scsi_acquire(s);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_cmd_vq(s, vq);
+    progress = virtio_scsi_handle_cmd_vq(s, vq);
+    virtio_scsi_release(s);
+    return progress;
 }
 
 static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
                                                VirtQueue *vq)
 {
+    bool progress;
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    virtio_scsi_acquire(s);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_ctrl_vq(s, vq);
+    progress = virtio_scsi_handle_ctrl_vq(s, vq);
+    virtio_scsi_release(s);
+    return progress;
 }
 
 static bool virtio_scsi_data_plane_handle_event(VirtIODevice *vdev,
                                                 VirtQueue *vq)
 {
+    bool progress;
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    virtio_scsi_acquire(s);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_event_vq(s, vq);
+    progress = virtio_scsi_handle_event_vq(s, vq);
+    virtio_scsi_release(s);
+    return progress;
 }
 
 static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueue *vq, int n,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index e7466d3..bd62d08 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -427,12 +427,10 @@ bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
     VirtIOSCSIReq *req;
     bool progress = false;
 
-    virtio_scsi_acquire(s);
     while ((req = virtio_scsi_pop_req(s, vq))) {
         progress = true;
         virtio_scsi_handle_ctrl_req(s, req);
     }
-    virtio_scsi_release(s);
     return progress;
 }
 
@@ -446,7 +444,9 @@ static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
+    virtio_scsi_acquire(s);
     virtio_scsi_handle_ctrl_vq(s, vq);
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_complete_cmd_req(VirtIOSCSIReq *req)
@@ -590,7 +590,6 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
 
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
 
-    virtio_scsi_acquire(s);
     do {
         virtio_queue_set_notification(vq, 0);
 
@@ -618,7 +617,6 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
     QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
         virtio_scsi_handle_cmd_req_submit(s, req);
     }
-    virtio_scsi_release(s);
     return progress;
 }
 
@@ -633,7 +631,9 @@ static void virtio_scsi_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
+    virtio_scsi_acquire(s);
     virtio_scsi_handle_cmd_vq(s, vq);
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_get_config(VirtIODevice *vdev,
@@ -709,12 +709,10 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
         return;
     }
 
-    virtio_scsi_acquire(s);
-
     req = virtio_scsi_pop_req(s, vs->event_vq);
     if (!req) {
         s->events_dropped = true;
-        goto out;
+        return;
     }
 
     if (s->events_dropped) {
@@ -724,7 +722,7 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
 
     if (virtio_scsi_parse_req(req, 0, sizeof(VirtIOSCSIEvent))) {
         virtio_scsi_bad_req(req);
-        goto out;
+        return;
     }
 
     evt = &req->resp.event;
@@ -744,19 +742,14 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
         evt->lun[3] = dev->lun & 0xFF;
     }
     virtio_scsi_complete_req(req);
-out:
-    virtio_scsi_release(s);
 }
 
 bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
-    virtio_scsi_acquire(s);
     if (s->events_dropped) {
         virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
-        virtio_scsi_release(s);
         return true;
     }
-    virtio_scsi_release(s);
     return false;
 }
 
@@ -770,7 +763,9 @@ static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
+    virtio_scsi_acquire(s);
     virtio_scsi_handle_event_vq(s, vq);
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
@@ -780,8 +775,10 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_CHANGE) &&
         dev->type != TYPE_ROM) {
+        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
                                sense.asc | (sense.ascq << 8));
+        virtio_scsi_release(s);
     }
 }
 
@@ -803,9 +800,11 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
+        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_RESCAN);
+        virtio_scsi_release(s);
     }
 }
 
@@ -817,9 +816,11 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     SCSIDevice *sd = SCSI_DEVICE(dev);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
+        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_REMOVED);
+        virtio_scsi_release(s);
     }
 
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
-- 
2.9.3
