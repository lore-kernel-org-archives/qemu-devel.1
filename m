Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQq-0007Ol-IQ
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQm-0001Zk-08
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:20 -0400
Received: from [59.151.112.132] (port=2168 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQl-0001XK-Ks
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:15 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Sun, 16 Apr 2017 17:24:36 +0800
Message-ID: <1492334677-14170-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] COLO-compare: Optimize tcp compare for
 option field
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

In this patch we support packet that have tcp options field.
Add tcp options field check, If the packet have options
field we just skip it and compare tcp payload,
Avoid unnecessary checkpoint, optimize performance.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index aada04e..881d6b2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -228,6 +228,7 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
 {
     struct tcphdr *ptcp, *stcp;
     int res;
+    int tcp_offset = 0;
 
     trace_colo_compare_main("compare tcp");
 
@@ -248,7 +249,31 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
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
+        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
+                     + (ptcp->th_off * 4);
+        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
+    } else if (ptcp->th_sum == stcp->th_sum) {
         res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
     } else {
         res = -1;
-- 
2.7.4
