Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdR-0000So-1i
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdQ-00043C-9i
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:49 -0400
Received: from [59.151.112.132] (port=32737 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdP-0003zw-TB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:48 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:26 +0800
Message-ID: <1494553288-30764-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 10/12] net/colo-compare.c: Add vnet packet's
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

COLO-Proxy just focus on packet payload, So we skip vnet header.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index cb0b04e..bf565f3 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -188,6 +188,8 @@ static int packet_enqueue(CompareState *s, int mode)
  */
 static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
 {
+    int offset_all;
+
     if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
@@ -201,9 +203,12 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
                                    sec_ip_src, sec_ip_dst);
     }
 
+    offset_all = ppkt->vnet_hdr_len + offset;
+
     if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data + offset, spkt->data + offset,
-                      spkt->size - offset);
+        return memcmp(ppkt->data + offset_all,
+                      spkt->data + offset_all,
+                      spkt->size - offset_all);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
         return -1;
@@ -261,8 +266,9 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
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
