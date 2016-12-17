Received: from eggs.gnu.org ([2001:4830:134:3::10]:53595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV5-0000Dx-58
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV2-0008T4-ES
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICV2-0007ss-67
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:56 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:43 +0800
Message-Id: <1481971427-11094-34-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 33/37] vhost-pci-net: send the negotiated
 feature bits to the master
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
 hw/net/vhost-pci-net.c              | 12 ++++++++++++
 hw/virtio/vhost-pci-slave.c         | 21 +++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 0198686..567fb86 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/error-report.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/vhost-pci-net.h"
 
@@ -136,6 +137,17 @@ static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features, Error
 
 static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
 {
+    static bool need_send;
+    int ret;
+
+    if (need_send) {
+        need_send = 0;
+        ret = vp_slave_send_feature_bits(features);
+        if (ret < 0)
+            error_report("failed to send feature bits to the master");
+    } else {
+        need_send = 1;
+    }
 }
 
 static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 427d618..d3c3443 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -85,6 +85,27 @@ static void vp_slave_set_features(VhostUserMsg *msg)
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
