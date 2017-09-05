Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7Ms-0002zz-GV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7Mn-0005sk-IT
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:29:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51446
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7Mm-0005q6-Or
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:29:45 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 14:31:04 +0800
Message-ID: <1504593066-14023-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1504593066-14023-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1504593066-14023-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 1/3] net/colo-compare.c: Optimize
 unpredictable tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

When network is busy, some tcp options(like sack) will unpredictable
occur in primary side or secondary side. it will make packet size
not same, but the two packet's payload is identical. colo just
care about packet payload, so we skip the option field.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ca67c68..d088262 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -186,7 +186,10 @@ static int packet_enqueue(CompareState *s, int mode)
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
@@ -201,12 +204,13 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
                                    sec_ip_src, sec_ip_dst);
     }
 
-    offset = ppkt->vnet_hdr_len + offset;
+    poffset = ppkt->vnet_hdr_len + poffset;
+    soffset = ppkt->vnet_hdr_len + soffset;
 
-    if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data + offset,
-                      spkt->data + offset,
-                      spkt->size - offset);
+    if (ppkt->size - poffset == spkt->size - soffset) {
+        return memcmp(ppkt->data + poffset,
+                      spkt->data + soffset,
+                      spkt->size - soffset);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
         return -1;
@@ -263,13 +267,22 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
      * so we just need skip this field.
      */
     if (ptcp->th_off > 5) {
-        ptrdiff_t tcp_offset;
+        ptrdiff_t ptcp_offset, stcp_offset;
 
-        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
-                     + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
-        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
+        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
+                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
+        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
+                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
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
@@ -329,6 +342,7 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
      * the ip payload here.
      */
     ret = colo_packet_compare_common(ppkt, spkt,
+                                     network_header_length + ETH_HLEN,
                                      network_header_length + ETH_HLEN);
 
     if (ret) {
@@ -366,6 +380,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
      * the ip payload here.
      */
     if (colo_packet_compare_common(ppkt, spkt,
+                                   network_header_length + ETH_HLEN,
                                    network_header_length + ETH_HLEN)) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
@@ -403,7 +418,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
                                    sec_ip_src, sec_ip_dst);
     }
 
-    return colo_packet_compare_common(ppkt, spkt, 0);
+    return colo_packet_compare_common(ppkt, spkt, 0, 0);
 }
 
 static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
-- 
2.7.4
