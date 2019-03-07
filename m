Received: from eggs.gnu.org ([209.51.188.92]:40026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrP-0003t9-7z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrO-0000CA-8G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:11 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrO-0000BN-0n
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id i16so18390732wrs.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:31:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:30:00 +0100
Message-Id: <1551979804-6060-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/57] qos-test: vmxnet3 test node
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

Convert tests/vmxnet3-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/vmxnet3-test.c   | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8ba8e27..5be98d7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -180,7 +180,6 @@ check-qtest-i386-y += tests/drive_del-test$(EXESUF)
 check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
 check-qtest-i386-y += tests/tco-test$(EXESUF)
 check-qtest-i386-y += $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
 check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
 check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
@@ -762,6 +761,7 @@ qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-scsi-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
+qos-test-obj-y += tests/vmxnet3-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -801,7 +801,6 @@ tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
-tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 159c0ad..35cdea9 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -9,23 +9,49 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+typedef struct QVmxnet3 QVmxnet3;
+
+struct QVmxnet3 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *vmxnet3_get_driver(void *obj, const char *interface)
 {
+    QVmxnet3 *vmxnet3 = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &vmxnet3->dev;
+    }
+
+    fprintf(stderr, "%s not present in vmxnet3\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *vmxnet3_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QVmxnet3 *vmxnet3 = g_new0(QVmxnet3, 1);
+    QPCIBus *bus = pci_bus;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/vmxnet3/nop", nop);
+    qpci_device_init(&vmxnet3->dev, bus, addr);
+    vmxnet3->obj.get_driver = vmxnet3_get_driver;
 
-    qtest_start("-device vmxnet3");
-    ret = g_test_run();
+    return &vmxnet3->obj;
+}
 
-    qtest_end();
+static void vmxnet3_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return ret;
+    qos_node_create_driver("vmxnet3", vmxnet3_create);
+    qos_node_consumes("vmxnet3", "pci-bus", &opts);
+    qos_node_produces("vmxnet3", "pci-device");
 }
+
+libqos_init(vmxnet3_register_nodes);
-- 
1.8.3.1
