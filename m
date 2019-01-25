Received: from eggs.gnu.org ([209.51.188.92]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gn57H-0000XL-6y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gn57C-0006cj-MA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gn57C-0006bg-Fp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:18:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m1so7514648wml.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 09:18:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	w12sm91534922wrr.23.2019.01.25.09.17.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Jan 2019 09:17:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 18:17:55 +0100
Message-Id: <1548436676-31749-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
References: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/50] vhost-user-test: create a main loop per
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

This makes the tests more independent and removes the need to defer test_server_free
via an idle event source.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-13-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 15e3bbf..4ea33b5 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -146,6 +146,8 @@ typedef struct TestServer {
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     VhostUserMemory memory;
+    GMainLoop *loop;
+    GThread *thread;
     GMutex data_mutex;
     GCond data_cond;
     int log_fd;
@@ -494,6 +496,13 @@ static const char *init_hugepagefs(const char *path)
 static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server = g_new0(TestServer, 1);
+    GMainContext *context = g_main_context_new();
+
+    server->loop = g_main_loop_new(context, FALSE);
+    g_main_context_unref(context);
+
+    /* run the main loop thread so the chardev may operate */
+    server->thread = g_thread_new(NULL, thread_function, server->loop);
 
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
@@ -538,10 +547,18 @@ static void test_server_listen(TestServer *server)
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
+
     qemu_chr_fe_deinit(&server->chr, true);
 
     for (i = 0; i < server->fds_num; i++) {
@@ -563,13 +580,6 @@ static gboolean _test_server_free(TestServer *server)
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
@@ -974,8 +984,6 @@ int main(int argc, char **argv)
     const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
-    GMainLoop *loop;
-    GThread *thread;
 
     g_test_init(&argc, &argv, NULL);
 
@@ -997,10 +1005,6 @@ int main(int argc, char **argv)
     }
 #endif
 
-    loop = g_main_loop_new(NULL, FALSE);
-    /* run the main loop thread so the chardev may operate */
-    thread = g_thread_new(NULL, thread_function, loop);
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1028,14 +1032,6 @@ int main(int argc, char **argv)
 
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
