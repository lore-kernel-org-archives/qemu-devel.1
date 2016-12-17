Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUy-0008VY-7k
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUx-0008Ou-7o
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUw-0007ss-VP
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:51 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:40 +0800
Message-Id: <1481971427-11094-31-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 30/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VHOST_PCI (stop)
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

The slave removes the slave device when receiving the request with the
stop command.

In the case that the master side guest crashes, the crashed guest, typically,
will be killed by the admin. This event will be captured via the close of the
socket connection, so we can remove the vhost-pci device and free the related
resources there.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c              |  1 +
 hw/virtio/vhost-pci-slave.c         | 40 +++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index d8b13c8..0198686 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -170,6 +170,7 @@ static void vpnet_device_realize(DeviceState *dev, Error **errp)
                                          vpnet_handle_rq);
     }
     vpnet->status = 0;
+    vp_slave->vdev = vdev;
 }
 
 static void vpnet_device_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 73d3f71..427d618 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -34,6 +34,9 @@ static void vp_slave_cleanup(void)
     uint32_t i, nregions;
     PeerVqNode *pvq_node;
 
+    if (!vp_slave->vdev)
+        return;
+
     nregions = vp_slave->pmem_msg.nregions;
     for (i = 0; i < nregions; i++) {
         ret = munmap(vp_slave->mr_map_base[i], vp_slave->mr_map_size[i]);
@@ -48,6 +51,7 @@ static void vp_slave_cleanup(void)
     }
     QLIST_INIT(&vp_slave->pvq_list);
     vp_slave->pvq_num = 0;
+    vp_slave->vdev = NULL;
 }
 
 static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
@@ -81,12 +85,44 @@ static void vp_slave_set_features(VhostUserMsg *msg)
                              & ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
+static DeviceState *virtio_to_pci_dev(VirtIODevice *vdev, uint16_t virtio_id)
+{
+    DeviceState *qdev;
+    VhostPCINet *vpnet;
+    VhostPCINetPCI *netpci;
+
+    switch (virtio_id) {
+    case VIRTIO_ID_NET:
+        vpnet = VHOST_PCI_NET(vdev);
+        netpci = container_of(vpnet, VhostPCINetPCI, vdev);
+        qdev = &netpci->parent_obj.pci_dev.qdev;
+        break;
+    default:
+        error_report("virtio_to_pci_dev: device type %d not supported",
+                     virtio_id);
+    }
+
+    return qdev;
+}
+
+static void vp_slave_device_del(VirtIODevice *vdev)
+{
+    Error *errp = NULL;
+    DeviceState *qdev = virtio_to_pci_dev(vdev, vp_slave->dev_type);
+
+    if (vdev != NULL) {
+        qdev_unplug(qdev, &errp);
+        vp_slave_cleanup();
+    }
+}
+
 static void vp_slave_event(void *opaque, int event)
 {
     switch (event) {
     case CHR_EVENT_OPENED:
         break;
     case CHR_EVENT_CLOSED:
+        vp_slave_device_del(vp_slave->vdev);
         break;
     }
 }
@@ -298,6 +334,10 @@ static int vp_slave_set_vhost_pci(CharBackend *chr_be, VhostUserMsg *msg)
         if (ret < 0)
             return ret;
         break;
+    case VHOST_USER_SET_VHOST_PCI_stop:
+        vp_slave_device_del(vp_slave->vdev);
+        ret = 0;
+        break;
     default:
         error_report("slave pconnection: cmd %d not supported yet", cmd);
         return -1;
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 3e0f4c7..79e1ffd 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -19,6 +19,8 @@ typedef struct PeerVqNode {
 
 typedef struct VhostPCISlave {
     CharBackend chr_be;
+    /* Ponnter to the slave device */
+    VirtIODevice *vdev;
     uint16_t dev_type;
     uint64_t feature_bits;
     /* hotplugged memory should be mapped following the offset */
-- 
2.7.4
