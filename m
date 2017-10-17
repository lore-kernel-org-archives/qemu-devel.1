Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4S0A-0006m9-65
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4S06-0003p0-2D
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Oct 2017 15:32:27 +0200
Message-Id: <1508247148-25240-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1508247148-25240-1-git-send-email-thuth@redhat.com>
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tests/cpu-plug-test: Check CPU
 hot-plugging on ppc64, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, david@redhat.com

Hot plugging on ppc64 is possible via "device_add", too. Unlike x86,
we must not specify a 'socket-id' and 'thread-id' here, so this needs
to be done with a separate function that just specifies the 'core-id'
during the "device_add".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |  1 +
 tests/cpu-plug-test.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d7e814..cbec19f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -332,6 +332,7 @@ check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
+check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 5fef297..714a69c 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -100,6 +100,28 @@ static void test_plug_with_device_add_x86(gconstpointer data)
     g_free(args);
 }
 
+static void test_plug_with_device_add_coreid(gconstpointer data)
+{
+    const PlugTestData *td = data;
+    char *args;
+    unsigned int c;
+
+    args = g_strdup_printf("-machine %s -cpu %s "
+                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                           td->machine, td->cpu_model,
+                           td->sockets, td->cores, td->threads, td->maxcpus);
+    qtest_start(args);
+
+    for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
+        char *id = g_strdup_printf("id-%i", c);
+        qtest_qmp_device_add(td->device_model, id, "'core-id':'%i'", c);
+        g_free(id);
+    }
+
+    qtest_end();
+    g_free(args);
+}
+
 static void test_data_free(gpointer data)
 {
     PlugTestData *pc = data;
@@ -159,6 +181,32 @@ static void add_pc_test_case(const char *mname)
     }
 }
 
+static void add_pseries_test_case(const char *mname)
+{
+    char *path;
+    PlugTestData *data;
+
+    if (!g_str_has_prefix(mname, "pseries-") ||
+        (g_str_has_prefix(mname, "pseries-2.") && atoi(&mname[10]) < 7)) {
+        return;
+    }
+    data = g_new(PlugTestData, 1);
+    data->machine = g_strdup(mname);
+    data->cpu_model = "POWER8_v2.0";
+    data->device_model = "power8_v2.0-spapr-cpu-core";
+    data->sockets = 2;
+    data->cores = 3;
+    data->threads = 1;
+    data->maxcpus = data->sockets * data->cores * data->threads * 2;
+
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_device_add_coreid,
+                             test_data_free);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -167,6 +215,8 @@ int main(int argc, char **argv)
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qtest_cb_for_every_machine(add_pc_test_case);
+    } else if (g_str_equal(arch, "ppc64")) {
+        qtest_cb_for_every_machine(add_pseries_test_case);
     }
 
     return g_test_run();
-- 
1.8.3.1
