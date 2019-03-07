Received: from eggs.gnu.org ([209.51.188.92]:39585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqt-0003K9-Rt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqr-0008BO-PA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqp-00086i-KI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id y15so10119343wma.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:31 +0100
Message-Id: <1551979804-6060-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/57] tests/libqos: arm/virt machine node
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
index c9c6019..4a9e2e4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -757,6 +757,7 @@ qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
+qos-test-obj-y += tests/libqos/arm-virt-machine.o
 qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
 qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
diff --git a/tests/libqos/arm-virt-machine.c b/tests/libqos/arm-virt-machine.c
new file mode 100644
index 0000000..2abc431
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
+               ARM_VIRT_RAM_ADDR,
+               ARM_VIRT_RAM_ADDR + ARM_VIRT_RAM_SIZE,
+               ARM_PAGE_SIZE);
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
