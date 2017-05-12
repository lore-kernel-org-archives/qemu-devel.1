Received: from eggs.gnu.org ([2001:4830:134:3::10]:45021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9691-0005sF-Dp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9690-00025D-Ha
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d9690-0001je-8t
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:50 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:46 +0800
Message-Id: <1494578148-102868-15-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 14/16] vhost-pci-slave: add support to
 delete a vhost-pci device
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

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index a7d3c8d..cde122c 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -139,6 +139,42 @@ static int vp_slave_send_u64(int request, uint64_t u64)
     return 0;
 }
 
+static DeviceState *virtio_to_pci_dev(VirtIODevice *vdev, uint16_t virtio_id)
+{
+    DeviceState *qdev = NULL;
+    VhostPCINet *vpnet;
+    VhostPCINetPCI *netpci;
+
+    if (!vdev) {
+        return NULL;
+    }
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
+    VhostPCIDev *vp_dev = vp_slave->vp_dev;
+    DeviceState *qdev = virtio_to_pci_dev(vdev, vp_dev->dev_type);
+
+    if (qdev != NULL) {
+        qdev_unplug(qdev, &errp);
+        vp_dev_cleanup();
+    }
+}
+
 int vp_slave_send_feature_bits(uint64_t features)
 {
     return vp_slave_send_u64(VHOST_USER_SET_FEATURES, features);
@@ -146,10 +182,13 @@ int vp_slave_send_feature_bits(uint64_t features)
 
 static void vp_slave_event(void *opaque, int event)
 {
+    VhostPCIDev *vp_dev = vp_slave->vp_dev;
+
     switch (event) {
     case CHR_EVENT_OPENED:
         break;
     case CHR_EVENT_CLOSED:
+        vp_slave_device_del(vp_dev->vdev);
         break;
     }
 }
@@ -416,6 +455,8 @@ static int vp_slave_set_vhost_pci(VhostUserMsg *msg)
         }
         break;
     case VHOST_USER_SET_VHOST_PCI_STOP:
+        vp_slave_device_del(vp_dev->vdev);
+        ret = 0;
         break;
     default:
         error_report("%s: cmd %d not supported", __func__, cmd);
-- 
2.7.4
