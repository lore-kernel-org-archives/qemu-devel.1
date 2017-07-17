Received: from eggs.gnu.org ([2001:4830:134:3::10]:48359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52b-0000r3-It
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52a-0008Et-Q9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52a-0008Ec-Ja
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:20 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:41 +0800
Message-Id: <1500294105-13713-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] net/colo-compare.c: Add vnet packet's
 tcp/udp/icmp compare
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

COLO-Proxy just focus on packet payload, so we skip vnet header.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 95911a2..ca67c68 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -201,8 +201,11 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
                                    sec_ip_src, sec_ip_dst);
     }
 
+    offset = ppkt->vnet_hdr_len + offset;
+
     if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data + offset, spkt->data + offset,
+        return memcmp(ppkt->data + offset,
+                      spkt->data + offset,
                       spkt->size - offset);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
@@ -261,8 +264,9 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
      */
     if (ptcp->th_off > 5) {
         ptrdiff_t tcp_offset;
+
         tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
-                     + (ptcp->th_off * 4);
+                     + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
         res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
     } else if (ptcp->th_sum == stcp->th_sum) {
         res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
-- 
2.7.4
