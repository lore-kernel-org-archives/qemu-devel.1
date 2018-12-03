Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEk-0000Jz-Gj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEg-0004i6-BX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEg-0004gk-33
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:14 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:40 +0100
Message-Id: <1543851204-41186-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 27/71] tests/libqos: aarch64/xlnx-zcu102
 machine node
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

Add xlnx-zcu102 machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include                     |  1 +
 tests/libqos/aarch64-xlnx-zcu102-machine.c | 93 ++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tests/libqos/aarch64-xlnx-zcu102-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 462c99b..752f2c2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -681,6 +681,7 @@ qos-test-obj-y += $(libqos-pc-obj-y)
 qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
+qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
diff --git a/tests/libqos/aarch64-xlnx-zcu102-machine.c b/tests/libqos/aarch64-xlnx-zcu102-machine.c
new file mode 100644
index 0000000..2019a44
--- /dev/null
+++ b/tests/libqos/aarch64-xlnx-zcu102-machine.c
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
+    qos_node_create_machine("aarch64/xlnx-zcu102", qos_create_machine_aarch64_xlnx_zcu102);
+    qos_node_contains("aarch64/xlnx-zcu102", "generic-sdhci", NULL);
+}
+
+libqos_init(xlnx_zcu102_register_nodes);
-- 
1.8.3.1
