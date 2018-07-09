Received: from eggs.gnu.org ([2001:4830:134:3::10]:38443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSE1-0005RT-Jz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSE0-0007Jl-Cb
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:53 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fcSE0-0007J6-5W
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:52 -0400
Received: by mail-ed1-x543.google.com with SMTP id a5-v6so13346736edt.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:12:52 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  9 Jul 2018 11:11:34 +0200
Message-Id: <20180709091136.28849-6-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 5/7] tests/qgraph: x86_64/pc machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add pc machine for the x86_64 QEMU binary. This machine contains an i440FX-pcihost
driver, that contains itself a pci-bus-pc that produces the pci-bus interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include           |  2 +-
 tests/libqos/x86_64_pc-machine.c | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/x86_64_pc-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index de75a7394e..706ac39ea5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -771,7 +771,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 
 libqgraph-obj-y = tests/libqos/qgraph.o
 libqgraph-pc-obj-y = $(libqos-pc-obj-y) $(libqgraph-obj-y) tests/libqos/sdhci.o
-libqgraph-pc-obj-y += tests/libqos/raspi2-machine.o
+libqgraph-pc-obj-y += tests/libqos/raspi2-machine.o tests/libqos/x86_64_pc-machine.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/libqos/x86_64_pc-machine.c
new file mode 100644
index 0000000000..626e8d7d70
--- /dev/null
+++ b/tests/libqos/x86_64_pc-machine.c
@@ -0,0 +1,93 @@
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
+#include "qgraph.h"
+#include "sdhci.h"
+#include "pci-pc.h"
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
+    printf("%s not present in i440FX-pcihost", device);
+    abort();
+}
+
+static void qos_create_i440FX_host(i440FX_pcihost *host)
+{
+    host->obj.get_device = i440FX_host_get_device;
+    qpci_set_pc(&host->pci, global_qtest, NULL);
+}
+
+/* x86_64/pc machine */
+
+static void pc_destroy(QOSGraphObject *obj)
+{
+    g_free(obj);
+}
+
+static QOSGraphObject *pc_get_device(void *obj, const char *device)
+{
+    QX86_64_PCMachine *machine = obj;
+    if (!g_strcmp0(device, "i440FX-pcihost")) {
+        return &machine->bridge.obj;
+    }
+
+    printf("%s not present in x86_64/pc", device);
+    abort();
+}
+
+static void *qos_create_machine_pc(void)
+{
+    QX86_64_PCMachine *machine = g_new0(QX86_64_PCMachine, 1);
+    machine->obj.get_device = pc_get_device;
+    machine->obj.destructor = pc_destroy;
+    qos_create_i440FX_host(&machine->bridge);
+
+    return &machine->obj;
+}
+
+static void pc_machine(void)
+{
+    qos_node_create_machine("x86_64/pc", qos_create_machine_pc);
+    qos_node_create_driver("i440FX-pcihost", NULL);
+    qos_node_contains("x86_64/pc", "i440FX-pcihost");
+    qos_node_contains("i440FX-pcihost", "pci-bus-pc");
+}
+
+libqos_init(pc_machine);
-- 
2.17.1
