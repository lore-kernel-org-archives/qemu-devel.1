Received: from eggs.gnu.org ([2001:4830:134:3::10]:43503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsI-0005ez-Ck
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004D2-Kw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:54 -0500
Received: from [45.249.212.188] (port=2946 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004B8-1A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:51 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 28 Feb 2017 11:54:19 +0800
Message-ID: <1488254059-22716-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/2] filter-rewriter: skip
 net_checksum_calculate() while offset = 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

While the offset of packets's sequence for primary side and
secondary side is zero, it is unnecessary to call net_checksum_calculate()
to recalculate the checksume value of packets.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/filter-rewriter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index c4ab91c..afa06e8 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -93,10 +93,12 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
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
     }
 
     return 0;
@@ -129,10 +131,13 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
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
     }
 
     return 0;
-- 
1.8.3.1
