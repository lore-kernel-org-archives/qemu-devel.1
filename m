Received: from eggs.gnu.org ([209.51.188.92]:39632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqx-0003OR-DC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqt-0008DR-VH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqr-0008A3-RM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id w6so18399944wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:33 +0100
Message-Id: <1551979804-6060-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/57] tests/libqos: virtio-serial driver and
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

Add qgraph nodes for virtio-serial-pci and virtio-serial-device.
Both nodes produce virtio-serial, but virtio-serial-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-serial-device receives a virtio-bus and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include       |   1 +
 tests/libqos/virtio-serial.c | 110 +++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-serial.h |  39 +++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 tests/libqos/virtio-serial.c
 create mode 100644 tests/libqos/virtio-serial.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ec929cc..2a51cab 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -751,6 +751,7 @@ qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += $(libqos-virtio-obj-y)
+qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
 qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
diff --git a/tests/libqos/virtio-serial.c b/tests/libqos/virtio-serial.c
new file mode 100644
index 0000000..91cedef
--- /dev/null
+++ b/tests/libqos/virtio-serial.c
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
+#include "libqos/virtio-serial.h"
+
+static void *qvirtio_serial_get_driver(QVirtioSerial *v_serial,
+                                       const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-serial")) {
+        return v_serial;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_serial->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-serial-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_serial_device_get_driver(void *object,
+                                              const char *interface)
+{
+    QVirtioSerialDevice *v_serial = object;
+    return qvirtio_serial_get_driver(&v_serial->serial, interface);
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
+    virtio_device->obj.get_driver = qvirtio_serial_device_get_driver;
+
+    return &virtio_device->obj;
+}
+
+/* virtio-serial-pci */
+static void *qvirtio_serial_pci_get_driver(void *object, const char *interface)
+{
+    QVirtioSerialPCI *v_serial = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_serial->pci_vdev.pdev;
+    }
+    return qvirtio_serial_get_driver(&v_serial->serial, interface);
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
+static void virtio_serial_register_nodes(void)
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
+    qos_node_consumes("virtio-serial-device", "virtio-bus", &edge_opts);
+    qos_node_produces("virtio-serial-device", "virtio");
+    qos_node_produces("virtio-serial-device", "virtio-serial");
+
+    /* virtio-serial-pci */
+    edge_opts.extra_device_opts = "id=vser0,addr=04.0";
+    add_qpci_address(&edge_opts, &addr);
+    qos_node_create_driver("virtio-serial-pci", virtio_serial_pci_create);
+    qos_node_consumes("virtio-serial-pci", "pci-bus", &edge_opts);
+    qos_node_produces("virtio-serial-pci", "pci-device");
+    qos_node_produces("virtio-serial-pci", "virtio");
+    qos_node_produces("virtio-serial-pci", "virtio-serial");
+}
+
+libqos_init(virtio_serial_register_nodes);
diff --git a/tests/libqos/virtio-serial.h b/tests/libqos/virtio-serial.h
new file mode 100644
index 0000000..b7e2a5d
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
1.8.3.1
