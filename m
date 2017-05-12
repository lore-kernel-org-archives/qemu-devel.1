Received: from eggs.gnu.org ([2001:4830:134:3::10]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968r-0005j5-N4
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968q-0001xK-Iu
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968q-0001je-83
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:40 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:41 +0800
Message-Id: <1494578148-102868-10-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 09/16] vhost-user: send
 VHOST_USER_SET_VHOST_PCI_START/STOP
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

The master requests the slave to create or destroy a vhost-pci device.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c                | 36 ++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c            | 17 +++++++++++++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 include/net/vhost_net.h           |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index ea9879f..0a5278d 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -18,6 +18,7 @@
 #include "net/tap.h"
 #include "net/vhost-user.h"
 
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "qemu/error-report.h"
@@ -296,6 +297,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int r, e, i;
 
     if (!k->set_guest_notifiers) {
@@ -341,6 +343,15 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    last_net = get_vhost_net(ncs[total_queues - 1].peer);
+    if (vhost_pci_enabled(&last_net->dev)) {
+        r = vhost_set_vhost_pci(ncs[total_queues - 1].peer,
+                              VHOST_USER_SET_VHOST_PCI_START);
+        if (r < 0) {
+            goto err_start;
+        }
+    }
+
     return 0;
 
 err_start:
@@ -362,8 +373,15 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int i, r;
 
+    last_net = get_vhost_net(ncs[total_queues - 1].peer);
+    if (vhost_pci_enabled(&last_net->dev)) {
+        vhost_set_vhost_pci(ncs[total_queues - 1].peer,
+                              VHOST_USER_SET_VHOST_PCI_STOP);
+    }
+
     for (i = 0; i < total_queues; i++) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
@@ -450,6 +468,18 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
 
+int vhost_set_vhost_pci(NetClientState *nc, uint8_t cmd)
+{
+    VHostNetState *net = get_vhost_net(nc);
+    const VhostOps *vhost_ops = net->dev.vhost_ops;
+
+    if (vhost_ops && vhost_ops->vhost_set_vhost_pci) {
+        return vhost_ops->vhost_set_vhost_pci(&net->dev, cmd);
+    }
+
+    return 0;
+}
+
 #else
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
 {
@@ -521,4 +551,10 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
 }
+
+int vhost_set_vhost_pci(NetClientState *nc, uint8_t cmd)
+{
+    return 0;
+}
+
 #endif
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1eba5e5..ca8fe36 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -313,6 +313,22 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
     return 0;
 }
 
+static int vhost_user_set_vhost_pci(struct vhost_dev *dev, uint8_t cmd)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_VHOST_PCI,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = (uint64_t)cmd,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 static int vhost_user_get_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
@@ -671,6 +687,7 @@ const VhostOps user_ops = {
         .vhost_reset_device = vhost_user_reset_device,
         .vhost_get_vq_index = vhost_user_get_vq_index,
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
+        .vhost_set_vhost_pci = vhost_user_set_vhost_pci,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index c3cf4a7..1c68f67 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -70,6 +70,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef int (*vhost_set_vhost_pci_op)(struct vhost_dev *dev, uint8_t cmd);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -114,6 +115,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vhost_pci_op vhost_set_vhost_pci;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_backend_can_merge_op vhost_backend_can_merge;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index afc1499..3db5559 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -37,4 +37,6 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
+int vhost_set_vhost_pci(NetClientState *nc, uint8_t cmd);
+
 #endif
-- 
2.7.4
