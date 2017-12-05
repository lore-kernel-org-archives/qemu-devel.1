Received: from eggs.gnu.org ([2001:4830:134:3::10]:33325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ez-0001Ti-6a
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ev-0007PS-5x
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:32277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM4Eu-0007JF-Sb
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:49 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:14 +0800
Message-Id: <1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 5/7] vhost-user: VHOST_USER_SET_VHOST_PCI msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>

Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg is
used to signal the vhost-pci device to start/stop working.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c                | 37 +++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-pci-slave.c       |  2 +-
 hw/virtio/vhost-user.c            | 17 +++++++++++++++++
 hw/virtio/vhost.c                 |  7 +++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 include/hw/virtio/vhost-user.h    |  2 ++
 include/hw/virtio/vhost.h         |  2 ++
 include/net/vhost_net.h           |  2 ++
 8 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db6..107aa13 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -296,6 +296,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int r, e, i;
 
     if (!k->set_guest_notifiers) {
@@ -341,6 +342,18 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    last_net = get_vhost_net(ncs[total_queues - 1].peer);
+    if (vhost_pci_enabled(&last_net->dev)) {
+        /*
+         * All the msgs have been sync-ed to the vhost-pci device. This is the
+         * last one to signal the vhost-pci device to link up.
+         */
+        r = vhost_set_vhost_pci(ncs[total_queues - 1].peer, true);
+        if (r < 0) {
+            goto err_start;
+        }
+    }
+
     return 0;
 
 err_start:
@@ -362,8 +375,15 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int i, r;
 
+    last_net = get_vhost_net(ncs[total_queues - 1].peer);
+    if (vhost_pci_enabled(&last_net->dev)) {
+        /* Signal the vhost-pci device to stop. */
+        vhost_set_vhost_pci(ncs[total_queues - 1].peer, false);
+    }
+
     for (i = 0; i < total_queues; i++) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
@@ -450,6 +470,18 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
 
+int vhost_set_vhost_pci(NetClientState *nc, bool up)
+{
+    VHostNetState *net = get_vhost_net(nc);
+    const VhostOps *vhost_ops = net->dev.vhost_ops;
+
+    if (vhost_ops && vhost_ops->vhost_set_vhost_pci) {
+        return vhost_ops->vhost_set_vhost_pci(&net->dev, up);
+    }
+
+    return 0;
+}
+
 #else
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
 {
@@ -521,4 +553,9 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
 }
+
+int vhost_set_vhost_pci(NetClientState *nc, bool up)
+{
+    return 0;
+}
 #endif
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index b1a8620..8052884 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -23,7 +23,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/vhost-pci-net.h"
 
-#define VHOST_USER_PROTOCOL_FEATURES 0
+#define VHOST_USER_PROTOCOL_FEATURES (1UL << VHOST_USER_PROTOCOL_F_VHOST_PCI)
 
 static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
 {
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e512f5a..a48003a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -342,6 +342,22 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
     return 0;
 }
 
+static int vhost_user_set_vhost_pci(struct vhost_dev *dev, bool up)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_VHOST_PCI,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = (uint64_t)up,
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
@@ -844,6 +860,7 @@ const VhostOps user_ops = {
         .vhost_reset_device = vhost_user_reset_device,
         .vhost_get_vq_index = vhost_user_get_vq_index,
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
+        .vhost_set_vhost_pci = vhost_user_set_vhost_pci,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce..dda7b8f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "hw/virtio/vhost-user.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
 
@@ -1007,6 +1008,12 @@ out:
     return ret;
 }
 
+bool vhost_pci_enabled(struct vhost_dev *dev)
+{
+    return ((dev->protocol_features &
+            (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI)) != 0);
+}
+
 static int vhost_virtqueue_start(struct vhost_dev *dev,
                                 struct VirtIODevice *vdev,
                                 struct vhost_virtqueue *vq,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22..e9d23dd 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -71,6 +71,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef int (*vhost_set_vhost_pci_op)(struct vhost_dev *dev, bool up);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -111,6 +112,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vhost_pci_op vhost_set_vhost_pci;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_backend_can_merge_op vhost_backend_can_merge;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index d76e9ad..d5bcee7 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -14,6 +14,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_VHOST_PCI = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -45,6 +46,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_SET_VHOST_PCI = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 467dc77..f173e81 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -106,4 +106,6 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
+
+bool vhost_pci_enabled(struct vhost_dev *dev);
 #endif
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index afc1499..257e8cc 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -37,4 +37,6 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
+int vhost_set_vhost_pci(NetClientState *nc, bool up);
+
 #endif
-- 
2.7.4
