Received: from eggs.gnu.org ([2001:4830:134:3::10]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNZ-0001qi-T1
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNY-0000k0-EU
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3403
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNX-0000jT-I5
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:52 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:42 +0800
Message-ID: <1492849558-17540-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 02/18] colo-compare: implement the process
 of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

While do checkpoint, we need to flush all the unhandled packets,
By using the filter notifier mechanism, we can easily to notify
every compare object to do this process, which runs inside
of compare threads as a coroutine.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.h |  6 +++++
 2 files changed, 84 insertions(+)
 create mode 100644 net/colo-compare.h

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 97bf0e5..3adccfb 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,17 +29,24 @@
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
+#include "net/colo-compare.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
 
+static QTAILQ_HEAD(, CompareState) net_compares =
+       QTAILQ_HEAD_INITIALIZER(net_compares);
+
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 
+static QemuMutex event_mtx = { .lock = PTHREAD_MUTEX_INITIALIZER };
+static QemuCond event_complete_cond = { .cond = PTHREAD_COND_INITIALIZER };
+static int event_unhandled_count;
 /*
   + CompareState ++
   |               |
@@ -87,6 +94,10 @@ typedef struct CompareState {
 
     GMainContext *worker_context;
     GMainLoop *compare_loop;
+    /* Used for COLO to notify compare to do something */
+    FilterNotifier *notifier;
+
+    QTAILQ_ENTRY(CompareState) next;
 } CompareState;
 
 typedef struct CompareClass {
@@ -417,6 +428,11 @@ static void colo_compare_connection(void *opaque, void *user_data)
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
         pkt = g_queue_pop_tail(&conn->primary_list);
+        if (!pkt) {
+            error_report("colo-compare pop pkt failed");
+            return;
+        }
+
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -538,6 +554,53 @@ static gboolean check_old_packet_regular(void *opaque)
     return TRUE;
 }
 
+/* Public API, Used for COLO frame to notify compare event */
+void colo_notify_compares_event(void *opaque, int event, Error **errp)
+{
+    CompareState *s;
+    int ret;
+
+    qemu_mutex_lock(&event_mtx);
+    QTAILQ_FOREACH(s, &net_compares, next) {
+        ret = filter_notifier_set(s->notifier, event);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to write value to eventfd");
+            goto fail;
+        }
+        event_unhandled_count++;
+    }
+    /* Wait all compare threads to finish handling this event */
+    while (event_unhandled_count > 0) {
+        qemu_cond_wait(&event_complete_cond, &event_mtx);
+    }
+
+fail:
+    qemu_mutex_unlock(&event_mtx);
+}
+
+static void colo_flush_packets(void *opaque, void *user_data);
+
+static void colo_compare_handle_event(void *opaque, int event)
+{
+    FilterNotifier *notify = opaque;
+    CompareState *s = notify->opaque;
+
+    switch (event) {
+    case COLO_CHECKPOINT:
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+        break;
+    case COLO_FAILOVER:
+        break;
+    default:
+        break;
+    }
+    qemu_mutex_lock(&event_mtx);
+    assert(event_unhandled_count > 0);
+    event_unhandled_count--;
+    qemu_cond_broadcast(&event_complete_cond);
+    qemu_mutex_unlock(&event_mtx);
+}
+
 static void *colo_compare_thread(void *opaque)
 {
     CompareState *s = opaque;
@@ -558,10 +621,15 @@ static void *colo_compare_thread(void *opaque)
                           (GSourceFunc)check_old_packet_regular, s, NULL);
     g_source_attach(timeout_source, s->worker_context);
 
+    s->notifier = filter_notifier_new(colo_compare_handle_event, s, NULL);
+    g_source_attach(&s->notifier->source, s->worker_context);
+
     qemu_sem_post(&s->thread_ready);
 
     g_main_loop_run(s->compare_loop);
 
+    g_source_destroy(&s->notifier->source);
+    g_source_unref(&s->notifier->source);
     g_source_destroy(timeout_source);
     g_source_unref(timeout_source);
 
@@ -706,6 +774,8 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
 
+    QTAILQ_INSERT_TAIL(&net_compares, s, next);
+
     g_queue_init(&s->conn_list);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
@@ -765,6 +835,7 @@ static void colo_compare_init(Object *obj)
 static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
+    CompareState *tmp = NULL;
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
                              s->worker_context, true);
@@ -777,6 +848,13 @@ static void colo_compare_finalize(Object *obj)
     }
     qemu_thread_join(&s->thread);
 
+    QTAILQ_FOREACH(tmp, &net_compares, next) {
+        if (!strcmp(tmp->outdev, s->outdev)) {
+            QTAILQ_REMOVE(&net_compares, s, next);
+            break;
+        }
+    }
+
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
diff --git a/net/colo-compare.h b/net/colo-compare.h
new file mode 100644
index 0000000..c9c62f5
--- /dev/null
+++ b/net/colo-compare.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_COLO_COMPARE_H
+#define QEMU_COLO_COMPARE_H
+
+void colo_notify_compares_event(void *opaque, int event, Error **errp);
+
+#endif /* QEMU_COLO_COMPARE_H */
-- 
1.8.3.1
