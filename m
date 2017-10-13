Received: from eggs.gnu.org ([2001:4830:134:3::10]:35400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZf-00080j-3V
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZc-0004v4-8z
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54764
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZb-0004sa-Ke
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:56 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 13 Oct 2017 14:32:06 +0800
Message-ID: <20171013063209.15617-2-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
References: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] colo-compare: Insert packet into the
 suitable position of packet queue directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

Currently, a packet from pri_dev or sec_dev is fristly pushed at the
tail of the primary or secondary packet queue then sorted by the tcp
sequence number.

Now, this patch use g_queue_insert_sorted to insert the packet directly
into the suitable position to avoid ordering all packets each time when
a new packet is comming, thereby increasing efficiency.

In addition, consolidate the code that add a packet to the list of
Connection (primary or secondary) into a separate routine colo_insert_packet()
since the same chunk of code is called from two place.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index b3f35d7..54b6347 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -113,6 +113,26 @@ static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 }
 
 /*
+ * Return 1 on success, if return 0 means the
+ * packet will be dropped
+ */
+static int colo_insert_packet(GQueue *queue, Packet *pkt)
+{
+    if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
+        if (pkt->ip->ip_p == IPPROTO_TCP) {
+            g_queue_insert_sorted(queue,
+                                  pkt,
+                                  (GCompareDataFunc)seq_sorter,
+                                  NULL);
+        } else {
+            g_queue_push_tail(queue, pkt);
+        }
+        return 1;
+    }
+    return 0;
+}
+
+/*
  * Return 0 on success, if return -1 means the pkt
  * is unsupported(arp and ipv6) and will be sent later
  */
@@ -149,28 +169,12 @@ static int packet_enqueue(CompareState *s, int mode)
     }
 
     if (mode == PRIMARY_IN) {
-        if (g_queue_get_length(&conn->primary_list) <=
-                               MAX_QUEUE_SIZE) {
-            g_queue_push_tail(&conn->primary_list, pkt);
-            if (conn->ip_proto == IPPROTO_TCP) {
-                g_queue_sort(&conn->primary_list,
-                             (GCompareDataFunc)seq_sorter,
-                             NULL);
-            }
-        } else {
+        if (!colo_insert_packet(&conn->primary_list, pkt)) {
             error_report("colo compare primary queue size too big,"
                          "drop packet");
         }
     } else {
-        if (g_queue_get_length(&conn->secondary_list) <=
-                               MAX_QUEUE_SIZE) {
-            g_queue_push_tail(&conn->secondary_list, pkt);
-            if (conn->ip_proto == IPPROTO_TCP) {
-                g_queue_sort(&conn->secondary_list,
-                             (GCompareDataFunc)seq_sorter,
-                             NULL);
-            }
-        } else {
+        if (!colo_insert_packet(&conn->secondary_list, pkt)) {
             error_report("colo compare secondary queue size too big,"
                          "drop packet");
         }
-- 
2.9.4
