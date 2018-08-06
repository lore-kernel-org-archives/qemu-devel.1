Received: from eggs.gnu.org ([2001:4830:134:3::10]:35756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb9-00058Y-Iq
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb8-0000xf-EC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:03 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb8-0000xF-3u
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:02 -0400
Received: by mail-ed1-x542.google.com with SMTP id b10-v6so5256955eds.4
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:01 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:58 +0200
Message-Id: <20180806143412.27722-21-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 20/34] test/qgraph: virtio-console test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

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
index ad784a3e84..6742f97058 100644
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
index 56007ef11b..9b97ab0625 100644
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
index 945bae5a15..55d5c0f138 100644
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
+static void virtio_console_test(void)
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
+libqos_init(virtio_console_test);
-- 
2.17.1
