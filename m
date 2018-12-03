Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEe-00006X-Bb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEd-0004dZ-7K
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEc-0004cG-SR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:11 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:38 +0100
Message-Id: <1543851204-41186-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 25/71] tests/libqos: arm/sabrelite machine node
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

Add arm/sabrelite machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include               |  1 +
 tests/libqos/arm-sabrelite-machine.c | 91 ++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/libqos/arm-sabrelite-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bda5ce7..6c42ada 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -682,6 +682,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
+qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
diff --git a/tests/libqos/arm-sabrelite-machine.c b/tests/libqos/arm-sabrelite-machine.c
new file mode 100644
index 0000000..c4128d8
--- /dev/null
+++ b/tests/libqos/arm-sabrelite-machine.c
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
+#define ARM_PAGE_SIZE            4096
+#define SABRELITE_RAM_START      0x10000000
+#define SABRELITE_RAM_END        0x30000000
+
+typedef struct QSabreliteMachine QSabreliteMachine;
+
+struct QSabreliteMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void *sabrelite_get_driver(void *object, const char *interface)
+{
+    QSabreliteMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/sabrelite\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *sabrelite_get_device(void *obj, const char *device)
+{
+    QSabreliteMachine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/sabrelite\n", device);
+    g_assert_not_reached();
+}
+
+static void sabrelite_destructor(QOSGraphObject *obj)
+{
+    QSabreliteMachine *machine = (QSabreliteMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_sabrelite(QTestState *qts)
+{
+    QSabreliteMachine *machine = g_new0(QSabreliteMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               SABRELITE_RAM_START,
+               SABRELITE_RAM_END,
+               ARM_PAGE_SIZE);
+    machine->obj.get_device = sabrelite_get_device;
+    machine->obj.get_driver = sabrelite_get_driver;
+    machine->obj.destructor = sabrelite_destructor;
+    qos_init_sdhci_mm(&machine->sdhci, qts, 0x02190000, &(QSDHCIProperties) {
+        .version = 3,
+        .baseclock = 0,
+        .capab.sdma = true,
+        .capab.reg = 0x057834b4,
+    });
+    return &machine->obj;
+}
+
+static void sabrelite_register_nodes(void)
+{
+    qos_node_create_machine("arm/sabrelite", qos_create_machine_arm_sabrelite);
+    qos_node_contains("arm/sabrelite", "generic-sdhci", NULL);
+}
+
+libqos_init(sabrelite_register_nodes);
-- 
1.8.3.1
