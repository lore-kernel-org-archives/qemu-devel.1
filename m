Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr07-00030C-VA
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr06-0004dd-Vl
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr06-0004Vl-Lx
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:42 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:47 +0800
Message-Id: <1482127152-84732-13-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 12/37] vhost-pci-slave/msg:
 VHOST_USER_SET_DEVICE_ID
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

Initialize the feature bits according to the device type.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 23 +++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 020e279..3f35649 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -18,6 +18,12 @@
 #include "hw/virtio/vhost-pci-slave.h"
 #include "hw/virtio/vhost-user.h"
 
+#define VHOST_PCI_FEATURE_BITS (1ULL << VIRTIO_F_VERSION_1)
+
+#define VHOST_PCI_NET_FEATURE_BITS ((1ULL << VIRTIO_NET_F_MRG_RXBUF) | \
+                                   (1ULL << VIRTIO_NET_F_CTRL_VQ) | \
+                                   (1ULL << VIRTIO_NET_F_MQ))
+
 VhostPCISlave *vp_slave;
 
 static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
@@ -72,6 +78,20 @@ static int vp_slave_get_protocol_features(CharBackend *chr_be,
     return vp_slave_write(chr_be, msg);
 }
 
+static void vp_slave_set_device_type(VhostUserMsg *msg)
+{
+    vp_slave->dev_type = (uint16_t)msg->payload.u64;
+
+    switch (vp_slave->dev_type) {
+    case VIRTIO_ID_NET:
+        vp_slave->feature_bits |= (VHOST_PCI_FEATURE_BITS
+                                   | VHOST_PCI_NET_FEATURE_BITS);
+        break;
+    default:
+        error_report("device type %d is not supported", vp_slave->dev_type);
+    }
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -123,6 +143,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
         break;
     case VHOST_USER_SET_PROTOCOL_FEATURES:
         break;
+    case VHOST_USER_SET_DEVICE_ID:
+        vp_slave_set_device_type(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 4ec25d4..8b162dc 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -5,6 +5,7 @@
 
 typedef struct VhostPCISlave {
     CharBackend chr_be;
+    uint16_t dev_type;
     uint64_t feature_bits;
 } VhostPCISlave;
 
-- 
2.7.4
