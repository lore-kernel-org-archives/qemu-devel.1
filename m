Received: from eggs.gnu.org ([2001:4830:134:3::10]:44225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tQ-0007os-TH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tP-0002r3-UO
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:08 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:44 +0200
Message-Id: <20180813101453.10200-25-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 24/33] tests/qgraph: virtio-balloon test node
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

Convert tests/virtio-balloon-test in qgraph test node,
virtio-balloon-test. This test consumes a virtio-balloon interface
and checks that its function return the expected values.

Note that this test does not allocate any virtio-balloon structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include      |  4 +---
 tests/virtio-balloon-test.c | 22 +++++++---------------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 362d9ec4b2..b23597972d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -192,7 +192,6 @@ gcov-files-virtioserial-y += hw/char/virtio-console.c
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
-check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
@@ -395,7 +394,6 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
@@ -784,6 +782,7 @@ libqgraph-tests-obj-y += tests/e1000e-test.o
 libqgraph-tests-obj-y += tests/virtio-serial-test.o
 libqgraph-tests-obj-y += tests/virtio-console-test.o
 libqgraph-tests-obj-y += tests/virtio-9p-test.o
+libqgraph-tests-obj-y += tests/virtio-balloon-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -826,7 +825,6 @@ tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
 tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
-tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libqos-virtio-obj-y)
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 0a07e036bb..8499a2349d 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -9,25 +9,17 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/virtio.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-balloon.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void balloon_nop(void)
+static void balloon_nop(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-int main(int argc, char **argv)
+static void register_virtio_balloon_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/balloon/nop", balloon_nop);
-
-    global_qtest = qtest_startf("-device virtio-balloon-%s",
-                                qvirtio_get_dev_type());
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("balloon-nop", "virtio-balloon", balloon_nop, NULL);
 }
+
+libqos_init(register_virtio_balloon_test);
-- 
2.17.1
