Received: from eggs.gnu.org ([2001:4830:134:3::10]:54684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edter-0007Gk-1B
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edteq-0001tI-1u
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:17 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:01 +0100
Message-Id: <1516694904-64879-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/25] tests: add machine 'none' with -cpu
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

Check that "$QEMU -M none -cpu FOO" starts QEMU without error

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - rename file to machine-none-test.c (Thomas Huth <thuth@redhat.com>)
  - use qtest_startf()/instead of qtest_start() (Thomas Huth <thuth@redhat.com>)
---
 tests/Makefile.include    |  2 ++
 tests/machine-none-test.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tests/machine-none-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8883274..ea0a803 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 
+check-qtest-generic-y += tests/machine-none-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
@@ -782,6 +783,7 @@ tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
+tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
new file mode 100644
index 0000000..2eb13e8
--- /dev/null
+++ b/tests/machine-none-test.c
@@ -0,0 +1,68 @@
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
+    QDict *response;
+    const char *arch = qtest_get_arch();
+    const char *cpu_model = get_cpu_model_by_arch(arch);
+
+    if (!cpu_model) {
+        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
+                " add it to cpus_map\n", arch);
+        return; /* TODO: die here to force all targets have a test */
+    }
+    global_qtest = qtest_startf("-machine none -cpu %s", cpu_model);
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
-- 
2.7.4
