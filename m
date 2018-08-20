Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritK-0005rC-AM
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritH-0002W3-Mc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:36 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:05 +0200
Message-Id: <20180820120213.11095-9-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 08/16] test/qgraph: ne2k_pci test node
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

Convert tests/ne2000-test in qgraph test node,
ne2000-test. Since it's a nop test, node creation and
initialization is made in the same file.

The actual device consumed by the test is ne2k_pci.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/ne2000-test.c    | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6a7848bd34..dea79797c5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -212,7 +212,6 @@ gcov-files-pci-y += hw/net/pcnet.c
 gcov-files-pci-y += hw/net/pcnet-pci.c
 check-qtest-pci-y += tests/eepro100-test$(EXESUF)
 gcov-files-pci-y += hw/net/eepro100.c
-check-qtest-pci-y += tests/ne2000-test$(EXESUF)
 gcov-files-pci-y += hw/net/ne2000.c
 check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
@@ -793,6 +792,7 @@ libqgraph-tests-obj-y += tests/virtio-scsi-test.o
 libqgraph-tests-obj-y += tests/ac97-test.o
 libqgraph-tests-obj-y += tests/tpci200-test.o
 libqgraph-tests-obj-y += tests/ipoctal232-test.o
+libqgraph-tests-obj-y += tests/ne2000-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -832,7 +832,6 @@ tests/pcnet-test$(EXESUF): tests/pcnet-test.o
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
-tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index b7cf3dd2f5..aeb2232e2a 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -9,23 +9,44 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QNe2k_pci QNe2k_pci;
+
+struct QNe2k_pci {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void pci_nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void ne2k_pci_destructor(QOSGraphObject *obj)
 {
+    QNe2k_pci *ne2k_pci = (QNe2k_pci *)obj;
+    g_free(ne2k_pci);
 }
 
-int main(int argc, char **argv)
+static void *ne2k_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QNe2k_pci *ne2k_pci = g_new0(QNe2k_pci, 1);
+    ne2k_pci->obj.destructor = ne2k_pci_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ne2000/pci/nop", pci_nop);
+    return &ne2k_pci->obj;
+}
 
-    qtest_start("-device ne2k_pci");
-    ret = g_test_run();
+static void ne2000_register_nodes(void)
+{
+    qos_node_create_driver("ne2k_pci", ne2k_pci_create);
+    qos_node_consumes("ne2k_pci", "pci-bus", NULL);
+}
 
-    qtest_end();
+libqos_init(ne2000_register_nodes);
 
-    return ret;
+static void register_ne2000_test(void)
+{
+    qos_add_test("ne2000-test", "ne2k_pci", pci_nop, NULL);
 }
+
+libqos_init(register_ne2000_test);
\ No newline at end of file
-- 
2.17.1
