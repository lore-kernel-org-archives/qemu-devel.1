Received: from eggs.gnu.org ([2001:4830:134:3::10]:35089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyui8-0002Ic-7q
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyui3-0006uC-MP
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:28:00 -0400
Received: from [59.151.112.132] (port=57362 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cyui3-0006rH-8p
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:27:55 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 14 Apr 2017 14:27:15 +0800
Message-ID: <1492151235-16173-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/filter-rewriter.c: Fix trace_event print
 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Because of inet_ntoa() return a statically allocated buffer,
subsequent calls will overwrite, So we fix this bug.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-rewriter.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 91cf6b2..aad00b4 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -69,8 +69,13 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
 
     tcp_pkt = (struct tcphdr *)pkt->transport_header;
     if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+        char ip_src[20], ip_dst[20];
+
+        strcpy(ip_src, inet_ntoa(pkt->ip->ip_src));
+        strcpy(ip_dst, inet_ntoa(pkt->ip->ip_dst));
+
         trace_colo_filter_rewriter_pkt_info(__func__,
-                    inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
+                    ip_src, ip_dst,
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
                     tcp_pkt->th_flags);
         trace_colo_filter_rewriter_conn_offset(conn->offset);
@@ -144,8 +149,13 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
     tcp_pkt = (struct tcphdr *)pkt->transport_header;
 
     if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+        char ip_src[20], ip_dst[20];
+
+        strcpy(ip_src, inet_ntoa(pkt->ip->ip_src));
+        strcpy(ip_dst, inet_ntoa(pkt->ip->ip_dst));
+
         trace_colo_filter_rewriter_pkt_info(__func__,
-                    inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
+                    ip_src, ip_dst,
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
                     tcp_pkt->th_flags);
         trace_colo_filter_rewriter_conn_offset(conn->offset);
-- 
2.7.4
