Received: from eggs.gnu.org ([209.51.188.92]:40076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrS-0003vo-Eb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wrR-0000Ef-GL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wrR-0000E3-8g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:31:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id g20so9985342wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:31:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:30:03 +0100
Message-Id: <1551979804-6060-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 56/57] qos-test: e1000 test node
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

Convert tests/e1000-test to a driver node; currently it runs
the PCI nop test only, therefore we're not placing it in tests/libqos.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/e1000-test.c     | 64 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index befeb8f..5bc6d63 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -151,7 +151,6 @@ check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
-check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
@@ -742,6 +741,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 # Tests
 qos-test-obj-y += tests/ac97-test.o
+qos-test-obj-y += tests/e1000-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/eepro100-test.o
 qos-test-obj-y += tests/es1370-test.o
@@ -797,7 +797,6 @@ tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
 tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
-tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 0c5fcdc..9e67916 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -9,22 +9,15 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void test_device(gconstpointer data)
-{
-    const char *model = data;
-    QTestState *s;
-    char *args;
-
-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
+typedef struct QE1000 QE1000;
 
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
-}
+struct QE1000 {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
 
 static const char *models[] = {
     "e1000",
@@ -33,19 +26,42 @@ static const char *models[] = {
     "e1000-82545em",
 };
 
-int main(int argc, char **argv)
+static void *e1000_get_driver(void *obj, const char *interface)
 {
-    int i;
+    QE1000 *e1000 = obj;
 
-    g_test_init(&argc, &argv, NULL);
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &e1000->dev;
+    }
 
-    for (i = 0; i < ARRAY_SIZE(models); i++) {
-        char *path;
+    fprintf(stderr, "%s not present in e1000e\n", interface);
+    g_assert_not_reached();
+}
 
-        path = g_strdup_printf("e1000/%s", models[i]);
-        qtest_add_data_func(path, models[i], test_device);
-        g_free(path);
-    }
+static void *e1000_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QE1000 *e1000 = g_new0(QE1000, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&e1000->dev, bus, addr);
+    e1000->obj.get_driver = e1000_get_driver;
+
+    return &e1000->obj;
+}
+
+static void e1000_register_nodes(void)
+{
+    int i;
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
-    return g_test_run();
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        qos_node_create_driver(models[i], e1000_create);
+        qos_node_consumes(models[i], "pci-bus", &opts);
+        qos_node_produces(models[i], "pci-device");
+    }
 }
+
+libqos_init(e1000_register_nodes);
-- 
1.8.3.1
