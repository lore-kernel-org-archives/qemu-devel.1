Received: from eggs.gnu.org ([209.51.188.92]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrE-0003hw-JY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrD-0008VS-Lx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrD-0008U1-EQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:59 -0500
Received: by mail-wr1-x433.google.com with SMTP id y6so3260281wrn.7
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:52 +0100
Message-Id: <1551979804-6060-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/57] qos-test: ac97 test node
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

Convert tests/ac97-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/ac97-test.c      | 47 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4b53ca..954b06b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -159,7 +159,6 @@ check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
-check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
@@ -754,6 +753,7 @@ qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 # Tests
+qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
@@ -822,7 +822,6 @@ tests/drive_del-test$(EXESUF): tests/drive_del-test.o
 tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-tests/ac97-test$(EXESUF): tests/ac97-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index e0d177b..532fb1c 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -9,23 +9,48 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+typedef struct QAC97 QAC97;
+
+struct QAC97 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *ac97_get_driver(void *obj, const char *interface)
 {
+    QAC97 *ac97 = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &ac97->dev;
+    }
+
+    fprintf(stderr, "%s not present in e1000e\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *ac97_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QAC97 *ac97 = g_new0(QAC97, 1);
+    QPCIBus *bus = pci_bus;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ac97/nop", nop);
-
-    qtest_start("-device AC97");
-    ret = g_test_run();
+    qpci_device_init(&ac97->dev, bus, addr);
+    ac97->obj.get_driver = ac97_get_driver;
+    return &ac97->obj;
+}
 
-    qtest_end();
+static void ac97_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return ret;
+    qos_node_create_driver("AC97", ac97_create);
+    qos_node_produces("AC97", "pci-device");
+    qos_node_consumes("AC97", "pci-bus", &opts);
 }
+
+libqos_init(ac97_register_nodes);
-- 
1.8.3.1
