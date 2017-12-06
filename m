Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWn-0007uQ-BQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWh-0004CN-Dj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16913
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWh-00045S-0g
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:03 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 6 Dec 2017 17:57:25 +0800
Message-ID: <b6d0276b6310888ce85e96277826e8e1ae1ba541.1512552817.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/4] colo: remove the incorrect if
 conditions in colo_compare_packet_tcp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

The th_off field specifies the size of the TCP header, if th_off > 5,
it only means this tcp packet have options field. Regardless of whether
the packet carries option fields, it doesn't effect us to obtain the
length of the header use a general method. So there is no need to add
the limiting conditions(if (th_off > 5)). In addtion, here we just focus
on the payload, don't care about the option field. So removed the
'if (th_off > 5)' and 'if (ptcp->th_sum == stcp->th_sum)' conditions
together.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 net/colo-compare.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1ce195f..0afb5f0 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -271,26 +271,19 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
      * the secondary guest's timestamp. COLO just focus on payload,
      * so we just need skip this field.
      */
-    if (ptcp->th_off > 5) {
-        ptrdiff_t ptcp_offset, stcp_offset;
+    ptrdiff_t ptcp_offset, stcp_offset;
 
-        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
-                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
-        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
-                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
-
-        /*
-         * When network is busy, some tcp options(like sack) will unpredictable
-         * occur in primary side or secondary side. it will make packet size
-         * not same, but the two packet's payload is identical. colo just
-         * care about packet payload, so we skip the option field.
-         */
-        res = colo_packet_compare_common(ppkt, spkt, ptcp_offset, stcp_offset);
-    } else if (ptcp->th_sum == stcp->th_sum) {
-        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN, ETH_HLEN);
-    } else {
-        res = -1;
-    }
+    ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
+                  + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
+    stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
+                  + (stcp->th_off * 4) - spkt->vnet_hdr_len;
+    /*
+     * When network is busy, some tcp options(like sack) will unpredictable
+     * occur in primary side or secondary side. it will make packet size
+     * not same, but the two packet's payload is identical. colo just
+     * care about packet payload, so we skip the option field.
+     */
+    res = colo_packet_compare_common(ppkt, spkt, ptcp_offset, stcp_offset);
 
     if (res != 0 &&
         trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-- 
2.9.4
