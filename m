Received: from eggs.gnu.org ([2001:4830:134:3::10]:56864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCR-0007Rl-L0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCQ-0002fN-F8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:47 -0500
Received: from [59.151.112.132] (port=31531 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCO-0002eX-Lm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:46 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 13:18:08 +0800
Message-ID: <1488259090-30034-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 1/3] COLO-compare: Rename compare function
 and remove duplicate codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Rename colo_packet_compare() to colo_packet_compare_common() that
make tcp_compare udp_compare icmp_compare reuse this function.
Remove minimum packet size check in icmp_compare, because we have
check this in parse_packet_early().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
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
