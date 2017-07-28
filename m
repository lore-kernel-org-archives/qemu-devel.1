Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1db24W-0003oJ-RQ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1db24S-0003fD-IS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:00:40 -0400
Received: from [59.151.112.132] (port=17887 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1db24S-0003a9-53
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:00:36 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Jul 2017 18:03:10 +0800
Message-ID: <1501236190-15177-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/filter-rewriter.c: Fix rewirter checksum
 bug when use virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Because vnet_hdr have a offset to net packet, we must add it when use
virtio-net.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-rewriter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 55a6cf5..72e4928 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -99,7 +99,8 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
             /* handle packets to the secondary from the primary */
             tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
 
-            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+            net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
+                                   pkt->size - pkt->vnet_hdr_len);
         }
     }
 
@@ -138,7 +139,8 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
             /* handle packets to the primary from the secondary*/
             tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
 
-            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
+            net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
+                                   pkt->size - pkt->vnet_hdr_len);
         }
     }
 
-- 
2.7.4
