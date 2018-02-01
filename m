Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEv1-0004zp-BW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEv0-0000R7-AY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehEv0-0000Qh-3I
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 635F6C0467C6
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 13:28:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 14:27:56 +0100
Message-Id: <20180201132757.23063-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180201132757.23063-1-marcandre.lureau@redhat.com>
References: <20180201132757.23063-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 6/7] vhost-user-test: make read-guest-mem
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
 tests/vhost-user-test.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 713ff5c5c6..a22075ff26 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -48,6 +48,14 @@
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
@@ -159,6 +167,10 @@ typedef struct TestServer {
     QGuestAllocator *alloc;
 } TestServer;
=20
+static TestServer *test_server_new(const gchar *name);
+static void test_server_free(TestServer *server);
+static void test_server_listen(TestServer *server);
+
 static const char *tmpfs;
 static const char *root;
=20
@@ -225,9 +237,8 @@ static void wait_for_fds(TestServer *s)
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
@@ -492,14 +503,6 @@ static void test_server_listen(TestServer *server)
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
@@ -652,7 +655,7 @@ static void test_read_guest_mem(void)
=20
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
=20
-    read_guest_mem(server);
+    read_guest_mem_server(server);
=20
     uninit_virtio_dev(server);
=20
@@ -730,7 +733,7 @@ static void test_migrate(void)
     global_qtest =3D to;
     qmp_eventwait("RESUME");
=20
-    read_guest_mem(dest);
+    read_guest_mem_server(dest);
=20
     uninit_virtio_dev(s);
=20
--=20
2.16.0.rc1.1.gef27df75a1
