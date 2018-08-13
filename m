Received: from eggs.gnu.org ([2001:4830:134:3::10]:43598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9si-0007FV-1w
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sg-00024l-Ch
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:23 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:29 +0200
Message-Id: <20180813101453.10200-10-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 09/33] tests/qgraph: ppc64/pseries machine node
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

Add pseries  machine for the ppc64 QEMU binary. This machine contains a
spapr-pci-host-bridge driver, that contains itself a pci-bus-spapr
that produces the pci-bus interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include               |   1 +
 tests/libqos/ppc64_pseries-machine.c | 111 +++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 tests/libqos/ppc64_pseries-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5713be3ec4..7c712406e1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,6 +770,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 
 libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
 libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
+libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
 
 libqgraph-pci-obj-y = $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/ppc64_pseries-machine.c b/tests/libqos/ppc64_pseries-machine.c
new file mode 100644
index 0000000000..c860e9bc5b
--- /dev/null
+++ b/tests/libqos/ppc64_pseries-machine.c
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
+ #include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "pci-spapr.h"
+#include "libqos/malloc-spapr.h"
+
+typedef struct QSPAPR_pci_host QSPAPR_pci_host;
+typedef struct Qppc64_pseriesMachine Qppc64_pseriesMachine;
+
+struct QSPAPR_pci_host {
+    QOSGraphObject obj;
+    QPCIBusSPAPR pci;
+};
+
+struct Qppc64_pseriesMachine {
+    QOSGraphObject obj;
+    QGuestAllocator *alloc;
+    QSPAPR_pci_host bridge;
+};
+
+/* QSPAPR_pci_host */
+
+static QOSGraphObject *QSPAPR_host_get_device(void *obj, const char *device)
+{
+    QSPAPR_pci_host *host = obj;
+    if (!g_strcmp0(device, "pci-bus-spapr")) {
+        return &host->pci.obj;
+    }
+    fprintf(stderr, "%s not present in QSPAPR_pci_host\n", device);
+    g_assert_not_reached();
+}
+
+static void qos_create_QSPAPR_host(QSPAPR_pci_host *host,
+                                   QGuestAllocator *alloc)
+{
+    host->obj.get_device = QSPAPR_host_get_device;
+    qpci_init_spapr(&host->pci, global_qtest, alloc);
+}
+
+/* ppc64/pseries machine */
+
+static void spapr_destructor(QOSGraphObject *obj)
+{
+    Qppc64_pseriesMachine *machine = (Qppc64_pseriesMachine *) obj;
+    spapr_alloc_uninit(machine->alloc);
+    g_free(obj);
+}
+
+static void *spapr_get_driver(void *object, const char *interface)
+{
+    Qppc64_pseriesMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in ppc64/pseries\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *spapr_get_device(void *obj, const char *device)
+{
+    Qppc64_pseriesMachine *machine = obj;
+    if (!g_strcmp0(device, "spapr-pci-host-bridge")) {
+        return &machine->bridge.obj;
+    }
+
+    fprintf(stderr, "%s not present in ppc64/pseries\n", device);
+    g_assert_not_reached();
+}
+
+static void *qos_create_machine_spapr(void)
+{
+    Qppc64_pseriesMachine *machine = g_new0(Qppc64_pseriesMachine, 1);
+    machine->obj.get_device = spapr_get_device;
+    machine->obj.get_driver = spapr_get_driver;
+    machine->obj.destructor = spapr_destructor;
+    machine->alloc =  spapr_alloc_init_flags(global_qtest,
+                                             ALLOC_NO_FLAGS);
+    qos_create_QSPAPR_host(&machine->bridge, machine->alloc);
+
+    return &machine->obj;
+}
+
+static void spapr_machine_register_nodes(void)
+{
+    qos_node_create_machine("ppc64/pseries", qos_create_machine_spapr);
+    qos_node_create_driver("spapr-pci-host-bridge", NULL);
+    qos_node_contains("ppc64/pseries", "spapr-pci-host-bridge", NULL);
+    qos_node_contains("spapr-pci-host-bridge", "pci-bus-spapr", NULL);
+}
+
+libqos_init(spapr_machine_register_nodes);
+
-- 
2.17.1
