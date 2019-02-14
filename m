Received: from eggs.gnu.org ([209.51.188.92]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guL4K-0002MK-A6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guKvf-0003NL-9I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:08 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1guKvf-0003Mr-2m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:07 -0500
Received: by mail-wr1-x443.google.com with SMTP id l5so6320983wrw.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:36:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Feb 2019 18:35:54 +0100
Message-Id: <1550165756-21617-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
References: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/9] vhost-user-test: create a main loop per
 TestServer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com

This makes the tests more independent and removes the need to defer test_server_free
via an idle event source.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-13-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 53 +++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index cdbdf3d..33030e0 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -146,6 +146,9 @@ typedef struct TestServer {
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     VhostUserMemory memory;
+    GMainContext *context;
+    GMainLoop *loop;
+    GThread *thread;
     GMutex data_mutex;
     GCond data_cond;
     int log_fd;
@@ -495,6 +498,12 @@ static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server = g_new0(TestServer, 1);
 
+    server->context = g_main_context_new();
+    server->loop = g_main_loop_new(server->context, FALSE);
+
+    /* run the main loop thread so the chardev may operate */
+    server->thread = g_thread_new(NULL, thread_function, server->loop);
+
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name = g_strdup_printf("chr-%s", name);
@@ -524,13 +533,13 @@ static void test_server_create_chr(TestServer *server, const gchar *opt)
     Chardev *chr;
 
     chr_path = g_strdup_printf("unix:%s%s", server->socket_path, opt);
-    chr = qemu_chr_new(server->chr_name, chr_path, NULL);
+    chr = qemu_chr_new(server->chr_name, chr_path, server->context);
     g_free(chr_path);
 
     g_assert_nonnull(chr);
     qemu_chr_fe_init(&server->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
-                             chr_event, NULL, server, NULL, true);
+                             chr_event, NULL, server, server->context, true);
 }
 
 static void test_server_listen(TestServer *server)
@@ -538,10 +547,19 @@ static void test_server_listen(TestServer *server)
     test_server_create_chr(server, ",server,nowait");
 }
 
-static gboolean _test_server_free(TestServer *server)
+static void test_server_free(TestServer *server)
 {
     int i;
 
+    /* finish the helper thread and dispatch pending sources */
+    g_main_loop_quit(server->loop);
+    g_thread_join(server->thread);
+    while (g_main_context_pending(NULL)) {
+        g_main_context_iteration(NULL, TRUE);
+    }
+    g_main_loop_unref(server->loop);
+    g_main_context_unref(server->context);
+
     qemu_chr_fe_deinit(&server->chr, true);
 
     for (i = 0; i < server->fds_num; i++) {
@@ -563,13 +581,6 @@ static gboolean _test_server_free(TestServer *server)
     qpci_free_pc(server->bus);
 
     g_free(server);
-
-    return FALSE;
-}
-
-static void test_server_free(TestServer *server)
-{
-    g_idle_add((GSourceFunc)_test_server_free, server);
 }
 
 static void wait_for_log_fd(TestServer *s)
@@ -728,7 +739,7 @@ static void test_migrate(void)
                           sizeof(TestMigrateSource));
     ((TestMigrateSource *)source)->src = s;
     ((TestMigrateSource *)source)->dest = dest;
-    g_source_attach(source, NULL);
+    g_source_attach(source, s->context);
 
     /* slow down migration to have time to fiddle with log */
     /* TODO: qtest could learn to break on some places */
@@ -825,6 +836,7 @@ connect_thread(gpointer data)
 static void test_reconnect_subprocess(void)
 {
     TestServer *s = test_server_new("reconnect");
+    GSource *src;
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
@@ -842,7 +854,10 @@ static void test_reconnect_subprocess(void)
     /* reconnect */
     s->fds_num = 0;
     s->rings = 0;
-    g_idle_add(reconnect_cb, s);
+    src = g_idle_source_new();
+    g_source_set_callback(src, reconnect_cb, s, NULL);
+    g_source_attach(src, s->context);
+    g_source_unref(src);
     g_assert(wait_for_fds(s));
     wait_for_rings_started(s, 2);
 
@@ -974,8 +989,6 @@ int main(int argc, char **argv)
     const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
-    GMainLoop *loop;
-    GThread *thread;
 
     g_test_init(&argc, &argv, NULL);
 
@@ -997,10 +1010,6 @@ int main(int argc, char **argv)
     }
 #endif
 
-    loop = g_main_loop_new(NULL, FALSE);
-    /* run the main loop thread so the chardev may operate */
-    thread = g_thread_new(NULL, thread_function, loop);
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1028,14 +1037,6 @@ int main(int argc, char **argv)
 
     /* cleanup */
 
-    /* finish the helper thread and dispatch pending sources */
-    g_main_loop_quit(loop);
-    g_thread_join(thread);
-    while (g_main_context_pending(NULL)) {
-        g_main_context_iteration (NULL, TRUE);
-    }
-    g_main_loop_unref(loop);
-
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s\n",
-- 
1.8.3.1
