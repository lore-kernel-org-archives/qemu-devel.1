Received: from eggs.gnu.org ([2001:4830:134:3::10]:43742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4S0D-0006nD-3M
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4S03-0003n7-6j
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Oct 2017 15:32:26 +0200
Message-Id: <1508247148-25240-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1508247148-25240-1-git-send-email-thuth@redhat.com>
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] tests/cpu-plug-test: Check the CPU
 hot-plugging with device_add, too
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

Using 'device_add' instead of 'cpu-add' is the new way for
hot-plugging CPUs, so we should test this regularly, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/cpu-plug-test.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 4579119..5fef297 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -16,6 +16,7 @@
 struct PlugTestData {
     char *machine;
     const char *cpu_model;
+    const char *device_model;
     unsigned sockets;
     unsigned cores;
     unsigned threads;
@@ -71,6 +72,34 @@ static void test_plug_without_cpu_add(gconstpointer data)
     g_free(args);
 }
 
+static void test_plug_with_device_add_x86(gconstpointer data)
+{
+    const PlugTestData *td = data;
+    char *args;
+    unsigned int s, c, t;
+
+    args = g_strdup_printf("-machine %s -cpu %s "
+                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                           td->machine, td->cpu_model,
+                           td->sockets, td->cores, td->threads, td->maxcpus);
+    qtest_start(args);
+
+    for (s = td->sockets; s < td->maxcpus / td->cores / td->threads; s++) {
+        for (c = 0; c < td->cores; c++) {
+            for (t = 0; t < td->threads; t++) {
+                char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
+                qtest_qmp_device_add(td->device_model, id, "'socket-id':'%i', "
+                                     "'core-id':'%i', 'thread-id':'%i'",
+                                     s, c, t);
+                g_free(id);
+            }
+        }
+    }
+
+    qtest_end();
+    g_free(args);
+}
+
 static void test_data_free(gpointer data)
 {
     PlugTestData *pc = data;
@@ -90,6 +119,7 @@ static void add_pc_test_case(const char *mname)
     data = g_new(PlugTestData, 1);
     data->machine = g_strdup(mname);
     data->cpu_model = "Haswell"; /* 1.3+ theoretically */
+    data->device_model = "Haswell-x86_64-cpu";
     data->sockets = 1;
     data->cores = 3;
     data->threads = 2;
@@ -105,19 +135,27 @@ static void add_pc_test_case(const char *mname)
         (strcmp(mname, "pc-0.12") == 0) ||
         (strcmp(mname, "pc-0.11") == 0) ||
         (strcmp(mname, "pc-0.10") == 0)) {
-        path = g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=%u",
+        path = g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
         qtest_add_data_func_full(path, data, test_plug_without_cpu_add,
                                  test_data_free);
         g_free(path);
     } else {
-        path = g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=%u",
+        PlugTestData *data2 = g_memdup(data, sizeof(PlugTestData));
+        data2->machine = g_strdup(mname);
+        path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
         qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
                                  test_data_free);
         g_free(path);
+        path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                               mname, data2->sockets, data2->cores,
+                               data2->threads, data2->maxcpus);
+        qtest_add_data_func_full(path, data2, test_plug_with_device_add_x86,
+                                 test_data_free);
+        g_free(path);
     }
 }
 
-- 
1.8.3.1
