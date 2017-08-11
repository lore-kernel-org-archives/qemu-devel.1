Received: from eggs.gnu.org ([2001:4830:134:3::10]:33821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dfiYU-0000mK-1O
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dfiYP-0007hq-2G
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:10:58 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:53790 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dfiYO-0007eI-Nu
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:10:53 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Fri, 11 Aug 2017 08:29:15 +0800
Message-Id: <1502411355-3943-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCH] qemu-iothread: IOThread supports the
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

From: Wang Yong<wang.yong155@zte.com.cn>

IOThread uses AioContext event loop and does not run a GMainContext.
Therefore,chardev cannot work in IOThread,such as the chardev is
used for colo-compare packets reception.

This patch makes the IOThread run the GMainContext event loop,
chardev and IOThread can work together.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 include/sysemu/iothread.h |  1 +
 iothread.c                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index e6da1a4..ffe4e8a 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -24,6 +24,7 @@ typedef struct {
 
     QemuThread thread;
     AioContext *ctx;
+    GMainLoop *loop;
     QemuMutex init_done_lock;
     QemuCond init_done_cond;    /* is thread initialization done? */
     bool stopping;
diff --git a/iothread.c b/iothread.c
index beeb870..b6f3c3c 100644
--- a/iothread.c
+++ b/iothread.c
@@ -46,6 +46,7 @@ AioContext *qemu_get_current_aio_context(void)
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
+    GMainContext *context;
 
     rcu_register_thread();
 
@@ -57,6 +58,15 @@ static void *iothread_run(void *opaque)
 
     while (!atomic_read(&iothread->stopping)) {
         aio_poll(iothread->ctx, true);
+
+        context = iothread->ctx->source.context;
+        if (context) {
+            iothread->loop = g_main_loop_new(context, TRUE);
+            g_main_loop_run(iothread->loop);
+
+            g_main_loop_unref(iothread->loop);
+            g_main_context_unref(context);
+        }
     }
 
     rcu_unregister_thread();
@@ -72,6 +82,9 @@ static int iothread_stop(Object *object, void *opaque)
         return 0;
     }
     iothread->stopping = true;
+    if (iothread->loop) {
+        g_main_loop_quit(iothread->loop);
+    }
     aio_notify(iothread->ctx);
     qemu_thread_join(&iothread->thread);
     return 0;
-- 
1.8.3.1
