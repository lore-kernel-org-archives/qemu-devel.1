Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19h-0002C1-2O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19c-0006nE-0A
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ey19b-0006ma-P2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 19 Mar 2018 17:12:50 -0300
Message-Id: <20180319201255.9317-3-ehabkost@redhat.com>
In-Reply-To: <20180319201255.9317-1-ehabkost@redhat.com>
References: <20180319201255.9317-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v3 2/7] tests: add machine 'none' with -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Igor Mammedov <imammedo@redhat.com>

Check that "$QEMU -M none -cpu FOO" starts QEMU without error

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1518000027-274608-3-git-send-email-imammedo@redhat.com>
[ehabkost: include qmp/qdict.h instead of qmp/types.h]
[ehabkost: add riscv targets to machine-none-test]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/machine-none-test.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |   2 +
 2 files changed, 105 insertions(+)
 create mode 100644 tests/machine-none-test.c

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
new file mode 100644
index 0000000000..efdd4be986
--- /dev/null
+++ b/tests/machine-none-test.c
@@ -0,0 +1,103 @@
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
+    { "riscv64", "rv64gcsu-v1.10.0" },
+    { "riscv32", "rv32gcsu-v1.9.1" },
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
index 42fd426cd0..8a9116834a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -400,6 +400,7 @@ check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
+check-qtest-generic-y += tests/machine-none-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
@@ -797,6 +798,7 @@ tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
+tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
-- 
2.14.3
