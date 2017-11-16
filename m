Received: from eggs.gnu.org ([2001:4830:134:3::10]:33941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eFAWW-0000gu-MO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eFAWR-0005kK-EE
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:07:28 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:53926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eFAWR-0005j6-89
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:07:23 -0500
Received: by mail-pg0-x244.google.com with SMTP id r12so2775747pgu.10
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 19:07:22 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 15 Nov 2017 19:07:13 -0800
Message-Id: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3] net: Transmit zero UDP checksum as 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>

The checksum algorithm used by IPv4, TCP and UDP allows a zero value
to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
UDP checksum must be transmitted as 0xFFFF, as 0x0000 is a special
value meaning no checksum.

Substitute 0xFFFF whenever a checksum is computed as zero when
modifying a UDP datagram header. Doing this on IPv4 packets and TCP
segments is unnecessary but legal. Add a wrapper for
net_checksum_finish() that makes the substitution.

(We can't just change net_checksum_finish(), as that function is also
used by receivers to verify checksums, and in that case the expected
value is always 0x0000.)

v3:

Leave net_tx_pkt_update_ip_checksums() alone since it's only computing
a partial sum of the IP pseudo-header.

Rename wrapper to net_checksum_finish_nozero() for clarity.

v2:

Add a wrapper net_checksum_finish_hdr() rather than duplicating the
logic at every caller.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000.c         | 2 +-
 hw/net/net_rx_pkt.c    | 2 +-
 hw/net/net_tx_pkt.c    | 2 +-
 hw/net/vmxnet3.c       | 3 ++-
 include/net/checksum.h | 6 ++++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 72a92be..804ec08 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -506,7 +506,7 @@ putsum(uint8_t *data, uint32_t n, uint32_t sloc, uint32_t css, uint32_t cse)
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
1.9.1
