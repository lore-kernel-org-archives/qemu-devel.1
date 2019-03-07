Received: from eggs.gnu.org ([209.51.188.92]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrF-0003jX-VD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrE-0008WU-L2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:01 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrE-0008VW-Ct
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id o17so18422043wrw.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:31:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:53 +0100
Message-Id: <1551979804-6060-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/57] qos-test: tpci200 test node
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
index 954b06b..905a361 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -160,7 +160,6 @@ check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
 check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
@@ -731,6 +730,7 @@ qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
+qos-test-obj-y += tests/libqos/tpci200.o
 qos-test-obj-y += tests/libqos/virtio.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
@@ -811,7 +811,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
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
