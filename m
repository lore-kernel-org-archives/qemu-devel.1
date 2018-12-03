Received: from eggs.gnu.org ([2001:4830:134:3::10]:52893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGl-0002hc-89
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGj-00072V-2o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGi-00071U-Nh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:21 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:24 +0100
Message-Id: <1543851204-41186-72-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 71/71] qos-test: megasas test node
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

Convert tests/megasas-test to a driver node; the code to discover the PCI
device is replaced by generic qgraph code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +-
 tests/megasas-test.c   | 80 +++++++++++++++++++++++++-------------------------
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0527342..014583f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,6 @@ check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
-check-qtest-pci-y += tests/megasas-test$(EXESUF)
 
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
@@ -672,6 +671,7 @@ qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/eepro100-test.o
 qos-test-obj-y += tests/es1370-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
+qos-test-obj-y += tests/megasas-test.o
 qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/nvme-test.o
 qos-test-obj-y += tests/pci-test.o
@@ -750,7 +750,6 @@ tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/megasas-test$(EXESUF): tests/megasas-test.o $(libqos-spapr-obj-y) $(libqos-pc-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index 81837e1..33aa970 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -10,55 +10,49 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
-#include "libqos/libqos-pc.h"
-#include "libqos/libqos-spapr.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-static QOSState *qmegasas_start(const char *extra_opts)
+typedef struct QMegasas QMegasas;
+
+struct QMegasas {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *megasas_get_driver(void *obj, const char *interface)
 {
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-    const char *cmd = "-drive id=hd0,if=none,file=null-co://,format=raw "
-                      "-device megasas,id=scsi0,addr=04.0 "
-                      "-device scsi-hd,bus=scsi0.0,drive=hd0 %s";
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, extra_opts ? : "");
-        global_qtest = qs->qts;
-        return qs;
+    QMegasas *megasas = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &megasas->dev;
     }
 
-    g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
-    exit(EXIT_FAILURE);
+    fprintf(stderr, "%s not present in megasas\n", interface);
+    g_assert_not_reached();
 }
 
-static void qmegasas_stop(QOSState *qs)
+static void *megasas_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    qtest_shutdown(qs);
-}
+    QMegasas *megasas = g_new0(QMegasas, 1);
+    QPCIBus *bus = pci_bus;
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
-{
-    QOSState *qs;
+    qpci_device_init(&megasas->dev, bus, addr);
+    megasas->obj.get_driver = megasas_get_driver;
 
-    qs = qmegasas_start(NULL);
-    qmegasas_stop(qs);
+    return &megasas->obj;
 }
 
 /* This used to cause a NULL pointer dereference.  */
-static void megasas_pd_get_info_fuzz(void)
+static void megasas_pd_get_info_fuzz(void *obj, void *data, QGuestAllocator *alloc)
 {
-    QPCIDevice *dev;
-    QOSState *qs;
+    QMegasas *megasas = obj;
+    QPCIDevice *dev = &megasas->dev;
     QPCIBar bar;
     uint32_t context[256];
     uint64_t context_pa;
     int i;
 
-    qs = qmegasas_start(NULL);
-    dev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4,0));
-    g_assert(dev != NULL);
-
     qpci_device_enable(dev);
     bar = qpci_iomap(dev, 0, NULL);
 
@@ -71,19 +65,25 @@ static void megasas_pd_get_info_fuzz(void)
     context[6] = cpu_to_le32(0x02020000);
     context[7] = cpu_to_le32(0);
 
-    context_pa = qmalloc(qs, sizeof(context));
+    context_pa = guest_alloc(alloc, sizeof(context));
     memwrite(context_pa, context, sizeof(context));
     qpci_io_writel(dev, bar, 0x40, context_pa);
-
-    g_free(dev);
-    qmegasas_stop(qs);
 }
 
-int main(int argc, char **argv)
+static void megasas_register_nodes(void)
 {
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/megasas/pci/nop", pci_nop);
-    qtest_add_func("/megasas/dcmd/pd-get-info/fuzz", megasas_pd_get_info_fuzz);
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0,id=scsi0",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+        .after_cmd_line = "-device scsi-hd,bus=scsi0.0,drive=drv0",
+    };
+
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
+
+    qos_node_create_driver("megasas", megasas_create);
+    qos_node_consumes("megasas", "pci-bus", &opts);
+    qos_node_produces("megasas", "pci-device");
 
-    return g_test_run();
+    qos_add_test("dcmd/pd-get-info/fuzz", "megasas", megasas_pd_get_info_fuzz, NULL);
 }
+libqos_init(megasas_register_nodes);
-- 
1.8.3.1
