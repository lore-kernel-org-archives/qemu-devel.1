Received: from eggs.gnu.org ([2001:4830:134:3::10]:53585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzv-0002pI-UW
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzu-0004XK-Tw
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzu-0004Vl-KJ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:30 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:40 +0800
Message-Id: <1482127152-84732-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 05/37] vhost-pci-slave: start the
 implementation of vhost-pci-slave
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

Vhost-pci-slave uses a QEMU socket to talk to the master. This patch
associates the slave with the qemu sever socket.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/Makefile.objs             |  1 +
 hw/virtio/vhost-pci-slave.c         | 53 +++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h | 16 +++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 hw/virtio/vhost-pci-slave.c
 create mode 100644 include/hw/virtio/vhost-pci-slave.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 95c4c30..3af6787 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,6 +2,7 @@ common-obj-y += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-y += virtio-bus.o
 common-obj-y += virtio-mmio.o
+common-obj-y += vhost-pci-slave.o
 
 obj-y += virtio.o virtio-balloon.o 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
new file mode 100644
index 0000000..6b6deb2
--- /dev/null
+++ b/hw/virtio/vhost-pci-slave.c
@@ -0,0 +1,53 @@
+/*
+ * Vhost-pci Slave
+ *
+ * Copyright Intel Corp. 2016
+ *
+ * Authors:
+ * Wei Wang    <wei.w.wang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <qemu/osdep.h>
+
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/vhost-pci-slave.h"
+
+VhostPCISlave *vp_slave;
+
+static CharDriverState *vp_slave_parse_chardev(const char *id)
+{
+    CharDriverState *chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_report("chardev \"%s\" not found", id);
+        return NULL;
+    }
+
+    return chr;
+}
+
+int vhost_pci_slave_init(QemuOpts *opts)
+{
+    CharDriverState *chr;
+    const char *chardev_id = qemu_opt_get(opts, "chardev");
+
+    vp_slave = g_malloc(sizeof(VhostPCISlave));
+    chr = vp_slave_parse_chardev(chardev_id);
+    if (!chr) {
+        return -1;
+    }
+    qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
+
+    return 0;
+}
+
+int vhost_pci_slave_cleanup(void)
+{
+    qemu_chr_fe_deinit(&vp_slave->chr_be);
+    g_free(vp_slave);
+
+    return 0;
+}
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
new file mode 100644
index 0000000..c82c775
--- /dev/null
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -0,0 +1,16 @@
+#ifndef QEMU_VHOST_PCI_SLAVE_H
+#define QEMU_VHOST_PCI_SLAVE_H
+
+#include "sysemu/char.h"
+
+typedef struct VhostPCISlave {
+    CharBackend chr_be;
+} VhostPCISlave;
+
+extern VhostPCISlave *vp_slave;
+
+extern int vhost_pci_slave_init(QemuOpts *opts);
+
+extern int vhost_pci_slave_cleanup(void);
+
+#endif
-- 
2.7.4
