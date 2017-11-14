Received: from eggs.gnu.org ([2001:4830:134:3::10]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkaY-0000ap-CH
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkaU-0007yL-5J
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:25:54 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:49847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eEkaT-0007xb-VE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:25:50 -0500
Received: by mail-pg0-x243.google.com with SMTP id 70so4060317pgf.6
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:25:49 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 14 Nov 2017 15:25:38 -0800
Message-Id: <1510701938-53743-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH] net: Transmit zero UDP checksum as 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>

The checksum algorithm used by IPv4, TCP and UDP allows a zero value
to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
UDP checksum must be transmitted as 0xFFFF, as 0x0000 is a special
value meaning no checksum.

Substitute 0xFFFF whenever a checksum is computed as zero on a UDP
datagram. Doing this on IPv4 packets and TCP segments is unnecessary
but legal.

(While it is tempting to make the substitution in
net_checksum_finish(), that function is also used by receivers to
verify checksums, and in that case the expected value is always
0x0000.)

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000.c      | 5 +++--
 hw/net/net_rx_pkt.c | 3 +++
 hw/net/net_tx_pkt.c | 6 ++++++
 hw/net/vmxnet3.c    | 7 +++++--
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index d642314..97242a1 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -505,8 +505,9 @@ putsum(uint8_t *data, uint32_t n, uint32_t sloc, uint32_t css, uint32_t cse)
     if (cse && cse < n)
         n = cse + 1;
     if (sloc < n-1) {
-        sum = net_checksum_add(n-css, data+css);
-        stw_be_p(data + sloc, net_checksum_finish(sum));
+        sum = net_raw_checksum(data + css, n - css);
+        /* For UDP, zero checksum must be sent as 0xFFFF */
+        stw_be_p(data + sloc, sum ? sum : 0xffff);
     }
 }
 
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 1019b50..e820132 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -588,6 +588,9 @@ bool net_rx_pkt_fix_l4_csum(struct NetRxPkt *pkt)
 
     /* Calculate L4 checksum */
     csum = cpu_to_be16(_net_rx_pkt_calc_l4_csum(pkt));
+    if (!csum) {
+        csum = 0xFFFF; /* For UDP, zero checksum must be sent as 0xFFFF */
+    }
 
     /* Set calculated checksum to checksum word */
     iov_from_buf(pkt->vec, pkt->vec_len,
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 20b2549..21194e7 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -136,6 +136,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
         return;
     }
 
+    if (!csum) {
+        csum = 0xFFFF; /* For UDP, zero checksum must be sent as 0xFFFF */
+    }
     iov_from_buf(&pkt->vec[NET_TX_PKT_PL_START_FRAG], pkt->payload_frags,
                  pkt->virt_hdr.csum_offset, &csum, sizeof(csum));
 }
@@ -487,6 +490,9 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
 
     /* Put the checksum obtained into the packet */
     csum = cpu_to_be16(net_checksum_finish(csum_cntr));
+    if (!csum) {
+        csum = 0xFFFF; /* For UDP, zero checksum must be sent as 0xFFFF */
+    }
     iov_from_buf(iov, iov_len, csum_offset, &csum, sizeof csum);
 }
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 90f6943..de9c40e 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -942,6 +942,7 @@ static void vmxnet3_rx_need_csum_calculate(struct NetRxPkt *pkt,
     bool isip4, isip6, istcp, isudp;
     uint8_t *data;
     int len;
+    uint16_t sum;
 
     if (!net_rx_pkt_has_virt_hdr(pkt)) {
         return;
@@ -969,8 +970,10 @@ static void vmxnet3_rx_need_csum_calculate(struct NetRxPkt *pkt,
 
     data = (uint8_t *)pkt_data + vhdr->csum_start;
     len = pkt_len - vhdr->csum_start;
-    /* Put the checksum obtained into the packet */
-    stw_be_p(data + vhdr->csum_offset, net_raw_checksum(data, len));
+    sum = net_raw_checksum(data, len);
+    /* Put the checksum obtained into the packet; for UDP, zero checksum */
+    /* must be sent as 0xFFFF */
+    stw_be_p(data + vhdr->csum_offset, sum ? sum : 0xFFFF);
 
     vhdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
     vhdr->flags |= VIRTIO_NET_HDR_F_DATA_VALID;
-- 
1.9.1
