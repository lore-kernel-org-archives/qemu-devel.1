Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9se-0007Av-7s
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sc-00021b-Jf
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:20 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:27 +0200
Message-Id: <20180813101453.10200-8-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 07/33] tests/qgraph: arm/raspi2 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add arm/raspi2 machine to the graph. This machine contains a generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include        |  1 +
 tests/libqos/raspi2-machine.c | 82 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/libqos/raspi2-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c4c7c8d56a..67dbec0d35 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -769,6 +769,7 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
 libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
+libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
 
 libqgraph-pci-obj-y = $(libqos-pc-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/raspi2-machine.c b/tests/libqos/raspi2-machine.c
new file mode 100644
index 0000000000..72fe7f3d4f
--- /dev/null
+++ b/tests/libqos/raspi2-machine.c
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
+typedef struct QRaspi2Machine QRaspi2Machine;
+
+struct QRaspi2Machine {
+    QOSGraphObject obj;
+    QGuestAllocator *alloc;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void raspi2_destructor(QOSGraphObject *obj)
+{
+    g_free(obj);
+}
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
+static void *qos_create_machine_arm_raspi2(void)
+{
+    QRaspi2Machine *machine = g_new0(QRaspi2Machine, 1);
+
+    machine->obj.get_device = raspi2_get_device;
+    machine->obj.get_driver = raspi2_get_driver;
+    machine->obj.destructor = raspi2_destructor;
+    qos_init_sdhci_smm(&machine->sdhci, 0x3f300000, &(QSDHCIProperties) {
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
2.17.1
