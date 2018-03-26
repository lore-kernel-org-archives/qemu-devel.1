Received: from eggs.gnu.org ([2001:4830:134:3::10]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ8-0006gl-Hw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ2-0006zh-Do
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:06 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ2-0006yz-4b
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:00 -0400
Received: by mail-wm0-x242.google.com with SMTP id r82so15632134wme.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:37 +0200
Message-Id: <1522071403-52486-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/16] vhost-user-test: add back memfd check
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

This revert commit fb68096da3d35e64c88cd610c1fa42766c58e92a, and
modify test_read_guest_mem() to use different chardev names, when
using memfd (_test_server_free(), where the chardev is removed, runs
in idle).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-4-marcandre.lureau@redhat.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 93 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index f87afee..61d9972 100644
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
@@ -175,6 +167,33 @@ static void test_server_listen(TestServer *server);
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
@@ -641,16 +660,18 @@ GSourceFuncs test_migrate_source_funcs = {
     .check = test_migrate_source_check,
 };
 
-static void test_read_guest_mem(void)
+static void test_read_guest_mem(const void *arg)
 {
+    enum test_memfd memfd = GPOINTER_TO_INT(arg);
     TestServer *server = NULL;
     char *qemu_cmd = NULL;
     QTestState *s = NULL;
 
-    server = test_server_new("test");
+    server = test_server_new(memfd == TEST_MEMFD_YES ?
+                             "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
 
-    qemu_cmd = GET_QEMU_CMD(server);
+    qemu_cmd = get_qemu_cmd(server, 512, memfd, root, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -672,7 +693,7 @@ static void test_migrate(void)
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
     QTestState *global = global_qtest, *from, *to;
     GSource *source;
-    gchar *cmd;
+    gchar *cmd, *tmp;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -680,7 +701,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = GET_QEMU_CMDE(s, 2, "", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -689,7 +710,9 @@ static void test_migrate(void)
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
-    cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
+    tmp = g_strdup_printf(" -incoming %s", uri);
+    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
 
@@ -802,7 +825,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -840,7 +863,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -870,7 +893,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -905,11 +928,21 @@ static void test_multiqueue(void)
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
 
@@ -955,7 +988,13 @@ int main(int argc, char **argv)
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
