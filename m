Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc4-0002MC-HO
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc1-0007m4-Tq
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tc1-0007ll-LI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:19 -0300
Message-Id: <20170511191843.13784-6-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/29] tests: add CPUs to numa node mapping test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1493816238-33120-2-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/numa-test.c      | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   5 +++
 2 files changed, 111 insertions(+)
 create mode 100644 tests/numa-test.c

diff --git a/tests/numa-test.c b/tests/numa-test.c
new file mode 100644
index 0000000000..f5da0c845b
--- /dev/null
+++ b/tests/numa-test.c
@@ -0,0 +1,106 @@
+/*
+ * NUMA configuration test cases
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ * Authors:
+ *  Igor Mammedov <imammedo@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static char *make_cli(const char *generic_cli, const char *test_cli)
+{
+    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
+}
+
+static char *hmp_info_numa(void)
+{
+    QDict *resp;
+    char *s;
+
+    resp = qmp("{ 'execute': 'human-monitor-command', 'arguments': "
+                      "{ 'command-line': 'info numa '} }");
+    g_assert(resp);
+    g_assert(qdict_haskey(resp, "return"));
+    s = g_strdup(qdict_get_str(resp, "return"));
+    g_assert(s);
+    QDECREF(resp);
+    return s;
+}
+
+static void test_mon_explicit(const void *data)
+{
+    char *s;
+    char *cli;
+
+    cli = make_cli(data, "-smp 8 "
+                   "-numa node,nodeid=0,cpus=0-3 "
+                   "-numa node,nodeid=1,cpus=4-7 ");
+    qtest_start(cli);
+
+    s = hmp_info_numa();
+    g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
+    g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
+    g_free(s);
+
+    qtest_end();
+    g_free(cli);
+}
+
+static void test_mon_default(const void *data)
+{
+    char *s;
+    char *cli;
+
+    cli = make_cli(data, "-smp 8 -numa node -numa node");
+    qtest_start(cli);
+
+    s = hmp_info_numa();
+    g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
+    g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
+    g_free(s);
+
+    qtest_end();
+    g_free(cli);
+}
+
+static void test_mon_partial(const void *data)
+{
+    char *s;
+    char *cli;
+
+    cli = make_cli(data, "-smp 8 "
+                   "-numa node,nodeid=0,cpus=0-1 "
+                   "-numa node,nodeid=1,cpus=4-5 ");
+    qtest_start(cli);
+
+    s = hmp_info_numa();
+    g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
+    g_assert(strstr(s, "node 1 cpus: 4 5"));
+    g_free(s);
+
+    qtest_end();
+    g_free(cli);
+}
+
+int main(int argc, char **argv)
+{
+    const char *args = NULL;
+    const char *arch = qtest_get_arch();
+
+    if (strcmp(arch, "aarch64") == 0) {
+        args = "-machine virt";
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/numa/mon/default", args, test_mon_default);
+    qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit);
+    qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 31931c0d77..16ff8f399f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -260,6 +260,7 @@ check-qtest-i386-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-y += tests/test-filter-redirector$(EXESUF)
 check-qtest-i386-y += tests/postcopy-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
+check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
@@ -300,6 +301,7 @@ check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
+check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
@@ -324,6 +326,8 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 
+check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
 check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
@@ -753,6 +757,7 @@ tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-use
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
+tests/numa-test$(EXESUF): tests/numa-test.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
2.11.0.259.g40922b1
