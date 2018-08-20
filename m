Received: from eggs.gnu.org ([2001:4830:134:3::10]:33015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritV-00065U-Pd
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritU-0002gC-Lq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:49 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:12 +0200
Message-Id: <20180820120213.11095-16-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 15/16] test/qgraph: eepro100 test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Keith Busch <keith.busch@intel.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/eepro100-test in qgraph test nodes,
eepro100-test. Since it's a nop test, node creation and
initialization is made in the same file.
In addition, all nodes share the same constructor and
destructor.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/eepro100-test.c  | 61 +++++++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 46ef183c5f..e7893cac65 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -209,7 +209,6 @@ check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
 gcov-files-pci-y += hw/net/rtl8139.c
 gcov-files-pci-y += hw/net/pcnet.c
 gcov-files-pci-y += hw/net/pcnet-pci.c
-check-qtest-pci-y += tests/eepro100-test$(EXESUF)
 gcov-files-pci-y += hw/net/eepro100.c
 gcov-files-pci-y += hw/net/ne2000.c
 gcov-files-pci-y += hw/block/nvme.c
@@ -792,6 +791,7 @@ libqgraph-tests-obj-y += tests/spapr-phb-test.o
 libqgraph-tests-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 libqgraph-tests-obj-y += tests/vmxnet3-test.o
 libqgraph-tests-obj-y += tests/es1370-test.o
+libqgraph-tests-obj-y += tests/eepro100-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -827,7 +827,6 @@ tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
 tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
-tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index bdc8a67d57..432695f422 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -9,23 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 
-static void test_device(gconstpointer data)
-{
-    const char *model = data;
-    QTestState *s;
-    char *args;
-
-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
+typedef struct QEepro100 QEepro100;
 
-    /* Tests only initialization so far. TODO: Implement functional tests */
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
-}
+struct QEepro100 {
+    QOSGraphObject obj;
+};
 
 static const char *models[] = {
     "i82550",
@@ -43,19 +33,48 @@ static const char *models[] = {
     "i82801",
 };
 
-int main(int argc, char **argv)
+/* Tests only initialization so far. TODO: Replace with functional tests */
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void eepro100_destructor(QOSGraphObject *obj)
+{
+    QEepro100 *eepro100 = (QEepro100 *)obj;
+    g_free(eepro100);
+}
+
+static void *eepro100_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QEepro100 *eepro100 = g_new0(QEepro100, 1);
+    eepro100->obj.destructor = eepro100_destructor;
+
+    return &eepro100->obj;
+}
+
+static void eepro100_register_nodes(void)
 {
     int i;
 
-    g_test_init(&argc, &argv, NULL);
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        qos_node_create_driver(models[i], eepro100_create);
+        qos_node_consumes(models[i], "pci-bus", NULL);
+    }
+}
+
+libqos_init(eepro100_register_nodes);
+
+static void register_eepro100_test(void)
+{
+    int i;
 
     for (i = 0; i < ARRAY_SIZE(models); i++) {
         char *path;
 
-        path = g_strdup_printf("eepro100/%s", models[i]);
-        qtest_add_data_func(path, models[i], test_device);
+        path = g_strdup_printf("%s-eepro100-test", models[i]);
+        qos_add_test(path, models[i], nop, NULL);
         g_free(path);
     }
-
-    return g_test_run();
 }
+
+libqos_init(register_eepro100_test);
-- 
2.17.1
