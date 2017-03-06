Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9v-0007jL-Ce
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9u-00012e-Cp
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:11 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:39 +0800
Message-Id: <1488777954-4578-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 04/19] NetRxPkt: Do not try to pull more
 data than present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Dmitry Fleytman <dmitry@daynix.com>

In case of VLAN stripping, ETH header put into a
separate buffer, therefore amont of data copied
from original IOV should be smaller.

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 3361d7e..0003a0e 100644
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
