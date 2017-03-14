Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPn-00046K-Cy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPm-0006lp-Dp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnhPm-0006lR-7c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:42 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 16:02:29 +0800
Message-Id: <1489478550-19431-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
References: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] COLO-compare: Fix trace_event print bug
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

Because of inet_ntoa() return a statically allocated buffer,
subsequent calls will overwrite, So we fix this bug.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
