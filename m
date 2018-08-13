Received: from eggs.gnu.org ([2001:4830:134:3::10]:44304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tW-0007rt-9n
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tT-0002u0-Kj
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:14 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:46 +0200
Message-Id: <20180813101453.10200-27-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 26/33] tests/qgraph: virtio-rng test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/virtio-rng-test in qgraph test node,
virtio-rng-test. This test consumes a virtio-rng interface
and checks that its function return the expected values.

Some functions are implemented only for virtio-rng-pci, so they
don't consume virtio-rng, but virtio-rng-pci

Note that this test does not allocate any virtio-rng structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include  |  3 +--
 tests/virtio-rng-test.c | 25 +++++++++----------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 162187d15b..cc1e1396f1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -195,7 +195,6 @@ gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
 gcov-files-virtio-y += hw/virtio/virtio-rng.c
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
@@ -784,6 +783,7 @@ libqgraph-tests-obj-y += tests/virtio-serial-test.o
 libqgraph-tests-obj-y += tests/virtio-console-test.o
 libqgraph-tests-obj-y += tests/virtio-9p-test.o
 libqgraph-tests-obj-y += tests/virtio-balloon-test.o
+libqgraph-tests-obj-y += tests/virtio-rng-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -829,7 +829,6 @@ tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
-tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index dcecf77463..fd67922b66 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -9,16 +9,17 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/pci.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-rng.h"
 
 #define PCI_SLOT_HP             0x06
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-static void hotplug(void)
+static void rng_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
     const char *arch = qtest_get_arch();
 
@@ -29,18 +30,10 @@ static void hotplug(void)
     }
 }
 
-int main(int argc, char **argv)
+static void register_virtio_rng_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/rng/pci/nop", pci_nop);
-    qtest_add_func("/virtio/rng/pci/hotplug", hotplug);
-
-    qtest_start("-device virtio-rng-pci");
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("rng-nop", "virtio-rng", nop, NULL);
+    qos_add_test("rng-hotplug", "virtio-rng-pci", rng_hotplug, NULL);
 }
+
+libqos_init(register_virtio_rng_test);
-- 
2.17.1
