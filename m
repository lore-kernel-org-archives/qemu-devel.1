Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAV-0008Gq-GB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAS-0001KZ-D5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAS-0001Jz-4F
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:44 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:51 +0800
Message-Id: <1488777954-4578-17-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 16/19] COLO-compare: Rename compare
 function and remove duplicate codes
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

Rename colo_packet_compare() to colo_packet_compare_common() that
make tcp_compare udp_compare icmp_compare reuse this function.
Remove minimum packet size check in icmp_compare, because we have
check this in parse_packet_early().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 300f017..602a758 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode)
  * return:    0  means packet same
  *            > 0 || < 0 means packet different
  */
-static int colo_packet_compare(Packet *ppkt, Packet *spkt)
+static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
 {
     trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
                                inet_ntoa(ppkt->ip->ip_dst), spkt->size,
@@ -190,6 +190,7 @@ static int colo_packet_compare(Packet *ppkt, Packet *spkt)
     if (ppkt->size == spkt->size) {
         return memcmp(ppkt->data, spkt->data, spkt->size);
     } else {
+        trace_colo_compare_main("Net packet size are not the same");
         return -1;
     }
 }
@@ -205,6 +206,7 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
     int res;
 
     trace_colo_compare_main("compare tcp");
+
     if (ppkt->size != spkt->size) {
         if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
             trace_colo_compare_main("pkt size not same");
@@ -263,7 +265,8 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
     int ret;
 
     trace_colo_compare_main("compare udp");
-    ret = colo_packet_compare(ppkt, spkt);
+
+    ret = colo_packet_compare_common(ppkt, spkt);
 
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
@@ -281,16 +284,9 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
  */
 static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
 {
-    int network_length;
-
     trace_colo_compare_main("compare icmp");
-    network_length = ppkt->ip->ip_hl * 4;
-    if (ppkt->size != spkt->size ||
-        ppkt->size < network_length + ETH_HLEN) {
-        return -1;
-    }
 
-    if (colo_packet_compare(ppkt, spkt)) {
+    if (colo_packet_compare_common(ppkt, spkt)) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
         qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
@@ -316,7 +312,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
                                inet_ntoa(ppkt->ip->ip_dst), spkt->size,
                                inet_ntoa(spkt->ip->ip_src),
                                inet_ntoa(spkt->ip->ip_dst));
-    return colo_packet_compare(ppkt, spkt);
+    return colo_packet_compare_common(ppkt, spkt);
 }
 
 static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
-- 
2.7.4
