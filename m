Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFX-0001Lt-VQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFR-0005cJ-Nj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFR-0005aI-Ba
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:03 +0100
Message-Id: <1543851204-41186-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 50/71] tests/libqos: virtio-net driver and
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

Add qgraph nodes for virtio-net-pci and virtio-net-device.
Both nodes produce virtio-net, but virtio-net-pci receives
a pci-bus and overrides virtio-pci QOSGraphObject and its functions,
while virtio-net-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-net.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-net.h |  41 +++++++++++
 tests/libqos/virtio.c     |   1 +
 tests/libqos/virtio.h     |   1 +
 5 files changed, 226 insertions(+)
 create mode 100644 tests/libqos/virtio-net.c
 create mode 100644 tests/libqos/virtio-net.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8ba1ca9..211c675 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -669,6 +669,7 @@ qos-test-obj-y += $(libqos-virtio-obj-y)
 qos-test-obj-y += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
 qos-test-obj-y += tests/libqos/virtio-blk.o
+qos-test-obj-y += tests/libqos/virtio-net.o
 qos-test-obj-y += tests/libqos/virtio-rng.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
 
diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
new file mode 100644
index 0000000..3ddfbdc
--- /dev/null
+++ b/tests/libqos/virtio-net.c
@@ -0,0 +1,182 @@
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
+#include "libqos/virtio-net.h"
+#include "hw/virtio/virtio-net.h"
+
+
+static QGuestAllocator *alloc;
+
+static void virtio_net_cleanup(QVirtioNet *interface)
+{
+    qvirtqueue_cleanup(interface->vdev->bus, interface->rx, alloc);
+    qvirtqueue_cleanup(interface->vdev->bus, interface->tx, alloc);
+}
+
+static void virtio_net_setup(QVirtioNet *interface)
+{
+    QVirtioDevice *vdev = interface->vdev;
+    uint64_t features;
+
+    features = qvirtio_get_features(vdev);
+    features &= ~(QVIRTIO_F_BAD_FEATURE |
+                  (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                  (1u << VIRTIO_RING_F_EVENT_IDX));
+    qvirtio_set_features(vdev, features);
+
+    interface->rx = qvirtqueue_setup(vdev, alloc, 0);
+    interface->tx = qvirtqueue_setup(vdev, alloc, 1);
+    qvirtio_set_driver_ok(vdev);
+}
+
+/* virtio-net-device */
+static void qvirtio_net_device_destructor(QOSGraphObject *obj)
+{
+    QVirtioNetDevice *v_net = (QVirtioNetDevice *) obj;
+    virtio_net_cleanup(&v_net->net);
+}
+
+static void qvirtio_net_device_start_hw(QOSGraphObject *obj)
+{
+    QVirtioNetDevice *v_net = (QVirtioNetDevice *) obj;
+    QVirtioNet *interface = &v_net->net;
+
+    virtio_net_setup(interface);
+}
+
+static void *qvirtio_net_get_driver(QVirtioNet *v_net,
+                                    const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-net")) {
+        return v_net;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_net->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-net-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_net_device_get_driver(void *object,
+                                           const char *interface)
+{
+    QVirtioNetDevice *v_net = object;
+    return qvirtio_net_get_driver(&v_net->net, interface);
+}
+
+static void *virtio_net_device_create(void *virtio_dev,
+                                          QGuestAllocator *t_alloc,
+                                          void *addr)
+{
+    QVirtioNetDevice *virtio_ndevice = g_new0(QVirtioNetDevice, 1);
+    QVirtioNet *interface = &virtio_ndevice->net;
+
+    interface->vdev = virtio_dev;
+    alloc = t_alloc;
+
+    virtio_ndevice->obj.destructor = qvirtio_net_device_destructor;
+    virtio_ndevice->obj.get_driver = qvirtio_net_device_get_driver;
+    virtio_ndevice->obj.start_hw = qvirtio_net_device_start_hw;
+
+    return &virtio_ndevice->obj;
+}
+
+/* virtio-net-pci */
+static void qvirtio_net_pci_destructor(QOSGraphObject *obj)
+{
+    QVirtioNetPCI *v_net = (QVirtioNetPCI *) obj;
+    QVirtioNet *interface = &v_net->net;
+    QOSGraphObject *pci_vobj =  &v_net->pci_vdev.obj;
+
+    virtio_net_cleanup(interface);
+    qvirtio_pci_destructor(pci_vobj);
+}
+
+static void qvirtio_net_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtioNetPCI *v_net = (QVirtioNetPCI *) obj;
+    QVirtioNet *interface = &v_net->net;
+    QOSGraphObject *pci_vobj =  &v_net->pci_vdev.obj;
+
+    qvirtio_pci_start_hw(pci_vobj);
+    virtio_net_setup(interface);
+}
+
+static void *qvirtio_net_pci_get_driver(void *object,
+                                            const char *interface)
+{
+    QVirtioNetPCI *v_net = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_net->pci_vdev.pdev;
+    }
+    return qvirtio_net_get_driver(&v_net->net, interface);
+}
+
+static void *virtio_net_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                  void *addr)
+{
+    QVirtioNetPCI *virtio_bpci = g_new0(QVirtioNetPCI, 1);
+    QVirtioNet *interface = &virtio_bpci->net;
+    QOSGraphObject *obj = &virtio_bpci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_bpci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_bpci->pci_vdev.vdev;
+    alloc = t_alloc;
+
+    g_assert_cmphex(interface->vdev->device_type, ==, VIRTIO_ID_NET);
+
+    obj->destructor = qvirtio_net_pci_destructor;
+    obj->start_hw = qvirtio_net_pci_start_hw;
+    obj->get_driver = qvirtio_net_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_net_register_nodes(void)
+{
+    /* FIXME: every test using these nodes needs to setup a
+     * -netdev socket,id=hs0 otherwise QEMU is not going to start.
+     * Therefore, we do not include "produces" edge for virtio
+     * and pci-device yet.
+     */
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts = { };
+
+    /* virtio-net-device */
+    opts.extra_device_opts = "netdev=hs0";
+    qos_node_create_driver("virtio-net-device",
+                            virtio_net_device_create);
+    qos_node_consumes("virtio-net-device", "virtio-bus", &opts);
+    qos_node_produces("virtio-net-device", "virtio-net");
+
+    /* virtio-net-pci */
+    opts.extra_device_opts = "netdev=hs0,addr=04.0";
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-net-pci", virtio_net_pci_create);
+    qos_node_consumes("virtio-net-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-net-pci", "virtio-net");
+}
+
+libqos_init(virtio_net_register_nodes);
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
new file mode 100644
index 0000000..e6905cd
--- /dev/null
+++ b/tests/libqos/virtio-net.h
@@ -0,0 +1,41 @@
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
+typedef struct QVirtioNet QVirtioNet;
+typedef struct QVirtioNetPCI QVirtioNetPCI;
+typedef struct QVirtioNetDevice QVirtioNetDevice;
+
+struct QVirtioNet {
+    QVirtioDevice *vdev;
+    QVirtQueue *rx;
+    QVirtQueue *tx;
+};
+
+struct QVirtioNetPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioNet net;
+};
+
+struct QVirtioNetDevice {
+    QOSGraphObject obj;
+    QVirtioNet net;
+};
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 9fc8c7e..e4925d1 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -40,6 +40,7 @@ uint32_t qvirtio_get_features(QVirtioDevice *d)
 
 void qvirtio_set_features(QVirtioDevice *d, uint32_t features)
 {
+    d->features = features;
     d->bus->set_features(d, features);
 }
 
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 7f0f9dd..3f97d79 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -21,6 +21,7 @@ typedef struct QVirtioDevice {
     const QVirtioBus *bus;
     /* Device type */
     uint16_t device_type;
+    uint64_t features;
     bool big_endian;
 } QVirtioDevice;
 
-- 
1.8.3.1
