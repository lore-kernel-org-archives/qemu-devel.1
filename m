Received: from eggs.gnu.org ([209.51.188.92]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqc-0002yD-1L
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqa-0007xJ-P0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqa-0007wi-Gk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id z84so10074253wmg.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:19 +0100
Message-Id: <1551979804-6060-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/57] tests/libqos: arm/xilinx-zynq-a9 machine
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

Add xilinx-zynq-a9 machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include                    |  1 +
 tests/libqos/arm-xilinx-zynq-a9-machine.c | 94 +++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tests/libqos/arm-xilinx-zynq-a9-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4758352..c7800d5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -758,6 +758,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
+qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
diff --git a/tests/libqos/arm-xilinx-zynq-a9-machine.c b/tests/libqos/arm-xilinx-zynq-a9-machine.c
new file mode 100644
index 0000000..4e199fc
--- /dev/null
+++ b/tests/libqos/arm-xilinx-zynq-a9-machine.c
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
+typedef struct QXilinxZynqA9Machine QXilinxZynqA9Machine;
+
+struct QXilinxZynqA9Machine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+#define ARM_PAGE_SIZE             4096
+#define XILINX_ZYNQ_A9_RAM_ADDR   0
+#define XILINX_ZYNQ_A9_RAM_SIZE   0x20000000
+
+static void *xilinx_zynq_a9_get_driver(void *object, const char *interface)
+{
+    QXilinxZynqA9Machine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/xilinx-zynq-a9\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *xilinx_zynq_a9_get_device(void *obj, const char *device)
+{
+    QXilinxZynqA9Machine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/xilinx-zynq-a9\n", device);
+    g_assert_not_reached();
+}
+
+static void xilinx_zynq_a9_destructor(QOSGraphObject *obj)
+{
+    QXilinxZynqA9Machine *machine = (QXilinxZynqA9Machine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_xilinx_zynq_a9(QTestState *qts)
+{
+    QXilinxZynqA9Machine *machine = g_new0(QXilinxZynqA9Machine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               XILINX_ZYNQ_A9_RAM_ADDR + (1 << 20),
+               XILINX_ZYNQ_A9_RAM_ADDR + XILINX_ZYNQ_A9_RAM_SIZE,
+               ARM_PAGE_SIZE);
+
+    machine->obj.get_device = xilinx_zynq_a9_get_device;
+    machine->obj.get_driver = xilinx_zynq_a9_get_driver;
+    machine->obj.destructor = xilinx_zynq_a9_destructor;
+    /* Datasheet: UG585 (v1.12.1) */
+    qos_init_sdhci_mm(&machine->sdhci, qts, 0xe0100000, &(QSDHCIProperties) {
+        .version = 2,
+        .baseclock = 0,
+        .capab.sdma = true,
+        .capab.reg = 0x69ec0080,
+    });
+    return &machine->obj;
+}
+
+static void xilinx_zynq_a9_register_nodes(void)
+{
+    qos_node_create_machine("arm/xilinx-zynq-a9",
+                            qos_create_machine_arm_xilinx_zynq_a9);
+    qos_node_contains("arm/xilinx-zynq-a9", "generic-sdhci", NULL);
+}
+
+libqos_init(xilinx_zynq_a9_register_nodes);
-- 
1.8.3.1
