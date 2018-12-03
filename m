Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEn-0000OH-Rc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEm-0004pl-FJ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEm-0004oj-5q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:20 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:44 +0100
Message-Id: <1543851204-41186-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 31/71] tests/qgraph: ppc64/pseries machine node
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

Add pseries  machine for the ppc64 QEMU binary. This machine contains a
spapr-pci-host-bridge driver, that contains itself a pci-bus-spapr
that produces the pci-bus interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include               |   1 +
 tests/libqos/ppc64_pseries-machine.c | 111 +++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 tests/libqos/ppc64_pseries-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9bf1f25..ae8adb0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -683,6 +683,7 @@ qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
 qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
+qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 # Tests
diff --git a/tests/libqos/ppc64_pseries-machine.c b/tests/libqos/ppc64_pseries-machine.c
new file mode 100644
index 0000000..534320f
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
+    QGuestAllocator alloc;
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
+                                   QTestState *qts,
+				   QGuestAllocator *alloc)
+{
+    host->obj.get_device = QSPAPR_host_get_device;
+    qpci_init_spapr(&host->pci, qts, alloc);
+}
+
+/* ppc64/pseries machine */
+
+static void spapr_destructor(QOSGraphObject *obj)
+{
+    Qppc64_pseriesMachine *machine = (Qppc64_pseriesMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *spapr_get_driver(void *object, const char *interface)
+{
+    Qppc64_pseriesMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
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
+static void *qos_create_machine_spapr(QTestState *qts)
+{
+    Qppc64_pseriesMachine *machine = g_new0(Qppc64_pseriesMachine, 1);
+    machine->obj.get_device = spapr_get_device;
+    machine->obj.get_driver = spapr_get_driver;
+    machine->obj.destructor = spapr_destructor;
+    spapr_alloc_init(&machine->alloc, qts, ALLOC_NO_FLAGS);
+
+    qos_create_QSPAPR_host(&machine->bridge, qts, &machine->alloc);
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
1.8.3.1
