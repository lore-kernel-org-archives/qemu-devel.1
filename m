Received: from eggs.gnu.org ([209.51.188.92]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr8-0003bq-Sc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr7-0008PY-Jk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wr7-0008Or-99
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id g20so9984426wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:48 +0100
Message-Id: <1551979804-6060-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/57] tests/libqos: virtio-scsi driver and
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

Add qgraph nodes for virtio-scsi-pci and virtio-scsi-device.
Both nodes produce virtio-scsi, but virtio-scsi-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and its functions,
while virtio-scsi-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include     |   1 +
 tests/libqos/virtio-scsi.c | 117 +++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-scsi.h |  39 +++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 tests/libqos/virtio-scsi.c
 create mode 100644 tests/libqos/virtio-scsi.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a0b42c9..48b7cf0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -743,6 +743,7 @@ qos-test-obj-y += tests/libqos/virtio-balloon.o
 qos-test-obj-y += tests/libqos/virtio-blk.o
 qos-test-obj-y += tests/libqos/virtio-net.o
 qos-test-obj-y += tests/libqos/virtio-rng.o
+qos-test-obj-y += tests/libqos/virtio-scsi.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
diff --git a/tests/libqos/virtio-scsi.c b/tests/libqos/virtio-scsi.c
new file mode 100644
index 0000000..482684d
--- /dev/null
+++ b/tests/libqos/virtio-scsi.c
@@ -0,0 +1,117 @@
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
+#include "standard-headers/linux/virtio_ids.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-scsi.h"
+
+/* virtio-scsi-device */
+static void *qvirtio_scsi_get_driver(QVirtioSCSI *v_scsi,
+                                     const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-scsi")) {
+        return v_scsi;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_scsi->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-scsi-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_scsi_device_get_driver(void *object,
+                                            const char *interface)
+{
+    QVirtioSCSIDevice *v_scsi = object;
+    return qvirtio_scsi_get_driver(&v_scsi->scsi, interface);
+}
+
+static void *virtio_scsi_device_create(void *virtio_dev,
+                                          QGuestAllocator *t_alloc,
+                                          void *addr)
+{
+    QVirtioSCSIDevice *virtio_bdevice = g_new0(QVirtioSCSIDevice, 1);
+    QVirtioSCSI *interface = &virtio_bdevice->scsi;
+
+    interface->vdev = virtio_dev;
+
+    virtio_bdevice->obj.get_driver = qvirtio_scsi_device_get_driver;
+
+    return &virtio_bdevice->obj;
+}
+
+/* virtio-scsi-pci */
+static void *qvirtio_scsi_pci_get_driver(void *object,
+                                         const char *interface)
+{
+    QVirtioSCSIPCI *v_scsi = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_scsi->pci_vdev.pdev;
+    }
+    return qvirtio_scsi_get_driver(&v_scsi->scsi, interface);
+}
+
+static void *virtio_scsi_pci_create(void *pci_bus,
+                                    QGuestAllocator *t_alloc,
+                                    void *addr)
+{
+    QVirtioSCSIPCI *virtio_spci = g_new0(QVirtioSCSIPCI, 1);
+    QVirtioSCSI *interface = &virtio_spci->scsi;
+    QOSGraphObject *obj = &virtio_spci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_spci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_spci->pci_vdev.vdev;
+
+    g_assert_cmphex(interface->vdev->device_type, ==, VIRTIO_ID_SCSI);
+
+    obj->get_driver = qvirtio_scsi_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_scsi_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+        .after_cmd_line = "-device scsi-hd,bus=vs0.0,drive=drv0",
+    };
+
+    /* virtio-scsi-device */
+    opts.extra_device_opts = "id=vs0";
+    qos_node_create_driver("virtio-scsi-device",
+                            virtio_scsi_device_create);
+    qos_node_consumes("virtio-scsi-device", "virtio-bus", &opts);
+    qos_node_produces("virtio-scsi-device", "virtio-scsi");
+
+    /* virtio-scsi-pci */
+    opts.extra_device_opts = "id=vs0,addr=04.0";
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-scsi-pci", virtio_scsi_pci_create);
+    qos_node_consumes("virtio-scsi-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-scsi-pci", "pci-device");
+    qos_node_produces("virtio-scsi-pci", "virtio-scsi");
+}
+
+libqos_init(virtio_scsi_register_nodes);
diff --git a/tests/libqos/virtio-scsi.h b/tests/libqos/virtio-scsi.h
new file mode 100644
index 0000000..17a47be
--- /dev/null
+++ b/tests/libqos/virtio-scsi.h
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
+typedef struct QVirtioSCSI QVirtioSCSI;
+typedef struct QVirtioSCSIPCI QVirtioSCSIPCI;
+typedef struct QVirtioSCSIDevice QVirtioSCSIDevice;
+
+struct QVirtioSCSI {
+    QVirtioDevice *vdev;
+};
+
+struct QVirtioSCSIPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioSCSI scsi;
+};
+
+struct QVirtioSCSIDevice {
+    QOSGraphObject obj;
+    QVirtioSCSI scsi;
+};
-- 
1.8.3.1
