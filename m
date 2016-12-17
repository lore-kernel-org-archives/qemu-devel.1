Received: from eggs.gnu.org ([2001:4830:134:3::10]:53161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUH-0007GP-Au
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUG-00080n-Ei
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUG-0007ss-4l
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:08 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:16 +0800
Message-Id: <1481971427-11094-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 06/37] vhost-pci-slave: set up the
 fundamental handlers for the server socket
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

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 5ff9a09..2278f63 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -15,9 +15,59 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-pci-slave.h"
+#include "hw/virtio/vhost-user.h"
 
 VhostPCISlave *vp_slave;
 
+static void vp_slave_event(void *opaque, int event)
+{
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        break;
+    case CHR_EVENT_CLOSED:
+        break;
+    }
+}
+
+static int vp_slave_can_read(void *opaque)
+{
+    return VHOST_USER_HDR_SIZE;
+}
+
+static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
+{
+    VhostUserMsg msg;
+    uint8_t *p = (uint8_t *) &msg;
+    CharBackend *chr_be = (CharBackend *)opaque;
+
+    if (size != VHOST_USER_HDR_SIZE) {
+        error_report("Wrong message size received %d", size);
+        return;
+    }
+
+    memcpy(p, buf, VHOST_USER_HDR_SIZE);
+
+    if (msg.size) {
+        p += VHOST_USER_HDR_SIZE;
+        size = qemu_chr_fe_read_all(chr_be, p, msg.size);
+        if (size != msg.size) {
+            error_report("Wrong message size received %d != %d",
+                           size, msg.size);
+            return;
+        }
+    }
+
+    if (msg.request > VHOST_USER_MAX)
+        error_report("vhost-pci-slave read incorrect msg");
+
+    switch(msg.request) {
+    default:
+        error_report("vhost-pci-slave does not support msg request = %d",
+                     msg.request);
+        break;
+    }
+}
+
 static CharDriverState *vp_slave_parse_chardev(const char *id)
 {
     CharDriverState *chr = qemu_chr_find(id);
@@ -40,6 +90,9 @@ int vhost_pci_slave_init(QemuOpts *opts)
         return -1;
     }
     qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&vp_slave->chr_be, vp_slave_can_read,
+                             vp_slave_read, vp_slave_event,
+                             &vp_slave->chr_be, NULL, true);
 
     return 0;
 }
-- 
2.7.4
