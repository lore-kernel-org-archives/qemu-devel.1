Received: from eggs.gnu.org ([2001:4830:134:3::10]:40926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbeDS-0006mD-OS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbeDN-0004o2-R7
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:10 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbeDN-0004nu-LJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:12:05 -0500
Received: by mail-io0-x242.google.com with SMTP id 101so851263iom.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 18:12:05 -0800 (PST)
Message-ID: <589bcff4.856d240a.3dcfb.a4be@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  8 Feb 2017 18:11:24 -0800
Subject: [Qemu-devel] [PATCH v2] net: e1000e: fix an infinite loop issue
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

This issue is like the issue in e1000 network card addressed in
this commit:
e1000: eliminate infinite loops on out-of-bounds transfer start.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since v1:
make wraparound detect in e1000e_ring_empty

 hw/net/e1000e_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2b11499..d4c56c3 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -806,7 +806,8 @@ typedef struct E1000E_RingInfo_st {
 static inline bool
 e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
 {
-    return core->mac[r->dh] == core->mac[r->dt];
+    return core->mac[r->dh] == core->mac[r->dt] ||
+                core->mac[r->dt] >= core->mac[r->dlen];
 }
 
 static inline uint64_t
@@ -914,7 +915,7 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
     struct e1000_tx_desc desc;
     bool ide = false;
     const E1000E_RingInfo *txi = txr->i;
-    uint32_t cause = E1000_ICS_TXQE;
+    uint32_t tdh_start = core->mac[txi->dh], cause = E1000_ICS_TXQE;
 
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
@@ -1522,6 +1533,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
             desc_size = core->rx_desc_buf_size;
         }
 
+        if (e1000e_ring_empty(core, rxi)) {
+            return;
+        }
+
         base = e1000e_ring_head_descr(core, rxi);
 
         pci_dma_read(d, base, &desc, core->rx_desc_len);
@@ -1605,6 +1620,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
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
