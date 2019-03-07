Received: from eggs.gnu.org ([209.51.188.92]:39385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqc-0002z8-Qj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqb-0007y0-LG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqb-0007xN-Cy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id l12so1948926wrp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:20 +0100
Message-Id: <1551979804-6060-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/57] tests/libqos: aarch64/xlnx-zcu102 machine
 node
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

Add xlnx-zcu102 machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include                     |  1 +
 tests/libqos/aarch64-xlnx-zcu102-machine.c | 94 ++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tests/libqos/aarch64-xlnx-zcu102-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7800d5..d675ad8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -755,6 +755,7 @@ qos-test-obj-y += $(libqos-pc-obj-y)
 qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
+qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
diff --git a/tests/libqos/aarch64-xlnx-zcu102-machine.c b/tests/libqos/aarch64-xlnx-zcu102-machine.c
new file mode 100644
index 0000000..6fff040
--- /dev/null
+++ b/tests/libqos/aarch64-xlnx-zcu102-machine.c
@@ -0,0 +1,94 @@
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
+#include "libqos/malloc.h"
+#include "libqos/qgraph.h"
+#include "sdhci.h"
+
+typedef struct QXlnxZCU102Machine QXlnxZCU102Machine;
+
+struct QXlnxZCU102Machine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+#define ARM_PAGE_SIZE          4096
+#define XLNX_ZCU102_RAM_ADDR   0
+#define XLNX_ZCU102_RAM_SIZE   0x20000000
+
+static void *xlnx_zcu102_get_driver(void *object, const char *interface)
+{
+    QXlnxZCU102Machine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in aarch64/xlnx-zcu102\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *xlnx_zcu102_get_device(void *obj, const char *device)
+{
+    QXlnxZCU102Machine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    fprintf(stderr, "%s not present in aarch64/xlnx-zcu102\n", device);
+    g_assert_not_reached();
+}
+
+static void xlnx_zcu102_destructor(QOSGraphObject *obj)
+{
+    QXlnxZCU102Machine *machine = (QXlnxZCU102Machine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_aarch64_xlnx_zcu102(QTestState *qts)
+{
+    QXlnxZCU102Machine *machine = g_new0(QXlnxZCU102Machine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               XLNX_ZCU102_RAM_ADDR + (1 << 20),
+               XLNX_ZCU102_RAM_ADDR + XLNX_ZCU102_RAM_SIZE,
+               ARM_PAGE_SIZE);
+
+    machine->obj.get_device = xlnx_zcu102_get_device;
+    machine->obj.get_driver = xlnx_zcu102_get_driver;
+    machine->obj.destructor = xlnx_zcu102_destructor;
+    /* Datasheet: UG1085 (v1.7) */
+    qos_init_sdhci_mm(&machine->sdhci, qts, 0xff160000, &(QSDHCIProperties) {
+        .version = 3,
+        .baseclock = 0,
+        .capab.sdma = true,
+        .capab.reg = 0x280737ec6481
+    });
+    return &machine->obj;
+}
+
+static void xlnx_zcu102_register_nodes(void)
+{
+    qos_node_create_machine("aarch64/xlnx-zcu102",
+                            qos_create_machine_aarch64_xlnx_zcu102);
+    qos_node_contains("aarch64/xlnx-zcu102", "generic-sdhci", NULL);
+}
+
+libqos_init(xlnx_zcu102_register_nodes);
-- 
1.8.3.1
