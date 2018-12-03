Received: from eggs.gnu.org ([2001:4830:134:3::10]:52597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGA-0002Hq-DM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqG9-0006Ql-E1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqG9-0006Q3-6C
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:45 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:14 +0100
Message-Id: <1543851204-41186-62-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 61/71] qos-test: ipoctal232 test node
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

Convert tests/ipoctal232-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

This test creates a tpci200 node that produces an interface ipack
consumed by the ipoctal232 device.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |  5 +----
 tests/ipoctal232-test.c | 35 ++++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d0b636e..fd76a34 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -141,8 +141,6 @@ check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
-check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
-
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
@@ -150,7 +148,6 @@ check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
@@ -681,6 +678,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 # Tests
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
+qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
@@ -737,7 +735,6 @@ tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
-tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 6849141..42d5371 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -9,23 +9,40 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QIpoctal232 QIpoctal232;
+
+struct QIpoctal232 {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-int main(int argc, char **argv)
+static void *ipoctal232_create(void *pci_bus, QGuestAllocator *alloc,
+                               void *addr)
 {
-    int ret;
+    QIpoctal232 *ipoctal232 = g_new0(QIpoctal232, 1);
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ipoctal232/tpci200/nop", nop);
+    return &ipoctal232->obj;
+}
 
-    qtest_start("-device tpci200,id=ipack0 -device ipoctal232,bus=ipack0.0");
-    ret = g_test_run();
+static void ipoctal232_register_nodes(void)
+{
+    qos_node_create_driver("ipoctal232", ipoctal232_create);
+    qos_node_consumes("ipoctal232", "ipack", &(QOSGraphEdgeOptions) {
+        .extra_device_opts = "bus=ipack0.0",
+    });
+}
 
-    qtest_end();
+libqos_init(ipoctal232_register_nodes);
 
-    return ret;
+static void register_ipoctal232_test(void)
+{
+    qos_add_test("nop", "ipoctal232", nop, NULL);
 }
+
+libqos_init(register_ipoctal232_test);
-- 
1.8.3.1
