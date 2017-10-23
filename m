Received: from eggs.gnu.org ([2001:4830:134:3::10]:40339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ7-00018x-7c
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ6-0000eY-6r
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6dZ5-0000e8-Uv
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DA0F745
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:18:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 15:18:14 +0100
Message-Id: <20171023141815.17709-9-marcandre.lureau@redhat.com>
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 8/9] vhost-user-test: make read-guest-mem
 setup its own qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 66 ++++++++++++++++++++++++++-----------------=
------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 7fc6f85888..2da6b6d61f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -49,6 +49,14 @@
 #define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
                         QEMU_CMD_NETDEV QEMU_CMD_NET
=20
+#define GET_QEMU_CMD(s)                                         \
+    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
+                    (s)->socket_path, "", (s)->chr_name)
+
+#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     =
\
+    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name,=
 \
+                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_=
ARGS__)
+
 #define HUGETLBFS_MAGIC       0x958458f6
=20
 /*********** FROM hw/virtio/vhost-user.c *******************************=
******/
@@ -156,6 +164,10 @@ typedef struct TestServer {
     int queues;
 } TestServer;
=20
+static TestServer *test_server_new(const gchar *name);
+static void test_server_free(TestServer *server);
+static void test_server_listen(TestServer *server);
+
 static const char *tmpfs;
 static const char *root;
=20
@@ -205,9 +217,8 @@ static void wait_for_fds(TestServer *s)
     g_mutex_unlock(&s->data_mutex);
 }
=20
-static void read_guest_mem(const void *data)
+static void read_guest_mem_server(TestServer *s)
 {
-    TestServer *s =3D (void *)data;
     uint32_t *guest_mem;
     int i, j;
     size_t size;
@@ -248,6 +259,26 @@ static void read_guest_mem(const void *data)
     g_mutex_unlock(&s->data_mutex);
 }
=20
+static void read_guest_mem(void)
+{
+    TestServer *s;
+    char *qemu_cmd;
+
+    s =3D test_server_new("test");
+    test_server_listen(s);
+
+    qemu_cmd =3D GET_QEMU_CMD(s);
+
+    qtest_start(qemu_cmd);
+    g_free(qemu_cmd);
+    init_virtio_dev(s);
+
+    read_guest_mem_server(s);
+
+    qtest_end();
+    test_server_free(s);
+}
+
 static void *thread_function(void *data)
 {
     GMainLoop *loop =3D data;
@@ -472,14 +503,6 @@ static void test_server_listen(TestServer *server)
     test_server_create_chr(server, ",server,nowait");
 }
=20
-#define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
-                    (s)->socket_path, "", (s)->chr_name)
-
-#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     =
\
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name,=
 \
-                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_=
ARGS__)
-
 static gboolean _test_server_free(TestServer *server)
 {
     int i;
@@ -686,7 +709,7 @@ static void test_migrate(void)
     global_qtest =3D to;
     qmp_eventwait("RESUME");
=20
-    read_guest_mem(dest);
+    read_guest_mem_server(dest);
=20
     g_source_destroy(source);
     g_source_unref(source);
@@ -918,10 +941,7 @@ static void test_multiqueue(void)
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
@@ -946,20 +966,11 @@ int main(int argc, char **argv)
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
+    qtest_add_func("/vhost-user/read-guest-mem", read_guest_mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
=20
@@ -980,13 +991,6 @@ int main(int argc, char **argv)
=20
     ret =3D g_test_run();
=20
-    if (s) {
-        qtest_quit(s);
-    }
-
-    /* cleanup */
-    test_server_free(server);
-
     /* finish the helper thread and dispatch pending sources */
     g_main_loop_quit(loop);
     g_thread_join(thread);
--=20
2.15.0.rc0.40.gaefcc5f6f
