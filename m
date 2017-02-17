Received: from eggs.gnu.org ([2001:4830:134:3::10]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceYg1-0001UO-Pf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceYfy-0005Pn-RU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:53:41 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceYfy-0005Kn-1E
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:53:38 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 17 Feb 2017 10:53:11 +0800
Message-ID: <1487299994-98348-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/4] colo-compare: use
 g_timeout_source_new() to process the stale packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Instead of using qemu timer to process the stale packets,
We re-use the colo compare thread to process these packets
by creating a new timeout coroutine.

Besides, since we process all the same vNIC's net connection/packets
in one thread, it is safe to remove the timer_check_lock.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 62 +++++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 162fd6a..fdde788 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -83,9 +83,6 @@ typedef struct CompareState {
     GHashTable *connection_track_table;
     /* compare thread, a thread for each NIC */
     QemuThread thread;
-    /* Timer used on the primary to find packets that are never matched */
-    QEMUTimer *timer;
-    QemuMutex timer_check_lock;
 } CompareState;
 
 typedef struct CompareClass {
@@ -374,9 +371,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
-        qemu_mutex_lock(&s->timer_check_lock);
         pkt = g_queue_pop_tail(&conn->primary_list);
-        qemu_mutex_unlock(&s->timer_check_lock);
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -411,9 +406,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
              * until next comparison.
              */
             trace_colo_compare_main("packet different");
-            qemu_mutex_lock(&s->timer_check_lock);
             g_queue_push_tail(&conn->primary_list, pkt);
-            qemu_mutex_unlock(&s->timer_check_lock);
             /* TODO: colo_notify_checkpoint();*/
             break;
         }
@@ -486,11 +479,26 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
     }
 }
 
+/*
+ * Check old packet regularly so it can watch for any packets
+ * that the secondary hasn't produced equivalents of.
+ */
+static gboolean check_old_packet_regular(void *opaque)
+{
+    CompareState *s = opaque;
+
+    /* if have old packet we will notify checkpoint */
+    colo_old_packet_check(s);
+
+    return TRUE;
+}
+
 static void *colo_compare_thread(void *opaque)
 {
     GMainContext *worker_context;
     GMainLoop *compare_loop;
     CompareState *s = opaque;
+    GSource *timeout_source;
 
     worker_context = g_main_context_new();
 
@@ -501,8 +509,15 @@ static void *colo_compare_thread(void *opaque)
 
     compare_loop = g_main_loop_new(worker_context, FALSE);
 
+    /* To kick any packets that the secondary doesn't match */
+    timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
+    g_source_set_callback(timeout_source,
+                          (GSourceFunc)check_old_packet_regular, s, NULL);
+    g_source_attach(timeout_source, worker_context);
+
     g_main_loop_run(compare_loop);
 
+    g_source_unref(timeout_source);
     g_main_loop_unref(compare_loop);
     g_main_context_unref(worker_context);
     return NULL;
@@ -604,26 +619,6 @@ static int find_and_check_chardev(Chardev **chr,
 }
 
 /*
- * Check old packet regularly so it can watch for any packets
- * that the secondary hasn't produced equivalents of.
- */
-static void check_old_packet_regular(void *opaque)
-{
-    CompareState *s = opaque;
-
-    timer_mod(s->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-              REGULAR_PACKET_CHECK_MS);
-    /* if have old packet we will notify checkpoint */
-    /*
-     * TODO: Make timer handler run in compare thread
-     * like qemu_chr_add_handlers_full.
-     */
-    qemu_mutex_lock(&s->timer_check_lock);
-    colo_old_packet_check(s);
-    qemu_mutex_unlock(&s->timer_check_lock);
-}
-
-/*
  * Called from the main thread on the primary
  * to setup colo-compare.
  */
@@ -665,7 +660,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
 
     g_queue_init(&s->conn_list);
-    qemu_mutex_init(&s->timer_check_lock);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
@@ -678,12 +672,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                        QEMU_THREAD_JOINABLE);
     compare_id++;
 
-    /* A regular timer to kick any packets that the secondary doesn't match */
-    s->timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, /* Only when guest runs */
-                            check_old_packet_regular, s);
-    timer_mod(s->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                        REGULAR_PACKET_CHECK_MS);
-
     return;
 }
 
@@ -723,12 +711,6 @@ static void colo_compare_finalize(Object *obj)
         qemu_thread_join(&s->thread);
     }
 
-    if (s->timer) {
-        timer_del(s->timer);
-    }
-
-    qemu_mutex_destroy(&s->timer_check_lock);
-
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-- 
1.8.3.1
