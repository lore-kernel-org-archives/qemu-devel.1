Received: from eggs.gnu.org ([2001:4830:134:3::10]:32902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritS-000619-Bd
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritQ-0002bU-UC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:46 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:10 +0200
Message-Id: <20180820120213.11095-14-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 13/16] test/qgraph: vmxnet3 test node
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

Convert tests/vmxnet3-test in qgraph test node,
vmxnet3-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/vmxnet3-test.c   | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e60890adb9..9370f79f2c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -258,7 +258,6 @@ check-qtest-i386-y += tests/tco-test$(EXESUF)
 gcov-files-i386-y += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
 check-qtest-i386-y += $(check-qtest-pci-y)
 gcov-files-i386-y += $(gcov-files-pci-y)
-check-qtest-i386-y += tests/vmxnet3-test$(EXESUF)
 gcov-files-i386-y += hw/net/vmxnet3.c
 gcov-files-i386-y += hw/net/net_rx_pkt.c
 gcov-files-i386-y += hw/net/net_tx_pkt.c
@@ -792,6 +791,7 @@ libqgraph-tests-obj-y += tests/nvme-test.o
 libqgraph-tests-obj-y += tests/pcnet-test.o
 libqgraph-tests-obj-y += tests/spapr-phb-test.o
 libqgraph-tests-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
+libqgraph-tests-obj-y += tests/vmxnet3-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -828,7 +828,6 @@ tests/e1000-test$(EXESUF): tests/e1000-test.o
 tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
 tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
 tests/eepro100-test$(EXESUF): tests/eepro100-test.o
-tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 159c0ad728..2bbd0352fa 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -9,23 +9,44 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QVmxnet3 QVmxnet3;
+
+struct QVmxnet3 {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void vmxnet3_destructor(QOSGraphObject *obj)
 {
+    QVmxnet3 *vmxnet3 = (QVmxnet3 *)obj;
+    g_free(vmxnet3);
 }
 
-int main(int argc, char **argv)
+static void *vmxnet3_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QVmxnet3 *vmxnet3 = g_new0(QVmxnet3, 1);
+    vmxnet3->obj.destructor = vmxnet3_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/vmxnet3/nop", nop);
+    return &vmxnet3->obj;
+}
 
-    qtest_start("-device vmxnet3");
-    ret = g_test_run();
+static void vmxnet3_register_nodes(void)
+{
+    qos_node_create_driver("vmxnet3", vmxnet3_create);
+    qos_node_consumes("vmxnet3", "pci-bus", NULL);
+}
 
-    qtest_end();
+libqos_init(vmxnet3_register_nodes);
 
-    return ret;
+static void register_vmxnet3_test(void)
+{
+    qos_add_test("vmxnet3-test", "vmxnet3", nop, NULL);
 }
+
+libqos_init(register_vmxnet3_test);
-- 
2.17.1
