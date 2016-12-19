Received: from eggs.gnu.org ([2001:4830:134:3::10]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0o-00059r-52
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0k-0004wF-GJ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0k-0004Vl-9F
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:22 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:10 +0800
Message-Id: <1482127152-84732-36-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 35/37] vhost-pci-net: start the
 vhost-pci-net device
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

If the peer device on the other side doesn't need to be reset, then
start the device when DRIVER_OK is received.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 3289f4d..4f2fab4 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -22,6 +22,16 @@
 #define VPNET_CQ_SIZE 32
 #define VPNET_RQ_SIZE 256
 
+static void vpnet_set_link_up(VhostPCINet *vpnet)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vpnet);
+    uint16_t old_status = vpnet->status;
+
+    vpnet->status |= VPNET_S_LINK_UP;
+    if (vpnet->status != old_status)
+        virtio_notify_config(vdev);
+}
+
 void vpnet_set_peer_vq_num(VhostPCINet *vpnet, uint16_t num)
 {
     vpnet->peer_vq_num = num;
@@ -127,6 +137,11 @@ static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
     if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
         vpnet_send_peer_mem_msg(vpnet);
         vpnet_send_peer_vq_msg(vpnet);
+        /* If the peer device is not reset, start the device now */
+        if (!vp_slave->peer_reset) {
+            vdev->status = status;
+            vpnet_set_link_up(vpnet);
+        }
     }
 }
 
-- 
2.7.4
