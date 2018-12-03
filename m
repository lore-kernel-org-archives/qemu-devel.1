Received: from eggs.gnu.org ([2001:4830:134:3::10]:51780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEb-0008OO-47
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEZ-0004XW-Sg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEZ-0004Wf-Jn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:07 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:36 +0100
Message-Id: <1543851204-41186-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 23/71] tests/libqos: arm/raspi2 machine node
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

Add arm/raspi2 machine to the graph. This machine contains a generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include            |  1 +
 tests/libqos/arm-raspi2-machine.c | 91 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/libqos/arm-raspi2-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 66c7848..75951f8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -681,6 +681,7 @@ qos-test-obj-y += $(libqos-pc-obj-y)
 qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
+qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
diff --git a/tests/libqos/arm-raspi2-machine.c b/tests/libqos/arm-raspi2-machine.c
new file mode 100644
index 0000000..3aff670
--- /dev/null
+++ b/tests/libqos/arm-raspi2-machine.c
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
+#define RASPI2_RAM_ADDR           0
+#define RASPI2_RAM_SIZE           0x20000000
+
+typedef struct QRaspi2Machine QRaspi2Machine;
+
+struct QRaspi2Machine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void *raspi2_get_driver(void *object, const char *interface)
+{
+    QRaspi2Machine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/raspi2\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *raspi2_get_device(void *obj, const char *device)
+{
+    QRaspi2Machine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/raspi2\n", device);
+    g_assert_not_reached();
+}
+
+static void raspi2_destructor(QOSGraphObject *obj)
+{
+    QRaspi2Machine *machine = (QRaspi2Machine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_raspi2(QTestState *qts)
+{
+    QRaspi2Machine *machine = g_new0(QRaspi2Machine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               RASPI2_RAM_ADDR + (1 << 20),
+               RASPI2_RAM_ADDR + RASPI2_RAM_SIZE,
+               ARM_PAGE_SIZE);
+    machine->obj.get_device = raspi2_get_device;
+    machine->obj.get_driver = raspi2_get_driver;
+    machine->obj.destructor = raspi2_destructor;
+    qos_init_sdhci_mm(&machine->sdhci, qts, 0x3f300000, &(QSDHCIProperties) {
+        .version = 3,
+        .baseclock = 52,
+        .capab.sdma = false,
+        .capab.reg = 0x052134b4
+    });
+    return &machine->obj;
+}
+
+static void raspi2_register_nodes(void)
+{
+    qos_node_create_machine("arm/raspi2", qos_create_machine_arm_raspi2);
+    qos_node_contains("arm/raspi2", "generic-sdhci", NULL);
+}
+
+libqos_init(raspi2_register_nodes);
-- 
1.8.3.1
