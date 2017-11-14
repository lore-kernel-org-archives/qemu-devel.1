Received: from eggs.gnu.org ([2001:4830:134:3::10]:57653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhg-0004Z7-9C
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhd-0000l1-1m
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEQhc-0000ka-PO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:52 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:32 +0800
Message-Id: <1510625498-4821-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] colo-compare: Insert packet into the
 suitable position of packet queue directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
