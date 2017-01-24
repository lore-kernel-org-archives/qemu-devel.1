Received: from eggs.gnu.org ([2001:4830:134:3::10]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kE-0004fb-St
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kC-0004mZ-NK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:46 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:58354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kB-0004m8-LN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:44 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 24 Jan 2017 22:05:46 +0800
Message-ID: <1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] colo-compare: reconstruct the mutex lock
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

The original 'timer_check_lock' mutex lock of struct CompareState
is used to protect the 'conn_list' queue and its child queues which
are 'primary_list' and 'secondary_list', which is a little abused
and confusing

To make it clearer, we rename 'timer_check_lock' to 'conn_list_lock'
which is used to protect 'conn_list' queue, use another 'conn_lock'
to protect 'primary_list' and 'secondary_list'.

Besides, fix some missing places which need these mutex lock.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 33 +++++++++++++++++++++++----------
 net/colo.c         |  2 ++
 net/colo.h         |  2 ++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5a4f335..9bea62a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -79,13 +79,15 @@ typedef struct CompareState {
      * element type: Connection
      */
     GQueue conn_list;
+    QemuMutex conn_list_lock;
     /* hashtable to save connection */
     GHashTable *connection_track_table;
+
     /* compare thread, a thread for each NIC */
     QemuThread thread;
+
     /* Timer used on the primary to find packets that are never matched */
     QEMUTimer *timer;
-    QemuMutex timer_check_lock;
 } CompareState;
 
 typedef struct CompareClass {
@@ -133,6 +135,7 @@ static int packet_enqueue(CompareState *s, int mode)
     }
     fill_connection_key(pkt, &key);
 
+    qemu_mutex_lock(&s->conn_list_lock);
     conn = connection_get(s->connection_track_table,
                           &key,
                           &s->conn_list);
@@ -141,16 +144,19 @@ static int packet_enqueue(CompareState *s, int mode)
         g_queue_push_tail(&s->conn_list, conn);
         conn->processing = true;
     }
+    qemu_mutex_unlock(&s->conn_list_lock);
 
     if (mode == PRIMARY_IN) {
         if (g_queue_get_length(&conn->primary_list) <=
                                MAX_QUEUE_SIZE) {
+            qemu_mutex_lock(&conn->conn_lock);
             g_queue_push_tail(&conn->primary_list, pkt);
             if (conn->ip_proto == IPPROTO_TCP) {
                 g_queue_sort(&conn->primary_list,
                              (GCompareDataFunc)seq_sorter,
                              NULL);
             }
+            qemu_mutex_unlock(&conn->conn_lock);
         } else {
             error_report("colo compare primary queue size too big,"
                          "drop packet");
@@ -158,12 +164,14 @@ static int packet_enqueue(CompareState *s, int mode)
     } else {
         if (g_queue_get_length(&conn->secondary_list) <=
                                MAX_QUEUE_SIZE) {
+            qemu_mutex_lock(&conn->conn_lock);
             g_queue_push_tail(&conn->secondary_list, pkt);
             if (conn->ip_proto == IPPROTO_TCP) {
                 g_queue_sort(&conn->secondary_list,
                              (GCompareDataFunc)seq_sorter,
                              NULL);
             }
+            qemu_mutex_unlock(&conn->conn_lock);
         } else {
             error_report("colo compare secondary queue size too big,"
                          "drop packet");
@@ -338,10 +346,11 @@ static void colo_old_packet_check_one_conn(void *opaque,
     GList *result = NULL;
     int64_t check_time = REGULAR_PACKET_CHECK_MS;
 
+    qemu_mutex_lock(&conn->conn_lock);
     result = g_queue_find_custom(&conn->primary_list,
                                  &check_time,
                                  (GCompareFunc)colo_old_packet_check_one);
-
+    qemu_mutex_unlock(&conn->conn_lock);
     if (result) {
         /* do checkpoint will flush old packet */
         /* TODO: colo_notify_checkpoint();*/
@@ -357,7 +366,9 @@ static void colo_old_packet_check(void *opaque)
 {
     CompareState *s = opaque;
 
+    qemu_mutex_lock(&s->conn_list_lock);
     g_queue_foreach(&s->conn_list, colo_old_packet_check_one_conn, NULL);
+    qemu_mutex_unlock(&s->conn_list_lock);
 }
 
 /*
@@ -372,11 +383,10 @@ static void colo_compare_connection(void *opaque, void *user_data)
     GList *result = NULL;
     int ret;
 
+    qemu_mutex_lock(&conn->conn_lock);
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
-        qemu_mutex_lock(&s->timer_check_lock);
         pkt = g_queue_pop_tail(&conn->primary_list);
-        qemu_mutex_unlock(&s->timer_check_lock);
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -411,13 +421,12 @@ static void colo_compare_connection(void *opaque, void *user_data)
              * until next comparison.
              */
             trace_colo_compare_main("packet different");
-            qemu_mutex_lock(&s->timer_check_lock);
             g_queue_push_tail(&conn->primary_list, pkt);
-            qemu_mutex_unlock(&s->timer_check_lock);
             /* TODO: colo_notify_checkpoint();*/
             break;
         }
     }
+    qemu_mutex_unlock(&conn->conn_lock);
 }
 
 static int compare_chr_send(CharBackend *out,
@@ -561,8 +570,10 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
         trace_colo_compare_main("primary: unsupported packet in");
         compare_chr_send(&s->chr_out, pri_rs->buf, pri_rs->packet_len);
     } else {
+        qemu_mutex_lock(&s->conn_list_lock);
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        qemu_mutex_unlock(&s->conn_list_lock);
     }
 }
 
@@ -573,8 +584,10 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     if (packet_enqueue(s, SECONDARY_IN)) {
         trace_colo_compare_main("secondary: unsupported packet in");
     } else {
+        qemu_mutex_lock(&s->conn_list_lock);
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        qemu_mutex_unlock(&s->conn_list_lock);
     }
 }
 
@@ -618,9 +631,7 @@ static void check_old_packet_regular(void *opaque)
      * TODO: Make timer handler run in compare thread
      * like qemu_chr_add_handlers_full.
      */
-    qemu_mutex_lock(&s->timer_check_lock);
     colo_old_packet_check(s);
-    qemu_mutex_unlock(&s->timer_check_lock);
 }
 
 /*
@@ -665,7 +676,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
 
     g_queue_init(&s->conn_list);
-    qemu_mutex_init(&s->timer_check_lock);
+    qemu_mutex_init(&s->conn_list_lock);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
@@ -718,8 +729,10 @@ static void colo_compare_finalize(Object *obj)
     g_queue_free(&s->conn_list);
 
     if (qemu_thread_is_self(&s->thread)) {
+        qemu_mutex_lock(&s->conn_list_lock);
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        qemu_mutex_unlock(&s->conn_list_lock);
         qemu_thread_join(&s->thread);
     }
 
@@ -727,7 +740,7 @@ static void colo_compare_finalize(Object *obj)
         timer_del(s->timer);
     }
 
-    qemu_mutex_destroy(&s->timer_check_lock);
+    qemu_mutex_destroy(&s->conn_list_lock);
 
     g_free(s->pri_indev);
     g_free(s->sec_indev);
diff --git a/net/colo.c b/net/colo.c
index 6a6eacd..267f29c 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -138,6 +138,7 @@ Connection *connection_new(ConnectionKey *key)
     conn->syn_flag = 0;
     g_queue_init(&conn->primary_list);
     g_queue_init(&conn->secondary_list);
+    qemu_mutex_init(&conn->conn_lock);
 
     return conn;
 }
@@ -151,6 +152,7 @@ void connection_destroy(void *opaque)
     g_queue_foreach(&conn->secondary_list, packet_destroy, NULL);
     g_queue_free(&conn->secondary_list);
     g_slice_free(Connection, conn);
+    qemu_mutex_destroy(&conn->conn_lock);
 }
 
 Packet *packet_new(const void *data, int size)
diff --git a/net/colo.h b/net/colo.h
index 7c524f3..2d5f9be 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -61,6 +61,8 @@ typedef struct Connection {
     GQueue secondary_list;
     /* flag to enqueue unprocessed_connections */
     bool processing;
+    /* Protect the access of primary_list or secondary list */
+    QemuMutex conn_lock;
     uint8_t ip_proto;
     /* offset = secondary_seq - primary_seq */
     tcp_seq  offset;
-- 
1.8.3.1
