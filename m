Received: from eggs.gnu.org ([2001:4830:134:3::10]:35693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhWNF-00042Q-CG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhWNB-0006Zm-9y
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:34:49 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:48108 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhWNA-0006YL-Np
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:34:45 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Tue, 15 Aug 2017 15:28:15 +0800
Message-Id: <1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCH v2] qemu-iothread: IOThread supports the
 GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com
Cc: wang.yong155@zte.com.cn, wang.guang55@zte.com.cn, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

From: Wang Yong <wang.yong155@zte.com.cn>

IOThread uses AioContext event loop and does not run a GMainContext.
Therefore,chardev cannot work in IOThread,such as the chardev is
used for colo-compare packets reception.

This patch makes the IOThread run the GMainContext event loop,
chardev and IOThread can work together.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 include/sysemu/iothread.h | 10 +++++++++
 iothread.c                | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index e6da1a4..89e913c 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -20,10 +20,19 @@
 #define TYPE_IOTHREAD "iothread"
 
 typedef struct {
+    GMainContext *worker_context;
+    GMainLoop *main_loop;
+    GOnce once;
+
+    QEMUBH *bh;
+} GMainOnce;
+
+typedef struct {
     Object parent_obj;
 
     QemuThread thread;
     AioContext *ctx;
+    GMainOnce thread_gonce;
     QemuMutex init_done_lock;
     QemuCond init_done_cond;    /* is thread initialization done? */
     bool stopping;
@@ -41,5 +50,6 @@ typedef struct {
 char *iothread_get_id(IOThread *iothread);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 void iothread_stop_all(void);
+GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index beeb870..9995eb0 100644
--- a/iothread.c
+++ b/iothread.c
@@ -72,6 +72,9 @@ static int iothread_stop(Object *object, void *opaque)
         return 0;
     }
     iothread->stopping = true;
+    if (iothread->thread_gonce.main_loop) {
+        g_main_loop_quit(iothread->thread_gonce.main_loop);
+    }
     aio_notify(iothread->ctx);
     qemu_thread_join(&iothread->thread);
     return 0;
@@ -125,6 +128,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
 
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
+    iothread->thread_gonce.once = (GOnce) G_ONCE_INIT;
 
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
@@ -309,3 +313,53 @@ void iothread_stop_all(void)
 
     object_child_foreach(container, iothread_stop, NULL);
 }
+
+static void iothread_g_main_context_bh(void *opaque)
+{
+    GMainOnce *g = opaque;
+
+    qemu_bh_delete(g->bh);
+    g->bh = NULL;
+
+    g_main_context_push_thread_default(g->worker_context);
+
+    g->main_loop = g_main_loop_new(g->worker_context, TRUE);
+    g_main_loop_run(g->main_loop);
+
+    g_main_loop_unref(g->main_loop);
+    g->main_loop = NULL;
+
+    g_main_context_pop_thread_default(g->worker_context);
+    g_main_context_unref(g->worker_context);
+    g->worker_context = NULL;
+}
+
+static gpointer iothread_g_main_context_init(gpointer g_data)
+{
+    AioContext *ctx;
+    IOThread *iothread = (IOThread *)g_data;
+    GMainOnce *g = &iothread->thread_gonce;
+    GSource *source;
+
+    g->worker_context = g_main_context_new();
+
+    ctx = iothread_get_aio_context(iothread);
+    source = aio_get_g_source(ctx);
+    g_source_attach(source, g->worker_context);
+    g_source_unref(source);
+
+    g->bh = aio_bh_new(ctx,
+                       iothread_g_main_context_bh, g);
+    qemu_bh_schedule(g->bh);
+
+    return (gpointer) g->worker_context;
+}
+
+GMainContext *iothread_get_g_main_context(IOThread *iothread)
+{
+    GMainOnce *g = &iothread->thread_gonce;
+
+    g_once(&g->once, iothread_g_main_context_init, iothread);
+
+    return (GMainContext *) g->once.retval;
+}
-- 
1.8.3.1
