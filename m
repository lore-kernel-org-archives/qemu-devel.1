Received: from eggs.gnu.org ([2001:4830:134:3::10]:44893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968o-0005fy-Dc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968l-0001tM-Ed
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968l-0001je-1D
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:35 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:38 +0800
Message-Id: <1494578148-102868-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 06/16] virtio: add inter-vm notification
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

This patch enables the assign of an already allocated eventfd to a notifier.
In this case, QEMU creates a new eventfd for the notifier only when the
notifier's fd equals to -1. Otherwise, it means that the notifier has been
assigned a vaild fd.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c            | 73 +++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-bus.c            | 19 +++++++---
 hw/virtio/virtio-pci.c            | 22 ++++++++++--
 hw/virtio/virtio.c                | 32 ++++++++++++++---
 include/hw/virtio/vhost-pci-net.h |  6 ++++
 include/hw/virtio/virtio.h        |  2 ++
 6 files changed, 141 insertions(+), 13 deletions(-)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index e36803a..0235511 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/vhost-pci-net.h"
+#include "hw/virtio/virtio-bus.h"
 
 #define VPNET_CTRLQ_SIZE 32
 #define VPNET_VQ_SIZE 256
@@ -114,12 +115,53 @@ static void vpnet_send_ctrlq_msg_remoteq(VhostPCINet *vpnet)
     g_free(msg);
 }
 
+static inline bool vq_is_txq(uint16_t id)
+{
+    return (id % 2 == 0);
+}
+
+static inline uint16_t tx2rx(uint16_t id)
+{
+    return id + 1;
+}
+
+static inline uint16_t rx2tx(uint16_t id)
+{
+    return id - 1;
+}
+
 static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    uint16_t vq_num = vpnet->vq_pairs * 2;
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    VirtQueue *vq;
+    int r, i;
 
     /* Send the ctrlq messages to the driver when the ctrlq is ready */
     if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        /*
+         * Set up the callfd when the driver is ready.
+         * Crosse share the eventfds from the remoteq.
+         * Use the tx remoteq's kickfd as the rx localq's callfd.
+         * Use the rx remoteq's kickfd as the tx localq's callfd.
+         */
+        for (i = 0; i < vq_num; i++) {
+            vq = virtio_get_queue(vdev, i);
+            if (vq_is_txq(i)) {
+                virtio_queue_set_guest_notifier(vq,
+                                          vpnet->remoteq_fds[tx2rx(i)].kickfd);
+            } else {
+                virtio_queue_set_guest_notifier(vq,
+                                          vpnet->remoteq_fds[rx2tx(i)].kickfd);
+            }
+        }
+        r = k->set_guest_notifiers(qbus->parent, vq_num, true);
+        if (r < 0) {
+            error_report("Error binding guest notifier: %d", -r);
+        }
         vpnet_send_ctrlq_msg_remote_mem(vpnet);
         vpnet_send_ctrlq_msg_remoteq(vpnet);
     }
@@ -155,17 +197,29 @@ static void vpnet_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
 }
 
+static void vpnet_copy_fds_from_vhostdev(VirtqueueFD *fds, Remoteq *remoteq)
+{
+    fds[remoteq->vring_num].callfd = remoteq->callfd;
+    fds[remoteq->vring_num].kickfd = remoteq->kickfd;
+}
+
 static void vpnet_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
     uint16_t i, vq_num;
     VhostPCIDev *vp_dev = get_vhost_pci_dev();
+    Remoteq *remoteq;
 
     vq_num = vp_dev->remoteq_num;
     vpnet->vq_pairs = vq_num / 2;
     virtio_init(vdev, "vhost-pci-net", VIRTIO_ID_VHOST_PCI_NET,
                 vpnet->config_size);
+    vpnet->remoteq_fds = g_malloc(sizeof(struct VirtqueueFD) *
+                                  vq_num);
+    QLIST_FOREACH(remoteq, &vp_dev->remoteq_list, node) {
+        vpnet_copy_fds_from_vhostdev(vpnet->remoteq_fds, remoteq);
+    }
 
     /* Add local vqs */
     for (i = 0; i < vq_num; i++) {
@@ -192,6 +246,25 @@ static void vpnet_device_unrealize(DeviceState *dev, Error **errp)
 
 static void vpnet_reset(VirtIODevice *vdev)
 {
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    VirtQueue *vq;
+    uint16_t i, vq_num = vpnet->vq_pairs * 2;
+
+    for (i = 0; i < vq_num; i++) {
+        vq = virtio_get_queue(vdev, i);
+        /*
+         * Cross share the eventfds.
+         * Use the tx remoteq's callfd as the rx localq's kickfd.
+         * Use the rx remoteq's callfd as the tx localq's kickfd.
+         */
+        if (vq_is_txq(i)) {
+            virtio_queue_set_host_notifier(vq,
+                                          vpnet->remoteq_fds[tx2rx(i)].callfd);
+        } else {
+            virtio_queue_set_host_notifier(vq,
+                                          vpnet->remoteq_fds[rx2tx(i)].callfd);
+        }
+    }
 }
 
 static Property vpnet_properties[] = {
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..3cf0991 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -274,11 +274,20 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
     }
 
     if (assign) {
-        r = event_notifier_init(notifier, 1);
-        if (r < 0) {
-            error_report("%s: unable to init event notifier: %s (%d)",
-                         __func__, strerror(-r), r);
-            return r;
+        if (notifier->wfd == -1) {
+            r = event_notifier_init(notifier, 1);
+            if (r < 0) {
+                error_report("%s: unable to init event notifier: %s (%d)",
+                             __func__, strerror(-r), r);
+                return r;
+            }
+        } else {
+            r = event_notifier_set(notifier);
+            if (r < 0) {
+                error_report("%s: unable to set event notifier: %s (%d)",
+                             __func__, strerror(-r), r);
+                return r;
+            }
         }
         r = k->ioeventfd_assign(proxy, notifier, n, true);
         if (r < 0) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b60e683..3f1a198 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -963,11 +963,24 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
+    int r = 0;
 
     if (assign) {
-        int r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
+        if (notifier->wfd == -1) {
+            r = event_notifier_init(notifier, 0);
+            if (r < 0) {
+                error_report("%s: unable to init event notifier: %s (%d)",
+                             __func__, strerror(-r), r);
+                return r;
+
+            }
+        } else {
+            r = event_notifier_set(notifier);
+            if (r < 0) {
+                error_report("%s: unable to set event notifier: %s (%d)",
+                             __func__, strerror(-r), r);
+                return r;
+            }
         }
         virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
     } else {
@@ -2370,6 +2383,9 @@ static const TypeInfo virtio_net_pci_info = {
 /* vhost-pci-net */
 
 static Property vpnet_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 4),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..43c7273 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1196,10 +1196,6 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (k->reset) {
-        k->reset(vdev);
-    }
-
     vdev->broken = false;
     vdev->guest_features = 0;
     vdev->queue_sel = 0;
@@ -1222,6 +1218,14 @@ void virtio_reset(void *opaque)
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
         virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
+        vdev->vq[i].host_notifier.rfd = -1;
+        vdev->vq[i].host_notifier.wfd = -1;
+        vdev->vq[i].guest_notifier.rfd = -1;
+        vdev->vq[i].guest_notifier.wfd = -1;
+    }
+
+    if (k->reset) {
+        k->reset(vdev);
     }
 }
 
@@ -2253,7 +2257,11 @@ void virtio_init(VirtIODevice *vdev, const char *name,
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
         vdev->vq[i].vdev = vdev;
         vdev->vq[i].queue_index = i;
-    }
+        vdev->vq[i].host_notifier.rfd = -1;
+        vdev->vq[i].host_notifier.wfd = -1;
+        vdev->vq[i].guest_notifier.rfd = -1;
+        vdev->vq[i].guest_notifier.wfd = -1;
+     }
 
     vdev->name = name;
     vdev->config_len = config_size;
@@ -2364,6 +2372,13 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
     return &vq->guest_notifier;
 }
 
+void virtio_queue_set_guest_notifier(VirtQueue *vq, int fd)
+{
+    EventNotifier *e = &vq->guest_notifier;
+    e->rfd = fd;
+    e->wfd = fd;
+}
+
 static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
 {
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
@@ -2437,6 +2452,13 @@ EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq)
     return &vq->host_notifier;
 }
 
+void virtio_queue_set_host_notifier(VirtQueue *vq, int fd)
+{
+    EventNotifier *e = &vq->host_notifier;
+    e->rfd = fd;
+    e->wfd = fd;
+}
+
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
 {
     g_free(vdev->bus_name);
diff --git a/include/hw/virtio/vhost-pci-net.h b/include/hw/virtio/vhost-pci-net.h
index e3a1c8b..9776260 100644
--- a/include/hw/virtio/vhost-pci-net.h
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -22,6 +22,11 @@
 #define VHOST_PCI_NET(obj) \
         OBJECT_CHECK(VhostPCINet, (obj), TYPE_VHOST_PCI_NET)
 
+typedef struct VirtqueueFD {
+    int kickfd;
+    int callfd;
+} VirtqueueFD;
+
 typedef struct VhostPCINet {
     VirtIODevice parent_obj;
     VirtQueue *ctrlq;
@@ -29,6 +34,7 @@ typedef struct VhostPCINet {
     uint16_t vq_pairs;
     size_t config_size;
     uint64_t device_features;
+    VirtqueueFD *remoteq_fds;
 } VhostPCINet;
 
 #endif
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7b6edba..423b466 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -276,6 +276,7 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
 uint16_t virtio_get_queue_index(VirtQueue *vq);
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
+void virtio_queue_set_guest_notifier(VirtQueue *vq, int fd);
 void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
                                                 bool with_irqfd);
 int virtio_device_start_ioeventfd(VirtIODevice *vdev);
@@ -284,6 +285,7 @@ int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
 EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
+void virtio_queue_set_host_notifier(VirtQueue *vq, int fd);
 void virtio_queue_host_notifier_read(EventNotifier *n);
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
                                                 VirtIOHandleAIOOutput handle_output);
-- 
2.7.4
