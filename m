Received: from eggs.gnu.org ([2001:4830:134:3::10]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoH-0007F1-Mo
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoG-0000wE-Lk
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eGcoG-0000w5-Cs
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:48 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Nov 2017 11:31:26 +0800
Message-Id: <1511148687-24909-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
References: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] net: Transmit zero UDP checksum as 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Ed Swierk <eswierk@skyportsystems.com>, Jason Wang <jasowang@redhat.com>

From: Ed Swierk <eswierk@skyportsystems.com>

The checksum algorithm used by IPv4, TCP and UDP allows a zero value
to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
UDP checksum must be transmitted as 0xFFFF because 0x0000 is a special
value meaning no checksum.

Substitute 0xFFFF whenever a checksum is computed as zero when
modifying a UDP datagram header. Doing this on IPv4 and TCP checksums
is unnecessary but legal. Add a wrapper for net_checksum_finish() that
makes the substitution.

(We can't just change net_checksum_finish(), as that function is also
used by receivers to verify checksums, and in that case the expected
value is always 0x0000.)

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c         | 2 +-
 hw/net/net_rx_pkt.c    | 2 +-
 hw/net/net_tx_pkt.c    | 2 +-
 hw/net/vmxnet3.c       | 3 ++-
 include/net/checksum.h | 6 ++++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index c0abee4..05a00cb 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -503,7 +503,7 @@ putsum(uint8_t *data, uint32_t n, uint32_t sloc, uint32_t css, uint32_t cse)
         n = cse + 1;
     if (sloc < n-1) {
         sum = net_checksum_add(n-css, data+css);
-        stw_be_p(data + sloc, net_checksum_finish(sum));
+        stw_be_p(data + sloc, net_checksum_finish_nozero(sum));
     }
 }
 
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index cef1c2e..98a5030 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -518,7 +518,7 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
     cntr += net_checksum_add_iov(pkt->vec, pkt->vec_len,
                                  pkt->l4hdr_off, csl, cso);
 
-    csum = net_checksum_finish(cntr);
+    csum = net_checksum_finish_nozero(cntr);
 
     trace_net_rx_pkt_l4_csum_calc_csum(pkt->l4hdr_off, csl, cntr, csum);
 
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 20b2549..e29c881 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -486,7 +486,7 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
         net_checksum_add_iov(iov, iov_len, pkt->virt_hdr.csum_start, csl, cso);
 
     /* Put the checksum obtained into the packet */
-    csum = cpu_to_be16(net_checksum_finish(csum_cntr));
+    csum = cpu_to_be16(net_checksum_finish_nozero(csum_cntr));
     iov_from_buf(iov, iov_len, csum_offset, &csum, sizeof csum);
 }
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8c4bae5..cdc307d 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -972,7 +972,8 @@ static void vmxnet3_rx_need_csum_calculate(struct NetRxPkt *pkt,
     data = (uint8_t *)pkt_data + vhdr->csum_start;
     len = pkt_len - vhdr->csum_start;
     /* Put the checksum obtained into the packet */
-    stw_be_p(data + vhdr->csum_offset, net_raw_checksum(data, len));
+    stw_be_p(data + vhdr->csum_offset,
+             net_checksum_finish_nozero(net_checksum_add(len, data)));
 
     vhdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
     vhdr->flags |= VIRTIO_NET_HDR_F_DATA_VALID;
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 7df472c..05a0d27 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -34,6 +34,12 @@ net_checksum_add(int len, uint8_t *buf)
 }
 
 static inline uint16_t
+net_checksum_finish_nozero(uint32_t sum)
+{
+    return net_checksum_finish(sum) ?: 0xFFFF;
+}
+
+static inline uint16_t
 net_raw_checksum(uint8_t *data, int length)
 {
     return net_checksum_finish(net_checksum_add(length, data));
-- 
2.7.4
