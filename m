Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAR-0008D1-MD
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAQ-0001JF-Ta
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAQ-0001IN-Nk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:42 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:50 +0800
Message-Id: <1488777954-4578-16-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 15/19] filter-rewriter: skip
 net_checksum_calculate() while offset = 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

While the offset of packets's sequence for primary side and
secondary side is zero, it is unnecessary to call net_checksum_calculate()
to recalculate the checksume value of packets.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
