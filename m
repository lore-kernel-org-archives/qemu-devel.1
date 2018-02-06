Received: from eggs.gnu.org ([2001:4830:134:3::10]:45049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uL-0001R0-Gu
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uI-0003Nu-6Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:01 -0500
Received: from mail-eopbgr00094.outbound.protection.outlook.com
	([40.107.0.94]:23680
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uH-0003NA-Sk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:58 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:41 +0300
Message-Id: <20180206203048.11096-28-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 27/34] tests: hv-scsi: add start-stop test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

It's trivial and tests only a tiny fraction of the relevant code, but
it's better than nothing.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/hv-scsi-test.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  3 +++
 2 files changed, 60 insertions(+)
 create mode 100644 tests/hv-scsi-test.c

diff --git a/tests/hv-scsi-test.c b/tests/hv-scsi-test.c
new file mode 100644
index 0000000000..9bff0df09c
--- /dev/null
+++ b/tests/hv-scsi-test.c
@@ -0,0 +1,57 @@
+/*
+ * QTest testcase for Hyper-V/VMBus SCSI
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bswap.h"
+#include "libqos/libqos-pc.h"
+
+static QOSState *qhv_scsi_start(const char *extra_opts)
+{
+    const char *arch = qtest_get_arch();
+    const char *cmd = "-machine accel=kvm,vmbus "
+                      "-cpu kvm64,hv_synic,hv_vpindex "
+                      "-drive id=hd0,if=none,file=null-co://,format=raw "
+                      "-device hv-scsi,id=scsi0 "
+                      "-device scsi-hd,bus=scsi0.0,drive=hd0 %s";
+
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_printerr("Hyper-V / VMBus are only available on x86\n");
+        exit(EXIT_FAILURE);
+    }
+
+    if (access("/dev/kvm", R_OK | W_OK)) {
+        g_printerr("Hyper-V / VMBus can only be used with KVM\n");
+        exit(EXIT_FAILURE);
+    }
+
+    return qtest_pc_boot(cmd, extra_opts ? : "");
+}
+
+static void qhv_scsi_stop(QOSState *qs)
+{
+    qtest_shutdown(qs);
+}
+
+static void start_stop(void)
+{
+    QOSState *qs;
+
+    qs = qhv_scsi_start(NULL);
+    qhv_scsi_stop(qs);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/hv-scsi/start-stop", start_stop);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca82e0c0cc..800f9cca92 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -281,6 +281,8 @@ gcov-files-i386-y += hw/usb/hcd-xhci.c
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
+check-qtest-i386-y += tests/hv-scsi-test$(EXESUF)
+gcov-files-i386-y += hw/scsi/hv-scsi.c
 gcov-files-i386-y += hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
 ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
@@ -820,6 +822,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
+tests/hv-scsi-test$(EXESUF): tests/hv-scsi-test.o $(libqos-pc-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
2.14.3
