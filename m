Received: from eggs.gnu.org ([209.51.188.92]:39715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr1-0003SU-6Q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqz-0008Hc-My
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqx-0008Ew-N4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id f65so10068410wma.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:39 +0100
Message-Id: <1551979804-6060-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/57] tests/libqos: virtio-rng driver and
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
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add qgraph nodes for virtio-rng-pci and virtio-rng-device.
Both nodes produce virtio-rng, but virtio-rng-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-rng-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-rng.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-rng.h |  39 ++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 tests/libqos/virtio-rng.c
 create mode 100644 tests/libqos/virtio-rng.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f53b718..2d2817e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -745,6 +745,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += $(libqos-virtio-obj-y)
 qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
+qos-test-obj-y += tests/libqos/virtio-rng.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
diff --git a/tests/libqos/virtio-rng.c b/tests/libqos/virtio-rng.c
new file mode 100644
index 0000000..a1d2c76
--- /dev/null
+++ b/tests/libqos/virtio-rng.c
@@ -0,0 +1,110 @@
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
+#include "libqos/qgraph.h"
+#include "libqos/virtio-rng.h"
+
+/* virtio-rng-device */
+static void *qvirtio_rng_get_driver(QVirtioRng *v_rng,
+                                    const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-rng")) {
+        return v_rng;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_rng->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-rng-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_rng_device_get_driver(void *object,
+                                           const char *interface)
+{
+    QVirtioRngDevice *v_rng = object;
+    return qvirtio_rng_get_driver(&v_rng->rng, interface);
+}
+
+static void *virtio_rng_device_create(void *virtio_dev,
+                                      QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVirtioRngDevice *virtio_rdevice = g_new0(QVirtioRngDevice, 1);
+    QVirtioRng *interface = &virtio_rdevice->rng;
+
+    interface->vdev = virtio_dev;
+
+    virtio_rdevice->obj.get_driver = qvirtio_rng_device_get_driver;
+
+    return &virtio_rdevice->obj;
+}
+
+/* virtio-rng-pci */
+static void *qvirtio_rng_pci_get_driver(void *object, const char *interface)
+{
+    QVirtioRngPCI *v_rng = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_rng->pci_vdev.pdev;
+    }
+    return qvirtio_rng_get_driver(&v_rng->rng, interface);
+}
+
+static void *virtio_rng_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                   void *addr)
+{
+    QVirtioRngPCI *virtio_rpci = g_new0(QVirtioRngPCI, 1);
+    QVirtioRng *interface = &virtio_rpci->rng;
+    QOSGraphObject *obj = &virtio_rpci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_rpci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_rpci->pci_vdev.vdev;
+
+    obj->get_driver = qvirtio_rng_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_rng_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+
+    /* virtio-rng-device */
+    qos_node_create_driver("virtio-rng-device", virtio_rng_device_create);
+    qos_node_consumes("virtio-rng-device", "virtio-bus", NULL);
+    qos_node_produces("virtio-rng-device", "virtio");
+    qos_node_produces("virtio-rng-device", "virtio-rng");
+
+    /* virtio-rng-pci */
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-rng-pci", virtio_rng_pci_create);
+    qos_node_consumes("virtio-rng-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-rng-pci", "pci-device");
+    qos_node_produces("virtio-rng-pci", "virtio");
+    qos_node_produces("virtio-rng-pci", "virtio-rng");
+}
+
+libqos_init(virtio_rng_register_nodes);
diff --git a/tests/libqos/virtio-rng.h b/tests/libqos/virtio-rng.h
new file mode 100644
index 0000000..fbba988
--- /dev/null
+++ b/tests/libqos/virtio-rng.h
@@ -0,0 +1,39 @@
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
+typedef struct QVirtioRng QVirtioRng;
+typedef struct QVirtioRngPCI QVirtioRngPCI;
+typedef struct QVirtioRngDevice QVirtioRngDevice;
+
+struct QVirtioRng {
+    QVirtioDevice *vdev;
+};
+
+struct QVirtioRngPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioRng rng;
+};
+
+struct QVirtioRngDevice {
+    QOSGraphObject obj;
+    QVirtioRng rng;
+};
-- 
1.8.3.1
