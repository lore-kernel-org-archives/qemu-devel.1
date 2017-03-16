Received: from eggs.gnu.org ([2001:4830:134:3::10]:60937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5V-0000ev-Ex
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5S-0005bU-VU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:53 -0400
Received: from [59.151.112.132] (port=49856 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5S-0005b4-8e
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:50 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 17:52:08 +0800
Message-ID: <1489657928-14919-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] COLO-compare: Add virtio-net packet
 compare support
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

If packet is virtio-net packet we will skip the virtio-net header
compare packet's payload.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ce0cd12..34af11a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -237,7 +237,12 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
     }
 
     if (ptcp->th_sum == stcp->th_sum) {
-        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
+        if (ppkt->is_virtio_net_pkt) {
+            res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN
+                                             + VIRTIO_NET_HEADER);
+        } else {
+            res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
+        }
     } else {
         res = -1;
     }
@@ -285,8 +290,14 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
      * other field like TOS,TTL,IP Checksum. we only need to compare
      * the ip payload here.
      */
-    ret = colo_packet_compare_common(ppkt, spkt,
-                                     network_header_length + ETH_HLEN);
+    if (ppkt->is_virtio_net_pkt) {
+        ret = colo_packet_compare_common(ppkt, spkt,
+                                         network_header_length
+                                         + VIRTIO_NET_HEADER + ETH_HLEN);
+    } else {
+        ret = colo_packet_compare_common(ppkt, spkt,
+                                         network_header_length + ETH_HLEN);
+    }
 
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
@@ -309,6 +320,7 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
 static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
 {
     int network_header_length = ppkt->ip->ip_hl * 4;
+    int ret;
 
     trace_colo_compare_main("compare icmp");
 
@@ -322,8 +334,17 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
      * other field like TOS,TTL,IP Checksum. we only need to compare
      * the ip payload here.
      */
-    if (colo_packet_compare_common(ppkt, spkt,
-                                   network_header_length + ETH_HLEN)) {
+
+    if (ppkt->is_virtio_net_pkt) {
+        ret = colo_packet_compare_common(ppkt, spkt,
+                                         network_header_length
+                                         + VIRTIO_NET_HEADER + ETH_HLEN);
+    } else {
+        ret = colo_packet_compare_common(ppkt, spkt,
+                                         network_header_length + ETH_HLEN);
+    }
+
+    if (ret) {
         trace_colo_compare_icmp_miscompare("primary pkt size",
                                            ppkt->size);
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
-- 
2.7.4
