Received: from eggs.gnu.org ([2001:4830:134:3::10]:52732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGT-0002U6-JN
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGR-0006iE-7k
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGQ-0006hG-Va
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:03 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:19 +0100
Message-Id: <1543851204-41186-67-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 66/71] qos-test: usb-hcd-ohci test node
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

Convert tests/usb-hcd-ohci-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    |  4 +---
 tests/usb-hcd-ohci-test.c | 54 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9f19e31..47b4d12 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -172,7 +172,6 @@ check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
 check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
 check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
-check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
 check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
@@ -221,7 +220,6 @@ check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
@@ -681,6 +679,7 @@ qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/pcnet-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/spapr-phb-test.o
+qos-test-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-y += tests/virtio-9p-test.o
@@ -741,7 +740,6 @@ tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
-tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 48ddbfd..98af02e 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -10,30 +10,58 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/usb.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
+typedef struct QOHCI_PCI QOHCI_PCI;
 
-static void test_ohci_init(void)
-{
+struct QOHCI_PCI {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
 
+static void test_ohci_hotplug(void *obj, void *data, QGuestAllocator *alloc)
+{
+    usb_test_hotplug("ohci", "1", NULL);
 }
 
-static void test_ohci_hotplug(void)
+static void *ohci_pci_get_driver(void *obj, const char *interface)
 {
-    usb_test_hotplug("ohci", "1", NULL);
+    QOHCI_PCI *ohci_pci = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &ohci_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in pci-ohci\n", interface);
+    g_assert_not_reached();
 }
 
-int main(int argc, char **argv)
+static void *ohci_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QOHCI_PCI *ohci_pci = g_new0(QOHCI_PCI, 1);
+    ohci_pci->obj.get_driver = ohci_pci_get_driver;
 
-    g_test_init(&argc, &argv, NULL);
+    return &ohci_pci->obj;
+}
+
+static void ohci_pci_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0,id=ohci",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    qtest_add_func("/ohci/pci/init", test_ohci_init);
-    qtest_add_func("/ohci/pci/hotplug", test_ohci_hotplug);
+    qos_node_create_driver("pci-ohci", ohci_pci_create);
+    qos_node_consumes("pci-ohci", "pci-bus", &opts);
+    qos_node_produces("pci-ohci", "pci-device");
+}
 
-    qtest_start("-device pci-ohci,id=ohci");
-    ret = g_test_run();
-    qtest_end();
+libqos_init(ohci_pci_register_nodes);
 
-    return ret;
+static void register_ohci_pci_test(void)
+{
+    qos_add_test("ohci_pci-test-hotplug", "pci-ohci", test_ohci_hotplug, NULL);
 }
+
+libqos_init(register_ohci_pci_test);
-- 
1.8.3.1
