Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCR-0007Rk-Kz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCP-0002fE-Qz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:47 -0500
Received: from [59.151.112.132] (port=24133 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCP-0002eU-D2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:45 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 13:18:10 +0800
Message-ID: <1488259090-30034-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 3/3] COLO-compare: Fix icmp and udp compare
 different packet always dump bug
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

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 61fcdf2..6b38723 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -275,9 +275,13 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
 
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
@@ -303,12 +307,14 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
     if (colo_packet_compare_common(ppkt, spkt, network_length + ETH_HLEN)) {
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
