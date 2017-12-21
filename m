Received: from eggs.gnu.org ([2001:4830:134:3::10]:42139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Ho-0000fa-68
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Hn-0000RM-A3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS8Hn-0000Qr-4w
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C7985F73A
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:21:50 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:21:22 +0100
Message-Id: <20171221212125.19075-3-maxime.coquelin@redhat.com>
In-Reply-To: <20171221212125.19075-1-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] vhost-user-test: extract read-guest-mem
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 43c6528644..df567248ae 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -617,6 +617,28 @@ GSourceFuncs test_migrate_source_funcs =3D {
     .check =3D test_migrate_source_check,
 };
=20
+static void test_read_guest_mem(void)
+{
+    TestServer *server =3D NULL;
+    char *qemu_cmd =3D NULL;
+    QTestState *s =3D NULL;
+
+    server =3D test_server_new("test");
+    test_server_listen(server);
+
+    qemu_cmd =3D GET_QEMU_CMD(server);
+
+    s =3D qtest_start(qemu_cmd);
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
     TestServer *s =3D test_server_new("src");
@@ -919,10 +941,7 @@ static void test_multiqueue(void)
=20
 int main(int argc, char **argv)
 {
-    QTestState *s =3D NULL;
-    TestServer *server =3D NULL;
     const char *hugefs;
-    char *qemu_cmd =3D NULL;
     int ret;
     char template[] =3D "/tmp/vhost-test-XXXXXX";
     GMainLoop *loop;
@@ -947,20 +966,11 @@ int main(int argc, char **argv)
         root =3D tmpfs;
     }
=20
-    server =3D test_server_new("test");
-    test_server_listen(server);
-
     loop =3D g_main_loop_new(NULL, FALSE);
     /* run the main loop thread so the chardev may operate */
     thread =3D g_thread_new(NULL, thread_function, loop);
=20
-    qemu_cmd =3D GET_QEMU_CMD(server);
-
-    s =3D qtest_start(qemu_cmd);
-    g_free(qemu_cmd);
-    init_virtio_dev(server);
-
-    qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest=
_mem);
+    qtest_add_func("/vhost-user/read-guest-mem", test_read_guest_mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
=20
@@ -978,12 +988,7 @@ int main(int argc, char **argv)
=20
     ret =3D g_test_run();
=20
-    if (s) {
-        qtest_quit(s);
-    }
-
     /* cleanup */
-    test_server_free(server);
=20
     /* finish the helper thread and dispatch pending sources */
     g_main_loop_quit(loop);
--=20
2.14.3
