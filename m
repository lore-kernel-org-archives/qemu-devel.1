Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzw-0000P9-79
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzt-0000rs-1c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUSzs-0000qN-NS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A98B44DD49
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:43 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:25 +0800
Message-Id: <20170710072027.7948-4-famz@redhat.com>
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
References: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/5] iothread: Extract iothread_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is the "create and start the thread" part of iothread spawning.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/sysemu/iothread.h |  1 +
 iothread.c                | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 37f033b..a3a03e8 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -36,6 +36,7 @@ typedef struct {
    OBJECT_CHECK(IOThread, obj, TYPE_IOTHREAD)
 
 char *iothread_get_id(IOThread *iothread);
+void iothread_start(IOThread *iothread, const char *thread_name, Error **errp);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
 
diff --git a/iothread.c b/iothread.c
index ce56724..8d703db 100644
--- a/iothread.c
+++ b/iothread.c
@@ -76,6 +76,10 @@ static void iothread_instance_init(Object *obj)
     IOThread *iothread = IOTHREAD(obj);
 
     iothread->poll_params.max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
+    iothread->stopping = false;
+    iothread->thread_id = -1;
+    qemu_mutex_init(&iothread->init_done_lock);
+    qemu_cond_init(&iothread->init_done_cond);
 }
 
 static void iothread_instance_finalize(Object *obj)
@@ -91,14 +95,26 @@ static void iothread_instance_finalize(Object *obj)
     aio_context_unref(iothread->ctx);
 }
 
+void iothread_start(IOThread *iothread, const char *thread_name, Error **errp)
+{
+    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
+                       iothread, QEMU_THREAD_JOINABLE);
+
+    /* Wait for initialization to complete */
+    qemu_mutex_lock(&iothread->init_done_lock);
+    while (iothread->thread_id == -1) {
+        qemu_cond_wait(&iothread->init_done_cond,
+                       &iothread->init_done_lock);
+    }
+    qemu_mutex_unlock(&iothread->init_done_lock);
+}
+
 static void iothread_complete(UserCreatable *obj, Error **errp)
 {
     Error *local_error = NULL;
     IOThread *iothread = IOTHREAD(obj);
     char *name, *thread_name;
 
-    iothread->stopping = false;
-    iothread->thread_id = -1;
     iothread->ctx = aio_context_new(&local_error);
     if (!iothread->ctx) {
         error_propagate(errp, local_error);
@@ -114,26 +130,15 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
         return;
     }
 
-    qemu_mutex_init(&iothread->init_done_lock);
-    qemu_cond_init(&iothread->init_done_cond);
 
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+    iothread_start(iothread, thread_name, errp);
     g_free(thread_name);
     g_free(name);
-
-    /* Wait for initialization to complete */
-    qemu_mutex_lock(&iothread->init_done_lock);
-    while (iothread->thread_id == -1) {
-        qemu_cond_wait(&iothread->init_done_cond,
-                       &iothread->init_done_lock);
-    }
-    qemu_mutex_unlock(&iothread->init_done_lock);
 }
 
 typedef struct {
-- 
2.9.4
