Received: from eggs.gnu.org ([2001:4830:134:3::10]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6T-0004LI-4I
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6S-0007uR-4p
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:35:53 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 Jan 2018 18:33:58 +0100
Message-Id: <1516296842-136976-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/5] tests: add machine 'none' with -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

Check that "$QEMU -M none -cpu FOO" starts QEMU without error

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/Makefile.include |  2 ++
 tests/machine-none.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/machine-none.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8883274..6661149 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 
+check-qtest-generic-y += tests/machine-none$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
@@ -782,6 +783,7 @@ tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
+tests/machine-none$(EXESUF): tests/machine-none.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
diff --git a/tests/machine-none.c b/tests/machine-none.c
new file mode 100644
index 0000000..d16c283
--- /dev/null
+++ b/tests/machine-none.c
@@ -0,0 +1,71 @@
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
+#include "qapi/qmp/types.h"
+
+struct arch2cpu {
+    const char *arch;
+    const char *cpu_model;
+};
+
+static struct arch2cpu cpus_map[] = {
+    /* tested targets list */
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
+    char *args;
+    QDict *response;
+    const char *arch = qtest_get_arch();
+    const char *cpu_model = get_cpu_model_by_arch(arch);
+
+    if (!cpu_model) {
+        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
+                " add it to cpus_map\n", arch);
+        return; /* TODO: die here to force all targets have a test */
+    }
+    args = g_strdup_printf("-machine none -cpu %s", cpu_model);
+    qtest_start(args);
+
+    response = qmp("{ 'execute': 'quit' }");
+    g_assert(qdict_haskey(response, "return"));
+    QDECREF(response);
+
+    qtest_end();
+    g_free(args);
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
-- 
2.7.4
