Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbP-0005Om-MH
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbO-000193-0X
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgbN-00018F-BU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:17 -0400
Received: by mail-ed1-x543.google.com with SMTP id f23-v6so5237967edr.11
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:17 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:34:10 +0200
Message-Id: <20180806143412.27722-33-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 32/34] test/qgraph: virtio-scsi driver and
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

Add qgraph nodes for virtio-scsi-pci and virtio-scsi-device.
Both nodes produce virtio-scsi, but virtio-scsi-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and its functions,
while virtio-scsi-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include     |   1 +
 tests/libqos/virtio-scsi.c | 117 +++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-scsi.h |  39 +++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 tests/libqos/virtio-scsi.c
 create mode 100644 tests/libqos/virtio-scsi.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4634fd8ef1..c5aa9f18b7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -768,6 +768,7 @@ libqgraph-virtio-obj-y += tests/libqos/virtio-balloon.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-rng.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-blk.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-net.o
+libqgraph-virtio-obj-y += tests/libqos/virtio-scsi.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virtio-scsi.c b/tests/libqos/virtio-scsi.c
new file mode 100644
index 0000000000..e751ef639d
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
+static void qvirtio_scsi_device_destroy(QOSGraphObject *obj)
+{
+    QVirtioSCSIDevice *v_scsi = (QVirtioSCSIDevice *) obj;
+
+    g_free(v_scsi);
+}
+
+static void *qvirtio_scsi_device_get_driver(void *object,
+                                               const char *interface)
+{
+    QVirtioSCSIDevice *v_scsi = object;
+    if (!g_strcmp0(interface, "virtio-scsi")) {
+        return &v_scsi->scsi;
+    }
+
+    printf("%s not present in virtio-scsi-device\n", interface);
+    abort();
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
+    virtio_bdevice->obj.destructor = qvirtio_scsi_device_destroy;
+    virtio_bdevice->obj.get_driver = qvirtio_scsi_device_get_driver;
+
+    return &virtio_bdevice->obj;
+}
+
+/* virtio-scsi-pci */
+static void *qvirtio_scsi_pci_get_driver(void *object,
+                                            const char *interface)
+{
+    QVirtioSCSIPCI *v_scsi = object;
+    if (!g_strcmp0(interface, "virtio-scsi")) {
+        return &v_scsi->scsi;
+    }
+
+    printf("%s not present in virtio-scsi-pci\n", interface);
+    abort();
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
+static void virtio_scsi(void)
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
+    qos_node_consumes("virtio-scsi-device", "virtio", &opts);
+    qos_node_produces("virtio-scsi-device", "virtio-scsi");
+
+    /* virtio-scsi-pci */
+    opts.extra_device_opts = "id=vs0,addr=04.0";
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-scsi-pci", virtio_scsi_pci_create);
+    qos_node_consumes("virtio-scsi-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-scsi-pci", "virtio-scsi");
+}
+
+libqos_init(virtio_scsi);
diff --git a/tests/libqos/virtio-scsi.h b/tests/libqos/virtio-scsi.h
new file mode 100644
index 0000000000..17a47beddc
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
2.17.1
