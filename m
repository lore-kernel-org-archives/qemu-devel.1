Received: from eggs.gnu.org ([2001:4830:134:3::10]:36917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2X-0007gR-3Z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2V-0003kl-By
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:53 -0400
Received: from [59.151.112.132] (port=34976 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2U-0003iF-VX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:51 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 7 Jul 2017 13:43:50 +0800
Message-ID: <1499406231-3877-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499406231-3877-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499406231-3877-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] net/colo-compare.c: Optimize unpredictable
 tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

When network is busy, some tcp options(like sack) will unpredictable
occur in primary side or secondary side. it will make packet size
not same, but the two packet's payload is identical. colo just
care about packet payload, so we skip the option field.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2caeb80..6406c4a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -183,7 +183,10 @@ static int packet_enqueue(CompareState *s, int mode)
  * return:    0  means packet same
  *            > 0 || < 0 means packet different
  */
-static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
+static int colo_packet_compare_common(Packet *ppkt,
+                                      Packet *spkt,
+                                      int poffset,
+                                      int soffset)
 {
     if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
@@ -198,9 +201,10 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
                                    sec_ip_src, sec_ip_dst);
     }
 
-    if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data + offset, spkt->data + offset,
-                      spkt->size - offset);
+    if (ppkt->size == spkt->size || poffset != soffset) {
+        return memcmp(ppkt->data + poffset,
+                      spkt->data + soffset,
+                      spkt->size - soffset);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
         return -1;
@@ -263,12 +267,22 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
      * so we just need skip this field.
      */
     if (ptcp->th_off > 5) {
-        ptrdiff_t tcp_offset;
-        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
+        ptrdiff_t ptcp_offset, stcp_offset;
+
+        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
                      + (ptcp->th_off * 4);
-        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
+        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
+                     + (stcp->th_off * 4);
+
+        /*
+         * When network is busy, some tcp options(like sack) will unpredictable
+         * occur in primary side or secondary side. it will make packet size
+         * not same, but the two packet's payload is identical. colo just
+         * care about packet payload, so we skip the option field.
+         */
+        res = colo_packet_compare_common(ppkt, spkt, ptcp_offset, stcp_offset);
     } else if (ptcp->th_sum == stcp->th_sum) {
-        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
+        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN, ETH_HLEN);
     } else {
         res = -1;
     }
@@ -328,6 +342,7 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
      * the ip payload here.
      */
     ret = colo_packet_compare_common(ppkt, spkt,
+                                     network_header_length + ETH_HLEN,
                                      network_header_length + ETH_HLEN);
 
     if (ret) {
@@ -365,6 +380,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
      * the ip payload here.
      */
     if (colo_packet_compare_common(ppkt, spkt,
+                                   network_header_length + ETH_HLEN,
                                    network_header_length + ETH_HLEN)) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
@@ -402,7 +418,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
                                    sec_ip_src, sec_ip_dst);
     }
 
-    return colo_packet_compare_common(ppkt, spkt, 0);
+    return colo_packet_compare_common(ppkt, spkt, 0, 0);
 }
 
 static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
-- 
2.7.4
