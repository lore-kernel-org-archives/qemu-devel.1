Received: from eggs.gnu.org ([2001:4830:134:3::10]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritT-00062u-R6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritS-0002eZ-Q9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:47 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:11 +0200
Message-Id: <20180820120213.11095-15-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 14/16] test/qgraph: es1370 test node
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

Convert tests/es1370-test in qgraph test node,
es1370-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/es1370-test.c    | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9370f79f2c..46ef183c5f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -214,7 +214,6 @@ gcov-files-pci-y += hw/net/eepro100.c
 gcov-files-pci-y += hw/net/ne2000.c
 gcov-files-pci-y += hw/block/nvme.c
 gcov-files-pci-y += hw/audio/ac97.c
-check-qtest-pci-y += tests/es1370-test$(EXESUF)
 gcov-files-pci-y += hw/audio/es1370.c
 check-qtest-pci-y += $(check-qtest-virtio-y)
 gcov-files-pci-y += $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
@@ -792,6 +791,7 @@ libqgraph-tests-obj-y += tests/pcnet-test.o
 libqgraph-tests-obj-y += tests/spapr-phb-test.o
 libqgraph-tests-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 libqgraph-tests-obj-y += tests/vmxnet3-test.o
+libqgraph-tests-obj-y += tests/es1370-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -839,7 +839,6 @@ tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index 199fe193ce..a734dbe404 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -9,23 +9,44 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QES1370 QES1370;
+
+struct QES1370 {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void es1370_destructor(QOSGraphObject *obj)
 {
+    QES1370 *es1370 = (QES1370 *)obj;
+    g_free(es1370);
 }
 
-int main(int argc, char **argv)
+static void *es1370_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QES1370 *es1370 = g_new0(QES1370, 1);
+    es1370->obj.destructor = es1370_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/es1370/nop", nop);
+    return &es1370->obj;
+}
 
-    qtest_start("-device ES1370");
-    ret = g_test_run();
+static void es1370_register_nodes(void)
+{
+    qos_node_create_driver("ES1370", es1370_create);
+    qos_node_consumes("ES1370", "pci-bus", NULL);
+}
 
-    qtest_end();
+libqos_init(es1370_register_nodes);
 
-    return ret;
+static void register_es1370_test(void)
+{
+    qos_add_test("es1370-test", "ES1370", nop, NULL);
 }
+
+libqos_init(register_es1370_test);
-- 
2.17.1
