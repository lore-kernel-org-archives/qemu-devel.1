Received: from eggs.gnu.org ([2001:4830:134:3::10]:53608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV7-0000GQ-BB
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV5-0008V8-US
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICV5-0007ss-La
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:59 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:45 +0800
Message-Id: <1481971427-11094-36-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 35/37] vhost-pci-net: start the
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
index 6d4db6c..75ee72c 100644
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
@@ -125,6 +135,11 @@ static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
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
