Received: from eggs.gnu.org ([2001:4830:134:3::10]:52663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGN-0002Oq-Uf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGJ-0006a7-Hm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGJ-0006ZK-AG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:55 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:17 +0100
Message-Id: <1543851204-41186-65-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 64/71] qos-test: pcnet test node
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

Convert tests/pcnet-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/pcnet-test.c     | 46 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 64eb8b6..351a729 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,7 +143,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
-check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
@@ -680,6 +679,7 @@ qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/nvme-test.o
 qos-test-obj-y += tests/pci-test.o
+qos-test-obj-y += tests/pcnet-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
 qos-test-obj-y += tests/virtio-test.o
@@ -726,7 +726,6 @@ tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
 tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
 tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
-tests/pcnet-test$(EXESUF): tests/pcnet-test.o
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index efb1ef4..484448c 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -9,23 +9,49 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+typedef struct QPCNet QPCNet;
+
+struct QPCNet {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *pcnet_get_driver(void *obj, const char *interface)
 {
+    QPCNet *pcnet = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &pcnet->dev;
+    }
+
+    fprintf(stderr, "%s not present in pcnet\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *pcnet_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QPCNet *pcnet = g_new0(QPCNet, 1);
+    QPCIBus *bus = pci_bus;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/pcnet/pci/nop", pci_nop);
+    qpci_device_init(&pcnet->dev, bus, addr);
+    pcnet->obj.get_driver = pcnet_get_driver;
 
-    qtest_start("-device pcnet");
-    ret = g_test_run();
+    return &pcnet->obj;
+}
 
-    qtest_end();
+static void pcnet_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return ret;
+    qos_node_create_driver("pcnet", pcnet_create);
+    qos_node_consumes("pcnet", "pci-bus", &opts);
+    qos_node_produces("pcnet", "pci-device");
 }
+
+libqos_init(pcnet_register_nodes);
-- 
1.8.3.1
