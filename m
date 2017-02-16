Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLD1-0003hu-EE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLD0-00088X-Hk
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:51 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceLD0-00088F-B2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:50 -0500
Received: by mail-wr0-x241.google.com with SMTP id c4so1878589wrd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:30:50 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Thu, 16 Feb 2017 14:29:36 +0200
Message-Id: <1487248176-29602-6-git-send-email-dmitry@daynix.com>
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH 5/5] NetRxPkt: Remove code duplication in
 net_rx_pkt_pull_data()
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

This is a refactoring commit that does not change behavior.

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
---
 hw/net/net_rx_pkt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index c7ae33d..3899211 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -88,20 +88,21 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
                         const struct iovec *iov, int iovcnt,
                         size_t ploff)
 {
+    uint32_t pllen = iov_size(iov, iovcnt) - ploff;
+
     if (pkt->ehdr_buf_len) {
         net_rx_pkt_iovec_realloc(pkt, iovcnt + 1);
 
         pkt->vec[0].iov_base = pkt->ehdr_buf;
         pkt->vec[0].iov_len = pkt->ehdr_buf_len;
 
-        pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
+        pkt->tot_len = pllen + pkt->ehdr_buf_len;
         pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
-                                iov, iovcnt, ploff,
-                                pkt->tot_len - pkt->ehdr_buf_len) + 1;
+                                iov, iovcnt, ploff, pllen) + 1;
     } else {
         net_rx_pkt_iovec_realloc(pkt, iovcnt);
 
-        pkt->tot_len = iov_size(iov, iovcnt) - ploff;
+        pkt->tot_len = pllen;
         pkt->vec_len = iov_copy(pkt->vec, pkt->vec_len_total,
                                 iov, iovcnt, ploff, pkt->tot_len);
     }
-- 
2.7.4
