Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAY-0008JP-3E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAX-0001QC-1p
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAW-0001On-S2
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:48 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:53 +0800
Message-Id: <1488777954-4578-19-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 18/19] COLO-compare: Fix icmp and udp
 compare different packet always dump bug
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

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9f5968d..282727b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -279,9 +279,13 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
 
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
-        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
-        qemu_hexdump((char *)spkt->data, stderr, "colo-compare", spkt->size);
+        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
+                         ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
+                         spkt->size);
+        }
     }
 
     return ret;
@@ -311,12 +315,14 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
                                    network_header_length + ETH_HLEN)) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
-        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
-                     ppkt->size);
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
                                            spkt->size);
-        qemu_hexdump((char *)spkt->data, stderr, "colo-compare",
-                     spkt->size);
+        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
+                         ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
+                         spkt->size);
+        }
         return -1;
     } else {
         return 0;
-- 
2.7.4
