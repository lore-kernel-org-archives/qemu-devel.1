Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGA-0002Hb-5I
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqG5-0006My-B4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqG5-0006MF-3Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:41 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:13 +0100
Message-Id: <1543851204-41186-61-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 60/71] qos-test: tpci200 test node
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

Convert tests/tpci200-test to a driver node; currently it runs
the PCI nop test only, but it also produces the ipack interface.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/libqos/tpci200.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/tpci200-test.c   | 31 ------------------------
 3 files changed, 66 insertions(+), 33 deletions(-)
 create mode 100644 tests/libqos/tpci200.c
 delete mode 100644 tests/tpci200-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5d65bd1..d0b636e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -150,7 +150,6 @@ check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
@@ -657,6 +656,7 @@ qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
+qos-test-obj-y += tests/libqos/tpci200.o
 qos-test-obj-y += tests/libqos/virtio.o
 qos-test-obj-y += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
@@ -736,7 +736,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
diff --git a/tests/libqos/tpci200.c b/tests/libqos/tpci200.c
new file mode 100644
index 0000000..98dc532
--- /dev/null
+++ b/tests/libqos/tpci200.c
@@ -0,0 +1,65 @@
+/*
+ * QTest testcase for tpci200 PCI-IndustryPack bridge
+ *
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
+
+typedef struct QTpci200 QTpci200;
+typedef struct QIpack QIpack;
+
+struct QIpack {
+
+};
+struct QTpci200 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+    QIpack ipack;
+};
+
+/* tpci200 */
+static void *tpci200_get_driver(void *obj, const char *interface)
+{
+    QTpci200 *tpci200 = obj;
+    if (!g_strcmp0(interface, "ipack")) {
+        return &tpci200->ipack;
+    }
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &tpci200->dev;
+    }
+
+    fprintf(stderr, "%s not present in tpci200\n", interface);
+    g_assert_not_reached();
+}
+
+static void *tpci200_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QTpci200 *tpci200 = g_new0(QTpci200, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&tpci200->dev, bus, addr);
+    tpci200->obj.get_driver = tpci200_get_driver;
+    return &tpci200->obj;
+}
+
+static void tpci200_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0,id=ipack0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
+
+    qos_node_create_driver("tpci200", tpci200_create);
+    qos_node_consumes("tpci200", "pci-bus", &opts);
+    qos_node_produces("tpci200", "ipack");
+    qos_node_produces("tpci200", "pci-device");
+}
+
+libqos_init(tpci200_register_nodes);
diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
deleted file mode 100644
index 0321ec2..0000000
--- a/tests/tpci200-test.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * QTest testcase for tpci200 PCI-IndustryPack bridge
- *
- * Copyright (c) 2014 SUSE LINUX Products GmbH
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "libqtest.h"
-
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
-{
-}
-
-int main(int argc, char **argv)
-{
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/tpci200/nop", nop);
-
-    qtest_start("-device tpci200");
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
-}
-- 
1.8.3.1
