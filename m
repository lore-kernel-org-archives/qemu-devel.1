Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFw-0002lB-Mf
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFv-0007Gq-Lj
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1edaFv-0007GG-D0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 Jan 2018 12:27:01 +0100
Message-Id: <1516620426-18530-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1516620426-18530-1-git-send-email-thuth@redhat.com>
References: <1516620426-18530-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] tests/cpu-plug-test: Test CPU hot-plugging
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>

CPU hot-plugging on s390x is possible with both, "cpu-add"
and "device_add", so test both.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |  1 +
 tests/cpu-plug-test.c  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 092ad5f..851aafe 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
+check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index a306340..05d82f7 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -212,6 +212,43 @@ static void add_pseries_test_case(const char *mname)
     g_free(path);
 }
 
+static void add_s390x_test_case(const char *mname)
+{
+    char *path;
+    PlugTestData *data, *data2;
+
+    if (!g_str_has_prefix(mname, "s390-ccw-virtio-")) {
+        return;
+    }
+
+    data = g_new(PlugTestData, 1);
+    data->machine = g_strdup(mname);
+    data->cpu_model = "qemu";
+    data->device_model = g_strdup("qemu-s390x-cpu");
+    data->sockets = 1;
+    data->cores = 3;
+    data->threads = 1;
+    data->maxcpus = data->sockets * data->cores * data->threads * 2;
+
+    data2 = g_memdup(data, sizeof(PlugTestData));
+    data2->machine = g_strdup(data->machine);
+    data2->device_model = g_strdup(data->device_model);
+
+    path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
+                             test_data_free);
+    g_free(path);
+
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data2->sockets, data2->cores,
+                           data2->threads, data2->maxcpus);
+    qtest_add_data_func_full(path, data2, test_plug_with_device_add_coreid,
+                             test_data_free);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -222,6 +259,8 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pc_test_case);
     } else if (g_str_equal(arch, "ppc64")) {
         qtest_cb_for_every_machine(add_pseries_test_case);
+    } else if (g_str_equal(arch, "s390x")) {
+        qtest_cb_for_every_machine(add_s390x_test_case);
     }
 
     return g_test_run();
-- 
1.8.3.1
