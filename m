Received: from eggs.gnu.org ([2001:4830:134:3::10]:45103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSj-0004wh-WE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSh-0005BM-On
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSh-0005B5-EI
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id j21-v6so14631243wmh.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:56 +0100
Message-Id: <1517858941-5538-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/47] tests: use memfd in vhost-user-test
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

This will exercise the memfd memory backend and should generally be
better for testing than memory-backend-file (thanks to anonymous files
and sealing).

If memfd is available, it is preferred.

However, in order to check that file & memfd backends both work
correctly, the read-guest-mem test is checked explicitly for each.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-8-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 90 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 26 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a22075f..95eb449 100644
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
@@ -39,23 +40,14 @@
 #define HAVE_MONOTONIC_TIME
 #endif
 
-#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM,"\
+#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM," \
                         "mem-path=%s,share=on -numa node,memdev=mem"
+#define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=mem,size=%dM," \
+                        " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=net0,chardev=%s,vhostforce"
 #define QEMU_CMD_NET    " -device virtio-net-pci,netdev=net0"
 
-#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
-                        QEMU_CMD_NETDEV QEMU_CMD_NET
-
-#define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
-                    (s)->socket_path, "", (s)->chr_name)
-
-#define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     \
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name, \
-                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__)
-
 #define HUGETLBFS_MAGIC       0x958458f6
 
 /*********** FROM hw/virtio/vhost-user.c *************************************/
@@ -174,6 +166,33 @@ static void test_server_listen(TestServer *server);
 static const char *tmpfs;
 static const char *root;
 
+enum test_memfd {
+    TEST_MEMFD_AUTO,
+    TEST_MEMFD_YES,
+    TEST_MEMFD_NO,
+};
+
+static char *get_qemu_cmd(TestServer *s,
+                          int mem, enum test_memfd memfd, const char *mem_path,
+                          const char *chr_opts, const char *extra)
+{
+    if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check()) {
+        memfd = TEST_MEMFD_YES;
+    }
+
+    if (memfd == TEST_MEMFD_YES) {
+        return g_strdup_printf(QEMU_CMD_MEMFD QEMU_CMD_CHR
+                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
+                               s->chr_name, s->socket_path,
+                               chr_opts, s->chr_name, extra);
+    } else {
+        return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
+                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
+                               mem_path, s->chr_name, s->socket_path,
+                               chr_opts, s->chr_name, extra);
+    }
+}
+
 static void init_virtio_dev(TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
@@ -639,8 +658,9 @@ GSourceFuncs test_migrate_source_funcs = {
     .check = test_migrate_source_check,
 };
 
-static void test_read_guest_mem(void)
+static void test_read_guest_mem(const void *arg)
 {
+    enum test_memfd memfd = GPOINTER_TO_INT(arg);
     TestServer *server = NULL;
     char *qemu_cmd = NULL;
     QTestState *s = NULL;
@@ -648,7 +668,7 @@ static void test_read_guest_mem(void)
     server = test_server_new("test");
     test_server_listen(server);
 
-    qemu_cmd = GET_QEMU_CMD(server);
+    qemu_cmd = get_qemu_cmd(server, 512, memfd, root, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -670,7 +690,7 @@ static void test_migrate(void)
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
     QTestState *global = global_qtest, *from, *to;
     GSource *source;
-    gchar *cmd;
+    gchar *cmd, *tmp;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -678,7 +698,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = GET_QEMU_CMDE(s, 2, "", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -687,7 +707,9 @@ static void test_migrate(void)
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
-    cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
+    tmp = g_strdup_printf(" -incoming %s", uri);
+    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
 
@@ -800,7 +822,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -838,7 +860,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -868,7 +890,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -903,11 +925,21 @@ static void test_multiqueue(void)
     s->queues = 2;
     test_server_listen(s);
 
-    cmd = g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-                          "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-                          512, 512, root, s->chr_name,
-                          s->socket_path, "", s->chr_name,
-                          s->queues, s->queues * 2 + 2);
+    if (qemu_memfd_check()) {
+        cmd = g_strdup_printf(
+            QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
+            "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
+            512, 512, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            s->queues, s->queues * 2 + 2);
+    } else {
+        cmd = g_strdup_printf(
+            QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
+            "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
+            512, 512, root, s->chr_name,
+            s->socket_path, "", s->chr_name,
+            s->queues, s->queues * 2 + 2);
+    }
     qtest_start(cmd);
     g_free(cmd);
 
@@ -953,7 +985,13 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread = g_thread_new(NULL, thread_function, loop);
 
-    qtest_add_func("/vhost-user/read-guest-mem", test_read_guest_mem);
+    if (qemu_memfd_check()) {
+        qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
+                            GINT_TO_POINTER(TEST_MEMFD_YES),
+                            test_read_guest_mem);
+    }
+    qtest_add_data_func("/vhost-user/read-guest-mem/memfile",
+                        GINT_TO_POINTER(TEST_MEMFD_NO), test_read_guest_mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
 
-- 
1.8.3.1
