Received: from eggs.gnu.org ([209.51.188.92]:52344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Uo-0004uT-6N
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Um-00047E-Sl
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:02 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gx9Um-0003pf-88
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:00 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 22 Feb 2019 13:59:11 +0200
Message-Id: <c86d09ddfada3d17bbdf9719fb0ac7df62964b51.1550836631.git.berto@igalia.com>
In-Reply-To: <cover.1550836631.git.berto@igalia.com>
References: <cover.1550836631.git.berto@igalia.com>
In-Reply-To: <cover.1550836631.git.berto@igalia.com>
References: <cover.1550836631.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 2/3] main-loop: Add qemu_idle_add()
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

qio_task_thread_worker() is modified to make use of this new function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/qemu/main-loop.h | 12 ++++++++++++
 io/task.c                | 10 +++-------
 util/main-loop.c         |  9 +++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index f6ba78ea73..f966c015d0 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -295,6 +295,18 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
  */
 void qemu_mutex_unlock_iothread(void);
 
+/**
+ * qemu_idle_add: Add an idle function to a GMainContext
+ *
+ * This function is similar to GLib's g_idle_add() but it allows
+ * specifying a GMainContext instead of using the global one.
+ *
+ * The returned GSource is owned by the GMainContext and is deleted
+ * automatically after @func returns false. It can also be deleted by
+ * removing it from the GMainContext using g_source_destroy().
+ */
+GSource *qemu_idle_add(GSourceFunc func, gpointer data, GMainContext *ctx);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);
diff --git a/io/task.c b/io/task.c
index 1ae7b86488..16754e22ba 100644
--- a/io/task.c
+++ b/io/task.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
@@ -130,13 +131,8 @@ static gpointer qio_task_thread_worker(gpointer opaque)
     trace_qio_task_thread_exit(task);
 
     qemu_mutex_lock(&task->thread_lock);
-
-    task->thread->completion = g_idle_source_new();
-    g_source_set_callback(task->thread->completion,
-                          qio_task_thread_result, task, NULL);
-    g_source_attach(task->thread->completion,
-                    task->thread->context);
-    g_source_unref(task->thread->completion);
+    task->thread->completion = qemu_idle_add(qio_task_thread_result, task,
+                                             task->thread->context);
     trace_qio_task_thread_source_attach(task, task->thread->completion);
 
     qemu_cond_signal(&task->thread_cond);
diff --git a/util/main-loop.c b/util/main-loop.c
index d4a521caeb..e23eda68cc 100644
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
