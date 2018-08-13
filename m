Received: from eggs.gnu.org ([2001:4830:134:3::10]:43378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sY-000751-Cu
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sW-0001to-Tc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:14 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:24 +0200
Message-Id: <20180813101453.10200-5-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 04/33] tests/qgraph: x86_64/pc machine node
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

Add pc machine for the x86_64 QEMU binary. This machine contains an i440FX-pcihost
driver, that contains itself a pci-bus-pc that produces the pci-bus interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include           |   3 +
 tests/libqos/x86_64_pc-machine.c | 110 +++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tests/libqos/x86_64_pc-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d99a58894b..2154e53944 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -771,7 +771,10 @@ libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
+libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
+
 libqgraph-pci-obj-y = $(libqos-pc-obj-y)
+libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/libqos/x86_64_pc-machine.c
new file mode 100644
index 0000000000..d8db18d0ff
--- /dev/null
+++ b/tests/libqos/x86_64_pc-machine.c
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
+#include "pci-pc.h"
+#include "malloc-pc.h"
+
+typedef struct QX86_64_PCMachine QX86_64_PCMachine;
+typedef struct i440FX_pcihost i440FX_pcihost;
+typedef struct QSDHCI_PCI  QSDHCI_PCI;
+
+struct i440FX_pcihost {
+    QOSGraphObject obj;
+    QPCIBusPC pci;
+};
+
+struct QX86_64_PCMachine {
+    QOSGraphObject obj;
+    QGuestAllocator *alloc;
+    i440FX_pcihost bridge;
+};
+
+/* i440FX_pcihost */
+
+static QOSGraphObject *i440FX_host_get_device(void *obj, const char *device)
+{
+    i440FX_pcihost *host = obj;
+    if (!g_strcmp0(device, "pci-bus-pc")) {
+        return &host->pci.obj;
+    }
+    fprintf(stderr, "%s not present in i440FX-pcihost\n", device);
+    g_assert_not_reached();
+}
+
+static void qos_create_i440FX_host(i440FX_pcihost *host,
+                                   QGuestAllocator *alloc)
+{
+    host->obj.get_device = i440FX_host_get_device;
+    qpci_init_pc(&host->pci, global_qtest, alloc);
+}
+
+/* x86_64/pc machine */
+
+static void pc_destructor(QOSGraphObject *obj)
+{
+    QX86_64_PCMachine *machine = (QX86_64_PCMachine *) obj;
+    pc_alloc_uninit(machine->alloc);
+    g_free(machine);
+}
+
+static void *pc_get_driver(void *object, const char *interface)
+{
+    QX86_64_PCMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in x86_64/pc\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *pc_get_device(void *obj, const char *device)
+{
+    QX86_64_PCMachine *machine = obj;
+    if (!g_strcmp0(device, "i440FX-pcihost")) {
+        return &machine->bridge.obj;
+    }
+
+    fprintf(stderr, "%s not present in x86_64/pc\n", device);
+    g_assert_not_reached();
+}
+
+static void *qos_create_machine_pc(void)
+{
+    QX86_64_PCMachine *machine = g_new0(QX86_64_PCMachine, 1);
+    machine->obj.get_device = pc_get_device;
+    machine->obj.get_driver = pc_get_driver;
+    machine->obj.destructor = pc_destructor;
+    machine->alloc = pc_alloc_init_flags(global_qtest, ALLOC_NO_FLAGS);
+    qos_create_i440FX_host(&machine->bridge, machine->alloc);
+
+    return &machine->obj;
+}
+
+static void pc_machine_register_nodes(void)
+{
+    qos_node_create_machine("x86_64/pc", qos_create_machine_pc);
+    qos_node_create_driver("i440FX-pcihost", NULL);
+    qos_node_contains("x86_64/pc", "i440FX-pcihost", NULL);
+    qos_node_contains("i440FX-pcihost", "pci-bus-pc", NULL);
+}
+
+libqos_init(pc_machine_register_nodes);
-- 
2.17.1
