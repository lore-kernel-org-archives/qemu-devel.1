Received: from eggs.gnu.org ([2001:4830:134:3::10]:45928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWN-0003l1-7t
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWI-0003yM-Hn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60907)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWH-0003wA-Mk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:45:58 -0400
From: Yong Wang <wang.yong155@zte.com.cn>
Date: Mon, 5 Jun 2017 18:44:51 +0800
Message-Id: <1496659493-1105-3-git-send-email-wang.yong155@zte.com.cn>
In-Reply-To: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv2 02/04] colo-compare: Process pactkets in the
 IOThread of the primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.yong155@zte.com.cn, wang.guang55@zte.com.cn

From: Wang Yong <wang.yong155@zte.com.cn>

Process pactkets in the IOThread which arrived over the socket.
we use qio_channel_set_aio_fd_handler to set the handlers on the
IOThread AioContext.then the packets from the primary and the secondary
are processed in the IOThread.
Finally remove the colo-compare thread using the IOThread instead.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 net/colo-compare.c | 133 ++++++++++++++++++++++++++++++++++++-----------------
 net/colo.h         |   1 +
 2 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index b0942a4..e3af791 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
+#include "io/channel.h"
 #include "sysemu/iothread.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
@@ -82,11 +83,6 @@ typedef struct CompareState {
     GQueue conn_list;
     /* hashtable to save connection */
     GHashTable *connection_track_table;
-    /* compare thread, a thread for each NIC */
-    QemuThread thread;
-
-    GMainContext *worker_context;
-    GMainLoop *compare_loop;
 
     /*compare iothread*/
     IOThread *iothread;
@@ -95,6 +91,14 @@ typedef struct CompareState {
     QEMUTimer *packet_check_timer;
 } CompareState;
 
+typedef struct {
+    Chardev parent;
+    QIOChannel *ioc; /*I/O channel */
+} CompareChardev;
+
+#define COMPARE_CHARDEV(obj)                                     \
+    OBJECT_CHECK(CompareChardev, (obj), TYPE_CHARDEV_SOCKET)
+
 typedef struct CompareClass {
     ObjectClass parent_class;
 } CompareClass;
@@ -107,6 +111,12 @@ enum {
 static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
                             uint32_t size);
+static void compare_chr_set_aio_fd_handlers(CharBackend *b,
+                                    AioContext *ctx,
+                                    IOCanReadHandler *fd_can_read,
+                                    IOReadHandler *fd_read,
+                                    IOEventHandler *fd_event,
+                                    void *opaque);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -534,6 +544,30 @@ err:
     return ret < 0 ? ret : -EIO;
 }
 
+static void compare_chr_read(void *opaque)
+{
+    Chardev *chr = opaque;
+    uint8_t buf[CHR_READ_BUF_LEN];
+    int len, size;
+    int max_size;
+
+    max_size = qemu_chr_be_can_write(chr);
+    if (max_size <= 0) {
+        return;
+    }
+
+    len = sizeof(buf);
+    if (len > max_size) {
+        len = max_size;
+    }
+    size = CHARDEV_GET_CLASS(chr)->chr_sync_read(chr, (void *)buf, len);
+    if (size == 0) {
+        return;
+    } else if (size > 0) {
+        qemu_chr_be_write(chr, buf, size);
+    }
+}
+
 static int compare_chr_can_read(void *opaque)
 {
     return COMPARE_READ_LEN_MAX;
@@ -550,8 +584,8 @@ static void compare_pri_chr_in(void *opaque, const uint8_t *buf, int size)
 
     ret = net_fill_rstate(&s->pri_rs, buf, size);
     if (ret == -1) {
-        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
-                                 NULL, NULL, true);
+        compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
+                                    NULL, NULL, NULL, NULL);
         error_report("colo-compare primary_in error");
     }
 }
@@ -567,8 +601,8 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
 
     ret = net_fill_rstate(&s->sec_rs, buf, size);
     if (ret == -1) {
-        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
-                                 NULL, NULL, true);
+        compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
+                                    NULL, NULL, NULL, NULL);
         error_report("colo-compare secondary_in error");
     }
 }
@@ -605,34 +639,57 @@ static void colo_compare_timer_del(CompareState *s)
     }
 }
 
-static void *colo_compare_thread(void *opaque)
-{
-    CompareState *s = opaque;
-
-    s->worker_context = g_main_context_new();
-
-    qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
-                          compare_pri_chr_in, NULL, s, s->worker_context, true);
-    qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
-                          compare_sec_chr_in, NULL, s, s->worker_context, true);
-
-    s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
-
-    g_main_loop_run(s->compare_loop);
-
-    g_main_loop_unref(s->compare_loop);
-    g_main_context_unref(s->worker_context);
-    return NULL;
-}
 
 static void colo_compare_iothread(CompareState *s)
 {
     object_ref(OBJECT(s->iothread));
     s->ctx = iothread_get_aio_context(s->iothread);
 
+    compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
+                    compare_chr_can_read,
+                    compare_pri_chr_in,
+                    NULL,
+                    s);
+    compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
+                    compare_chr_can_read,
+                    compare_sec_chr_in,
+                    NULL,
+                    s);
+
     colo_compare_timer_init(s);
 }
 
+static void compare_chr_set_aio_fd_handlers(CharBackend *b,
+                                    AioContext *ctx,
+                                    IOCanReadHandler *fd_can_read,
+                                    IOReadHandler *fd_read,
+                                    IOEventHandler *fd_event,
+                                    void *opaque)
+{
+    CompareChardev *s;
+
+    if (!b->chr) {
+        return;
+    }
+    s = COMPARE_CHARDEV(b->chr);
+    if (!s->ioc) {
+        return;
+    }
+
+    b->chr_can_read = fd_can_read;
+    b->chr_read = fd_read;
+    b->chr_event = fd_event;
+    b->opaque = opaque;
+    remove_fd_in_watch(b->chr);
+
+    if (b->chr_read) {
+        qio_channel_set_aio_fd_handler(s->ioc, ctx,
+                                compare_chr_read, NULL, b->chr);
+    } else {
+        qio_channel_set_aio_fd_handler(s->ioc, ctx, NULL, NULL, NULL);
+    }
+}
+
 static char *compare_get_pri_indev(Object *obj, Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
@@ -736,8 +793,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
 {
     CompareState *s = COLO_COMPARE(uc);
     Chardev *chr;
-    char thread_name[64];
-    static int compare_id;
 
     if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
         error_setg(errp, "colo compare needs 'primary_in' ,"
@@ -776,12 +831,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                                                       g_free,
                                                       connection_destroy);
 
-    sprintf(thread_name, "colo-compare %d", compare_id);
-    qemu_thread_create(&s->thread, thread_name,
-                       colo_compare_thread, s,
-                       QEMU_THREAD_JOINABLE);
-    compare_id++;
-
     colo_compare_iothread(s);
 
     return;
@@ -834,16 +883,14 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
 
-    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
-                             s->worker_context, true);
-    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
-                             s->worker_context, true);
+    compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
+                                    NULL, NULL, NULL, NULL);
+    compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
+                                    NULL, NULL, NULL, NULL);
+
     qemu_chr_fe_deinit(&s->chr_out);
     colo_compare_timer_del(s);
 
-    g_main_loop_quit(s->compare_loop);
-    qemu_thread_join(&s->thread);
-
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
diff --git a/net/colo.h b/net/colo.h
index 7c524f3..936dea1 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -84,5 +84,6 @@ Connection *connection_get(GHashTable *connection_track_table,
 void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size);
 void packet_destroy(void *opaque, void *user_data);
+void remove_fd_in_watch(Chardev *chr);
 
 #endif /* QEMU_COLO_PROXY_H */
-- 
1.8.3.1
