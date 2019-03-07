Received: from eggs.gnu.org ([209.51.188.92]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrP-0003tR-Jh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrO-0000Cf-OR
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:11 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrO-0000Bx-GK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:10 -0500
Received: by mail-wr1-x431.google.com with SMTP id w6so18402177wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:31:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:30:01 +0100
Message-Id: <1551979804-6060-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 54/57] qos-test: es1370 test node
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

Convert tests/es1370-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/es1370-test.c    | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5be98d7..4a387b6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -154,7 +154,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
-check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
@@ -745,6 +744,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 # Tests
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
+qos-test-obj-y += tests/es1370-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/nvme-test.o
@@ -812,7 +812,6 @@ tests/device-plug-test$(EXESUF): tests/device-plug-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index 199fe19..d845cd0 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -9,23 +9,49 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+typedef struct QES1370 QES1370;
+
+struct QES1370 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *es1370_get_driver(void *obj, const char *interface)
 {
+    QES1370 *es1370 = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &es1370->dev;
+    }
+
+    fprintf(stderr, "%s not present in e1000e\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *es1370_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QES1370 *es1370 = g_new0(QES1370, 1);
+    QPCIBus *bus = pci_bus;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/es1370/nop", nop);
+    qpci_device_init(&es1370->dev, bus, addr);
+    es1370->obj.get_driver = es1370_get_driver;
 
-    qtest_start("-device ES1370");
-    ret = g_test_run();
+    return &es1370->obj;
+}
 
-    qtest_end();
+static void es1370_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return ret;
+    qos_node_create_driver("ES1370", es1370_create);
+    qos_node_consumes("ES1370", "pci-bus", &opts);
+    qos_node_produces("ES1370", "pci-device");
 }
+
+libqos_init(es1370_register_nodes);
-- 
1.8.3.1
