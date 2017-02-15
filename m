Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv3B-0008Ew-R9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv37-0007Zg-5m
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:57 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:44864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv36-0007Th-Im
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:53 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 15 Feb 2017 16:34:15 +0800
Message-ID: <1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/5] colo-compare: release all unhandled
 packets in finalize function
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

We should release all unhandled packets before finalize colo compare.
Besides, we need to free connection_track_table, or there will be
a memory leak bug.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a16e2d5..809bad3 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -676,6 +676,23 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     return;
 }
 
+static void colo_release_packets(void *opaque, void *user_data)
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
@@ -707,9 +724,12 @@ static void colo_compare_finalize(Object *obj)
     g_main_loop_quit(s->compare_loop);
     qemu_thread_join(&s->thread);
 
+    /* Release all unhandled packets after compare thead exited */
+    g_queue_foreach(&s->conn_list, colo_release_packets, s);
 
     g_queue_free(&s->conn_list);
 
+    g_hash_table_destroy(s->connection_track_table);
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-- 
1.8.3.1
