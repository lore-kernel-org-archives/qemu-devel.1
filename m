Received: from eggs.gnu.org ([2001:4830:134:3::10]:45104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSk-0004wi-05
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSg-0005Aw-GT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSg-0005AZ-8W
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:54 -0500
Received: by mail-wm0-x243.google.com with SMTP id 141so27960598wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:55 +0100
Message-Id: <1517858941-5538-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/47] vhost-user-test: make read-guest-mem
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 713ff5c..a22075f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -48,6 +48,14 @@
 #define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
                         QEMU_CMD_NETDEV QEMU_CMD_NET
 
+#define GET_QEMU_CMD(s)                                         \
+    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
+                    (s)->socket_path, "", (s)->chr_name)
+
+#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     \
+    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name, \
+                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__)
+
 #define HUGETLBFS_MAGIC       0x958458f6
 
 /*********** FROM hw/virtio/vhost-user.c *************************************/
@@ -159,6 +167,10 @@ typedef struct TestServer {
     QGuestAllocator *alloc;
 } TestServer;
 
+static TestServer *test_server_new(const gchar *name);
+static void test_server_free(TestServer *server);
+static void test_server_listen(TestServer *server);
+
 static const char *tmpfs;
 static const char *root;
 
@@ -225,9 +237,8 @@ static void wait_for_fds(TestServer *s)
     g_mutex_unlock(&s->data_mutex);
 }
 
-static void read_guest_mem(const void *data)
+static void read_guest_mem_server(TestServer *s)
 {
-    TestServer *s = (void *)data;
     uint32_t *guest_mem;
     int i, j;
     size_t size;
@@ -492,14 +503,6 @@ static void test_server_listen(TestServer *server)
     test_server_create_chr(server, ",server,nowait");
 }
 
-#define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
-                    (s)->socket_path, "", (s)->chr_name)
-
-#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     \
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name, \
-                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__)
-
 static gboolean _test_server_free(TestServer *server)
 {
     int i;
@@ -652,7 +655,7 @@ static void test_read_guest_mem(void)
 
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
 
-    read_guest_mem(server);
+    read_guest_mem_server(server);
 
     uninit_virtio_dev(server);
 
@@ -730,7 +733,7 @@ static void test_migrate(void)
     global_qtest = to;
     qmp_eventwait("RESUME");
 
-    read_guest_mem(dest);
+    read_guest_mem_server(dest);
 
     uninit_virtio_dev(s);
 
-- 
1.8.3.1
