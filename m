Received: from eggs.gnu.org ([2001:4830:134:3::10]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAV-0008HG-V5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAU-0001Mm-Or
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAU-0001MG-GA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:46 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:52 +0800
Message-Id: <1488777954-4578-18-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 17/19] COLO-compare: Optimize
 compare_common and compare_tcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Add offset args for colo_packet_compare_common, optimize
colo_packet_compare_icmp() and colo_packet_compare_udp()
just compare the IP payload. Before compare all tcp packet,
we compare tcp checksum firstly, this function can get
better performance.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 602a758..9f5968d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode)
  * return:    0  means packet same
  *            > 0 || < 0 means packet different
  */
-static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
+static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
 {
     trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
                                inet_ntoa(ppkt->ip->ip_dst), spkt->size,
@@ -188,7 +188,8 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
                                inet_ntoa(spkt->ip->ip_dst));
 
     if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data, spkt->data, spkt->size);
+        return memcmp(ppkt->data + offset, spkt->data + offset,
+                      spkt->size - offset);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
         return -1;
@@ -207,13 +208,6 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
 
     trace_colo_compare_main("compare tcp");
 
-    if (ppkt->size != spkt->size) {
-        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            trace_colo_compare_main("pkt size not same");
-        }
-        return -1;
-    }
-
     ptcp = (struct tcphdr *)ppkt->transport_header;
     stcp = (struct tcphdr *)spkt->transport_header;
 
@@ -231,8 +225,11 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
         spkt->ip->ip_sum = ppkt->ip->ip_sum;
     }
 
-    res = memcmp(ppkt->data + ETH_HLEN, spkt->data + ETH_HLEN,
-                (spkt->size - ETH_HLEN));
+    if (ptcp->th_sum == stcp->th_sum) {
+        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
+    } else {
+        res = -1;
+    }
 
     if (res != 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
         trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
@@ -263,10 +260,22 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
 static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
 {
     int ret;
+    int network_header_length = ppkt->ip->ip_hl * 4;
 
     trace_colo_compare_main("compare udp");
 
-    ret = colo_packet_compare_common(ppkt, spkt);
+    /*
+     * Because of ppkt and spkt are both in the same connection,
+     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
+     * same with spkt. In addition, IP header's Identification is a random
+     * field, we can handle it in IP fragmentation function later.
+     * COLO just concern the response net packet payload from primary guest
+     * and secondary guest are same or not, So we ignored all IP header include
+     * other field like TOS,TTL,IP Checksum. we only need to compare
+     * the ip payload here.
+     */
+    ret = colo_packet_compare_common(ppkt, spkt,
+                                     network_header_length + ETH_HLEN);
 
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
@@ -284,9 +293,22 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
  */
 static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
 {
+    int network_header_length = ppkt->ip->ip_hl * 4;
+
     trace_colo_compare_main("compare icmp");
 
-    if (colo_packet_compare_common(ppkt, spkt)) {
+    /*
+     * Because of ppkt and spkt are both in the same connection,
+     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
+     * same with spkt. In addition, IP header's Identification is a random
+     * field, we can handle it in IP fragmentation function later.
+     * COLO just concern the response net packet payload from primary guest
+     * and secondary guest are same or not, So we ignored all IP header include
+     * other field like TOS,TTL,IP Checksum. we only need to compare
+     * the ip payload here.
+     */
+    if (colo_packet_compare_common(ppkt, spkt,
+                                   network_header_length + ETH_HLEN)) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
         qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
@@ -312,7 +334,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
                                inet_ntoa(ppkt->ip->ip_dst), spkt->size,
                                inet_ntoa(spkt->ip->ip_src),
                                inet_ntoa(spkt->ip->ip_dst));
-    return colo_packet_compare_common(ppkt, spkt);
+    return colo_packet_compare_common(ppkt, spkt, 0);
 }
 
 static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
-- 
2.7.4
