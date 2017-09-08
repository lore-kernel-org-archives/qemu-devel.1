Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8fq-0002vt-Fl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8fl-0001w5-O1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8fl-0001vL-9O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:33 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:07 +0800
Message-Id: <1504836324-4871-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 01/18] net/filter-rewriter.c: Fix rewirter
 checksum bug when use virtio-net
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

Because vnet_hdr have a offset to net packet, we must add it when use
virtio-net.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-rewriter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 9812009..2be388f 100644
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
