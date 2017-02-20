Received: from eggs.gnu.org ([2001:4830:134:3::10]:46294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cfjIS-0006jF-Bs
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cfjIN-0004O1-Cz
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:26:12 -0500
Received: from [45.249.212.188] (port=2928 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cfjIM-0004Na-Pu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:26:07 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Mon, 20 Feb 2017 16:02:01 +0800
Message-ID: <1487577721-31084-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487577721-31084-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487577721-31084-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] filter-rewriter: skip
 net_checksum_calculate() while offset = 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

While the offset of packets's sequence for primary side and
secondary side is zero, it is unnecessary to call net_checksum_calculate()
to recalculate the checksume value of packets.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/filter-rewriter.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 7e7ec35..c9a6d43 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -93,10 +93,12 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
             conn->offset -= (ntohl(tcp_pkt->th_ack) - 1);
             conn->syn_flag = 0;
         }
-        /* handle packets to the secondary from the primary */
-        tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
+        if (conn->offset) {
+            /* handle packets to the secondary from the primary */
+            tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
 
-        net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+        }
         /*
          * Case 1:
          * The *server* side of this connect is VM, *client* tries to close
@@ -112,7 +114,6 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
          */
         if ((conn->tcp_state == TCPS_LAST_ACK) &&
             (ntohl(tcp_pkt->th_ack) == (conn->fin_ack_seq + 1))) {
-            fprintf(stderr, "Remove conn "
             g_hash_table_remove(rf->connection_track_table, key);
         }
     }
@@ -159,10 +160,13 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
     }
 
     if ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_ACK) {
-        /* handle packets to the primary from the secondary*/
-        tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
+        /* Only need to adjust seq while offset is Non-zero */
+        if (conn->offset) {
+            /* handle packets to the primary from the secondary*/
+            tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
 
-        net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+        }
         /*
          * Case 2:
          * The *server* side of this connect is VM, *server* tries to close
-- 
1.8.3.1
