Received: from eggs.gnu.org ([209.51.188.92]:39328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqZ-0002vj-Se
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqY-0007v1-By
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqY-0007uE-3F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id o17so18419085wrw.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:17 +0100
Message-Id: <1551979804-6060-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/57] tests/libqos: arm/smdkc210 machine node
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

Add arm/smdkc210 machine machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include              |  1 +
 tests/libqos/arm-smdkc210-machine.c | 91 +++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/libqos/arm-smdkc210-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 41d248d..959d026 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -756,6 +756,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
+qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
diff --git a/tests/libqos/arm-smdkc210-machine.c b/tests/libqos/arm-smdkc210-machine.c
new file mode 100644
index 0000000..1fb9dfc
--- /dev/null
+++ b/tests/libqos/arm-smdkc210-machine.c
@@ -0,0 +1,91 @@
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
+#define ARM_PAGE_SIZE             4096
+#define SMDKC210_RAM_ADDR         0x40000000ull
+#define SMDKC210_RAM_SIZE         0x40000000ull
+
+typedef struct QSmdkc210Machine QSmdkc210Machine;
+
+struct QSmdkc210Machine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void *smdkc210_get_driver(void *object, const char *interface)
+{
+    QSmdkc210Machine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/smdkc210\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *smdkc210_get_device(void *obj, const char *device)
+{
+    QSmdkc210Machine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/smdkc210\n", device);
+    g_assert_not_reached();
+}
+
+static void smdkc210_destructor(QOSGraphObject *obj)
+{
+    QSmdkc210Machine *machine = (QSmdkc210Machine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_smdkc210(QTestState *qts)
+{
+    QSmdkc210Machine *machine = g_new0(QSmdkc210Machine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               SMDKC210_RAM_ADDR,
+               SMDKC210_RAM_ADDR + SMDKC210_RAM_SIZE,
+               ARM_PAGE_SIZE);
+    machine->obj.get_device = smdkc210_get_device;
+    machine->obj.get_driver = smdkc210_get_driver;
+    machine->obj.destructor = smdkc210_destructor;
+    qos_init_sdhci_mm(&machine->sdhci, qts, 0x12510000, &(QSDHCIProperties) {
+        .version = 2,
+        .baseclock = 0,
+        .capab.sdma = true,
+        .capab.reg = 0x5e80080,
+    });
+    return &machine->obj;
+}
+
+static void smdkc210_register_nodes(void)
+{
+    qos_node_create_machine("arm/smdkc210", qos_create_machine_arm_smdkc210);
+    qos_node_contains("arm/smdkc210", "generic-sdhci", NULL);
+}
+
+libqos_init(smdkc210_register_nodes);
-- 
1.8.3.1
