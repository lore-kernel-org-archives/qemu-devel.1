Received: from eggs.gnu.org ([2001:4830:134:3::10]:60988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritL-0005si-Ns
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritJ-0002Wz-Kx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:39 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:06 +0200
Message-Id: <20180820120213.11095-10-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 09/16] test/qgraph: nvme test node
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

Convert tests/nvme-test in qgraph test node,
nvme-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/nvme-test.c      | 43 ++++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index dea79797c5..62e74b28d1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -213,7 +213,6 @@ gcov-files-pci-y += hw/net/pcnet-pci.c
 check-qtest-pci-y += tests/eepro100-test$(EXESUF)
 gcov-files-pci-y += hw/net/eepro100.c
 gcov-files-pci-y += hw/net/ne2000.c
-check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
 gcov-files-pci-y += hw/audio/ac97.c
 check-qtest-pci-y += tests/es1370-test$(EXESUF)
@@ -793,6 +792,7 @@ libqgraph-tests-obj-y += tests/ac97-test.o
 libqgraph-tests-obj-y += tests/tpci200-test.o
 libqgraph-tests-obj-y += tests/ipoctal232-test.o
 libqgraph-tests-obj-y += tests/ne2000-test.o
+libqgraph-tests-obj-y += tests/nvme-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -841,7 +841,6 @@ tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
-tests/nvme-test$(EXESUF): tests/nvme-test.o
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 7674a446e4..f6209e45cb 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -9,24 +9,47 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QNvme QNvme;
+
+struct QNvme {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void nvme_destructor(QOSGraphObject *obj)
 {
+    QNvme *nvme = (QNvme *)obj;
+    g_free(nvme);
 }
 
-int main(int argc, char **argv)
+static void *nvme_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QNvme *nvme = g_new0(QNvme, 1);
+    nvme->obj.destructor = nvme_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/nvme/nop", nop);
+    return &nvme->obj;
+}
 
-    qtest_start("-drive id=drv0,if=none,file=null-co://,format=raw "
-                "-device nvme,drive=drv0,serial=foo");
-    ret = g_test_run();
+static void nvme_register_nodes(void)
+{
+    qos_node_create_driver("nvme", nvme_create);
+    qos_node_consumes("nvme", "pci-bus", &(QOSGraphEdgeOptions) {
+        .extra_device_opts = "drive=drv0,serial=foo",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+    });
+}
 
-    qtest_end();
+libqos_init(nvme_register_nodes);
 
-    return ret;
+static void register_nvme_test(void)
+{
+    qos_add_test("nvme-test", "nvme", nop, NULL);
 }
+
+libqos_init(register_nvme_test);
-- 
2.17.1
