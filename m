Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tN-0007lH-5f
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tK-0002nE-GX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:05 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:41 +0200
Message-Id: <20180813101453.10200-22-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 21/33] tests/qgraph: virtio-9p driver and
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

Add qgraph nodes for virtio-9p-pci and virtio-9p-device.
Both nodes produce virtio-9p, but virtio-9p-pci receives
a pci-bus and overrides virtio-pci QOSGraphObject and its functions,
while virtio-9p-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include   |   1 +
 tests/libqos/virtio-9p.c | 165 +++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-9p.h |  42 ++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 tests/libqos/virtio-9p.c
 create mode 100644 tests/libqos/virtio-9p.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eafceefc12..48d3aab447 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,6 +770,7 @@ libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
 libqgraph-machines-obj-y += tests/libqos/virt-machine.o
 
 libqgraph-virtio-obj-y = tests/libqos/virtio-serial.o
+libqgraph-virtio-obj-y += tests/libqos/virtio-9p.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virtio-9p.c b/tests/libqos/virtio-9p.c
new file mode 100644
index 0000000000..df60db8f39
--- /dev/null
+++ b/tests/libqos/virtio-9p.c
@@ -0,0 +1,165 @@
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
+#include "libqos/virtio-9p.h"
+#include "libqos/qgraph.h"
+
+static QGuestAllocator *alloc;
+
+static void virtio_9p_cleanup(QVirtio9P *interface)
+{
+    qvirtqueue_cleanup(interface->vdev->bus, interface->vq, alloc);
+}
+
+static void virtio_9p_setup(QVirtio9P *interface)
+{
+    interface->vq = qvirtqueue_setup(interface->vdev, alloc, 0);
+    qvirtio_set_driver_ok(interface->vdev);
+}
+
+/* virtio-9p-device */
+static void virtio_9p_device_destructor(QOSGraphObject *obj)
+{
+    QVirtio9PDevice *v_9p = (QVirtio9PDevice *) obj;
+    QVirtio9P *interface = &v_9p->v9p;
+    virtio_9p_cleanup(interface);
+
+    g_free(v_9p);
+}
+
+static void virtio_9p_device_start_hw(QOSGraphObject *obj)
+{
+    QVirtio9PDevice *v_9p = (QVirtio9PDevice *) obj;
+    QVirtio9P *interface = &v_9p->v9p;
+
+    virtio_9p_setup(interface);
+}
+
+static void *virtio_9p_device_get_driver(void *object, const char *interface)
+{
+    QVirtio9PDevice *v_9p = object;
+    if (!g_strcmp0(interface, "virtio-9p")) {
+        return &v_9p->v9p;
+    }
+
+    fprintf(stderr, "%s not present in virtio-9p-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *virtio_9p_device_create(void *virtio_dev,
+                                     QGuestAllocator *t_alloc,
+                                     void *addr)
+{
+    QVirtio9PDevice *virtio_device = g_new0(QVirtio9PDevice, 1);
+    QVirtio9P *interface = &virtio_device->v9p;
+
+    interface->vdev = virtio_dev;
+    alloc = t_alloc;
+
+    virtio_device->obj.destructor = virtio_9p_device_destructor;
+    virtio_device->obj.get_driver = virtio_9p_device_get_driver;
+    virtio_device->obj.start_hw = virtio_9p_device_start_hw;
+
+    return &virtio_device->obj;
+}
+
+/* virtio-9p-pci */
+static void virtio_9p_pci_destructor(QOSGraphObject *obj)
+{
+    QVirtio9PPCI *v9_pci = (QVirtio9PPCI *) obj;
+    QVirtio9P *interface = &v9_pci->v9p;
+    QOSGraphObject *pci_vobj =  &v9_pci->pci_vdev.obj;
+
+    virtio_9p_cleanup(interface);
+    qvirtio_pci_destructor(pci_vobj);
+    g_free(v9_pci);
+}
+
+static void virtio_9p_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtio9PPCI *v9_pci = (QVirtio9PPCI *) obj;
+    QVirtio9P *interface = &v9_pci->v9p;
+    QOSGraphObject *pci_vobj =  &v9_pci->pci_vdev.obj;
+
+    qvirtio_pci_start_hw(pci_vobj);
+    virtio_9p_setup(interface);
+}
+
+static void *virtio_9p_pci_get_driver(void *object, const char *interface)
+{
+    QVirtio9PPCI *v9p = object;
+    if (!g_strcmp0(interface, "virtio-9p")) {
+        return &v9p->v9p;
+    }
+
+    fprintf(stderr, "%s not present in virtio-9p-pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void *virtio_9p_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                  void *addr)
+{
+    QVirtio9PPCI *v9_pci = g_new0(QVirtio9PPCI, 1);
+    QVirtio9P *interface = &v9_pci->v9p;
+    QOSGraphObject *obj = &v9_pci->pci_vdev.obj;
+
+    virtio_pci_init(&v9_pci->pci_vdev, pci_bus, addr);
+    interface->vdev = &v9_pci->pci_vdev.vdev;
+    alloc = t_alloc;
+
+    g_assert_cmphex(interface->vdev->device_type, ==, VIRTIO_ID_9P);
+
+    obj->destructor = virtio_9p_pci_destructor;
+    obj->start_hw = virtio_9p_pci_start_hw;
+    obj->get_driver = virtio_9p_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_9p_register_nodes(void)
+{
+    const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
+    const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
+
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .before_cmd_line = "-fsdev synth,id=fsdev0",
+    };
+
+    /* virtio-9p-device */
+    opts.extra_device_opts = str_simple,
+    qos_node_create_driver("virtio-9p-device", virtio_9p_device_create);
+    qos_node_consumes("virtio-9p-device", "virtio", &opts);
+    qos_node_produces("virtio-9p-device", "virtio-9p");
+
+    /* virtio-9p-pci */
+    opts.extra_device_opts = str_addr;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-9p-pci", virtio_9p_pci_create);
+    qos_node_consumes("virtio-9p-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-9p-pci", "virtio-9p");
+
+}
+
+libqos_init(virtio_9p_register_nodes);
diff --git a/tests/libqos/virtio-9p.h b/tests/libqos/virtio-9p.h
new file mode 100644
index 0000000000..dba22772b5
--- /dev/null
+++ b/tests/libqos/virtio-9p.h
@@ -0,0 +1,42 @@
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
+typedef struct QVirtio9P QVirtio9P;
+typedef struct QVirtio9PPCI QVirtio9PPCI;
+typedef struct QVirtio9PDevice QVirtio9PDevice;
+
+#define MOUNT_TAG "qtest"
+
+struct QVirtio9P {
+    QVirtioDevice *vdev;
+    QVirtQueue *vq;
+};
+
+struct QVirtio9PPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtio9P v9p;
+};
+
+struct QVirtio9PDevice {
+    QOSGraphObject obj;
+    QVirtio9P v9p;
+};
-- 
2.17.1
