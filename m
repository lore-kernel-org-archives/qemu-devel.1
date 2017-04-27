Received: from eggs.gnu.org ([2001:4830:134:3::10]:42066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3aOL-0001Qg-6M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3aOI-0001II-3N
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:46:53 -0400
Received: from [59.151.112.132] (port=44957 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3aOH-0001I5-Da
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:46:50 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 11:46:45 +0800
Message-ID: <1493264805-15398-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] COLO-compare: Improve tcp compare trace event
 readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>

Because of previous patch's trace arguments over the limit
of UST backend, so I rewrite the patch.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 33 ++++++++++++++++++++++-----------
 net/trace-events   |  3 +--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 4ab80b1..2639c7f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -265,17 +265,28 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
     }
 
     if (res != 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
-        trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
-                                        ntohl(stcp->th_seq),
-                                        ntohl(stcp->th_ack),
-                                        res, stcp->th_flags,
-                                        spkt->size);
-
-        trace_colo_compare_pkt_info_dst(inet_ntoa(ppkt->ip->ip_dst),
-                                        ntohl(ptcp->th_seq),
-                                        ntohl(ptcp->th_ack),
-                                        res, ptcp->th_flags,
-                                        ppkt->size);
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
+
+        trace_colo_compare_tcp_info("pri tcp packet",
+                                    ntohl(ptcp->th_seq),
+                                    ntohl(ptcp->th_ack),
+                                    res, ptcp->th_flags,
+                                    ppkt->size);
+
+        trace_colo_compare_tcp_info("sec tcp packet",
+                                    ntohl(stcp->th_seq),
+                                    ntohl(stcp->th_ack),
+                                    res, stcp->th_flags,
+                                    spkt->size);
 
         qemu_hexdump((char *)ppkt->data, stderr,
                      "colo-compare ppkt", ppkt->size);
diff --git a/net/trace-events b/net/trace-events
index 35198bc..247e5c0 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,8 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
-colo_compare_pkt_info_src(const char *src, uint32_t sseq, uint32_t sack, int res, uint32_t sflag, int ssize) "src/dst: %s s: seq/ack=%u/%u res=%d flags=%x spkt_size: %d\n"
-colo_compare_pkt_info_dst(const char *dst, uint32_t dseq, uint32_t dack, int res, uint32_t dflag, int dsize) "src/dst: %s d: seq/ack=%u/%u res=%d flags=%x dpkt_size: %d\n"
+colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= %x pkt_size: %d\n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-- 
2.7.4
