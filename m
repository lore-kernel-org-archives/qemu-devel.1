Received: from eggs.gnu.org ([2001:4830:134:3::10]:60885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritG-0005pd-MD
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritD-0002U3-Va
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:34 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:03 +0200
Message-Id: <20180820120213.11095-7-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 06/16] test/qgraph: tpci200 test node
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

Convert tests/tpci200-test in qgraph test node,
tpci200-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  2 +-
 tests/tpci200-test.c   | 60 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3e5964263e..1daee93de5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -792,6 +792,7 @@ libqgraph-tests-obj-y += tests/virtio-blk-test.o
 libqgraph-tests-obj-y += tests/virtio-net-test.o
 libqgraph-tests-obj-y += tests/virtio-scsi-test.o
 libqgraph-tests-obj-y += tests/ac97-test.o
+libqgraph-tests-obj-y += tests/tpci200-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -835,7 +836,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
index 0321ec27ec..a0e1785e50 100644
--- a/tests/tpci200-test.c
+++ b/tests/tpci200-test.c
@@ -9,23 +9,65 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QTpci200 QTpci200;
+typedef struct QIpack QIpack;
+
+struct QIpack {
+
+};
+struct QTpci200 {
+    QOSGraphObject obj;
+    QIpack ipack;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-int main(int argc, char **argv)
+/* tpci200 */
+static void *tpci200_get_driver(void *obj, const char *interface)
 {
-    int ret;
+    QTpci200 *tpci200 = obj;
+    if (!g_strcmp0(interface, "ipack")) {
+        return &tpci200->ipack;
+    }
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/tpci200/nop", nop);
+    fprintf(stderr, "%s not present in tpci200\n", interface);
+    g_assert_not_reached();
+}
 
-    qtest_start("-device tpci200");
-    ret = g_test_run();
+static void tpci200_destructor(QOSGraphObject *obj)
+{
+    QTpci200 *tpci200 = (QTpci200 *) obj;
+    g_free(tpci200);
+}
 
-    qtest_end();
+static void *tpci200_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QTpci200 *tpci200 = g_new0(QTpci200, 1);
+    tpci200->obj.destructor = tpci200_destructor;
+    tpci200->obj.get_driver = tpci200_get_driver;
 
-    return ret;
+    return &tpci200->obj;
 }
+
+static void tpci200_register_nodes(void)
+{
+    qos_node_create_driver("tpci200", tpci200_create);
+    qos_node_consumes("tpci200", "pci-bus", &(QOSGraphEdgeOptions) {
+        .extra_device_opts = "id=ipack0",
+    });
+    qos_node_produces("tpci200", "ipack");
+}
+
+libqos_init(tpci200_register_nodes);
+
+static void register_tpci200_test(void)
+{
+    qos_add_test("tpci200-test", "tpci200", nop, NULL);
+}
+
+libqos_init(register_tpci200_test);
-- 
2.17.1
