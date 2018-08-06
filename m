Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbJ-0005Hz-Hs
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbI-00013C-2Z
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:13 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgbH-00011b-P1
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:12 -0400
Received: by mail-ed1-x543.google.com with SMTP id e6-v6so5263051edr.2
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:11 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:34:06 +0200
Message-Id: <20180806143412.27722-29-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 28/34] test/qgraph: virtio-blk driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add qgraph nodes for virtio-blk-pci and virtio-blk-device.
Both nodes produce virtio-blk, but virtio-blk-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-blk-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-blk.c | 126 ++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-blk.h |  40 ++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 tests/libqos/virtio-blk.c
 create mode 100644 tests/libqos/virtio-blk.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3a1a99b8c8..1d68e7d223 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -769,6 +769,7 @@ libqgraph-virtio-obj-y = tests/libqos/virtio-serial.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-9p.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-balloon.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-rng.o
+libqgraph-virtio-obj-y += tests/libqos/virtio-blk.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virtio-blk.c b/tests/libqos/virtio-blk.c
new file mode 100644
index 0000000000..991fa01809
--- /dev/null
+++ b/tests/libqos/virtio-blk.c
@@ -0,0 +1,126 @@
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
+static void qvirtio_blk_device_destroy(QOSGraphObject *obj)
+{
+    QVirtioBlkDevice *v_blk = (QVirtioBlkDevice *) obj;
+    g_free(v_blk);
+}
+
+static void *qvirtio_blk_device_get_driver(void *object,
+                                           const char *interface)
+{
+    QVirtioBlkDevice *v_blk = object;
+    if (!g_strcmp0(interface, "virtio-blk")) {
+        return &v_blk->blk;
+    }
+
+    printf("%s not present in virtio-blk-device\n", interface);
+    abort();
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
+    virtio_blk->obj.destructor = qvirtio_blk_device_destroy;
+    virtio_blk->obj.get_driver = qvirtio_blk_device_get_driver;
+
+    return &virtio_blk->obj;
+}
+
+/* virtio-blk-pci */
+static void *qvirtio_blk_pci_get_driver(void *object, const char *interface)
+{
+    QVirtioBlkPCI *v_blk = object;
+    if (!g_strcmp0(interface, "virtio-blk")) {
+        return &v_blk->blk;
+    }
+
+    /* implicit contains */
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_blk->pci_vdev.pdev;
+    }
+
+    printf("%s not present in virtio-blk-pci\n", interface);
+    abort();
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
+static void virtio_blk(void)
+{
+    /* FIXME: every test using these two nodes needs to setup a
+     * -drive,id=drive0 otherwise QEMU is not going to start */
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
+    qos_node_consumes("virtio-blk-device", "virtio", &opts);
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
+libqos_init(virtio_blk);
diff --git a/tests/libqos/virtio-blk.h b/tests/libqos/virtio-blk.h
new file mode 100644
index 0000000000..dc258496ba
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
2.17.1
