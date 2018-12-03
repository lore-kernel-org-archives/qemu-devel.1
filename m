Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGX-0002Vu-LI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGV-0006nZ-OF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGV-0006m0-Fd
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:07 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:20 +0100
Message-Id: <1543851204-41186-68-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 67/71] qos-test: vmxnet3 test node
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

Convert tests/vmxnet3-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/vmxnet3-test.c   | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 47b4d12..8995132 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -168,7 +168,6 @@ check-qtest-i386-y += tests/drive_del-test$(EXESUF)
 check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
 check-qtest-i386-y += tests/tco-test$(EXESUF)
 check-qtest-i386-y += $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
 check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
 check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
@@ -688,6 +687,7 @@ qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-scsi-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
+qos-test-obj-y += tests/vmxnet3-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -726,7 +726,6 @@ tests/e1000-test$(EXESUF): tests/e1000-test.o
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
