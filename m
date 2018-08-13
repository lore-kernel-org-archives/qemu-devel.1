Received: from eggs.gnu.org ([2001:4830:134:3::10]:43942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9t6-0007aN-Na
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9t5-0002fU-Iv
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:48 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:36 +0200
Message-Id: <20180813101453.10200-17-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 16/33] tests/qgraph: arm/virt machine node
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

Add arm/virt machine to the graph. This machine contains virtio-mmio, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include      |  1 +
 tests/libqos/virt-machine.c | 90 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/libqos/virt-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5220136473..20cb983ed0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,6 +770,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
 libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
 libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
+libqgraph-machines-obj-y += tests/libqos/virt-machine.o
 
 libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
diff --git a/tests/libqos/virt-machine.c b/tests/libqos/virt-machine.c
new file mode 100644
index 0000000000..c8910a58f4
--- /dev/null
+++ b/tests/libqos/virt-machine.c
@@ -0,0 +1,90 @@
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
+#include "libqos/virtio-mmio.h"
+#include "libqos/malloc-generic.h"
+
+#define ARM_PAGE_SIZE               4096
+#define VIRTIO_MMIO_BASE_ADDR       0x0A003E00
+#define ARM_VIRT_RAM_ADDR           0x40000000
+#define ARM_VIRT_RAM_SIZE           0x20000000
+#define VIRTIO_MMIO_SIZE            0x00000200
+
+typedef struct QVirtioMachine QVirtioMachine;
+
+struct QVirtioMachine {
+    QOSGraphObject obj;
+    QGuestAllocator *alloc;
+    QVirtioMMIODevice virtio_mmio;
+};
+
+static void virtio_destructor(QOSGraphObject *obj)
+{
+    QVirtioMachine *machine = (QVirtioMachine *) obj;
+    generic_alloc_uninit(machine->alloc);
+    g_free(obj);
+}
+
+static void *virtio_get_driver(void *object, const char *interface)
+{
+    QVirtioMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/virtio\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *virtio_get_device(void *obj, const char *device)
+{
+    QVirtioMachine *machine = obj;
+    if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/virtio\n", device);
+    g_assert_not_reached();
+}
+
+static void *qos_create_machine_arm_virt(void)
+{
+    QVirtioMachine *machine = g_new0(QVirtioMachine, 1);
+
+    machine->alloc = generic_alloc_init(ARM_VIRT_RAM_ADDR, ARM_VIRT_RAM_SIZE,
+                                        ARM_PAGE_SIZE);
+    qvirtio_mmio_init_device(&machine->virtio_mmio, VIRTIO_MMIO_BASE_ADDR,
+                             VIRTIO_MMIO_SIZE);
+
+    machine->obj.get_device = virtio_get_device;
+    machine->obj.get_driver = virtio_get_driver;
+    machine->obj.destructor = virtio_destructor;
+    return machine;
+}
+
+static void virtio_mmio_register_nodes(void)
+{
+    qos_node_create_machine("arm/virt", qos_create_machine_arm_virt);
+    qos_node_contains("arm/virt", "virtio-mmio", NULL);
+}
+
+libqos_init(virtio_mmio_register_nodes);
-- 
2.17.1
