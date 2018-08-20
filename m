Received: from eggs.gnu.org ([2001:4830:134:3::10]:33148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritb-0006AC-VK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritW-0002hL-3a
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:55 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:13 +0200
Message-Id: <20180820120213.11095-17-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 16/16] test/qgraph: e1000 test node
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

Convert tests/e1000-test in qgraph test nodes,
e1000-test. Since it's a nop test, node creation and
initialization is made in the same file.
In addition, all nodes share the same constructor and
destructor.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/e1000-test.c     | 60 ++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e7893cac65..546fdf603c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -202,7 +202,6 @@ gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 gcov-files-virtio-y += $(gcov-files-virtioserial-y)
 
-check-qtest-pci-y += tests/e1000-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000.c
 gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
 check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
@@ -792,6 +791,7 @@ libqgraph-tests-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 libqgraph-tests-obj-y += tests/vmxnet3-test.o
 libqgraph-tests-obj-y += tests/es1370-test.o
 libqgraph-tests-obj-y += tests/eepro100-test.o
+libqgraph-tests-obj-y += tests/e1000-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -824,7 +824,6 @@ tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
 tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
-tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 0c5fcdcc44..93e47abc2c 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -9,22 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void test_device(gconstpointer data)
-{
-    const char *model = data;
-    QTestState *s;
-    char *args;
+typedef struct QE1000 QE1000;
 
-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
-}
+struct QE1000 {
+    QOSGraphObject obj;
+};
 
 static const char *models[] = {
     "e1000",
@@ -33,19 +24,48 @@ static const char *models[] = {
     "e1000-82545em",
 };
 
-int main(int argc, char **argv)
+/* Tests only initialization so far. TODO: Replace with functional tests */
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void e1000_destructor(QOSGraphObject *obj)
+{
+    QE1000 *e1000 = (QE1000 *)obj;
+    g_free(e1000);
+}
+
+static void *e1000_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QE1000 *e1000 = g_new0(QE1000, 1);
+    e1000->obj.destructor = e1000_destructor;
+
+    return &e1000->obj;
+}
+
+static void e1000_register_nodes(void)
 {
     int i;
 
-    g_test_init(&argc, &argv, NULL);
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        qos_node_create_driver(models[i], e1000_create);
+        qos_node_consumes(models[i], "pci-bus", NULL);
+    }
+}
+
+libqos_init(e1000_register_nodes);
+
+static void register_e1000_test(void)
+{
+    int i;
 
     for (i = 0; i < ARRAY_SIZE(models); i++) {
         char *path;
 
-        path = g_strdup_printf("e1000/%s", models[i]);
-        qtest_add_data_func(path, models[i], test_device);
+        path = g_strdup_printf("%s-e1000-test", models[i]);
+        qos_add_test(path, models[i], nop, NULL);
         g_free(path);
     }
-
-    return g_test_run();
 }
+
+libqos_init(register_e1000_test);
-- 
2.17.1
