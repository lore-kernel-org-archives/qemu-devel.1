Received: from eggs.gnu.org ([2001:4830:134:3::10]:35745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb8-00057k-ID
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb7-0000x7-C2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:02 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb7-0000wm-29
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:01 -0400
Received: by mail-ed1-x544.google.com with SMTP id f23-v6so5237478edr.11
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:00 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:57 +0200
Message-Id: <20180806143412.27722-20-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 19/34] test/qgraph: virtio-serial driver and
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

Add qgraph nodes for virtio-serial-pci and virtio-serial-device.
Both nodes produce virtio-serial, but virtio-serial-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-serial-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include       |   3 +
 tests/libqos/virtio-serial.c | 109 +++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-serial.h |  39 +++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tests/libqos/virtio-serial.c
 create mode 100644 tests/libqos/virtio-serial.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d72d0d65b4..ad784a3e84 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,8 +770,11 @@ libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
 libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
 libqgraph-machines-obj-y += tests/libqos/virt-machine.o
 
+libqgraph-virtio-obj-y = tests/libqos/virtio-serial.o
+
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
+libqgraph-pci-obj-y += $(libqgraph-virtio-obj-y)
 libqgraph-pci-obj-y += tests/libqos/sdhci.o
 libqgraph-pci-obj-y += tests/libqos/e1000e.o
 
diff --git a/tests/libqos/virtio-serial.c b/tests/libqos/virtio-serial.c
new file mode 100644
index 0000000000..6dd4582d15
--- /dev/null
+++ b/tests/libqos/virtio-serial.c
@@ -0,0 +1,109 @@
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
+#include "libqos/virtio-serial.h"
+
+/* virtio-serial-device */
+static void qvirtio_serial_device_destroy(QOSGraphObject *obj)
+{
+    QVirtioSerialDevice *v_serial = (QVirtioSerialDevice *) obj;
+
+    g_free(v_serial);
+}
+
+static void *qvirtio_serial_device_get_driver(void *object,
+                                              const char *interface)
+{
+    QVirtioSerialDevice *v_serial = object;
+    if (!g_strcmp0(interface, "virtio-serial")) {
+        return &v_serial->serial;
+    }
+
+    printf("%s not present in virtio-serial-device\n", interface);
+    abort();
+}
+
+static void *virtio_serial_device_create(void *virtio_dev,
+                                         QGuestAllocator *t_alloc,
+                                         void *addr)
+{
+    QVirtioSerialDevice *virtio_device = g_new0(QVirtioSerialDevice, 1);
+    QVirtioSerial *interface = &virtio_device->serial;
+
+    interface->vdev = virtio_dev;
+
+    virtio_device->obj.destructor = qvirtio_serial_device_destroy;
+    virtio_device->obj.get_driver = qvirtio_serial_device_get_driver;
+
+    return &virtio_device->obj;
+}
+
+/* virtio-serial-pci */
+static void *qvirtio_serial_pci_get_driver(void *object, const char *interface)
+{
+    QVirtioSerialPCI *v_serial = object;
+    if (!g_strcmp0(interface, "virtio-serial")) {
+        return &v_serial->serial;
+    }
+
+    printf("%s not present in virtio-serial-pci\n", interface);
+    abort();
+}
+
+static void *virtio_serial_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVirtioSerialPCI *virtio_spci = g_new0(QVirtioSerialPCI, 1);
+    QVirtioSerial *interface = &virtio_spci->serial;
+    QOSGraphObject *obj = &virtio_spci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_spci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_spci->pci_vdev.vdev;
+
+    obj->get_driver = qvirtio_serial_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_serial(void)
+{
+   QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions edge_opts = { };
+
+    /* virtio-serial-device */
+    edge_opts.extra_device_opts = "id=vser0";
+    qos_node_create_driver("virtio-serial-device",
+                            virtio_serial_device_create);
+    qos_node_consumes("virtio-serial-device", "virtio", &edge_opts);
+    qos_node_produces("virtio-serial-device", "virtio-serial");
+
+    /* virtio-serial-pci */
+    edge_opts.extra_device_opts = "id=vser0,addr=04.0";
+    add_qpci_address(&edge_opts, &addr);
+    qos_node_create_driver("virtio-serial-pci", virtio_serial_pci_create);
+    qos_node_consumes("virtio-serial-pci", "pci-bus", &edge_opts);
+    qos_node_produces("virtio-serial-pci", "virtio-serial");
+}
+
+libqos_init(virtio_serial);
diff --git a/tests/libqos/virtio-serial.h b/tests/libqos/virtio-serial.h
new file mode 100644
index 0000000000..b7e2a5d178
--- /dev/null
+++ b/tests/libqos/virtio-serial.h
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
+typedef struct QVirtioSerial QVirtioSerial;
+typedef struct QVirtioSerialPCI QVirtioSerialPCI;
+typedef struct QVirtioSerialDevice QVirtioSerialDevice;
+
+struct QVirtioSerial {
+    QVirtioDevice *vdev;
+};
+
+struct QVirtioSerialPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioSerial serial;
+};
+
+struct QVirtioSerialDevice {
+    QOSGraphObject obj;
+    QVirtioSerial serial;
+};
-- 
2.17.1
