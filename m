Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritC-0005mY-PN
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1frit6-0002RT-Sa
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:30 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:01:59 +0200
Message-Id: <20180820120213.11095-3-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 02/16] test/qgraph: arm/sabrelite machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Keith Busch <keith.busch@intel.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add arm/sabrelite machine to the graph. This machine contains generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include           |  1 +
 tests/libqos/sabrelite-machine.c | 82 ++++++++++++++++++++++++++++++++
 tests/sdhci-test.c               |  7 +--
 3 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 tests/libqos/sabrelite-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4a9b28706..4690d5f5e9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -759,6 +759,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 libqgraph-arm-machines-obj-y = tests/libqos/raspi2-machine.o
 libqgraph-arm-machines-obj-y += tests/libqos/virt-machine.o
 libqgraph-arm-machines-obj-y += tests/libqos/smdkc210-machine.o
+libqgraph-arm-machines-obj-y += tests/libqos/sabrelite-machine.o
 
 libqgraph-machines-obj-y = $(libqgraph-arm-machines-obj-y)
 libqgraph-machines-obj-y += tests/libqos/x86_64_pc-machine.o
diff --git a/tests/libqos/sabrelite-machine.c b/tests/libqos/sabrelite-machine.c
new file mode 100644
index 0000000000..1d8c39e209
--- /dev/null
+++ b/tests/libqos/sabrelite-machine.c
@@ -0,0 +1,82 @@
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
+typedef struct QSabreliteMachine QSabreliteMachine;
+
+struct QSabreliteMachine {
+    QOSGraphObject obj;
+    QGuestAllocator *alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void sabrelite_destructor(QOSGraphObject *obj)
+{
+    g_free(obj);
+}
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
+static void *qos_create_machine_arm_sabrelite(void)
+{
+    QSabreliteMachine *machine = g_new0(QSabreliteMachine, 1);
+
+    machine->obj.get_device = sabrelite_get_device;
+    machine->obj.get_driver = sabrelite_get_driver;
+    machine->obj.destructor = sabrelite_destructor;
+    qos_init_sdhci_smm(&machine->sdhci, 0x02190000, &(QSDHCIProperties) {
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
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 9f4cd9209a..31ecc06159 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -55,14 +55,15 @@ FIELD(SDHC_CAPAB, DRIVER,                   36, 3); /* since v3 */
     Exynos4210
         { "arm",    "smdkc210",
             {0x12510000, 2, 0,  {1, 0x5e80080} } },
- *
- * FIXME: the following drivers are missing:
- *
 
     i.MX 6
         { "arm",    "sabrelite",
             {0x02190000, 3, 0,  {1, 0x057834b4} } },
 
+ *
+ * FIXME: the following drivers are missing:
+ *
+
     Zynq-7000
         { "arm",    "xilinx-zynq-a9",   Datasheet: UG585 (v1.12.1)
             {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
-- 
2.17.1
