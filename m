Received: from eggs.gnu.org ([209.51.188.92]:39255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqW-0002sN-Ip
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqV-0007sT-4K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:16 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqU-0007rY-My
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id e74so10066371wmg.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:14 +0100
Message-Id: <1551979804-6060-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/57] tests/libqos: x86_64/pc machine node
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

Add pc machine for the x86_64 QEMU binary. This machine contains an i440FX-pcihost
driver, that contains itself a pci-bus-pc that produces the pci-bus interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include           |   3 ++
 tests/libqos/x86_64_pc-machine.c | 114 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tests/libqos/x86_64_pc-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5a7ea15..8a760bd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -753,6 +753,9 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y)
 
+# Machines
+qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
+
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
 
diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/libqos/x86_64_pc-machine.c
new file mode 100644
index 0000000..8bd0360
--- /dev/null
+++ b/tests/libqos/x86_64_pc-machine.c
@@ -0,0 +1,114 @@
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
+typedef struct QX86PCMachine QX86PCMachine;
+typedef struct i440FX_pcihost i440FX_pcihost;
+typedef struct QSDHCI_PCI  QSDHCI_PCI;
+
+struct i440FX_pcihost {
+    QOSGraphObject obj;
+    QPCIBusPC pci;
+};
+
+struct QX86PCMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
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
+                                   QTestState *qts,
+                                   QGuestAllocator *alloc)
+{
+    host->obj.get_device = i440FX_host_get_device;
+    qpci_init_pc(&host->pci, qts, alloc);
+}
+
+/* x86_64/pc machine */
+
+static void pc_destructor(QOSGraphObject *obj)
+{
+    QX86PCMachine *machine = (QX86PCMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *pc_get_driver(void *object, const char *interface)
+{
+    QX86PCMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in x86_64/pc\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *pc_get_device(void *obj, const char *device)
+{
+    QX86PCMachine *machine = obj;
+    if (!g_strcmp0(device, "i440FX-pcihost")) {
+        return &machine->bridge.obj;
+    }
+
+    fprintf(stderr, "%s not present in x86_64/pc\n", device);
+    g_assert_not_reached();
+}
+
+static void *qos_create_machine_pc(QTestState *qts)
+{
+    QX86PCMachine *machine = g_new0(QX86PCMachine, 1);
+    machine->obj.get_device = pc_get_device;
+    machine->obj.get_driver = pc_get_driver;
+    machine->obj.destructor = pc_destructor;
+    pc_alloc_init(&machine->alloc, qts, ALLOC_NO_FLAGS);
+    qos_create_i440FX_host(&machine->bridge, qts, &machine->alloc);
+
+    return &machine->obj;
+}
+
+static void pc_machine_register_nodes(void)
+{
+    qos_node_create_machine("i386/pc", qos_create_machine_pc);
+    qos_node_contains("i386/pc", "i440FX-pcihost", NULL);
+
+    qos_node_create_machine("x86_64/pc", qos_create_machine_pc);
+    qos_node_contains("x86_64/pc", "i440FX-pcihost", NULL);
+
+    qos_node_create_driver("i440FX-pcihost", NULL);
+    qos_node_contains("i440FX-pcihost", "pci-bus-pc", NULL);
+}
+
+libqos_init(pc_machine_register_nodes);
-- 
1.8.3.1
