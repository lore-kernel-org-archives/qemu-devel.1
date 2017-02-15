Received: from eggs.gnu.org ([2001:4830:134:3::10]:48817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqeu-00027k-LG
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqet-0008QE-M3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdqet-0008Q9-G0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:35 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2017 11:53:20 +0800
Message-Id: <1487130802-27953-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
References: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] colo-compare: sort TCP packet queue by
 sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Improve efficiency of TCP packet comparison.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 4962976..162fd6a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -101,6 +101,15 @@ static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
                             uint32_t size);
 
+static gint seq_sorter(Packet *a, Packet *b, gpointer data)
+{
+    struct tcphdr *atcp, *btcp;
+
+    atcp = (struct tcphdr *)(a->transport_header);
+    btcp = (struct tcphdr *)(b->transport_header);
+    return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
+}
+
 /*
  * Return 0 on success, if return -1 means the pkt
  * is unsupported(arp and ipv6) and will be sent later
@@ -137,6 +146,11 @@ static int packet_enqueue(CompareState *s, int mode)
         if (g_queue_get_length(&conn->primary_list) <=
                                MAX_QUEUE_SIZE) {
             g_queue_push_tail(&conn->primary_list, pkt);
+            if (conn->ip_proto == IPPROTO_TCP) {
+                g_queue_sort(&conn->primary_list,
+                             (GCompareDataFunc)seq_sorter,
+                             NULL);
+            }
         } else {
             error_report("colo compare primary queue size too big,"
                          "drop packet");
@@ -145,6 +159,11 @@ static int packet_enqueue(CompareState *s, int mode)
         if (g_queue_get_length(&conn->secondary_list) <=
                                MAX_QUEUE_SIZE) {
             g_queue_push_tail(&conn->secondary_list, pkt);
+            if (conn->ip_proto == IPPROTO_TCP) {
+                g_queue_sort(&conn->secondary_list,
+                             (GCompareDataFunc)seq_sorter,
+                             NULL);
+            }
         } else {
             error_report("colo compare secondary queue size too big,"
                          "drop packet");
-- 
2.7.4
