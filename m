Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritE-0005ng-9F
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritC-0002TV-6o
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:32 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:02 +0200
Message-Id: <20180820120213.11095-6-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 05/16] test/qgraph: ac97 test node
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

Convert tests/ac97-test in qgraph test node,
ac97-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/ac97-test.c      | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bad4de3d61..3e5964263e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -217,7 +217,6 @@ check-qtest-pci-y += tests/ne2000-test$(EXESUF)
 gcov-files-pci-y += hw/net/ne2000.c
 check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
-check-qtest-pci-y += tests/ac97-test$(EXESUF)
 gcov-files-pci-y += hw/audio/ac97.c
 check-qtest-pci-y += tests/es1370-test$(EXESUF)
 gcov-files-pci-y += hw/audio/es1370.c
@@ -792,6 +791,7 @@ libqgraph-tests-obj-y += tests/virtio-rng-test.o
 libqgraph-tests-obj-y += tests/virtio-blk-test.o
 libqgraph-tests-obj-y += tests/virtio-net-test.o
 libqgraph-tests-obj-y += tests/virtio-scsi-test.o
+libqgraph-tests-obj-y += tests/ac97-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -846,7 +846,6 @@ tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-tests/ac97-test$(EXESUF): tests/ac97-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index e0d177bd9c..1928424250 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -9,23 +9,44 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
+
+typedef struct QAC97 QAC97;
+
+struct QAC97 {
+    QOSGraphObject obj;
+};
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void ac97_destructor(QOSGraphObject *obj)
 {
+    QAC97 *ac97 = (QAC97 *)obj;
+    g_free(ac97);
 }
 
-int main(int argc, char **argv)
+static void *ac97_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QAC97 *ac97 = g_new0(QAC97, 1);
+    ac97->obj.destructor = ac97_destructor;
 
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ac97/nop", nop);
+    return &ac97->obj;
+}
 
-    qtest_start("-device AC97");
-    ret = g_test_run();
+static void ac97_register_nodes(void)
+{
+    qos_node_create_driver("AC97", ac97_create);
+    qos_node_consumes("AC97", "pci-bus", NULL);
+}
 
-    qtest_end();
+libqos_init(ac97_register_nodes);
 
-    return ret;
+static void register_ac97_test(void)
+{
+    qos_add_test("ac97-test", "AC97", nop, NULL);
 }
+
+libqos_init(register_ac97_test);
-- 
2.17.1
