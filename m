Received: from eggs.gnu.org ([2001:4830:134:3::10]:58307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklA1-0007qR-Jb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklA0-00015Z-Sr
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklA0-00014x-My
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:16 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:41 +0800
Message-Id: <1488777954-4578-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 06/19] NetRxPkt: Remove code duplication
 in net_rx_pkt_pull_data()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Dmitry Fleytman <dmitry@daynix.com>

This is a refactoring commit that does not change behavior.

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 2649d40..cef1c2e 100644
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
