Received: from eggs.gnu.org ([2001:4830:134:3::10]:44187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tP-0007nw-SG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tO-0002pk-F8
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:07 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:43 +0200
Message-Id: <20180813101453.10200-24-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 23/33] tests/qgraph: virtio-balloon driver and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add qgraph nodes for virtio-balloon-pci and virtio-balloon-device.
Both nodes produce virtio-balloon, but virtio-balloon-pci receives
a pci-bus and uses virtio-pci QOSGraphObject and functions,
while virtio-balloon-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include        |   1 +
 tests/libqos/virtio-balloon.c | 111 ++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-balloon.h |  39 ++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tests/libqos/virtio-balloon.c
 create mode 100644 tests/libqos/virtio-balloon.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 495ff5ca9b..362d9ec4b2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,6 +770,7 @@ libqgraph-machines-obj-y += tests/libqos/virt-machine.o
 
 libqgraph-virtio-obj-y = tests/libqos/virtio-serial.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-9p.o
+libqgraph-virtio-obj-y += tests/libqos/virtio-balloon.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virtio-balloon.c b/tests/libqos/virtio-balloon.c
new file mode 100644
index 0000000000..98d2548ffe
--- /dev/null
+++ b/tests/libqos/virtio-balloon.c
@@ -0,0 +1,111 @@
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
+static void qvirtio_balloon_device_destructor(QOSGraphObject *obj)
+{
+    QVirtioBalloonDevice *v_balloon = (QVirtioBalloonDevice *) obj;
+
+    g_free(v_balloon);
+}
+
+static void *qvirtio_balloon_device_get_driver(void *object,
+                                               const char *interface)
+{
+    QVirtioBalloonDevice *v_balloon = object;
+    if (!g_strcmp0(interface, "virtio-balloon")) {
+        return &v_balloon->balloon;
+    }
+
+    fprintf(stderr, "%s not present in virtio-balloon-device\n", interface);
+    g_assert_not_reached();
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
+    virtio_bdevice->obj.destructor = qvirtio_balloon_device_destructor;
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
+    if (!g_strcmp0(interface, "virtio-balloon")) {
+        return &v_balloon->balloon;
+    }
+
+    fprintf(stderr, "%s not present in virtio-balloon-pci\n", interface);
+    g_assert_not_reached();
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
+    qos_node_consumes("virtio-balloon-device", "virtio", NULL);
+    qos_node_produces("virtio-balloon-device", "virtio-balloon");
+
+    /* virtio-balloon-pci */
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-balloon-pci", virtio_balloon_pci_create);
+    qos_node_consumes("virtio-balloon-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-balloon-pci", "virtio-balloon");
+}
+
+libqos_init(virtio_balloon_register_nodes);
diff --git a/tests/libqos/virtio-balloon.h b/tests/libqos/virtio-balloon.h
new file mode 100644
index 0000000000..e8066c42bb
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
2.17.1
