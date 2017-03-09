Received: from eggs.gnu.org ([2001:4830:134:3::10]:32923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1clshS-0007HG-3i
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1clshO-0005iR-6N
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:41:26 -0500
Received: from [59.151.112.132] (port=2879 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1clshN-0005KQ-P4
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:41:22 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 9 Mar 2017 15:40:07 +0800
Message-ID: <1489045207-27706-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] COLO-compare: Fix trace_event print bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Because of inet_ntoa() return a statically allocated buffer,
subsequent calls will overwrite, So we fix this bug.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 282727b..54e6d40 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -182,10 +182,18 @@ static int packet_enqueue(CompareState *s, int mode)
  */
 static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
 {
-    trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
-                               inet_ntoa(ppkt->ip->ip_dst), spkt->size,
-                               inet_ntoa(spkt->ip->ip_src),
-                               inet_ntoa(spkt->ip->ip_dst));
+    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
+
+        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
+        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
+        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
+        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
+
+        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
+                                   pri_ip_dst, spkt->size,
+                                   sec_ip_src, sec_ip_dst);
+    }
 
     if (ppkt->size == spkt->size) {
         return memcmp(ppkt->data + offset, spkt->data + offset,
@@ -336,10 +344,19 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
 static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
 {
     trace_colo_compare_main("compare other");
-    trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
-                               inet_ntoa(ppkt->ip->ip_dst), spkt->size,
-                               inet_ntoa(spkt->ip->ip_src),
-                               inet_ntoa(spkt->ip->ip_dst));
+    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
+
+        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
+        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
+        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
+        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
+
+        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
+                                   pri_ip_dst, spkt->size,
+                                   sec_ip_src, sec_ip_dst);
+    }
+
     return colo_packet_compare_common(ppkt, spkt, 0);
 }
 
-- 
2.7.4
