Received: from eggs.gnu.org ([209.51.188.92]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqv-0003MT-QP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqt-0008DM-Un
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqr-0008Ao-Ri
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id j125so10118377wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:34 +0100
Message-Id: <1551979804-6060-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/57] qos-test: virtio-console and
 virtio-serial test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/virtio-console-test and tests/virtio-serial-test
in qgraph test node. This test consumes a virtio-serial interface
and checks that its function return the expected values.

Note that this test does not allocate any virtio-console or
virtio-serial structure, it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include      | 18 +++++++-----------
 tests/libqos/virtio.c       |  1 +
 tests/virtio-console-test.c | 38 --------------------------------------
 tests/virtio-serial-test.c  | 27 ++++++++++++---------------
 4 files changed, 20 insertions(+), 64 deletions(-)
 delete mode 100644 tests/virtio-console-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2a51cab..d0cd6d2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -153,18 +153,14 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
-check-qtest-virtioserial-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-console-test$(EXESUF)
-
-check-qtest-virtio-$(CONFIG_VIRTIO_NET) += tests/virtio-net-test$(EXESUF)
-check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
-check-qtest-virtio-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
-check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) += tests/virtio-scsi-test$(EXESUF)
+check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
+check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
+check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
+check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
+check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-$(CONFIG_VIRTIO_9P) += tests/virtio-9p-test$(EXESUF)
 endif
-check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-serial-test$(EXESUF)
-check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
@@ -315,6 +311,7 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/device-plug-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-s390x-y += tests/migration-test$(EXESUF)
 
@@ -768,6 +765,7 @@ qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
+qos-test-obj-y += tests/virtio-serial-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -820,8 +818,6 @@ tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(lib
 tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
-tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o $(libqos-virtio-obj-y)
-tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 5a62950..9fc8c7e 100644
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
deleted file mode 100644
index a7c6f16..0000000
--- a/tests/virtio-console-test.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * QTest testcase for VirtIO Console
- *
- * Copyright (c) 2014 SUSE LINUX Products GmbH
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "libqtest.h"
-#include "libqos/virtio.h"
-
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void console_nop(void)
-{
-    global_qtest = qtest_initf("-device virtio-serial-%s,id=vser0 "
-                               "-device virtconsole,bus=vser0.0",
-                               qvirtio_get_dev_type());
-    qtest_end();
-}
-
-static void serialport_nop(void)
-{
-    global_qtest = qtest_initf("-device virtio-serial-%s,id=vser0 "
-                               "-device virtserialport,bus=vser0.0",
-                               qvirtio_get_dev_type());
-    qtest_end();
-}
-
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/console/nop", console_nop);
-    qtest_add_func("/virtio/serialport/nop", serialport_nop);
-
-    return g_test_run();
-}
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 8da9980..85f35e0 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -9,33 +9,30 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/virtio.h"
+#include "libqos/virtio-serial.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void virtio_serial_nop(void)
+static void virtio_serial_nop(void *obj, void *data, QGuestAllocator *alloc)
 {
+    /* no operation */
 }
 
-static void hotplug(void)
+static void serial_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
     qtest_qmp_device_add("virtserialport", "hp-port", "{}");
-
     qtest_qmp_device_del("hp-port");
 }
 
-int main(int argc, char **argv)
+static void register_virtio_serial_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
-    qtest_add_func("/virtio/serial/hotplug", hotplug);
+    QOSGraphTestOptions opts = { };
 
-    global_qtest = qtest_initf("-device virtio-serial-%s",
-                               qvirtio_get_dev_type());
-    ret = g_test_run();
+    opts.edge.before_cmd_line = "-device virtconsole,bus=vser0.0";
+    qos_add_test("console-nop", "virtio-serial", virtio_serial_nop, &opts);
 
-    qtest_end();
+    opts.edge.before_cmd_line = "-device virtserialport,bus=vser0.0";
+    qos_add_test("serialport-nop", "virtio-serial", virtio_serial_nop, &opts);
 
-    return ret;
+    qos_add_test("hotplug", "virtio-serial", serial_hotplug, NULL);
 }
+libqos_init(register_virtio_serial_test);
-- 
1.8.3.1
