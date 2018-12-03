Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGe-0002cm-Tv
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGa-0006vH-VL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGa-0006uh-N2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:21 +0100
Message-Id: <1543851204-41186-69-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 68/71] qos-test: es1370 test node
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

Convert tests/es1370-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/es1370-test.c    | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8995132..ee6871d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -144,7 +144,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
-check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
@@ -671,6 +670,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 # Tests
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
+qos-test-obj-y += tests/es1370-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/nvme-test.o
@@ -736,7 +736,6 @@ tests/machine-none-test$(EXESUF): tests/machine-none-test.o
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
