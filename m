Received: from eggs.gnu.org ([2001:4830:134:3::10]:35710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb6-00054m-0a
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb4-0000w9-Rr
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:00 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb4-0000vE-Jg
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:58 -0400
Received: by mail-ed1-x543.google.com with SMTP id h4-v6so5253337edi.6
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:58 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:55 +0200
Message-Id: <20180806143412.27722-18-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 17/34] test/qgraph: arm/virt machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add arm/virt machine to the graph. This machine contains virtio-mmio, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include      |  1 +
 tests/libqos/virt-machine.c | 90 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/libqos/virt-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8dfbe049e7..4659785baf 100644
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
index 0000000000..e23fb95191
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
+static void virtio_destroy(QOSGraphObject *obj)
+{
+    QVirtioMachine *machine = (QVirtioMachine *) obj;
+    generic_alloc_uninit(machine->alloc);
+    g_free(obj);
+}
+
+static void *virtio_get_driver(void *object, const char *interface)
+{
+    QVirtioMachine *machine = object;
+    if (!g_strcmp0(interface, "guest_allocator")) {
+        return machine->alloc;
+    }
+
+    printf("%s not present in arm/virtio\n", interface);
+    abort();
+}
+
+static QOSGraphObject *virtio_get_device(void *obj, const char *device)
+{
+    QVirtioMachine *machine = obj;
+    if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    printf("%s not present in arm/virtio\n", device);
+    abort();
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
+    machine->obj.destructor = virtio_destroy;
+    return machine;
+}
+
+static void virtio_machine(void)
+{
+    qos_node_create_machine("arm/virt", qos_create_machine_arm_virt);
+    qos_node_contains("arm/virt", "virtio-mmio", NULL);
+}
+
+libqos_init(virtio_machine);
-- 
2.17.1
