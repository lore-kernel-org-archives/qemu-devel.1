Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCz-0003gZ-J1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCw-00087C-FS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceLCw-00086u-5E
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:46 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so2903898wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:30:46 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Thu, 16 Feb 2017 14:29:35 +0200
Message-Id: <1487248176-29602-5-git-send-email-dmitry@daynix.com>
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH 4/5] NetRxPkt: Account buffer with ETH header
 in IOV length
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

In case of VLAN stripping ETH header is stored in a
separate chunk and length of IOV should take this into
account.

This patch fixes checksum validation for RX packets
with VLAN header.

Devices affected by this problem: e1000e and vmxnet3.

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
---
 hw/net/net_rx_pkt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index d38babe..c7ae33d 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -97,7 +97,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
         pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
         pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
                                 iov, iovcnt, ploff,
-                                pkt->tot_len - pkt->ehdr_buf_len);
+                                pkt->tot_len - pkt->ehdr_buf_len) + 1;
     } else {
         net_rx_pkt_iovec_realloc(pkt, iovcnt);
 
-- 
2.7.4
