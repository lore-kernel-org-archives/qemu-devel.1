Received: from eggs.gnu.org ([2001:4830:134:3::10]:51520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQq-0007On-Um
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQo-0001bL-Fj
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:20 -0400
Received: from [59.151.112.132] (port=36753 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQn-0001Zy-J0
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:18 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Sun, 16 Apr 2017 17:24:37 +0800
Message-ID: <1492334677-14170-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] COLO-compare: Optimize tcp compare trace
 event
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

Optimize two trace events as one, adjust print format make
it easy to read. rename trace_colo_compare_pkt_info_src/dst
to trace_colo_compare_tcp_info.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 29 +++++++++++++++++------------
 net/trace-events   |  3 +--
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 881d6b2..18cda58 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -279,18 +279,23 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
         res = -1;
     }
 
-    if (res != 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
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
+    if (res && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        char ip_src[20], ip_dst[20];
+
+        strcpy(ip_src, inet_ntoa(ppkt->ip->ip_src));
+        strcpy(ip_dst, inet_ntoa(ppkt->ip->ip_dst));
+
+        trace_colo_compare_tcp_info(ip_src,
+                                    ip_dst,
+                                    ntohl(ptcp->th_seq),
+                                    ntohl(stcp->th_seq),
+                                    ntohl(ptcp->th_ack),
+                                    ntohl(stcp->th_ack),
+                                    res,
+                                    ptcp->th_flags,
+                                    stcp->th_flags,
+                                    ppkt->size,
+                                    spkt->size);
 
         qemu_hexdump((char *)ppkt->data, stderr,
                      "colo-compare ppkt", ppkt->size);
diff --git a/net/trace-events b/net/trace-events
index 35198bc..123cb28 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,8 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
-colo_compare_pkt_info_src(const char *src, uint32_t sseq, uint32_t sack, int res, uint32_t sflag, int ssize) "src/dst: %s s: seq/ack=%u/%u res=%d flags=%x spkt_size: %d\n"
-colo_compare_pkt_info_dst(const char *dst, uint32_t dseq, uint32_t dack, int res, uint32_t dflag, int dsize) "src/dst: %s d: seq/ack=%u/%u res=%d flags=%x dpkt_size: %d\n"
+colo_compare_tcp_info(const char *src, const char *dst, uint32_t pseq, uint32_t sseq, uint32_t pack, uint32_t sack, int res, uint32_t pflag, uint32_t sflag, int psize, int ssize) "src/dst: %s/%s pseq/sseq:%u/%u pack/sack:%u/%u res=%d pflags/sflag:%x/%x psize/ssize:%d/%d \n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-- 
2.7.4
