Received: from eggs.gnu.org ([209.51.188.92]:33965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gn57J-0000Y8-EZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gn57C-0006cr-Ow
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gn57C-0006cA-G3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:02 -0500
Received: by mail-wr1-x436.google.com with SMTP id l9so11063571wrt.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 09:18:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	w12sm91534922wrr.23.2019.01.25.09.17.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Jan 2019 09:17:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 18:17:56 +0100
Message-Id: <1548436676-31749-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
References: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/50] vhost-user-test: create a temporary
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

This makes the tests more independent, and also the source and destination
TestServers in the migration test.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-15-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 77 ++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 803b64b..a1d17af 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -142,6 +142,8 @@ typedef struct TestServer {
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
+    const gchar *mem_path;
+    gchar *tmpfs;
     CharBackend chr;
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -162,9 +164,6 @@ static TestServer *test_server_new(const gchar *name);
 static void test_server_free(TestServer *server);
 static void test_server_listen(TestServer *server);
 
-static const char *tmpfs;
-static const char *root;
-
 enum test_memfd {
     TEST_MEMFD_AUTO,
     TEST_MEMFD_YES,
@@ -172,7 +171,7 @@ enum test_memfd {
 };
 
 static char *get_qemu_cmd(TestServer *s,
-                          int mem, enum test_memfd memfd, const char *mem_path,
+                          int mem, enum test_memfd memfd,
                           const char *chr_opts, const char *extra)
 {
     if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
@@ -187,7 +186,7 @@ static char *get_qemu_cmd(TestServer *s,
     } else {
         return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
                                QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
-                               mem_path, s->chr_name, s->socket_path,
+                               s->mem_path, s->chr_name, s->socket_path,
                                chr_opts, s->chr_name, extra);
     }
 }
@@ -506,6 +505,8 @@ static const char *init_hugepagefs(void)
 static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server = g_new0(TestServer, 1);
+    char template[] = "/tmp/vhost-test-XXXXXX";
+    const char *tmpfs;
     GMainContext *context = g_main_context_new();
 
     server->loop = g_main_loop_new(context, FALSE);
@@ -514,6 +515,14 @@ static TestServer *test_server_new(const gchar *name)
     /* run the main loop thread so the chardev may operate */
     server->thread = g_thread_new(NULL, thread_function, server->loop);
 
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s", template, strerror(errno));
+    }
+    g_assert(tmpfs);
+
+    server->tmpfs = g_strdup(tmpfs);
+    server->mem_path = init_hugepagefs() ? : server->tmpfs;
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name = g_strdup_printf("chr-%s", name);
@@ -559,7 +568,7 @@ static void test_server_listen(TestServer *server)
 
 static void test_server_free(TestServer *server)
 {
-    int i;
+    int i, ret;
 
     /* finish the helper thread and dispatch pending sources */
     g_main_loop_quit(server->loop);
@@ -569,6 +578,18 @@ static void test_server_free(TestServer *server)
     }
     g_main_loop_unref(server->loop);
 
+    unlink(server->socket_path);
+    g_free(server->socket_path);
+
+    unlink(server->mig_path);
+    g_free(server->mig_path);
+
+    ret = rmdir(server->tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s",
+                       server->tmpfs, strerror(errno));
+    }
+
     qemu_chr_fe_deinit(&server->chr, true);
 
     for (i = 0; i < server->fds_num; i++) {
@@ -579,12 +600,6 @@ static void test_server_free(TestServer *server)
         close(server->log_fd);
     }
 
-    unlink(server->socket_path);
-    g_free(server->socket_path);
-
-    unlink(server->mig_path);
-    g_free(server->mig_path);
-
     g_free(server->chr_name);
     g_assert(server->bus);
     qpci_free_pc(server->bus);
@@ -690,7 +705,7 @@ static void test_read_guest_mem(const void *arg)
                              "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
 
-    qemu_cmd = get_qemu_cmd(server, 512, memfd, root, "", "");
+    qemu_cmd = get_qemu_cmd(server, 512, memfd, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -725,7 +740,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -738,7 +753,7 @@ static void test_migrate(void)
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
     tmp = g_strdup_printf(" -incoming %s", uri);
-    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, "", tmp);
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
@@ -848,7 +863,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -890,7 +905,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -923,7 +938,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -971,7 +986,7 @@ static void test_multiqueue(void)
         cmd = g_strdup_printf(
             QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
             "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            512, 512, root, s->chr_name,
+            512, 512, s->mem_path, s->chr_name,
             s->socket_path, "", s->chr_name,
             s->queues, s->queues * 2 + 2);
     }
@@ -991,22 +1006,11 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    int ret;
-    char template[] = "/tmp/vhost-test-XXXXXX";
-
     g_test_init(&argc, &argv, NULL);
 
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
 
-    tmpfs = mkdtemp(template);
-    if (!tmpfs) {
-        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
-    }
-    g_assert(tmpfs);
-
-    root = init_hugepagefs() ? : tmpfs;
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1030,16 +1034,5 @@ int main(int argc, char **argv)
         qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
     }
 
-    ret = g_test_run();
-
-    /* cleanup */
-
-    ret = rmdir(tmpfs);
-    if (ret != 0) {
-        g_test_message("unable to rmdir: path (%s): %s\n",
-                       tmpfs, strerror(errno));
-    }
-    g_assert_cmpint(ret, ==, 0);
-
-    return ret;
+    return g_test_run();
 }
-- 
1.8.3.1
