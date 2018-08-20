Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritH-0005q6-1f
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritF-0002VB-UX
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:34 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:04 +0200
Message-Id: <20180820120213.11095-8-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 07/16] test/qgraph: ipoctal232 test node
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

Convert tests/ipoctal232-test in qgraph test node,
ipoctal232-test. Since it's a nop test, node creation and
initialization is made in the same file.

This test creates a tpci200 node that produces an interface ipack
consumed by the ipoctal232 device.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include  |  3 +--
 tests/ipoctal232-test.c | 42 ++++++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1daee93de5..6a7848bd34 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -184,7 +184,6 @@ gcov-files-generic-y = qdev-monitor.c qmp.c
 check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 gcov-files-ipack-y += hw/ipack/ipack.c
-check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 gcov-files-ipack-y += hw/char/ipoctal232.c
 
 gcov-files-virtioserial-y += hw/char/virtio-console.c
@@ -793,6 +792,7 @@ libqgraph-tests-obj-y += tests/virtio-net-test.o
 libqgraph-tests-obj-y += tests/virtio-scsi-test.o
 libqgraph-tests-obj-y += tests/ac97-test.o
 libqgraph-tests-obj-y += tests/tpci200-test.o
+libqgraph-tests-obj-y += tests/ipoctal232-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -837,7 +837,6 @@ tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
-tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 684914164d..3514b89107 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -9,23 +9,47 @@
 
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
+{
+}
+
+static void ipoctal232_destructor(QOSGraphObject *obj)
 {
+    QIpoctal232 *ipoctal232 = (QIpoctal232 *) obj;
+    g_free(ipoctal232);
 }
 
-int main(int argc, char **argv)
+static void *ipoctal232_create(void *pci_bus, QGuestAllocator *alloc,
+                               void *addr)
 {
-    int ret;
+    QIpoctal232 *ipoctal232 = g_new0(QIpoctal232, 1);
+    ipoctal232->obj.destructor = ipoctal232_destructor;
 
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
+    qos_add_test("ipoctal232-test", "ipoctal232", nop, NULL);
 }
+
+libqos_init(register_ipoctal232_test);
-- 
2.17.1
