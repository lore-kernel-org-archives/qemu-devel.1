Received: from eggs.gnu.org ([2001:4830:134:3::10]:44060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tH-0007ht-S6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9tG-0002lO-Q0
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:59 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:39 +0200
Message-Id: <20180813101453.10200-20-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 19/33] tests/qgraph: virtio-console test node
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

Convert tests/virtio-console-test in qgraph test node,
virtio-console-test. This test consumes a virtio-serial interface
and checks that its function return the expected values.

Note that this test does not allocate any virtio-console structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include      |  5 +++--
 tests/libqos/virtio.c       |  1 +
 tests/virtio-console-test.c | 30 +++++++++++++++---------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 409475eafd..a160059758 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -187,7 +187,6 @@ gcov-files-ipack-y += hw/ipack/ipack.c
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 gcov-files-ipack-y += hw/char/ipoctal232.c
 
-check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 gcov-files-virtioserial-y += hw/char/virtio-console.c
 
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
@@ -398,6 +397,8 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
@@ -781,6 +782,7 @@ libqgraph-pci-obj-y += tests/libqos/e1000e.o
 libqgraph-tests-obj-y = $(libqgraph-pci-obj-y)
 libqgraph-tests-obj-y += tests/sdhci-test.o
 libqgraph-tests-obj-y += tests/e1000e-test.o
+libqgraph-tests-obj-y += tests/virtio-console-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -831,7 +833,6 @@ tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
 tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o $(libqos-virtio-obj-y)
-tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index c1ff0206d5..6c2124523e 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -352,6 +352,7 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
 /*
  * qvirtio_get_dev_type:
  * Returns: the preferred virtio bus/device type for the current architecture.
+ * TODO: delete this
  */
 const char *qvirtio_get_dev_type(void)
 {
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 945bae5a15..336078f1c0 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -10,29 +10,29 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
+#include "libqos/qgraph.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void console_nop(void)
+static void console_nop(void *obj, void *data, QGuestAllocator *alloc)
 {
-    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
-                                "-device virtconsole,bus=vser0.0",
-                                qvirtio_get_dev_type());
-    qtest_end();
+    /* no operation */
 }
 
-static void serialport_nop(void)
+static void serialport_nop(void *obj, void *data, QGuestAllocator *alloc)
 {
-    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
-                                "-device virtserialport,bus=vser0.0",
-                                qvirtio_get_dev_type());
-    qtest_end();
+    /* no operation */
 }
 
-int main(int argc, char **argv)
+static void register_virtio_console_test(void)
 {
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/console/nop", console_nop);
-    qtest_add_func("/virtio/serialport/nop", serialport_nop);
+    QOSGraphTestOptions opts = { };
+    QOSGraphEdgeOptions *edge_opts = &opts.edge;
 
-    return g_test_run();
+    edge_opts->before_cmd_line = "-device virtconsole,bus=vser0.0";
+    qos_add_test("console-nop", "virtio-serial", console_nop, &opts);
+
+    edge_opts->before_cmd_line = "-device virtserialport,bus=vser0.0";
+    qos_add_test("serialport-nop", "virtio-serial", serialport_nop, &opts);
 }
+
+libqos_init(register_virtio_console_test);
-- 
2.17.1
