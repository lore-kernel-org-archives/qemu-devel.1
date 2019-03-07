Received: from eggs.gnu.org ([209.51.188.92]:39347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqb-0002x2-0a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqZ-0007wd-Se
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqZ-0007vb-Ew
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id x7so10090906wmj.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:18 +0100
Message-Id: <1551979804-6060-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/57] tests/libqos: arm/sabrelite machine node
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
index 959d026..4758352 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -756,6 +756,7 @@ qos-test-obj-y += tests/libqos/sdhci.o
 
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
