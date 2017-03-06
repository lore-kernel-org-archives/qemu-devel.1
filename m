Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklA6-0007vB-Ug
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklA6-00017l-0u
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklA5-00017J-O1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:21 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:43 +0800
Message-Id: <1488777954-4578-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 08/19] colo-compare: kick compare thread
 to exit after some cleanup in finalization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

We should call g_main_loop_quit() to notify colo compare thread to
exit, Or it will run in g_main_loop_run() forever.

Besides, the finalizing process can't happen in context of colo thread,
it is reasonable to remove the 'if (qemu_thread_is_self(&s->thread))'
branch.

Before compare thead exits, some cleanup works need to be
done,  All unhandled packets need to be released and connection_track_table
needs to be freed, or there will be memory leak.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index fdde788..37ce75c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -83,6 +83,8 @@ typedef struct CompareState {
     GHashTable *connection_track_table;
     /* compare thread, a thread for each NIC */
     QemuThread thread;
+
+    GMainLoop *compare_loop;
 } CompareState;
 
 typedef struct CompareClass {
@@ -496,7 +498,6 @@ static gboolean check_old_packet_regular(void *opaque)
 static void *colo_compare_thread(void *opaque)
 {
     GMainContext *worker_context;
-    GMainLoop *compare_loop;
     CompareState *s = opaque;
     GSource *timeout_source;
 
@@ -507,7 +508,7 @@ static void *colo_compare_thread(void *opaque)
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
                              compare_sec_chr_in, NULL, s, worker_context, true);
 
-    compare_loop = g_main_loop_new(worker_context, FALSE);
+    s->compare_loop = g_main_loop_new(worker_context, FALSE);
 
     /* To kick any packets that the secondary doesn't match */
     timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
@@ -515,10 +516,10 @@ static void *colo_compare_thread(void *opaque)
                           (GSourceFunc)check_old_packet_regular, s, NULL);
     g_source_attach(timeout_source, worker_context);
 
-    g_main_loop_run(compare_loop);
+    g_main_loop_run(s->compare_loop);
 
     g_source_unref(timeout_source);
-    g_main_loop_unref(compare_loop);
+    g_main_loop_unref(s->compare_loop);
     g_main_context_unref(worker_context);
     return NULL;
 }
@@ -675,6 +676,23 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     return;
 }
 
+static void colo_flush_packets(void *opaque, void *user_data)
+{
+    CompareState *s = user_data;
+    Connection *conn = opaque;
+    Packet *pkt = NULL;
+
+    while (!g_queue_is_empty(&conn->primary_list)) {
+        pkt = g_queue_pop_head(&conn->primary_list);
+        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+        packet_destroy(pkt, NULL);
+    }
+    while (!g_queue_is_empty(&conn->secondary_list)) {
+        pkt = g_queue_pop_head(&conn->secondary_list);
+        packet_destroy(pkt, NULL);
+    }
+}
+
 static void colo_compare_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
@@ -703,14 +721,15 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_deinit(&s->chr_sec_in);
     qemu_chr_fe_deinit(&s->chr_out);
 
-    g_queue_free(&s->conn_list);
+    g_main_loop_quit(s->compare_loop);
+    qemu_thread_join(&s->thread);
 
-    if (qemu_thread_is_self(&s->thread)) {
-        /* compare connection */
-        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
-        qemu_thread_join(&s->thread);
-    }
+    /* Release all unhandled packets after compare thead exited */
+    g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+
+    g_queue_free(&s->conn_list);
 
+    g_hash_table_destroy(s->connection_track_table);
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-- 
2.7.4
