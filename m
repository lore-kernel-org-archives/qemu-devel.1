Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGG-0002LI-Qk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGC-0006TK-1a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGB-0006SW-Qj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:47 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:15 +0100
Message-Id: <1543851204-41186-63-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 62/71] qos-test: ne2k_pci test node
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

Convert tests/ne2000-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

The actual device consumed by the test is ne2k_pci.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/ne2000-test.c    | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd76a34..290e496 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,6 @@ check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
-check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
@@ -679,6 +678,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
+qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
@@ -730,7 +730,6 @@ tests/pcnet-test$(EXESUF): tests/pcnet-test.o
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
-tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index b7cf3dd..097c2ee 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -9,23 +9,49 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+typedef struct QNe2k_pci QNe2k_pci;
+
+struct QNe2k_pci {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *ne2k_pci_get_driver(void *obj, const char *interface)
 {
+    QNe2k_pci *ne2k_pci = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &ne2k_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in ne2k_pci\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *ne2k_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QNe2k_pci *ne2k_pci = g_new0(QNe2k_pci, 1);
+    QPCIBus *bus = pci_bus;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ne2000/pci/nop", pci_nop);
+    qpci_device_init(&ne2k_pci->dev, bus, addr);
+    ne2k_pci->obj.get_driver = ne2k_pci_get_driver;
 
-    qtest_start("-device ne2k_pci");
-    ret = g_test_run();
+    return &ne2k_pci->obj;
+}
 
-    qtest_end();
+static void ne2000_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return ret;
+    qos_node_create_driver("ne2k_pci", ne2k_pci_create);
+    qos_node_consumes("ne2k_pci", "pci-bus", &opts);
+    qos_node_produces("ne2k_pci", "pci-device");
 }
+
+libqos_init(ne2000_register_nodes);
-- 
1.8.3.1
