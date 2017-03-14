Received: from eggs.gnu.org ([2001:4830:134:3::10]:45383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoV5-0000bq-P6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoV1-0001TD-Fv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cnoV1-0001Sl-7U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:35 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58040128D
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 15:36:35 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 23:36:26 +0800
Message-Id: <20170314153626.16989-3-famz@redhat.com>
In-Reply-To: <20170314153626.16989-1-famz@redhat.com>
References: <20170314153626.16989-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

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
 hw/scsi/virtio-scsi.c           | 26 ++++++++++++++------------
 2 files changed, 30 insertions(+), 16 deletions(-)

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
index e7466d3..4939f1f 100644
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
@@ -744,19 +742,15 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
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
         virtio_scsi_release(s);
         return true;
     }
-    virtio_scsi_release(s);
     return false;
 }
 
@@ -770,7 +764,9 @@ static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
+    virtio_scsi_acquire(s);
     virtio_scsi_handle_event_vq(s, vq);
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
@@ -780,8 +776,10 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_CHANGE) &&
         dev->type != TYPE_ROM) {
+        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
                                sense.asc | (sense.ascq << 8));
+        virtio_scsi_release(s);
     }
 }
 
@@ -803,9 +801,11 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
+        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, sd,
                                VIRTIO_SCSI_T_TRANSPORT_RESET,
                                VIRTIO_SCSI_EVT_RESET_RESCAN);
+        virtio_scsi_release(s);
     }
 }
 
@@ -817,9 +817,11 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
