Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV0-00005J-23
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUy-0008Py-Ut
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUy-0007ss-NG
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:52 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:41 +0800
Message-Id: <1481971427-11094-32-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 31/37] vhost-user/msg: send
 VHOST_USER_SET_VHOST_PCI (start/stop)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

The master requests the slave to create or destroy a vhost-pci device.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c                | 34 ++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c            | 17 +++++++++++++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 include/net/vhost_net.h           |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6524503..7f64be3 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -18,6 +18,7 @@
 #include "net/tap.h"
 #include "net/vhost-user.h"
 
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "qemu/error-report.h"
@@ -293,6 +294,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int r, e, i;
 
     if (!k->set_guest_notifiers) {
@@ -338,6 +340,14 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    last_net = get_vhost_net(ncs[total_queues-1].peer);
+    if (vhost_pci_enabled(&last_net->dev)) {
+        r = vhost_set_vhost_pci(ncs[total_queues-1].peer,
+                              VHOST_USER_SET_VHOST_PCI_start);
+        if (r < 0)
+            goto err_start;
+    }
+
     return 0;
 
 err_start:
@@ -359,8 +369,14 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *last_net;
     int i, r;
 
+    last_net = get_vhost_net(ncs[total_queues-1].peer);
+    if (vhost_pci_enabled(&last_net->dev))
+        vhost_set_vhost_pci(ncs[total_queues-1].peer,
+                              VHOST_USER_SET_VHOST_PCI_stop);
+
     for (i = 0; i < total_queues; i++) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
@@ -436,6 +452,18 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
     return 0;
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
@@ -502,4 +530,10 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
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
index 8b5ac0b..ce92140 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -312,6 +312,22 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
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
@@ -639,6 +655,7 @@ const VhostOps user_ops = {
         .vhost_reset_device = vhost_user_reset_device,
         .vhost_get_vq_index = vhost_user_get_vq_index,
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
+        .vhost_set_vhost_pci = vhost_user_set_vhost_pci,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6e90703..60c0833 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -67,6 +67,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef int (*vhost_set_vhost_pci_op)(struct vhost_dev *dev, uint8_t cmd);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -102,6 +103,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vhost_pci_op vhost_set_vhost_pci;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_backend_can_merge_op vhost_backend_can_merge;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 5a08eff..82d5987 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,4 +35,6 @@ int vhost_set_vring_enable(NetClientState * nc, int enable);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
+int vhost_set_vhost_pci(NetClientState *nc, uint8_t cmd);
+
 #endif
-- 
2.7.4
