Received: from eggs.gnu.org ([2001:4830:134:3::10]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritM-0005tT-AU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritL-0002Y0-95
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:40 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:07 +0200
Message-Id: <20180820120213.11095-11-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 10/16] test/qgraph: pcnet test node
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

Convert tests/pcnet-test in qgraph test node,
pcnet-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/pcnet-test.c     | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 62e74b28d1..1a2b645209 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -207,7 +207,6 @@ gcov-files-pci-y += hw/net/e1000.c
 gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
 check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
 gcov-files-pci-y += hw/net/rtl8139.c
-check-qtest-pci-y += tests/pcnet-test$(EXESUF)
 gcov-files-pci-y += hw/net/pcnet.c
 gcov-files-pci-y += hw/net/pcnet-pci.c
 check-qtest-pci-y += tests/eepro100-test$(EXESUF)
@@ -793,6 +792,7 @@ libqgraph-tests-obj-y += tests/tpci200-test.o
 libqgraph-tests-obj-y += tests/ipoctal232-test.o
 libqgraph-tests-obj-y += tests/ne2000-test.o
 libqgraph-tests-obj-y += tests/nvme-test.o
+libqgraph-tests-obj-y += tests/pcnet-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -828,7 +828,6 @@ tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
 tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
 tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
-tests/pcnet-test$(EXESUF): tests/pcnet-test.o
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
 tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index efb1ef44e9..0f89d6510b 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -9,23 +9,44 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QPcnet QPcnet;
+
+struct QPcnet {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void pci_nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void pcnet_destructor(QOSGraphObject *obj)
 {
+    QPcnet *pcnet = (QPcnet *)obj;
+    g_free(pcnet);
 }
 
-int main(int argc, char **argv)
+static void *pcnet_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QPcnet *pcnet = g_new0(QPcnet, 1);
+    pcnet->obj.destructor = pcnet_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/pcnet/pci/nop", pci_nop);
+    return &pcnet->obj;
+}
 
-    qtest_start("-device pcnet");
-    ret = g_test_run();
+static void pcnet_register_nodes(void)
+{
+    qos_node_create_driver("pcnet", pcnet_create);
+    qos_node_consumes("pcnet", "pci-bus", NULL);
+}
 
-    qtest_end();
+libqos_init(pcnet_register_nodes);
 
-    return ret;
+static void register_pcnet_test(void)
+{
+    qos_add_test("pcnet-test", "pcnet", pci_nop, NULL);
 }
+
+libqos_init(register_pcnet_test);
-- 
2.17.1
