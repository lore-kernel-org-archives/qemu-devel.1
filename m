Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSE0-0005RD-Jt
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDz-0007Iv-8h
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:52 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fcSDz-0007IS-1n
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:51 -0400
Received: by mail-ed1-x543.google.com with SMTP id d17-v6so1280331eds.11
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:12:51 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  9 Jul 2018 11:11:33 +0200
Message-Id: <20180709091136.28849-5-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] tests/qgraph: arm/raspi2 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add arm/raspi2 machine to the graph. This machine contains a generic-sdhci, so
its constructor must take care of setting it properly when called.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include        |  3 +-
 tests/libqos/raspi2-machine.c | 68 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/raspi2-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index acbf704a8a..de75a7394e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,7 +770,8 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
 libqgraph-obj-y = tests/libqos/qgraph.o
-libqgraph-pc-obj-y = $(libqos-pc-obj-y) tests/libqos/sdhci.o
+libqgraph-pc-obj-y = $(libqos-pc-obj-y) $(libqgraph-obj-y) tests/libqos/sdhci.o
+libqgraph-pc-obj-y += tests/libqos/raspi2-machine.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/libqos/raspi2-machine.c b/tests/libqos/raspi2-machine.c
new file mode 100644
index 0000000000..47f024076f
--- /dev/null
+++ b/tests/libqos/raspi2-machine.c
@@ -0,0 +1,68 @@
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
+#include "qgraph.h"
+#include "sdhci.h"
+
+typedef struct QRaspi2Machine QRaspi2Machine;
+
+struct QRaspi2Machine {
+    QOSGraphObject obj;
+    QSDHCI_MemoryMapped sdhci;
+};
+
+static void raspi2_destroy(QOSGraphObject *obj)
+{
+    g_free(obj);
+}
+
+static QOSGraphObject *raspi2_get_device(void *obj, const char *device)
+{
+    QRaspi2Machine *machine = obj;
+    if (!g_strcmp0(device, "generic-sdhci")) {
+        return &machine->sdhci.obj;
+    }
+
+    printf("%s not present in arm/raspi2", device);
+    abort();
+}
+
+static void *qos_create_machine_arm_raspi2(void)
+{
+    QRaspi2Machine *machine = g_new0(QRaspi2Machine, 1);
+
+    machine->obj.get_device = raspi2_get_device;
+    machine->obj.destructor = raspi2_destroy;
+    qos_create_sdhci_mm(&machine->sdhci, 0x3f300000, &(QSDHCIProperties) {
+        .version = 3,
+        .baseclock = 52,
+        .capab.sdma = false,
+        .capab.reg = 0x052134b4
+    });
+    return &machine->obj;
+}
+
+static void raspi2(void)
+{
+    qos_node_create_machine("arm/raspi2", qos_create_machine_arm_raspi2);
+    qos_node_contains("arm/raspi2", "generic-sdhci");
+}
+
+libqos_init(raspi2);
-- 
2.17.1
