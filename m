Received: from eggs.gnu.org ([2001:4830:134:3::10]:60454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePDJs-0001Dp-SC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePDJr-00028T-71
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:07:56 -0500
Date: Wed, 13 Dec 2017 22:07:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513195592-9651-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH dontapply] virtio: rework set_status callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org, Ilya Maximets <i.maximets@samsung.com>

set status calls do not nest properly.

The issue is that if someone calls set_status nested
from within set_status, then status gets over-written
because status is only set at the last moment,
it's thus actually incorrect most of the time.

But most people just want the new status,
so it is better to keep that as part of status.

The actual case was virtio_error invoking a
status callback, but that is gone now.

I thus do not plan to apply this patch, posting
here for achival purposes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h  |  2 +-
 hw/block/virtio-blk.c       |  6 +++---
 hw/char/virtio-serial-bus.c |  6 +++---
 hw/input/virtio-input.c     |  4 ++--
 hw/net/virtio-net.c         | 22 ++++++++++++----------
 hw/scsi/vhost-scsi.c        |  4 ++--
 hw/scsi/vhost-user-scsi.c   |  4 ++--
 hw/virtio/vhost-vsock.c     |  9 ++++++---
 hw/virtio/virtio-balloon.c  |  4 ++--
 hw/virtio/virtio.c          |  9 +++++++--
 10 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaa..f5d0ee1 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -115,7 +115,7 @@ typedef struct VirtioDeviceClass {
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
-    void (*set_status)(VirtIODevice *vdev, uint8_t val);
+    void (*set_status)(VirtIODevice *vdev, uint8_t old_status);
     /* For transitional devices, this is a bitmap of features
      * that are only exposed on the legacy interface but not
      * the modern one.
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..b8b07ba 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -814,15 +814,15 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
-static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
+static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t old_status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
-    if (!(status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK))) {
+    if (!(vdev->status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK))) {
         assert(!s->dataplane_started);
     }
 
-    if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return;
     }
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..881b1ff 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -616,7 +616,7 @@ static void guest_reset(VirtIOSerial *vser)
     }
 }
 
-static void set_status(VirtIODevice *vdev, uint8_t status)
+static void set_status(VirtIODevice *vdev, uint8_t old_status)
 {
     VirtIOSerial *vser;
     VirtIOSerialPort *port;
@@ -625,7 +625,7 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
     port = find_port_by_id(vser, 0);
 
     if (port && !use_multiport(port->vser)
-        && (status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         /*
          * Non-multiport guests won't be able to tell us guest
          * open/close status.  Such guests can only have a port at id
@@ -634,7 +634,7 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
          */
         port->guest_connected = true;
     }
-    if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         guest_reset(vser);
     }
 
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d..abb817b 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -188,12 +188,12 @@ static uint64_t virtio_input_get_features(VirtIODevice *vdev, uint64_t f,
     return f;
 }
 
-static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
+static void virtio_input_set_status(VirtIODevice *vdev, uint8_t old_val)
 {
     VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
     VirtIOInput *vinput = VIRTIO_INPUT(vdev);
 
-    if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
+    if (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
         if (!vinput->active) {
             vinput->active = true;
             if (vic->change_active) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b0..7851968 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -124,7 +124,7 @@ static void virtio_net_announce_timer(void *opaque)
     virtio_notify_config(vdev);
 }
 
-static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
+static void virtio_net_vhost_status(VirtIONet *n, uint8_t old_status)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     NetClientState *nc = qemu_get_queue(n->nic);
@@ -134,7 +134,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
         return;
     }
 
-    if ((virtio_net_started(n, status) && !nc->peer->link_down) ==
+    if ((virtio_net_started(n, vdev->status) && !nc->peer->link_down) ==
         !!n->vhost_started) {
         return;
     }
@@ -212,12 +212,12 @@ static bool virtio_net_set_vnet_endian(VirtIODevice *vdev, NetClientState *ncs,
     return false;
 }
 
-static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
+static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t old_status)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int queues = n->multiqueue ? n->max_queues : 1;
 
-    if (virtio_net_started(n, status)) {
+    if (virtio_net_started(n, vdev->status)) {
         /* Before using the device, we tell the network backend about the
          * endianness to use when parsing vnet headers. If the backend
          * can't do it, we fallback onto fixing the headers in the core
@@ -225,7 +225,7 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
          */
         n->needs_vnet_hdr_swap = virtio_net_set_vnet_endian(vdev, n->nic->ncs,
                                                             queues, true);
-    } else if (virtio_net_started(n, vdev->status)) {
+    } else if (virtio_net_started(n, old_status)) {
         /* After using the device, we need to reset the network backend to
          * the default (guest native endianness), otherwise the guest may
          * lose network connectivity if it is rebooted into a different
@@ -243,15 +243,15 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
-static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
+static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t old_status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q;
     int i;
     uint8_t queue_status;
 
-    virtio_net_vnet_endian_status(n, status);
-    virtio_net_vhost_status(n, status);
+    virtio_net_vnet_endian_status(n, old_status);
+    virtio_net_vhost_status(n, old_status);
 
     for (i = 0; i < n->max_queues; i++) {
         NetClientState *ncs = qemu_get_subqueue(n->nic, i);
@@ -261,7 +261,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
         if ((!n->multiqueue && i != 0) || i >= n->curr_queues) {
             queue_status = 0;
         } else {
-            queue_status = status;
+            queue_status = vdev->status;
         }
         queue_started =
             virtio_net_started(n, queue_status) && !n->vhost_started;
@@ -2048,9 +2048,11 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     int i, max_queues;
+    uint8_t old_status = vdev->status;
 
     /* This will stop vhost backend if appropriate. */
-    virtio_net_set_status(vdev, 0);
+    vdev->status = 0;
+    virtio_net_set_status(vdev, old_status);
 
     g_free(n->netclient_name);
     n->netclient_name = NULL;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 9c1bea8..5a561e4 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -108,11 +108,11 @@ static void vhost_scsi_stop(VHostSCSI *s)
     vhost_scsi_common_stop(vsc);
 }
 
-static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
+static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t old_val)
 {
     VHostSCSI *s = VHOST_SCSI(vdev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    bool start = (val & VIRTIO_CONFIG_S_DRIVER_OK);
+    bool start = vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
 
     if (vsc->dev.started == start) {
         return;
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index f7561e2..289a27e 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -38,11 +38,11 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
-static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
+static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t old_status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    bool start = (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
+    bool start = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
 
     if (vsc->dev.started == start) {
         return;
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 5ec1c6a..d3f445b 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -154,10 +154,10 @@ static void vhost_vsock_stop(VirtIODevice *vdev)
     vhost_dev_disable_notifiers(&vsock->vhost_dev, vdev);
 }
 
-static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
+static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t old_status)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
-    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+    bool should_start = vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
 
     if (!vdev->vm_running) {
         should_start = false;
@@ -370,11 +370,14 @@ static void vhost_vsock_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    uint8_t old_status;
 
     vhost_vsock_post_load_timer_cleanup(vsock);
 
     /* This will stop vhost backend if appropriate. */
-    vhost_vsock_set_status(vdev, 0);
+    old_status = vdev->status;
+    vdev->status = 0;
+    vhost_vsock_set_status(vdev, old_status);
 
     vhost_dev_cleanup(&vsock->vhost_dev);
     virtio_cleanup(vdev);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38..84e897a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -468,12 +468,12 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
     }
 }
 
-static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
+static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t old_status)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
     if (!s->stats_vq_elem && vdev->vm_running &&
-        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
+        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
         /* poll stats queue for the element we have discarded when the VM
          * was stopped */
         virtio_balloon_receive_stats(vdev, s->svq);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d6002ee..a508dbe 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1128,6 +1128,8 @@ static int virtio_validate_features(VirtIODevice *vdev)
 int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint8_t old_status;
+
     trace_virtio_set_status(vdev, val);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
@@ -1140,10 +1142,13 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
+
+    old_status = vdev->status;
+    vdev->status = val;
+
     if (k->set_status) {
-        k->set_status(vdev, val);
+        k->set_status(vdev, old_status);
     }
-    vdev->status = val;
     return 0;
 }
 
-- 
MST
