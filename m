Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGK-0002Mw-0L
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGF-0006WH-H4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGF-0006Vc-9m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:51 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:16 +0100
Message-Id: <1543851204-41186-64-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 63/71] qos-test: nvme test node
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

Convert tests/nvme-test to a driver node; the code to discover the PCI
device is replaced by generic qgraph code, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +-
 tests/nvme-test.c      | 78 +++++++++++++++++++++++++++-----------------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 290e496..64eb8b6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,6 @@ check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
-check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
@@ -679,6 +678,7 @@ qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/ne2000-test.o
+qos-test-obj-y += tests/nvme-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
@@ -738,7 +738,6 @@ tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o
-tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 2700ba8..b48d3a2 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -10,49 +10,47 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "libqtest.h"
-#include "libqos/libqos-pc.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-static QOSState *qnvme_start(const char *extra_opts)
+typedef struct QNvme QNvme;
+
+struct QNvme {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *nvme_get_driver(void *obj, const char *interface)
 {
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-    const char *cmd = "-drive id=drv0,if=none,file=null-co://,format=raw "
-                      "-device nvme,addr=0x4.0,serial=foo,drive=drv0 %s";
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, extra_opts ? : "");
-        global_qtest = qs->qts;
-        return qs;
+    QNvme *nvme = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &nvme->dev;
     }
 
-    g_printerr("nvme tests are only available on x86\n");
-    exit(EXIT_FAILURE);
+    fprintf(stderr, "%s not present in nvme\n", interface);
+    g_assert_not_reached();
 }
 
-static void qnvme_stop(QOSState *qs)
+static void *nvme_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    qtest_shutdown(qs);
-}
+    QNvme *nvme = g_new0(QNvme, 1);
+    QPCIBus *bus = pci_bus;
 
-static void nop(void)
-{
-    QOSState *qs;
+    qpci_device_init(&nvme->dev, bus, addr);
+    nvme->obj.get_driver = nvme_get_driver;
 
-    qs = qnvme_start(NULL);
-    qnvme_stop(qs);
+    return &nvme->obj;
 }
 
-static void nvmetest_cmb_test(void)
+/* This used to cause a NULL pointer dereference.  */
+static void nvmetest_oob_cmb_test(void *obj, void *data, QGuestAllocator *alloc)
 {
     const int cmb_bar_size = 2 * MiB;
-    QOSState *qs;
-    QPCIDevice *pdev;
+    QNvme *nvme = obj;
+    QPCIDevice *pdev = &nvme->dev;
     QPCIBar bar;
 
-    qs = qnvme_start("-global nvme.cmb_size_mb=2");
-    pdev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4,0));
-    g_assert(pdev != NULL);
-
     qpci_device_enable(pdev);
     bar = qpci_iomap(pdev, 2, NULL);
 
@@ -65,16 +63,24 @@ static void nvmetest_cmb_test(void)
     g_assert_cmpint(qpci_io_readb(pdev, bar, cmb_bar_size - 1), ==, 0x11);
     g_assert_cmpint(qpci_io_readw(pdev, bar, cmb_bar_size - 1), !=, 0x2211);
     g_assert_cmpint(qpci_io_readl(pdev, bar, cmb_bar_size - 1), !=, 0x44332211);
-    g_free(pdev);
-
-    qnvme_stop(qs);
 }
 
-int main(int argc, char **argv)
+static void nvme_register_nodes(void)
 {
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/nvme/nop", nop);
-    qtest_add_func("/nvme/cmb_test", nvmetest_cmb_test);
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0,drive=drv0,serial=foo",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+    };
+
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return g_test_run();
+    qos_node_create_driver("nvme", nvme_create);
+    qos_node_consumes("nvme", "pci-bus", &opts);
+    qos_node_produces("nvme", "pci-device");
+
+    qos_add_test("oob-cmb-access", "nvme", nvmetest_oob_cmb_test, &(QOSGraphTestOptions) {
+        .edge.extra_device_opts = "cmb_size_mb=2"
+    });
 }
+
+libqos_init(nvme_register_nodes);
-- 
1.8.3.1
