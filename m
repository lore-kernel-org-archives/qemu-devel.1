Received: from eggs.gnu.org ([2001:4830:134:3::10]:35906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbN-0005O6-7I
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbL-00016v-3v
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:17 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgbK-00015Q-P3
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:15 -0400
Received: by mail-ed1-x541.google.com with SMTP id h4-v6so5253803edi.6
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:14 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:34:08 +0200
Message-Id: <20180806143412.27722-31-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 30/34] test/qgraph: virtio-net driver and
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

Add qgraph nodes for virtio-net-pci and virtio-net-device.
Both nodes produce virtio-net, but virtio-net-pci receives
a pci-bus and overrides virtio-pci QOSGraphObject and its functions,
while virtio-net-device receives a virtio and implements
its own functions

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-net.c | 177 ++++++++++++++++++++++++++++++++++++++
 tests/libqos/virtio-net.h |  41 +++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 tests/libqos/virtio-net.c
 create mode 100644 tests/libqos/virtio-net.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b628d2b821..ecab26b7b2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -768,6 +768,7 @@ libqgraph-virtio-obj-y += tests/libqos/virtio-9p.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-balloon.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-rng.o
 libqgraph-virtio-obj-y += tests/libqos/virtio-blk.o
+libqgraph-virtio-obj-y += tests/libqos/virtio-net.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
new file mode 100644
index 0000000000..12eb6e0530
--- /dev/null
+++ b/tests/libqos/virtio-net.c
@@ -0,0 +1,177 @@
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
+static void driver_init(QVirtioDevice *dev)
+{
+    uint32_t features;
+
+    features = qvirtio_get_features(dev);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_RING_F_EVENT_IDX));
+    qvirtio_set_features(dev, features);
+}
+
+static void virtio_net_cleanup(QVirtioNet *interface)
+{
+    qvirtqueue_cleanup(interface->vdev->bus, interface->rx, alloc);
+    qvirtqueue_cleanup(interface->vdev->bus, interface->tx, alloc);
+}
+
+static void virtio_net_setup(QVirtioNet *interface)
+{
+    interface->rx = qvirtqueue_setup(interface->vdev, alloc, 0);
+    interface->tx = qvirtqueue_setup(interface->vdev, alloc, 1);
+    driver_init(interface->vdev);
+}
+
+/* virtio-net-device */
+static void qvirtio_net_device_destroy(QOSGraphObject *obj)
+{
+    QVirtioNetDevice *v_net = (QVirtioNetDevice *) obj;
+    virtio_net_cleanup(&v_net->net);
+    g_free(v_net);
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
+static void *qvirtio_net_device_get_driver(void *object,
+                                               const char *interface)
+{
+    QVirtioNetDevice *v_net = object;
+    if (!g_strcmp0(interface, "virtio-net")) {
+        return &v_net->net;
+    }
+
+    printf("%s not present in virtio-net-device\n", interface);
+    abort();
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
+    virtio_ndevice->obj.destructor = qvirtio_net_device_destroy;
+    virtio_ndevice->obj.get_driver = qvirtio_net_device_get_driver;
+    virtio_ndevice->obj.start_hw = qvirtio_net_device_start_hw;
+
+    return &virtio_ndevice->obj;
+}
+
+/* virtio-net-pci */
+static void qvirtio_net_pci_destroy(QOSGraphObject *obj)
+{
+    QVirtioNetPCI *v_net = (QVirtioNetPCI *) obj;
+    QVirtioNet *interface = &v_net->net;
+    QOSGraphObject *pci_vobj =  &v_net->pci_vdev.obj;
+
+    virtio_net_cleanup(interface);
+    qvirtio_pci_destroy(pci_vobj);
+    g_free(v_net);
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
+    driver_init(interface->vdev);
+}
+
+static void *qvirtio_net_pci_get_driver(void *object,
+                                            const char *interface)
+{
+    QVirtioNetPCI *v_net = object;
+    if (!g_strcmp0(interface, "virtio-net")) {
+        return &v_net->net;
+    }
+
+    printf("%s not present in virtio-net-pci\n", interface);
+    abort();
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
+    obj->destructor = qvirtio_net_pci_destroy;
+    obj->start_hw = qvirtio_net_pci_start_hw;
+    obj->get_driver = qvirtio_net_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_net(void)
+{
+    /* FIXME: every test using these nodes needs to setup a
+     * -netdev socket,id=hs0 otherwise QEMU is not going to start */
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
+    qos_node_consumes("virtio-net-device", "virtio", &opts);
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
+libqos_init(virtio_net);
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
new file mode 100644
index 0000000000..e6905cd82e
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
-- 
2.17.1
