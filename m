Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2i-0004H5-FM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2h-0003xo-DF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evW2h-0003wm-5T
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:34:51 -0300
Message-Id: <20180312223455.18124-4-ehabkost@redhat.com>
In-Reply-To: <20180312223455.18124-1-ehabkost@redhat.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] tests: add machine 'none' with -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Check that "$QEMU -M none -cpu FOO" starts QEMU without error

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1518000027-274608-3-git-send-email-imammedo@redhat.com>
[ehabkost: include qmp/qdict.h instead of qmp/types.h]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/machine-none-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |   2 +
 2 files changed, 103 insertions(+)
 create mode 100644 tests/machine-none-test.c

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
new file mode 100644
index 0000000000..596ad0153b
--- /dev/null
+++ b/tests/machine-none-test.c
@@ -0,0 +1,101 @@
+/*
+ * Machine 'none' tests.
+ *
+ * Copyright (c) 2018 Red Hat Inc.
+ *
+ * Authors:
+ *  Igor Mammedov <imammedo@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+
+
+struct arch2cpu {
+    const char *arch;
+    const char *cpu_model;
+};
+
+static struct arch2cpu cpus_map[] = {
+    /* tested targets list */
+    { "arm", "cortex-a15" },
+    { "aarch64", "cortex-a57" },
+    { "x86_64", "qemu64,apic-id=0" },
+    { "i386", "qemu32,apic-id=0" },
+    { "alpha", "ev67" },
+    { "cris", "crisv32" },
+    { "lm32", "lm32-full" },
+    { "m68k", "m5206" },
+    /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
+    /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
+    { "mips", "4Kc" },
+    { "mipsel", "4Kc" },
+    { "mips64", "20Kc" },
+    { "mips64el", "20Kc" },
+    { "moxie", "MoxieLite" },
+    { "nios2", "FIXME" },
+    { "or1k", "or1200" },
+    { "ppc", "604" },
+    { "ppc64", "power8e_v2.1" },
+    { "ppcemb", "440epb" },
+    { "s390x", "qemu" },
+    { "sh4", "sh7750r" },
+    { "sh4eb", "sh7751r" },
+    { "sparc", "LEON2" },
+    { "sparc64", "Fujitsu Sparc64" },
+    { "tricore", "tc1796" },
+    { "unicore32", "UniCore-II" },
+    { "xtensa", "dc233c" },
+    { "xtensaeb", "fsf" },
+    { "hppa", "hppa" },
+};
+
+static const char *get_cpu_model_by_arch(const char *arch)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(cpus_map); i++) {
+        if (!strcmp(arch, cpus_map[i].arch)) {
+            return cpus_map[i].cpu_model;
+        }
+    }
+    return NULL;
+}
+
+static void test_machine_cpu_cli(void)
+{
+    QDict *response;
+    const char *arch = qtest_get_arch();
+    const char *cpu_model = get_cpu_model_by_arch(arch);
+
+    if (!cpu_model) {
+        if (!(!strcmp(arch, "microblaze") || !strcmp(arch, "microblazeel"))) {
+            fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
+                    " add it to cpus_map\n", arch);
+        }
+        return; /* TODO: die here to force all targets have a test */
+    }
+    global_qtest = qtest_startf("-machine none -cpu '%s'", cpu_model);
+
+    response = qmp("{ 'execute': 'quit' }");
+    g_assert(qdict_haskey(response, "return"));
+    QDECREF(response);
+
+    qtest_quit(global_qtest);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("machine/none/cpu_option", test_machine_cpu_cli);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c369..b0e3785e0f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -399,6 +399,7 @@ check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
+check-qtest-generic-y += tests/machine-none-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
@@ -794,6 +795,7 @@ tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
+tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
-- 
2.14.3
