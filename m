Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEy-0000dZ-Ik
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEx-00053E-Gq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEx-00052N-8J
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:31 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:51 +0100
Message-Id: <1543851204-41186-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 38/71] tests/libqos: arm/virt machine node
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

Add arm/virt machine to the graph. This machine contains virtio-mmio, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include          |  1 +
 tests/libqos/arm-virt-machine.c | 90 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/libqos/arm-virt-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1d4e147..4545232 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -683,6 +683,7 @@ qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
+qos-test-obj-y += tests/libqos/arm-virt-machine.o
 qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
 qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
diff --git a/tests/libqos/arm-virt-machine.c b/tests/libqos/arm-virt-machine.c
new file mode 100644
index 0000000..05aa0b2
--- /dev/null
+++ b/tests/libqos/arm-virt-machine.c
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
+
+#define ARM_PAGE_SIZE               4096
+#define VIRTIO_MMIO_BASE_ADDR       0x0A003E00
+#define ARM_VIRT_RAM_ADDR           0x40000000
+#define ARM_VIRT_RAM_SIZE           0x20000000
+#define VIRTIO_MMIO_SIZE            0x00000200
+
+typedef struct QVirtMachine QVirtMachine;
+
+struct QVirtMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QVirtioMMIODevice virtio_mmio;
+};
+
+static void virt_destructor(QOSGraphObject *obj)
+{
+    QVirtMachine *machine = (QVirtMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *virt_get_driver(void *object, const char *interface)
+{
+    QVirtMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/virtio\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *virt_get_device(void *obj, const char *device)
+{
+    QVirtMachine *machine = obj;
+    if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/virtio\n", device);
+    g_assert_not_reached();
+}
+
+static void *qos_create_machine_arm_virt(QTestState *qts)
+{
+    QVirtMachine *machine = g_new0(QVirtMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+	       ARM_VIRT_RAM_ADDR,
+	       ARM_VIRT_RAM_ADDR + ARM_VIRT_RAM_SIZE,
+	       ARM_PAGE_SIZE);
+    qvirtio_mmio_init_device(&machine->virtio_mmio, qts, VIRTIO_MMIO_BASE_ADDR,
+                             VIRTIO_MMIO_SIZE);
+
+    machine->obj.get_device = virt_get_device;
+    machine->obj.get_driver = virt_get_driver;
+    machine->obj.destructor = virt_destructor;
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
1.8.3.1
