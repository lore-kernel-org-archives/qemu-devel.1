Received: from eggs.gnu.org ([2001:4830:134:3::10]:53536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUy-0008VW-7P
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUv-0008Nj-Il
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUv-0007ss-7J
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:49 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:39 +0800
Message-Id: <1481971427-11094-30-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 29/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VHOST_PCI (start)
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

The VHOST_USER_SET_VHOST_PCI msg is used to request the start or
stop of the vhost-pci device.

This patch handles the start commandin the slave. When receiving
the SET_VHOST_PCI request with the start command, the slave creates
a vhost-pci device based on the previously received virtio_id.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c    | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user.h |  5 +++++
 2 files changed, 56 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index cdeb710..73d3f71 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -13,6 +13,7 @@
 #include <qemu/osdep.h>
 #include <qemu/sockets.h>
 
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio-pci.h"
@@ -260,6 +261,51 @@ static void vp_slave_set_vring_enable(VhostUserMsg *msg)
     }
 }
 
+static int vp_slave_device_create(uint16_t virtio_id)
+{
+    Error *local_err = NULL;
+    QemuOpts *opts;
+    DeviceState *dev;
+    char params[50];
+
+    switch (virtio_id) {
+    case VIRTIO_ID_NET:
+        strcpy(params, "driver=vhost-pci-net-pci,id=vhost-pci-0");
+        break;
+    default:
+        error_report("vhost-pci device create: device type %d not supported",
+                     virtio_id);
+    }
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("device"), params, true);
+    dev = qdev_device_add(opts, &local_err);
+    if (!dev) {
+        qemu_opts_del(opts);
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
+
+static int vp_slave_set_vhost_pci(CharBackend *chr_be, VhostUserMsg *msg)
+{
+    int ret;
+    uint8_t cmd = (uint8_t)msg->payload.u64;
+
+    switch (cmd) {
+    case VHOST_USER_SET_VHOST_PCI_start:
+        ret = vp_slave_device_create(vp_slave->dev_type);
+        if (ret < 0)
+            return ret;
+        break;
+    default:
+        error_report("slave pconnection: cmd %d not supported yet", cmd);
+        return -1;
+    }
+
+    return ret;
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -370,6 +416,11 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
         break;
     case VHOST_USER_SEND_RARP:
         break;
+    case VHOST_USER_SET_VHOST_PCI:
+        ret = vp_slave_set_vhost_pci(chr_be, &msg);
+        if (ret < 0)
+            goto err_handling;
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 45f11be..12e4dc9 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -25,6 +25,10 @@ enum VhostUserProtocolFeature {
                                       (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI) | \
                                       (1ULL << VHOST_USER_PROTOCOL_F_SET_DEVICE_ID)
 
+/* control/status of the vhost-pci device */
+#define VHOST_USER_SET_VHOST_PCI_start    0
+#define VHOST_USER_SET_VHOST_PCI_stop     1
+
 typedef enum VhostUserRequest {
     VHOST_USER_NONE = 0,
     VHOST_USER_GET_FEATURES = 1,
@@ -47,6 +51,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
     VHOST_USER_SET_DEVICE_ID = 20,
+    VHOST_USER_SET_VHOST_PCI = 21,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
2.7.4
