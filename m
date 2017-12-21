Received: from eggs.gnu.org ([2001:4830:134:3::10]:56273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS83A-0000pE-OZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS839-0005NY-Qy
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS839-0005N4-LN
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E662C883BC
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:06:42 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:06:06 +0100
Message-Id: <20171221210609.17408-3-maxime.coquelin@redhat.com>
In-Reply-To: <20171221210609.17408-1-maxime.coquelin@redhat.com>
References: <20171221210609.17408-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] vhost-user-test: extract read-guest-mem
 test from main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch makes read-guest-test consistent with other tests,
i.e. create the test server in the test function.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 43c6528644..df567248ae 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -617,6 +617,28 @@ GSourceFuncs test_migrate_source_funcs = {
     .check = test_migrate_source_check,
 };
 
+static void test_read_guest_mem(void)
+{
+    TestServer *server = NULL;
+    char *qemu_cmd = NULL;
+    QTestState *s = NULL;
+
+    server = test_server_new("test");
+    test_server_listen(server);
+
+    qemu_cmd = GET_QEMU_CMD(server);
+
+    s = qtest_start(qemu_cmd);
+    g_free(qemu_cmd);
+
+    init_virtio_dev(server);
+
+    read_guest_mem(server);
+
+    qtest_quit(s);
+    test_server_free(server);
+}
+
 static void test_migrate(void)
 {
     TestServer *s = test_server_new("src");
@@ -919,10 +941,7 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    QTestState *s = NULL;
-    TestServer *server = NULL;
     const char *hugefs;
-    char *qemu_cmd = NULL;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
     GMainLoop *loop;
@@ -947,20 +966,11 @@ int main(int argc, char **argv)
         root = tmpfs;
     }
 
-    server = test_server_new("test");
-    test_server_listen(server);
-
     loop = g_main_loop_new(NULL, FALSE);
     /* run the main loop thread so the chardev may operate */
     thread = g_thread_new(NULL, thread_function, loop);
 
-    qemu_cmd = GET_QEMU_CMD(server);
-
-    s = qtest_start(qemu_cmd);
-    g_free(qemu_cmd);
-    init_virtio_dev(server);
-
-    qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
+    qtest_add_func("/vhost-user/read-guest-mem", test_read_guest_mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
 
@@ -978,12 +988,7 @@ int main(int argc, char **argv)
 
     ret = g_test_run();
 
-    if (s) {
-        qtest_quit(s);
-    }
-
     /* cleanup */
-    test_server_free(server);
 
     /* finish the helper thread and dispatch pending sources */
     g_main_loop_quit(loop);
-- 
2.14.3
