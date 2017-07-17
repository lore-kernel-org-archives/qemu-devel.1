Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52Z-0000ot-CE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52Y-0008Cq-Fa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52Y-0008CH-9w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:18 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:40 +0800
Message-Id: <1500294105-13713-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 09/14] net/colo.c: Add vnet packet parse feature
 in colo-proxy
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

Make colo-compare and filter-rewriter can parse vnet packet.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/colo.c b/net/colo.c
index 180eaed..28ce7c8 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -43,11 +43,11 @@ int parse_packet_early(Packet *pkt)
 {
     int network_length;
     static const uint8_t vlan[] = {0x81, 0x00};
-    uint8_t *data = pkt->data;
+    uint8_t *data = pkt->data + pkt->vnet_hdr_len;
     uint16_t l3_proto;
     ssize_t l2hdr_len = eth_get_l2_hdr_length(data);
 
-    if (pkt->size < ETH_HLEN) {
+    if (pkt->size < ETH_HLEN + pkt->vnet_hdr_len) {
         trace_colo_proxy_main("pkt->size < ETH_HLEN");
         return 1;
     }
@@ -73,7 +73,7 @@ int parse_packet_early(Packet *pkt)
     }
 
     network_length = pkt->ip->ip_hl * 4;
-    if (pkt->size < l2hdr_len + network_length) {
+    if (pkt->size < l2hdr_len + network_length + pkt->vnet_hdr_len) {
         trace_colo_proxy_main("pkt->size < network_header + network_length");
         return 1;
     }
-- 
2.7.4
