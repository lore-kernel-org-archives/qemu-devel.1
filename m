Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2f-0005qN-Q6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2c-0000m0-Kv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2c-0000ja-FD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D9454023112
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:26:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:49 +0100
Message-Id: <20180215212552.26997-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] vhost-user-test: add back memfd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This revert commit fb68096da3d35e64c88cd610c1fa42766c58e92a, and
modify test_read_guest_mem() to use different chardev names, when
using memfd (_test_server_free(), where the chardev is removed, runs
in idle).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 93 +++++++++++++++++++++++++++++++++++--------=
------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a217353e2c..67e5f7f858 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -18,6 +18,7 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
+#include "qemu/memfd.h"
 #include "sysemu/sysemu.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
@@ -40,23 +41,14 @@
 #define HAVE_MONOTONIC_TIME
 #endif
=20
-#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=3Dmem,siz=
e=3D%dM,"\
+#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=3Dmem,siz=
e=3D%dM," \
                         "mem-path=3D%s,share=3Don -numa node,memdev=3Dme=
m"
+#define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=3Dmem,si=
ze=3D%dM," \
+                        " -numa node,memdev=3Dmem"
 #define QEMU_CMD_CHR    " -chardev socket,id=3D%s,path=3D%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=3Dnet0,chardev=3D%s,vhos=
tforce"
 #define QEMU_CMD_NET    " -device virtio-net-pci,netdev=3Dnet0"
=20
-#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
-                        QEMU_CMD_NETDEV QEMU_CMD_NET
-
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
 #define HUGETLBFS_MAGIC       0x958458f6
=20
 /*********** FROM hw/virtio/vhost-user.c *******************************=
******/
@@ -175,6 +167,33 @@ static void test_server_listen(TestServer *server);
 static const char *tmpfs;
 static const char *root;
=20
+enum test_memfd {
+    TEST_MEMFD_AUTO,
+    TEST_MEMFD_YES,
+    TEST_MEMFD_NO,
+};
+
+static char *get_qemu_cmd(TestServer *s,
+                          int mem, enum test_memfd memfd, const char *me=
m_path,
+                          const char *chr_opts, const char *extra)
+{
+    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check()) {
+        memfd =3D TEST_MEMFD_YES;
+    }
+
+    if (memfd =3D=3D TEST_MEMFD_YES) {
+        return g_strdup_printf(QEMU_CMD_MEMFD QEMU_CMD_CHR
+                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, m=
em,
+                               s->chr_name, s->socket_path,
+                               chr_opts, s->chr_name, extra);
+    } else {
+        return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
+                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, m=
em,
+                               mem_path, s->chr_name, s->socket_path,
+                               chr_opts, s->chr_name, extra);
+    }
+}
+
 static void init_virtio_dev(TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
@@ -640,16 +659,18 @@ GSourceFuncs test_migrate_source_funcs =3D {
     .check =3D test_migrate_source_check,
 };
=20
-static void test_read_guest_mem(void)
+static void test_read_guest_mem(const void *arg)
 {
+    enum test_memfd memfd =3D GPOINTER_TO_INT(arg);
     TestServer *server =3D NULL;
     char *qemu_cmd =3D NULL;
     QTestState *s =3D NULL;
=20
-    server =3D test_server_new("test");
+    server =3D test_server_new(memfd =3D=3D TEST_MEMFD_YES ?
+                             "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
=20
-    qemu_cmd =3D GET_QEMU_CMD(server);
+    qemu_cmd =3D get_qemu_cmd(server, 512, memfd, root, "", "");
=20
     s =3D qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -671,7 +692,7 @@ static void test_migrate(void)
     char *uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
     QTestState *global =3D global_qtest, *from, *to;
     GSource *source;
-    gchar *cmd;
+    gchar *cmd, *tmp;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -679,7 +700,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
=20
-    cmd =3D GET_QEMU_CMDE(s, 2, "", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
     from =3D qtest_start(cmd);
     g_free(cmd);
=20
@@ -688,7 +709,9 @@ static void test_migrate(void)
     size =3D get_log_size(s);
     g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
=20
-    cmd =3D GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
+    tmp =3D g_strdup_printf(" -incoming %s", uri);
+    cmd =3D get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    g_free(tmp);
     to =3D qtest_init(cmd);
     g_free(cmd);
=20
@@ -801,7 +824,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
=20
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -839,7 +862,7 @@ static void test_connect_fail_subprocess(void)
=20
     s->test_fail =3D true;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -869,7 +892,7 @@ static void test_flags_mismatch_subprocess(void)
=20
     s->test_flags =3D TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -904,11 +927,21 @@ static void test_multiqueue(void)
     s->queues =3D 2;
     test_server_listen(s);
=20
-    cmd =3D g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",=
queues=3D%d "
-                          "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,=
vectors=3D%d",
-                          512, 512, root, s->chr_name,
-                          s->socket_path, "", s->chr_name,
-                          s->queues, s->queues * 2 + 2);
+    if (qemu_memfd_check()) {
+        cmd =3D g_strdup_printf(
+            QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
+            "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
+            512, 512, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            s->queues, s->queues * 2 + 2);
+    } else {
+        cmd =3D g_strdup_printf(
+            QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
+            "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
+            512, 512, root, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            s->queues, s->queues * 2 + 2);
+    }
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -954,7 +987,13 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread =3D g_thread_new(NULL, thread_function, loop);
=20
-    qtest_add_func("/vhost-user/read-guest-mem", test_read_guest_mem);
+    if (qemu_memfd_check()) {
+        qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
+                            GINT_TO_POINTER(TEST_MEMFD_YES),
+                            test_read_guest_mem);
+    }
+    qtest_add_data_func("/vhost-user/read-guest-mem/memfile",
+                        GINT_TO_POINTER(TEST_MEMFD_NO), test_read_guest_=
mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
=20
--=20
2.16.1.73.g5832b7e9f2
