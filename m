Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dk4re-00020F-L9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dk4rb-0004oP-LQ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:48:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:59634)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dk4ra-0004jF-VI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:48:43 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Tue, 22 Aug 2017 16:46:16 +0800
Message-Id: <1503391578-6121-2-git-send-email-wang.yong155@zte.com.cn>
In-Reply-To: <1503391578-6121-1-git-send-email-wang.yong155@zte.com.cn>
References: <1503391578-6121-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv4 01/03] qemu-iothread: IOThread supports the
 GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com
Cc: wang.yong155@zte.com.cn, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

From: Wang Yong <wang.yong155@zte.com.cn>

IOThread uses AioContext event loop and does not run a GMainContext.
Therefore,chardev cannot work in IOThread,such as the chardev is
used for colo-compare packets reception.

This patch makes the IOThread run the GMainContext event loop,
chardev and IOThread can work together.

Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
---
 include/sysemu/iothread.h |  4 ++++
 iothread.c                | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index e6da1a4..d2985b3 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -24,6 +24,9 @@ typedef struct {
 
     QemuThread thread;
     AioContext *ctx;
+    GMainContext *worker_context;
+    GMainLoop *main_loop;
+    GOnce once;
     QemuMutex init_done_lock;
     QemuCond init_done_cond;    /* is thread initialization done? */
     bool stopping;
@@ -41,5 +44,6 @@ typedef struct {
 char *iothread_get_id(IOThread *iothread);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
+GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index beeb870..fb1c55b 100644
--- a/iothread.c
+++ b/iothread.c
@@ -57,6 +57,20 @@ static void *iothread_run(void *opaque)
 
     while (!atomic_read(&iothread->stopping)) {
         aio_poll(iothread->ctx, true);
+
+        if (atomic_read(&iothread->worker_context)) {
+            g_main_context_push_thread_default(iothread->worker_context);
+            iothread->main_loop =
+                g_main_loop_new(iothread->worker_context, TRUE);
+            g_main_loop_run(iothread->main_loop);
+
+            g_main_loop_unref(iothread->main_loop);
+            iothread->main_loop = NULL;
+
+            g_main_context_pop_thread_default(iothread->worker_context);
+            g_main_context_unref(iothread->worker_context);
+            iothread->worker_context = NULL;
+        }
     }
 
     rcu_unregister_thread();
@@ -73,6 +87,9 @@ static int iothread_stop(Object *object, void *opaque)
     }
     iothread->stopping = true;
     aio_notify(iothread->ctx);
+    if (atomic_read(&iothread->main_loop)) {
+        g_main_loop_quit(iothread->main_loop);
+    }
     qemu_thread_join(&iothread->thread);
     return 0;
 }
@@ -125,6 +142,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
 
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
+    iothread->once = (GOnce) G_ONCE_INIT;
 
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
@@ -309,3 +327,28 @@ void iothread_stop_all(void)
 
     object_child_foreach(container, iothread_stop, NULL);
 }
+
+static gpointer iothread_g_main_context_init(gpointer opaque)
+{
+    AioContext *ctx;
+    IOThread *iothread = opaque;
+    GSource *source;
+
+    iothread->worker_context = g_main_context_new();
+
+    ctx = iothread_get_aio_context(iothread);
+    source = aio_get_g_source(ctx);
+    g_source_attach(source, iothread->worker_context);
+    g_source_unref(source);
+
+    aio_notify(iothread->ctx);
+
+    return NULL;
+}
+
+GMainContext *iothread_get_g_main_context(IOThread *iothread)
+{
+    g_once(&iothread->once, iothread_g_main_context_init, iothread);
+
+    return iothread->worker_context;
+}
-- 
1.8.3.1
