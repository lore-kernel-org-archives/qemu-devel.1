Received: from eggs.gnu.org ([2001:4830:134:3::10]:44969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6ZWA-0005W4-BA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6ZW8-00030W-UW
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6ZW8-0002zl-Gn
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7763C7E425
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:59:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 10:59:10 +0100
Message-Id: <20171023095910.23202-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171023095910.23202-1-marcandre.lureau@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 6/6] tests: use memfd in vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will exercise the memfd memory backend and should generally be
better for testing than memory-backend-file (thanks to anonymous files
and sealing).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 68 ++++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 830f1e4026..58682f0871 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
+#include "qemu/memfd.h"
 #include "sysemu/sysemu.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
@@ -42,15 +43,14 @@
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
 #define HUGETLBFS_MAGIC       0x958458f6
=20
 /*********** FROM hw/virtio/vhost-user.c *******************************=
******/
@@ -161,6 +161,22 @@ typedef struct TestServer {
 static const char *tmpfs;
 static const char *root;
=20
+static char *get_qemu_cmd(TestServer *s, int mem, const char *mem_path,
+                          const char *chr_opts, const char *extra)
+{
+    if (qemu_memfd_check()) {
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
 static void init_virtio_dev(TestServer *s)
 {
     QVirtioPCIDevice *dev;
@@ -474,14 +490,6 @@ static void test_server_listen(TestServer *server)
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
@@ -625,7 +633,7 @@ static void test_migrate(void)
     char *uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
     QTestState *global =3D global_qtest, *from, *to;
     GSource *source;
-    gchar *cmd;
+    gchar *cmd, *tmp;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -633,7 +641,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
=20
-    cmd =3D GET_QEMU_CMDE(s, 2, "", "");
+    cmd =3D get_qemu_cmd(s, 2, root, "", "");
     from =3D qtest_start(cmd);
     g_free(cmd);
=20
@@ -642,7 +650,9 @@ static void test_migrate(void)
     size =3D get_log_size(s);
     g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
=20
-    cmd =3D GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
+    tmp =3D g_strdup_printf(" -incoming %s", uri);
+    cmd =3D get_qemu_cmd(dest, 2, root, "", tmp);
+    g_free(tmp);
     to =3D qtest_init(cmd);
     g_free(cmd);
=20
@@ -753,7 +763,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
=20
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -789,7 +799,7 @@ static void test_connect_fail_subprocess(void)
=20
     s->test_fail =3D true;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -817,7 +827,7 @@ static void test_flags_mismatch_subprocess(void)
=20
     s->test_flags =3D TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd =3D GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd =3D get_qemu_cmd(s, 2, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -885,11 +895,21 @@ static void test_multiqueue(void)
     s->queues =3D queues;
     test_server_listen(s);
=20
-    cmd =3D g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",=
queues=3D%d "
-                          "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,=
vectors=3D%d",
-                          512, 512, root, s->chr_name,
-                          s->socket_path, "", s->chr_name,
-                          queues, queues * 2 + 2);
+    if (qemu_memfd_check()) {
+        cmd =3D g_strdup_printf(
+            QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
+            "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
+            512, 512, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            queues, queues * 2 + 2);
+    } else {
+        cmd =3D g_strdup_printf(
+            QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
+            "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
+            512, 512, root, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            queues, queues * 2 + 2);
+    }
     qtest_start(cmd);
     g_free(cmd);
=20
@@ -955,7 +975,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread =3D g_thread_new(NULL, thread_function, loop);
=20
-    qemu_cmd =3D GET_QEMU_CMD(server);
+    qemu_cmd =3D get_qemu_cmd(server, 512, root, "", "");
=20
     s =3D qtest_start(qemu_cmd);
     g_free(qemu_cmd);
--=20
2.15.0.rc0.40.gaefcc5f6f
