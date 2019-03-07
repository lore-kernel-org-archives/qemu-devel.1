Received: from eggs.gnu.org ([209.51.188.92]:39964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrI-0003n8-IX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrH-00007u-IE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrH-00006Q-Av
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id x7so10093549wmj.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:31:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:55 +0100
Message-Id: <1551979804-6060-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 48/57] qos-test: ne2k_pci test node
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
index 3eaa888..0d06490 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -155,7 +155,6 @@ check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
-check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
@@ -753,6 +752,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
+qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
@@ -805,7 +805,6 @@ tests/pcnet-test$(EXESUF): tests/pcnet-test.o
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
