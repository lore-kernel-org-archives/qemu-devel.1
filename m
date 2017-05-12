Received: from eggs.gnu.org ([2001:4830:134:3::10]:45068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9693-0005to-5a
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9692-00028D-6R
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d9691-0001je-UF
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:52 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:47 +0800
Message-Id: <1494578148-102868-16-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 15/16] vhost-pci-net: tell the driver that
 it is ready to send packets
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

If the remote device on the other side doesn't need to be reset,
set bit 0 of the device status register to allow the driver to
send out the packets.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index a2dca50..513a7ff 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -130,6 +130,20 @@ static inline uint16_t rx2tx(uint16_t id)
     return id - 1;
 }
 
+static void vpnet_set_link_up(VhostPCINet *vpnet)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vpnet);
+    uint16_t old_status = vpnet->status;
+
+    /*
+     * Set the LINK_UP status bit and notify the driver that it can send
+     * packets.
+     */
+    vpnet->status |= VPNET_S_LINK_UP;
+    if (vpnet->status != old_status)
+        virtio_notify_config(vdev);
+}
+
 static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
@@ -137,6 +151,7 @@ static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
     VirtQueue *vq;
     int r, i;
 
@@ -164,6 +179,11 @@ static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
         }
         vpnet_send_ctrlq_msg_remote_mem(vpnet);
         vpnet_send_ctrlq_msg_remoteq(vpnet);
+        /* If the peer device is not reset, start the device now */
+        if (!vp_dev->reset_virtio) {
+            vdev->status = status;
+            vpnet_set_link_up(vpnet);
+        }
     }
 }
 
-- 
2.7.4
