Received: from eggs.gnu.org ([2001:4830:134:3::10]:49721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d13mK-0001Ii-9t
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d13mH-00040B-6V
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:33:12 -0400
Received: from [59.151.112.132] (port=48336 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d13mG-0003w5-Qy
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:33:09 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 12:32:43 +0800
Message-ID: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] COLO-compare: Add compare_lock aviod
 comparison conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

When network traffic heavy, compare_pri_rs_finalize() and
compare_sec_rs_finalize() have a chance to confilct.
Both of them call colo_compare_connection() to compare packet,
But during compare_pri_rs_finalize() comparison, have secondary
packet come and call compare_sec_rs_finalize(), that packet will be
handle twice. If packet same, the pkt will be double free.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..686c1b4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -79,6 +79,8 @@ typedef struct CompareState {
      * element type: Connection
      */
     GQueue conn_list;
+    /* compare lock */
+    QemuMutex compare_lock;
     /* hashtable to save connection */
     GHashTable *connection_track_table;
     /* compare thread, a thread for each NIC */
@@ -619,7 +621,9 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
         compare_chr_send(&s->chr_out, pri_rs->buf, pri_rs->packet_len);
     } else {
         /* compare connection */
+        qemu_mutex_lock(&s->compare_lock);
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        qemu_mutex_unlock(&s->compare_lock);
     }
 }
 
@@ -631,7 +635,9 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
         trace_colo_compare_main("secondary: unsupported packet in");
     } else {
         /* compare connection */
+        qemu_mutex_lock(&s->compare_lock);
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
+        qemu_mutex_unlock(&s->compare_lock);
     }
 }
 
@@ -702,6 +708,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
 
     g_queue_init(&s->conn_list);
+    qemu_mutex_init(&s->compare_lock);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
@@ -771,6 +778,7 @@ static void colo_compare_finalize(Object *obj)
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
     g_queue_clear(&s->conn_list);
+    qemu_mutex_destroy(&s->compare_lock);
 
     g_hash_table_destroy(s->connection_track_table);
     g_free(s->pri_indev);
-- 
2.7.4
