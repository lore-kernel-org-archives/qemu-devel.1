Received: from eggs.gnu.org ([2001:4830:134:3::10]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFJ-000137-8B
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFH-0005Qm-Vi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFH-0005Q0-N9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:51 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:01 +0100
Message-Id: <1543851204-41186-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 48/71] tests/libqos: virtio-blk driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add qgraph nodes for virtio-blk-pci and virtio-blk-device.
Both nodes produce virtio-blk, but virtio-blk-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-blk-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-blk.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-blk.h |  40 +++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 tests/libqos/virtio-blk.c
 create mode 100644 tests/libqos/virtio-blk.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a7c01a3..5e1d75c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -670,6 +670,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += $(libqos-virtio-obj-y)
 qos-test-obj-y += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
+qos-test-obj-y += tests/libqos/virtio-blk.o
 qos-test-obj-y += tests/libqos/virtio-rng.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
 
diff --git a/tests/libqos/virtio-blk.c b/tests/libqos/virtio-blk.c
new file mode 100644
index 0000000..c17bdf4
--- /dev/null
+++ b/tests/libqos/virtio-blk.c
@@ -0,0 +1,124 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-blk.h"
+
+#define PCI_SLOT                0x04
+#define PCI_FN                  0x00
+
+/* virtio-blk-device */
+static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
+                                    const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-blk")) {
+        return v_blk;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_blk->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-blk-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_blk_device_get_driver(void *object,
+                                           const char *interface)
+{
+    QVirtioBlkDevice *v_blk = object;
+    return qvirtio_blk_get_driver(&v_blk->blk, interface);
+}
+
+static void *virtio_blk_device_create(void *virtio_dev,
+                                      QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVirtioBlkDevice *virtio_blk = g_new0(QVirtioBlkDevice, 1);
+    QVirtioBlk *interface = &virtio_blk->blk;
+
+    interface->vdev = virtio_dev;
+
+    virtio_blk->obj.get_driver = qvirtio_blk_device_get_driver;
+
+    return &virtio_blk->obj;
+}
+
+/* virtio-blk-pci */
+static void *qvirtio_blk_pci_get_driver(void *object, const char *interface)
+{
+    QVirtioBlkPCI *v_blk = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_blk->pci_vdev.pdev;
+    }
+    return qvirtio_blk_get_driver(&v_blk->blk, interface);
+}
+
+static void *virtio_blk_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVirtioBlkPCI *virtio_blk = g_new0(QVirtioBlkPCI, 1);
+    QVirtioBlk *interface = &virtio_blk->blk;
+    QOSGraphObject *obj = &virtio_blk->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_blk->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_blk->pci_vdev.vdev;
+
+    g_assert_cmphex(interface->vdev->device_type, ==, VIRTIO_ID_BLOCK);
+
+    obj->get_driver = qvirtio_blk_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_blk_register_nodes(void)
+{
+    /* FIXME: every test using these two nodes needs to setup a
+     * -drive,id=drive0 otherwise QEMU is not going to start.
+     * Therefore, we do not include "produces" edge for virtio
+     * and pci-device yet.
+    */
+
+    char *arg = g_strdup_printf("id=drv0,drive=drive0,addr=%x.%x",
+                                PCI_SLOT, PCI_FN);
+
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(PCI_SLOT, PCI_FN),
+    };
+
+    QOSGraphEdgeOptions opts = { };
+
+    /* virtio-blk-device */
+    opts.extra_device_opts = "drive=drive0";
+    qos_node_create_driver("virtio-blk-device", virtio_blk_device_create);
+    qos_node_consumes("virtio-blk-device", "virtio-bus", &opts);
+    qos_node_produces("virtio-blk-device", "virtio-blk");
+
+    /* virtio-blk-pci */
+    opts.extra_device_opts = arg;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-blk-pci", virtio_blk_pci_create);
+    qos_node_consumes("virtio-blk-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-blk-pci", "virtio-blk");
+
+    g_free(arg);
+}
+
+libqos_init(virtio_blk_register_nodes);
diff --git a/tests/libqos/virtio-blk.h b/tests/libqos/virtio-blk.h
new file mode 100644
index 0000000..dc25849
--- /dev/null
+++ b/tests/libqos/virtio-blk.h
@@ -0,0 +1,40 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "libqos/qgraph.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+
+typedef struct QVirtioBlk QVirtioBlk;
+typedef struct QVirtioBlkPCI QVirtioBlkPCI;
+typedef struct QVirtioBlkDevice QVirtioBlkDevice;
+
+/* virtqueue is created in each test */
+struct QVirtioBlk {
+    QVirtioDevice *vdev;
+};
+
+struct QVirtioBlkPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioBlk blk;
+};
+
+struct QVirtioBlkDevice {
+    QOSGraphObject obj;
+    QVirtioBlk blk;
+};
-- 
1.8.3.1
