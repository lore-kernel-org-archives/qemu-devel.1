Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT7C-0003Zk-Iu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT7B-0006oF-KC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:46 -0500
Received: from [59.151.112.132] (port=47327 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT7B-0006iV-8M
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:45 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 11:32:10 +0800
Message-ID: <1487993530-30875-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] COLO-compare: Make qemu_hexdump() print
 data when trace-event ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9853232..5ffc4a3 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -288,9 +288,13 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
 
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
-        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
-        qemu_hexdump((char *)spkt->data, stderr, "colo-compare", spkt->size);
+        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
+                         ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr, "colo-compare",
+                         spkt->size);
+        }
     }
 
     return ret;
@@ -321,12 +325,14 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
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
+            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
+                         ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr, "colo-compare",
+                         spkt->size);
+        }
         return -1;
     } else {
         return 0;
-- 
2.7.4
