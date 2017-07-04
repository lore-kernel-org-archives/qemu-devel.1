Received: from eggs.gnu.org ([2001:4830:134:3::10]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003hm-4E
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhg-00074x-3k
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=28283 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhf-0006vy-65
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:56 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:53 +0800
Message-ID: <1499151236-14671-10-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 09/12] net/colo.c: Add vnet packet parse
 feature in colo-proxy
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

Make colo-compare and filter-rewriter can parse vnet packet.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
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
