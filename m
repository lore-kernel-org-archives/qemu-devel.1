Received: from eggs.gnu.org ([2001:4830:134:3::10]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAI-0001yn-CD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAH-0001QO-FN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHAH-0001Q9-AS
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:01 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 743F383F3A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:34:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:47 +0100
Message-Id: <20170111113347.7577-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 9/9] tests: use memfd in vhost-user-test
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

This will exercise the memfd memory backend and should generally be
better for testing than memory-backend-file (thanks to anonymous files
and sealing).

The test is already Linux-specific, but will now require Linux with
memfd (since 3.17).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 96bf00eefa..bf0630e38b 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -39,8 +39,8 @@
 #define HAVE_MONOTONIC_TIME
 #endif
=20
-#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=3Dmem,siz=
e=3D%dM,"\
-                        "mem-path=3D%s,share=3Don -numa node,memdev=3Dme=
m"
+#define QEMU_CMD_MEM    " -m %d -object memory-backend-memfd,id=3Dmem,si=
ze=3D%dM,"\
+                        " -numa node,memdev=3Dmem"
 #define QEMU_CMD_CHR    " -chardev socket,id=3D%s,path=3D%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=3Dnet0,chardev=3D%s,vhos=
tforce"
 #define QEMU_CMD_NET    " -device virtio-net-pci,netdev=3Dnet0"
@@ -475,12 +475,12 @@ static inline void test_server_connect(TestServer *=
server)
     test_server_create_chr(server, ",reconnect=3D1");
 }
=20
-#define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
+#define GET_QEMU_CMD(s)                                 \
+    g_strdup_printf(QEMU_CMD, 512, 512, (s)->chr_name,  \
                     (s)->socket_path, "", (s)->chr_name)
=20
-#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     =
\
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name,=
 \
+#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     =
 \
+    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (s)->chr_name,        =
\
                     (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_=
ARGS__)
=20
 static gboolean _test_server_free(TestServer *server)
@@ -883,7 +883,7 @@ static void test_multiqueue(void)
=20
     cmd =3D g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",=
queues=3D%d "
                           "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,=
vectors=3D%d",
-                          512, 512, root, s->chr_name,
+                          512, 512, s->chr_name,
                           s->socket_path, "", s->chr_name,
                           queues, queues * 2 + 2);
     qtest_start(cmd);
--=20
2.11.0
