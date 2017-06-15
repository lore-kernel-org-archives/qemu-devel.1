Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOv-0008B1-6W
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOt-0007V7-La
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:21 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOt-0007Ui-Es
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:19 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so16384326wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:19 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:27 +0200
Message-Id: <1497523981-38449-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/41] megasas: add qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +++
 tests/megasas-test.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tests/megasas-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3df..77da9b7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -205,6 +205,8 @@ check-qtest-pci-y += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-y += hw/audio/intel-hda.c hw/audio/hda-codec.c
 check-qtest-pci-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-y += hw/misc/ivshmem.c
+check-qtest-pci-y += tests/megasas-test$(EXESUF)
+gcov-files-pci-y += hw/scsi/megasas.c
 
 check-qtest-i386-y = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
@@ -755,6 +757,7 @@ tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/megasas-test$(EXESUF): tests/megasas-test.o $(libqos-spapr-obj-y) $(libqos-pc-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
new file mode 100644
index 0000000..a9e56a2
--- /dev/null
+++ b/tests/megasas-test.c
@@ -0,0 +1,51 @@
+/*
+ * QTest testcase for LSI MegaRAID
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bswap.h"
+#include "libqos/libqos-pc.h"
+#include "libqos/libqos-spapr.h"
+
+static QOSState *qmegasas_start(const char *extra_opts)
+{
+    const char *arch = qtest_get_arch();
+    const char *cmd = "-drive id=hd0,if=none,file=null-co://,format=raw "
+                      "-device megasas,id=scsi0,addr=04.0 "
+                      "-device scsi-hd,bus=scsi0.0,drive=hd0 %s";
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        return qtest_pc_boot(cmd, extra_opts ? : "");
+    }
+
+    g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
+    exit(EXIT_FAILURE);
+}
+
+static void qmegasas_stop(QOSState *qs)
+{
+    qtest_shutdown(qs);
+}
+
+/* Tests only initialization so far. TODO: Replace with functional tests */
+static void pci_nop(void)
+{
+    QOSState *qs;
+
+    qs = qmegasas_start(NULL);
+    qmegasas_stop(qs);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/megasas/pci/nop", pci_nop);
+
+    return g_test_run();
+}
-- 
1.8.3.1
