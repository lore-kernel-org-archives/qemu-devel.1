Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEO-00084i-CM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEL-0004GN-AE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEK-0004FP-VH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:53 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:27 +0100
Message-Id: <1543851204-41186-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/71] vhost-user-test: create a temporary
 directory per TestServer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

This makes the tests more independent, and also the source and destinatio=
n
TestServers in the migration test.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 75 ++++++++++++++++++++++---------------------=
------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a282fc5..23f129f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -139,6 +139,8 @@ typedef struct TestServer {
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
+    const gchar *mem_path;
+    gchar *tmpfs;
     CharBackend chr;
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -159,9 +161,6 @@ static TestServer *test_server_new(const gchar *name)=
;
 static void test_server_free(TestServer *server);
 static void test_server_listen(TestServer *server);
=20
-static const char *tmpfs;
-static const char *root;
-
 enum test_memfd {
     TEST_MEMFD_AUTO,
     TEST_MEMFD_YES,
@@ -169,7 +168,7 @@ enum test_memfd {
 };
=20
 static char *get_qemu_cmd(TestServer *s,
-                          int mem, enum test_memfd memfd, const char *me=
m_path,
+                          int mem, enum test_memfd memfd,
                           const char *chr_opts, const char *extra)
 {
     if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
@@ -184,7 +183,7 @@ static char *get_qemu_cmd(TestServer *s,
     } else {
         return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
                                QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, m=
em,
-                               mem_path, s->chr_name, s->socket_path,
+                               s->mem_path, s->chr_name, s->socket_path,
                                chr_opts, s->chr_name, extra);
     }
 }
@@ -499,11 +498,21 @@ static const char *init_hugepagefs(void)
 static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server =3D g_new0(TestServer, 1);
+    char template[] =3D "/tmp/vhost-test-XXXXXX";
+    const char *tmpfs;
=20
     server->loop =3D g_main_loop_new(NULL, FALSE);
     /* run the main loop thread so the chardev may operate */
     server->thread =3D g_thread_new(NULL, thread_function, server->loop)=
;
=20
+    tmpfs =3D mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(=
errno));
+    }
+    g_assert(tmpfs);
+
+    server->tmpfs =3D g_strdup(tmpfs);
+    server->mem_path =3D init_hugepagefs() ? : server->tmpfs;
     server->socket_path =3D g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path =3D g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name =3D g_strdup_printf("chr-%s", name);
@@ -560,6 +569,18 @@ static void test_server_free(TestServer *server)
     }
     g_main_loop_unref(server->loop);
=20
+    unlink(server->socket_path);
+    g_free(server->socket_path);
+
+    unlink(server->mig_path);
+    g_free(server->mig_path);
+
+    ret =3D rmdir(server->tmpfs);
+    if (ret !=3D 0) {
+        g_test_message("unable to rmdir: path (%s): %s\n",
+                       server->tmpfs, strerror(errno));
+    }
+
     qemu_chr_fe_deinit(&server->chr, true);
=20
     for (i =3D 0; i < server->fds_num; i++) {
@@ -570,12 +591,6 @@ static void test_server_free(TestServer *server)
         close(server->log_fd);
     }
=20
-    unlink(server->socket_path);
-    g_free(server->socket_path);
-
-    unlink(server->mig_path);
-    g_free(server->mig_path);
-
     g_free(server->chr_name);
     g_assert(server->bus);
     qpci_free_pc(server->bus);
@@ -681,7 +696,7 @@ static void test_read_guest_mem(const void *arg)
                              "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
=20
-    qemu_cmd =3D get_qemu_cmd(server, 512, memfd, root, "", "");
+    qemu_cmd =3D get_qemu_cmd(server, 512, memfd, "", "");
=20
     s =3D qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -716,7 +731,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
=20
-    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, "", "");
     from =3D qtest_start(cmd);
     g_free(cmd);
=20
@@ -729,7 +744,7 @@ static void test_migrate(void)
     g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
=20
     tmp =3D g_strdup_printf(" -incoming %s", uri);
-    cmd =3D get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    cmd =3D get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, "", tmp);
     g_free(tmp);
     to =3D qtest_init(cmd);
     g_free(cmd);
@@ -839,7 +854,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
=20
     g_thread_new("connect", connect_thread, s);
-    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -881,7 +896,7 @@ static void test_connect_fail_subprocess(void)
=20
     s->test_fail =3D true;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -914,7 +929,7 @@ static void test_flags_mismatch_subprocess(void)
=20
     s->test_flags =3D TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -962,7 +977,7 @@ static void test_multiqueue(void)
         cmd =3D g_strdup_printf(
             QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
             "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
-            512, 512, root, s->chr_name,
+            512, 512, s->mem_path, s->chr_name,
             s->socket_path, "", s->chr_name,
             s->queues, s->queues * 2 + 2);
     }
@@ -982,22 +997,11 @@ static void test_multiqueue(void)
=20
 int main(int argc, char **argv)
 {
-    int ret;
-    char template[] =3D "/tmp/vhost-test-XXXXXX";
-
     g_test_init(&argc, &argv, NULL);
=20
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
=20
-    tmpfs =3D mkdtemp(template);
-    if (!tmpfs) {
-        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(=
errno));
-    }
-    g_assert(tmpfs);
-
-    root =3D init_hugepagefs() ? : tmpfs;
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1021,16 +1025,5 @@ int main(int argc, char **argv)
         qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch=
);
     }
=20
-    ret =3D g_test_run();
-
-    /* cleanup */
-
-    ret =3D rmdir(tmpfs);
-    if (ret !=3D 0) {
-        g_test_message("unable to rmdir: path (%s): %s\n",
-                       tmpfs, strerror(errno));
-    }
-    g_assert_cmpint(ret, =3D=3D, 0);
-
-    return ret;
+    return g_test_run();
 }
--=20
1.8.3.1
