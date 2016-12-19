Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzz-0002r3-6y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzy-0004Za-8C
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzx-0004Vl-Vt
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:34 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:42 +0800
Message-Id: <1482127152-84732-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 07/37] vhost-pci-slave/msg:
 VHOST_USER_GET_FEATURES
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

Offer the initial feature bits, which haven't been negotiated with the slave
driver, to the master.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 38 +++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index cb3abae..448b76c 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -14,11 +14,37 @@
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/vhost-pci-slave.h"
 #include "hw/virtio/vhost-user.h"
 
 VhostPCISlave *vp_slave;
 
+static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
+{
+    int size;
+
+    if (!msg) {
+        return 0;
+    }
+
+    size = msg->size + VHOST_USER_HDR_SIZE;
+    msg->flags &= ~VHOST_USER_VERSION_MASK;
+    msg->flags |= VHOST_USER_VERSION;
+
+    return qemu_chr_fe_write_all(chr_be, (const uint8_t *)msg, size)
+           == size ? 0 : -1;
+}
+
+static int vp_slave_get_features(CharBackend *chr_be, VhostUserMsg *msg)
+{
+    msg->payload.u64 = vp_slave->feature_bits;
+    msg->size = sizeof(msg->payload.u64);
+    msg->flags |= VHOST_USER_REPLY_MASK;
+
+    return vp_slave_write(chr_be, msg);
+}
+
 static void vp_slave_event(void *opaque, int event)
 {
     switch (event) {
@@ -36,6 +62,7 @@ static int vp_slave_can_read(void *opaque)
 
 static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
 {
+    int ret;
     VhostUserMsg msg;
     uint8_t *p = (uint8_t *) &msg;
     CharBackend *chr_be = (CharBackend *)opaque;
@@ -62,11 +89,21 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     }
 
     switch (msg.request) {
+    case VHOST_USER_GET_FEATURES:
+        ret = vp_slave_get_features(chr_be, &msg);
+        if (ret < 0) {
+            goto err_handling;
+        }
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
         break;
     }
+    return;
+
+err_handling:
+    error_report("vhost-pci-slave handle request %d failed", msg.request);
 }
 
 static CharDriverState *vp_slave_parse_chardev(const char *id)
@@ -90,6 +127,7 @@ int vhost_pci_slave_init(QemuOpts *opts)
     if (!chr) {
         return -1;
     }
+    vp_slave->feature_bits =  1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
     qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&vp_slave->chr_be, vp_slave_can_read,
                              vp_slave_read, vp_slave_event,
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index c82c775..4ec25d4 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -5,6 +5,7 @@
 
 typedef struct VhostPCISlave {
     CharBackend chr_be;
+    uint64_t feature_bits;
 } VhostPCISlave;
 
 extern VhostPCISlave *vp_slave;
-- 
2.7.4
