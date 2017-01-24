Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cVwst-00063P-0V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cVwso-0000sJ-HC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:55:23 -0500
Received: from [59.151.112.132] (port=16059 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cVwso-0000mP-55
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:55:18 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 24 Jan 2017 16:53:46 +0800
Message-ID: <1485248026-9628-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] colo-compare: sort TCP packet queue by
 sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Improve efficiency of TCP packet comparison.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 net/colo-compare.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9bfc736..5a4f335 100644
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
