Received: from eggs.gnu.org ([2001:4830:134:3::10]:55725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJlA-000454-L9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJl9-0004zw-Lb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvJl9-0004ys-D1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A6844E4D1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:56:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Sep 2017 16:56:11 +0800
Message-Id: <1506070572-7549-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1506070572-7549-1-git-send-email-peterx@redhat.com>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] iothread: export iothread_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

So that internal iothread users can explicitly stop one iothread without
destroying it.

Since at it, fix iothread_stop() to allow re-entrance.  Before this
patch we may call iothread_stop() twice on single iothread, while that
may not be correct since qemu_thread_join() is not allowed to run twice.
>From manual of pthread_join():

  Joining with a thread that has previously been joined results in
  undefined behavior.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/iothread.h |  1 +
 iothread.c                | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index b07663f..110329b 100644
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
index 74e400c..894756b 100644
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
-    if (!iothread || !iothread->ctx) {
-        return 0;
+    if (iothread->stopping) {
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
+    if (!iothread || !iothread->ctx) {
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
2.7.4
