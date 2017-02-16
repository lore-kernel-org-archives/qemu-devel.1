Received: from eggs.gnu.org ([2001:4830:134:3::10]:47658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCT-0003HN-9t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCS-0007zO-Dt
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:17 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceLCS-0007z2-83
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:16 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so2881866wmd.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:30:16 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Thu, 16 Feb 2017 14:29:34 +0200
Message-Id: <1487248176-29602-4-git-send-email-dmitry@daynix.com>
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH 3/5] NetRxPkt: Do not try to pull more data
 than present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>

In case of VLAN stripping, ETH header put into a
separate buffer, therefore amont of data copied
from original IOV should be smaller.

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
---
 hw/net/net_rx_pkt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 7c0beac..d38babe 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -96,7 +96,8 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
 
         pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
         pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
-                                iov, iovcnt, ploff, pkt->tot_len);
+                                iov, iovcnt, ploff,
+                                pkt->tot_len - pkt->ehdr_buf_len);
     } else {
         net_rx_pkt_iovec_realloc(pkt, iovcnt);
 
-- 
2.7.4
