Received: from eggs.gnu.org ([2001:4830:134:3::10]:33295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2WMZ-00046t-IB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2WMU-0006FH-Vn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2WMU-0006Ex-PN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:34 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2017 13:16:05 +0800
Message-Id: <1493010966-22976-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
References: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] COLO-compare: Optimize tcp compare for
 option field
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

In this patch we support packet that have tcp options field.
Add tcp options field check, If the packet have options
field we just skip it and compare tcp payload,
Avoid unnecessary checkpoint, optimize performance.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9b09cfc..4ab80b1 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -233,7 +233,32 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
         spkt->ip->ip_sum = ppkt->ip->ip_sum;
     }
 
-    if (ptcp->th_sum == stcp->th_sum) {
+    /*
+     * Check tcp header length for tcp option field.
+     * th_off > 5 means this tcp packet have options field.
+     * The tcp options maybe always different.
+     * for example:
+     * From RFC 7323.
+     * TCP Timestamps option (TSopt):
+     * Kind: 8
+     *
+     * Length: 10 bytes
+     *
+     *    +-------+-------+---------------------+---------------------+
+     *    |Kind=8 |  10   |   TS Value (TSval)  |TS Echo Reply (TSecr)|
+     *    +-------+-------+---------------------+---------------------+
+     *       1       1              4                     4
+     *
+     * In this case the primary guest's timestamp always different with
+     * the secondary guest's timestamp. COLO just focus on payload,
+     * so we just need skip this field.
+     */
+    if (ptcp->th_off > 5) {
+        ptrdiff_t tcp_offset;
+        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
+                     + (ptcp->th_off * 4);
+        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
+    } else if (ptcp->th_sum == stcp->th_sum) {
         res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
     } else {
         res = -1;
-- 
2.7.4
