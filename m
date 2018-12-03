Received: from eggs.gnu.org ([2001:4830:134:3::10]:52204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFB-0000uM-2t
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqF9-0005H9-R5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqF9-0005GH-JF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:43 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:57 +0100
Message-Id: <1543851204-41186-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 44/71] tests/libqos: virtio-balloon driver and
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

Add qgraph nodes for virtio-balloon-pci and virtio-balloon-device.
Both nodes produce virtio-balloon, but virtio-balloon-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-balloon-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include        |   1 +
 tests/libqos/virtio-balloon.c | 113 ++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-balloon.h |  39 +++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 tests/libqos/virtio-balloon.c
 create mode 100644 tests/libqos/virtio-balloon.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2a531df..d31aade 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -672,6 +672,7 @@ qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += $(libqos-virtio-obj-y)
 qos-test-obj-y += tests/libqos/virtio-9p.o
+qos-test-obj-y += tests/libqos/virtio-balloon.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
diff --git a/tests/libqos/virtio-balloon.c b/tests/libqos/virtio-balloon.c
new file mode 100644
index 0000000..7e6e9e9
--- /dev/null
+++ b/tests/libqos/virtio-balloon.c
@@ -0,0 +1,113 @@
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
+#include "libqos/virtio-balloon.h"
+
+/* virtio-balloon-device */
+static void *qvirtio_balloon_get_driver(QVirtioBalloon *v_balloon,
+                                        const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-balloon")) {
+        return v_balloon;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_balloon->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-balloon-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_balloon_device_get_driver(void *object,
+                                               const char *interface)
+{
+    QVirtioBalloonDevice *v_balloon = object;
+    return qvirtio_balloon_get_driver(&v_balloon->balloon, interface);
+}
+
+static void *virtio_balloon_device_create(void *virtio_dev,
+                                          QGuestAllocator *t_alloc,
+                                          void *addr)
+{
+    QVirtioBalloonDevice *virtio_bdevice = g_new0(QVirtioBalloonDevice, 1);
+    QVirtioBalloon *interface = &virtio_bdevice->balloon;
+
+    interface->vdev = virtio_dev;
+
+    virtio_bdevice->obj.get_driver = qvirtio_balloon_device_get_driver;
+
+    return &virtio_bdevice->obj;
+}
+
+/* virtio-balloon-pci */
+static void *qvirtio_balloon_pci_get_driver(void *object,
+                                            const char *interface)
+{
+    QVirtioBalloonPCI *v_balloon = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_balloon->pci_vdev.pdev;
+    }
+    return qvirtio_balloon_get_driver(&v_balloon->balloon, interface);
+}
+
+static void *virtio_balloon_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                  void *addr)
+{
+    QVirtioBalloonPCI *virtio_bpci = g_new0(QVirtioBalloonPCI, 1);
+    QVirtioBalloon *interface = &virtio_bpci->balloon;
+    QOSGraphObject *obj = &virtio_bpci->pci_vdev.obj;
+
+
+    virtio_pci_init(&virtio_bpci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_bpci->pci_vdev.vdev;
+
+    obj->get_driver = qvirtio_balloon_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_balloon_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+
+    /* virtio-balloon-device */
+    qos_node_create_driver("virtio-balloon-device",
+                            virtio_balloon_device_create);
+    qos_node_consumes("virtio-balloon-device", "virtio-bus", NULL);
+    qos_node_produces("virtio-balloon-device", "virtio");
+    qos_node_produces("virtio-balloon-device", "virtio-balloon");
+
+    /* virtio-balloon-pci */
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-balloon-pci", virtio_balloon_pci_create);
+    qos_node_consumes("virtio-balloon-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-balloon-pci", "pci-device");
+    qos_node_produces("virtio-balloon-pci", "virtio");
+    qos_node_produces("virtio-balloon-pci", "virtio-balloon");
+}
+
+libqos_init(virtio_balloon_register_nodes);
diff --git a/tests/libqos/virtio-balloon.h b/tests/libqos/virtio-balloon.h
new file mode 100644
index 0000000..e8066c4
--- /dev/null
+++ b/tests/libqos/virtio-balloon.h
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
+typedef struct QVirtioBalloon QVirtioBalloon;
+typedef struct QVirtioBalloonPCI QVirtioBalloonPCI;
+typedef struct QVirtioBalloonDevice QVirtioBalloonDevice;
+
+struct QVirtioBalloon {
+    QVirtioDevice *vdev;
+};
+
+struct QVirtioBalloonPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioBalloon balloon;
+};
+
+struct QVirtioBalloonDevice {
+    QOSGraphObject obj;
+    QVirtioBalloon balloon;
+};
-- 
1.8.3.1
