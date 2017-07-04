Received: from eggs.gnu.org ([2001:4830:134:3::10]:43989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhi-0003j2-EL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-000764-6Y
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from [59.151.112.132] (port=52152 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhg-0006rz-Ny
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:54 +0800
Message-ID: <1499151236-14671-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 10/12] net/colo-compare.c: Add vnet packet's
 tcp/udp/icmp compare
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

COLO-Proxy just focus on packet payload, so we skip vnet header.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 945e7d4..0be12de 100644
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
