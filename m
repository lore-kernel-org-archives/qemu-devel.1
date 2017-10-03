Received: from eggs.gnu.org ([2001:4830:134:3::10]:36691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScq-0001xL-KD
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScn-0005qu-Fm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dzScn-0005pL-6r
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:13:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  3 Oct 2017 15:12:25 -0400
Message-Id: <20171003191227.11845-4-stefanha@redhat.com>
In-Reply-To: <20171003191227.11845-1-stefanha@redhat.com>
References: <20171003191227.11845-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] iothread: export iothread_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Peter Xu <peterx@redhat.com>

So that internal iothread users can explicitly stop one iothread without
destroying it.

Since at it, fix iothread_stop() to allow it to be called multiple
times.  Before this patch we may call iothread_stop() more than once on
single iothread, while that may not be correct since qemu_thread_join()
is not allowed to run twice.  From manual of pthread_join():

  Joining with a thread that has previously been joined results in
  undefined behavior.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20170928025958.1420-4-peterx@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  1 +
 iothread.c                | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index b07663f0a1..110329b2b4 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -52,6 +52,7 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread);
  * "query-iothreads".
  */
 IOThread *iothread_create(const char *id, Error **errp);
+void iothread_stop(IOThread *iothread);
 void iothread_destroy(IOThread *iothread);
 
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index 0672a9196f..b3c092b2d7 100644
--- a/iothread.c
+++ b/iothread.c
@@ -80,13 +80,10 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
 
-static int iothread_stop(Object *object, void *opaque)
+void iothread_stop(IOThread *iothread)
 {
-    IOThread *iothread;
-
-    iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
-    if (!iothread || !iothread->ctx || iothread->stopping) {
-        return 0;
+    if (!iothread->ctx || iothread->stopping) {
+        return;
     }
     iothread->stopping = true;
     aio_notify(iothread->ctx);
@@ -94,6 +91,17 @@ static int iothread_stop(Object *object, void *opaque)
         g_main_loop_quit(iothread->main_loop);
     }
     qemu_thread_join(&iothread->thread);
+}
+
+static int iothread_stop_iter(Object *object, void *opaque)
+{
+    IOThread *iothread;
+
+    iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
+    if (!iothread) {
+        return 0;
+    }
+    iothread_stop(iothread);
     return 0;
 }
 
@@ -108,7 +116,7 @@ static void iothread_instance_finalize(Object *obj)
 {
     IOThread *iothread = IOTHREAD(obj);
 
-    iothread_stop(obj, NULL);
+    iothread_stop(iothread);
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
     if (!iothread->ctx) {
@@ -328,7 +336,7 @@ void iothread_stop_all(void)
         aio_context_release(ctx);
     }
 
-    object_child_foreach(container, iothread_stop, NULL);
+    object_child_foreach(container, iothread_stop_iter, NULL);
 }
 
 static gpointer iothread_g_main_context_init(gpointer opaque)
-- 
2.13.6
