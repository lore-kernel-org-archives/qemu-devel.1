Received: from eggs.gnu.org ([2001:4830:134:3::10]:32992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkYX-0007RX-O5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkYU-0006xo-LH
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:49 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eEkYU-0006xc-Cr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:46 -0500
Received: by mail-pg0-x241.google.com with SMTP id z184so11163688pgd.13
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:23:46 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 14 Nov 2017 15:23:33 -0800
Message-Id: <1510701814-52973-2-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
References: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 1/2] e1000,
 e1000e: Move per-packet TX offload flags out of context state
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

sum_needed and cptse flags are received from the guest within each
transmit data descriptor. They are not part of the offload context;
instead, they determine how to apply a previously received context to
the packet being transmitted:

- If cptse is set, perform both segmentation and checksum offload
  using the parameters in the TSO context; otherwise just do checksum
  offload. (Currently the e1000 device incorrectly stores only one
  context, which will be fixed in a subsequent patch.)

- Depending on the bits set in sum_needed, possibly perform L4
  checksum offload and/or IP checksum offload, using the parameters in
  the appropriate context.

Move these flags out of struct e1000x_txd_props, which is otherwise
dedicated to storing values from a context descriptor, and into the
per-packet TX struct.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000.c         | 30 ++++++++++++++++--------------
 hw/net/e1000e.c        |  4 ++--
 hw/net/e1000e_core.c   | 16 ++++++++--------
 hw/net/e1000e_core.h   |  2 ++
 hw/net/e1000x_common.h |  2 --
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9324949..471cdd9 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -98,6 +98,8 @@ typedef struct E1000State_st {
         unsigned char data[0x10000];
         uint16_t size;
         unsigned char vlan_needed;
+        unsigned char sum_needed;
+        bool cptse;
         e1000x_txd_props props;
         uint16_t tso_frames;
     } tx;
@@ -540,7 +542,7 @@ xmit_seg(E1000State *s)
     unsigned int frames = s->tx.tso_frames, css, sofar;
     struct e1000_tx *tp = &s->tx;
 
-    if (tp->props.tse && tp->props.cptse) {
+    if (tp->props.tse && tp->cptse) {
         css = tp->props.ipcss;
         DBGOUT(TXSUM, "frames %d size %d ipcss %d\n",
                frames, tp->size, css);
@@ -564,7 +566,7 @@ xmit_seg(E1000State *s)
             }
         } else    /* UDP */
             stw_be_p(tp->data+css+4, len);
-        if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
+        if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
             unsigned int phsum;
             // add pseudo-header length before checksum calculation
             void *sp = tp->data + tp->props.tucso;
@@ -576,11 +578,11 @@ xmit_seg(E1000State *s)
         tp->tso_frames++;
     }
 
-    if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
+    if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
         putsum(tp->data, tp->size, tp->props.tucso,
                tp->props.tucss, tp->props.tucse);
     }
-    if (tp->props.sum_needed & E1000_TXD_POPTS_IXSM) {
+    if (tp->sum_needed & E1000_TXD_POPTS_IXSM) {
         putsum(tp->data, tp->size, tp->props.ipcso,
                tp->props.ipcss, tp->props.ipcse);
     }
@@ -624,17 +626,17 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
     } else if (dtype == (E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D)) {
         // data descriptor
         if (tp->size == 0) {
-            tp->props.sum_needed = le32_to_cpu(dp->upper.data) >> 8;
+            tp->sum_needed = le32_to_cpu(dp->upper.data) >> 8;
         }
-        tp->props.cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
+        tp->cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
     } else {
         // legacy descriptor
-        tp->props.cptse = 0;
+        tp->cptse = 0;
     }
 
     if (e1000x_vlan_enabled(s->mac_reg) &&
         e1000x_is_vlan_txd(txd_lower) &&
-        (tp->props.cptse || txd_lower & E1000_TXD_CMD_EOP)) {
+        (tp->cptse || txd_lower & E1000_TXD_CMD_EOP)) {
         tp->vlan_needed = 1;
         stw_be_p(tp->vlan_header,
                       le16_to_cpu(s->mac_reg[VET]));
@@ -643,7 +645,7 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
     }
 
     addr = le64_to_cpu(dp->buffer_addr);
-    if (tp->props.tse && tp->props.cptse) {
+    if (tp->props.tse && tp->cptse) {
         msh = tp->props.hdr_len + tp->props.mss;
         do {
             bytes = split_size;
@@ -665,7 +667,7 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
             }
             split_size -= bytes;
         } while (bytes && split_size);
-    } else if (!tp->props.tse && tp->props.cptse) {
+    } else if (!tp->props.tse && tp->cptse) {
         // context descriptor TSE is not set, while data descriptor TSE is set
         DBGOUT(TXERR, "TCP segmentation error\n");
     } else {
@@ -676,14 +678,14 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 
     if (!(txd_lower & E1000_TXD_CMD_EOP))
         return;
-    if (!(tp->props.tse && tp->props.cptse && tp->size < tp->props.hdr_len)) {
+    if (!(tp->props.tse && tp->cptse && tp->size < tp->props.hdr_len)) {
         xmit_seg(s);
     }
     tp->tso_frames = 0;
-    tp->props.sum_needed = 0;
+    tp->sum_needed = 0;
     tp->vlan_needed = 0;
     tp->size = 0;
-    tp->props.cptse = 0;
+    tp->cptse = 0;
 }
 
 static uint32_t
@@ -1459,7 +1461,7 @@ static const VMStateDescription vmstate_e1000 = {
         VMSTATE_UINT16(tx.props.mss, E1000State),
         VMSTATE_UINT16(tx.size, E1000State),
         VMSTATE_UINT16(tx.tso_frames, E1000State),
-        VMSTATE_UINT8(tx.props.sum_needed, E1000State),
+        VMSTATE_UINT8(tx.sum_needed, E1000State),
         VMSTATE_INT8(tx.props.ip, E1000State),
         VMSTATE_INT8(tx.props.tcp, E1000State),
         VMSTATE_BUFFER(tx.header, E1000State),
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index bad43f4..bc97a40 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -547,7 +547,7 @@ static const VMStateDescription e1000e_vmstate_tx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(props.sum_needed, struct e1000e_tx),
+        VMSTATE_UINT8(sum_needed, struct e1000e_tx),
         VMSTATE_UINT8(props.ipcss, struct e1000e_tx),
         VMSTATE_UINT8(props.ipcso, struct e1000e_tx),
         VMSTATE_UINT16(props.ipcse, struct e1000e_tx),
@@ -560,7 +560,7 @@ static const VMStateDescription e1000e_vmstate_tx = {
         VMSTATE_INT8(props.ip, struct e1000e_tx),
         VMSTATE_INT8(props.tcp, struct e1000e_tx),
         VMSTATE_BOOL(props.tse, struct e1000e_tx),
-        VMSTATE_BOOL(props.cptse, struct e1000e_tx),
+        VMSTATE_BOOL(cptse, struct e1000e_tx),
         VMSTATE_BOOL(skip_cp, struct e1000e_tx),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index badb1fe..b66bd70 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -632,18 +632,18 @@ e1000e_rss_parse_packet(E1000ECore *core,
 static void
 e1000e_setup_tx_offloads(E1000ECore *core, struct e1000e_tx *tx)
 {
-    if (tx->props.tse && tx->props.cptse) {
+    if (tx->props.tse && tx->cptse) {
         net_tx_pkt_build_vheader(tx->tx_pkt, true, true, tx->props.mss);
         net_tx_pkt_update_ip_checksums(tx->tx_pkt);
         e1000x_inc_reg_if_not_full(core->mac, TSCTC);
         return;
     }
 
-    if (tx->props.sum_needed & E1000_TXD_POPTS_TXSM) {
+    if (tx->sum_needed & E1000_TXD_POPTS_TXSM) {
         net_tx_pkt_build_vheader(tx->tx_pkt, false, true, 0);
     }
 
-    if (tx->props.sum_needed & E1000_TXD_POPTS_IXSM) {
+    if (tx->sum_needed & E1000_TXD_POPTS_IXSM) {
         net_tx_pkt_update_ip_hdr_checksum(tx->tx_pkt);
     }
 }
@@ -715,13 +715,13 @@ e1000e_process_tx_desc(E1000ECore *core,
         return;
     } else if (dtype == (E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D)) {
         /* data descriptor */
-        tx->props.sum_needed = le32_to_cpu(dp->upper.data) >> 8;
-        tx->props.cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
+        tx->sum_needed = le32_to_cpu(dp->upper.data) >> 8;
+        tx->cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
         e1000e_process_ts_option(core, dp);
     } else {
         /* legacy descriptor */
         e1000e_process_ts_option(core, dp);
-        tx->props.cptse = 0;
+        tx->cptse = 0;
     }
 
     addr = le64_to_cpu(dp->buffer_addr);
@@ -747,8 +747,8 @@ e1000e_process_tx_desc(E1000ECore *core,
         tx->skip_cp = false;
         net_tx_pkt_reset(tx->tx_pkt);
 
-        tx->props.sum_needed = 0;
-        tx->props.cptse = 0;
+        tx->sum_needed = 0;
+        tx->cptse = 0;
     }
 }
 
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 5f413a9..be4b4e9 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -71,6 +71,8 @@ struct E1000Core {
         e1000x_txd_props props;
 
         bool skip_cp;
+        unsigned char sum_needed;
+        bool cptse;
         struct NetTxPkt *tx_pkt;
     } tx[E1000E_NUM_QUEUES];
 
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 21bf28e..1116c35 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -193,7 +193,6 @@ void e1000x_update_regs_on_autoneg_done(uint32_t *mac, uint16_t *phy);
 void e1000x_increase_size_stats(uint32_t *mac, const int *size_regs, int size);
 
 typedef struct e1000x_txd_props {
-    unsigned char sum_needed;
     uint8_t ipcss;
     uint8_t ipcso;
     uint16_t ipcse;
@@ -206,7 +205,6 @@ typedef struct e1000x_txd_props {
     int8_t ip;
     int8_t tcp;
     bool tse;
-    bool cptse;
 } e1000x_txd_props;
 
 void e1000x_read_tx_ctx_descr(struct e1000_context_desc *d,
-- 
1.9.1
