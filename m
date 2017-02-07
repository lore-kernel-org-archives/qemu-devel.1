Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cb2J8-0007Zp-1L
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cb2J4-00044H-T1
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:43:30 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cb2J4-00043f-Lq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:43:26 -0500
Received: by mail-lf0-x241.google.com with SMTP id v186so6159789lfa.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 01:43:25 -0800 (PST)
Message-ID: <589996bb.02482e0a.10629.5b0e@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  7 Feb 2017 01:43:08 -0800
Subject: [Qemu-devel] [PATCH] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dmitry@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

This issue is the same as e1000 network card in this commit:
e1000: eliminate infinite loops on out-of-bounds transfer start.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/net/e1000e_core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2b11499..53f2b1d 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -914,7 +914,8 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
     struct e1000_tx_desc desc;
     bool ide = false;
     const E1000E_RingInfo *txi = txr->i;
-    uint32_t cause = E1000_ICS_TXQE;
+    uint32_t tdh_start = core->mac[txi->dh], cause = E1000_ICS_TXQE;
+
 
     if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
         trace_e1000e_tx_disabled();
@@ -933,6 +934,14 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
         cause |= e1000e_txdesc_writeback(core, base, &desc, &ide, txi->idx);
 
         e1000e_ring_advance(core, txi, 1);
+
+        /*
+         * The following avoid infinite loop, just as the e1000
+         */
+        if (core->mac[txi->dh] == tdh_start ||
+            tdh_start >= core->mac[txi->dlen] / E1000_RING_DESC_LEN) {
+            break;
+            }
     }
 
     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
@@ -1500,6 +1509,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     size_t desc_size;
     size_t desc_offset = 0;
     size_t iov_ofs = 0;
+    uint32_t rdh_start;
 
     struct iovec *iov = net_rx_pkt_get_iovec(pkt);
     size_t size = net_rx_pkt_get_total_len(pkt);
@@ -1509,6 +1519,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     bool do_ps = e1000e_do_ps(core, pkt, &ps_hdr_len);
 
     rxi = rxr->i;
+    rdh_start = core->mac[rxi->dh];
 
     do {
         hwaddr ba[MAX_PS_BUFFERS];
@@ -1605,6 +1616,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_ring_advance(core, rxi,
                             core->rx_desc_len / E1000_MIN_RX_DESC_LEN);
 
+        if (core->mac[rxi->dh] == rdh_start ||
+            rdh_start >= core->mac[rxi->dlen] / E1000_RING_DESC_LEN) {
+            break;
+            }
     } while (desc_offset < total_size);
 
     e1000e_update_rx_stats(core, size, total_size);
-- 
1.8.3.1
