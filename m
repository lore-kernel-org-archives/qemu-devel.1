Received: from eggs.gnu.org ([209.51.188.92]:49446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjf6-0001Oo-R5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjex-0004Dw-GE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:16 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:59534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grjex-000403-7c
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:07 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  7 Feb 2019 15:23:22 +0200
Message-Id: <2c1d9d03c5b3ee26b116db3438caa3df73dffa46.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/3] main-loop: Add qemu_idle_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This works like g_idle_add() but allows specifying a different
GMainContext. It also returns the GSource directly instead of its ID
number for convenience.

pty_chr_state() and qio_task_thread_worker() are modified to make use
of this new function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 chardev/char-pty.c       | 8 ++------
 include/qemu/main-loop.h | 8 ++++++++
 io/task.c                | 7 ++-----
 util/main-loop.c         | 9 +++++++++
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index f16a5e8d59..6562c38f39 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -209,13 +209,9 @@ static void pty_chr_state(Chardev *chr, int connected)
         pty_chr_timer_cancel(s);
         if (!s->connected) {
             g_assert(s->open_source == NULL);
-            s->open_source = g_idle_source_new();
+            s->open_source = qemu_idle_add(qemu_chr_be_generic_open_func,
+                                           chr, chr->gcontext);
             s->connected = 1;
-            g_source_set_callback(s->open_source,
-                                  qemu_chr_be_generic_open_func,
-                                  chr, NULL);
-            g_source_attach(s->open_source, chr->gcontext);
-            g_source_unref(s->open_source);
         }
         if (!chr->gsource) {
             chr->gsource = io_add_watch_poll(chr, s->ioc,
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index e59f9ae1e9..1865afd993 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
  */
 void qemu_mutex_unlock_iothread(void);
 
+/**
+ * qemu_idle_add: Add an idle function to a GMainContext
+ *
+ * This function is similar to GLib's g_idle_add() but it allows
+ * specifying a GMainContext instead of using the global one.
+ */
+GSource *qemu_idle_add(GSourceFunc func, gpointer data, GMainContext *ctx);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);
diff --git a/io/task.c b/io/task.c
index c8489fb790..bdd395b0ad 100644
--- a/io/task.c
+++ b/io/task.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
@@ -105,7 +106,6 @@ static gboolean qio_task_thread_result(gpointer opaque)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     struct QIOTaskThreadData *data = opaque;
-    GSource *idle;
 
     trace_qio_task_thread_run(data->task);
     data->worker(data->task, data->opaque);
@@ -117,10 +117,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
      */
     trace_qio_task_thread_exit(data->task);
 
-    idle = g_idle_source_new();
-    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
-    g_source_attach(idle, data->context);
-    g_source_unref(idle);
+    qemu_idle_add(qio_task_thread_result, data, data->context);
 
     return NULL;
 }
diff --git a/util/main-loop.c b/util/main-loop.c
index 443cb4cfe8..1c68e3bf5f 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -171,6 +171,15 @@ int qemu_init_main_loop(Error **errp)
     return 0;
 }
 
+GSource *qemu_idle_add(GSourceFunc func, gpointer data, GMainContext *ctx)
+{
+    GSource *idle = g_idle_source_new();
+    g_source_set_callback(idle, func, data, NULL);
+    g_source_attach(idle, ctx);
+    g_source_unref(idle);
+    return idle;
+}
+
 static int max_priority;
 
 #ifndef _WIN32
-- 
2.11.0
