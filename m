Received: from eggs.gnu.org ([2001:4830:134:3::10]:52850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGh-0002fR-NF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGd-0006xq-Fs
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGd-0006x9-8M
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:15 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:22 +0100
Message-Id: <1543851204-41186-70-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 69/71] qos-test: eepro100 test node
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

Convert tests/eepro100-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.
For now, all nodes share the same constructor and destructor.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/eepro100-test.c  | 65 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ee6871d..eefb503 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,7 +143,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
-check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
@@ -670,6 +669,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 # Tests
 qos-test-obj-y += tests/ac97-test.o
 qos-test-obj-y += tests/e1000e-test.o
+qos-test-obj-y += tests/eepro100-test.o
 qos-test-obj-y += tests/es1370-test.o
 qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/ne2000-test.o
@@ -725,7 +725,6 @@ tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
 tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
-tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index bdc8a67..90b5c1a 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -9,23 +9,15 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-static void test_device(gconstpointer data)
-{
-    const char *model = data;
-    QTestState *s;
-    char *args;
-
-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
-
-    /* Tests only initialization so far. TODO: Implement functional tests */
+typedef struct QEEPRO100 QEEPRO100;
 
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
-}
+struct QEEPRO100 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
 
 static const char *models[] = {
     "i82550",
@@ -43,19 +35,42 @@ static const char *models[] = {
     "i82801",
 };
 
-int main(int argc, char **argv)
+static void *eepro100_get_driver(void *obj, const char *interface)
 {
-    int i;
+    QEEPRO100 *eepro100 = obj;
 
-    g_test_init(&argc, &argv, NULL);
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &eepro100->dev;
+    }
 
-    for (i = 0; i < ARRAY_SIZE(models); i++) {
-        char *path;
+    fprintf(stderr, "%s not present in eepro100\n", interface);
+    g_assert_not_reached();
+}
 
-        path = g_strdup_printf("eepro100/%s", models[i]);
-        qtest_add_data_func(path, models[i], test_device);
-        g_free(path);
-    }
+static void *eepro100_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QEEPRO100 *eepro100 = g_new0(QEEPRO100, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&eepro100->dev, bus, addr);
+    eepro100->obj.get_driver = eepro100_get_driver;
+
+    return &eepro100->obj;
+}
+
+static void eepro100_register_nodes(void)
+{
+    int i;
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
 
-    return g_test_run();
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        qos_node_create_driver(models[i], eepro100_create);
+        qos_node_consumes(models[i], "pci-bus", &opts);
+        qos_node_produces(models[i], "pci-device");
+    }
 }
+
+libqos_init(eepro100_register_nodes);
-- 
1.8.3.1
