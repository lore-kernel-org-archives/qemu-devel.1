Received: from eggs.gnu.org ([2001:4830:134:3::10]:60887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001An-8p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3o-0005gC-As
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3n-0005MN-60
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:15 -0400
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so3614594wmb.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:05 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:33 +0200
Message-Id: <1534870966-9287-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/74] tests: virtio: separate ccw tests from
 libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Because qtest does not support s390 channel I/O, s390 only performs smoke tests on
those few devices that do not have any functional tests.  Therefore, every time we
add functional tests for a virtio device, the choice is between removing
those tests from the s390 suite (so that s390 actually _loses_ coverage)
or sprinkling the test with architecture checks.

This patch simply creates a ccw-specific test that only performs smoke tests on
all virtio-ccw devices.  If channel I/O support is ever added to qtest and libqos,
then this file can go away.  In the meanwhile, it simplifies maintenance and
makes sure that all virtio devices are tested.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |   5 +--
 tests/virtio-ccw-test.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 tests/virtio-ccw-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 760a0f1..29e70f4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -402,9 +402,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
@@ -809,6 +807,7 @@ tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libqos-virtio-obj-y)
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
+tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
 tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
diff --git a/tests/virtio-ccw-test.c b/tests/virtio-ccw-test.c
new file mode 100644
index 0000000..48c714d
--- /dev/null
+++ b/tests/virtio-ccw-test.c
@@ -0,0 +1,110 @@
+/*
+ * QTest testcase for VirtIO CCW
+ *
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/* Until we have a full libqos implementation of virtio-ccw (which requires
+ * also to add support for I/O channels to qtest), we can only do simple
+ * tests that initialize the devices.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/virtio.h"
+
+static void virtio_balloon_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-balloon-ccw");
+    qtest_end();
+}
+
+static void virtconsole_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-serial-ccw,id=vser0 "
+                                "-device virtconsole,bus=vser0.0");
+    qtest_end();
+}
+
+static void virtserialport_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-serial-ccw,id=vser0 "
+                                "-device virtserialport,bus=vser0.0");
+    qtest_end();
+}
+
+static void virtio_serial_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-serial-ccw");
+    qtest_end();
+}
+
+static void virtio_serial_hotplug(void)
+{
+    global_qtest = qtest_initf("-device virtio-serial-ccw");
+    qtest_qmp_device_add("virtserialport", "hp-port", "{}");
+    qtest_qmp_device_del("hp-port");
+    qtest_end();
+}
+
+static void virtio_blk_nop(void)
+{
+    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,format=raw "
+                                "-device virtio-blk-ccw,drive=drv0");
+    qtest_end();
+}
+
+static void virtio_net_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-net-ccw");
+    qtest_end();
+}
+
+static void virtio_rng_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-rng-ccw");
+    qtest_end();
+}
+
+static void virtio_scsi_nop(void)
+{
+    global_qtest = qtest_initf("-device virtio-scsi-ccw");
+    qtest_end();
+}
+
+static void virtio_scsi_hotplug(void)
+{
+    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,format=raw "
+                                "-drive if=none,id=drv1,file=null-co://,format=raw "
+                                "-device virtio-scsi-ccw "
+                                "-device scsi-hd,drive=drv0");
+    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
+    qtest_qmp_device_del("scsihd");
+
+    qtest_end();
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/virtio/balloon/nop", virtio_balloon_nop);
+    qtest_add_func("/virtio/console/nop", virtconsole_nop);
+    qtest_add_func("/virtio/serialport/nop", virtserialport_nop);
+    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
+    qtest_add_func("/virtio/serial/hotplug", virtio_serial_hotplug);
+    qtest_add_func("/virtio/block/nop", virtio_blk_nop);
+    qtest_add_func("/virtio/net/nop", virtio_net_nop);
+    qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
+    qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
+    qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
+
+    ret = g_test_run();
+
+    return ret;
+}
-- 
1.8.3.1
