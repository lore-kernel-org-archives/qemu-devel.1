Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0h-00040P-Tf
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0h-0004ss-2c
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0g-0004Vl-Rj
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:19 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:08 +0800
Message-Id: <1482127152-84732-34-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 33/37] vhost-pci-net: send the
 negotiated feature bits to the master
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

The slave actively sends the negotiated feature bits to the master.
"need_send" is used to detect if the 64-bit feature bits are ready to
be sent.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c              | 13 +++++++++++++
 hw/virtio/vhost-pci-slave.c         | 21 +++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 5ad4a9f..8e30281 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/error-report.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/vhost-pci-net.h"
 
@@ -139,6 +140,18 @@ static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
 
 static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
 {
+    static bool need_send;
+    int ret;
+
+    if (need_send) {
+        need_send = 0;
+        ret = vp_slave_send_feature_bits(features);
+        if (ret < 0) {
+            error_report("failed to send feature bits to the master");
+        }
+    } else {
+        need_send = 1;
+    }
 }
 
 static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index de08324..a966885 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -88,6 +88,27 @@ static void vp_slave_set_features(VhostUserMsg *msg)
                              & ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
+static int vp_slave_send_u64(int request, uint64_t u64)
+{
+    VhostUserMsg msg = {
+        .request = request,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = u64,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    if (vp_slave_write(&vp_slave->chr_be, &msg) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+int vp_slave_send_feature_bits(uint64_t features)
+{
+    return vp_slave_send_u64(VHOST_USER_SET_FEATURES, features);
+}
+
 static DeviceState *virtio_to_pci_dev(VirtIODevice *vdev, uint16_t virtio_id)
 {
     DeviceState *qdev;
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 79e1ffd..e60580a 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -40,4 +40,6 @@ extern int vhost_pci_slave_init(QemuOpts *opts);
 
 extern int vhost_pci_slave_cleanup(void);
 
+extern int vp_slave_send_feature_bits(uint64_t features);
+
 #endif
-- 
2.7.4
