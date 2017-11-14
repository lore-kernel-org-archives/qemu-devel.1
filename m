Received: from eggs.gnu.org ([2001:4830:134:3::10]:32990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkYX-0007RV-Ni
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkYV-0006yG-PC
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:49 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:51209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eEkYV-0006xv-GP
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:23:47 -0500
Received: by mail-pg0-x241.google.com with SMTP id p9so16545874pgc.8
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:23:47 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 14 Nov 2017 15:23:34 -0800
Message-Id: <1510701814-52973-3-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
References: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 2/2] e1000: Separate TSO and non-TSO contexts,
 fixing UDP TX corruption
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

The device is supposed to maintain two distinct contexts for transmit
offloads: one has parameters for both segmentation and checksum
offload, the other only for checksum offload. The guest driver can
send two context descriptors, one for each context (the TSE flag
specifies which). Then the guest can refer to one or the other context
in subsequent transmit data descriptors, depending on what offloads it
wants applied to each packet.

Currently the e1000 device stores just one context, and misinterprets
the TSE flags in the context and data descriptors. This is often okay:
Linux happens to send a fresh context descriptor before every data
descriptor, so forgetting the other context doesn't matter. Windows
does rely on separate contexts for TSO vs. non-TSO packets, but for
mostly-TCP traffic the two contexts have identical TCP-specific
offload parameters so confusing them doesn't matter.

One case where this confusion matters is when a Windows guest sets up
a TSO context for TCP and a non-TSO context for UDP, and then
transmits both TCP and UDP traffic in parallel. The e1000 device
sometimes ends up using TCP-specific parameters while doing checksum
offload on a UDP datagram: it writes the checksum to offset 16 (the
correct location for a TCP checksum), stomping on two bytes of UDP
data, and leaving the wrong value in the actual UDP checksum field at
offset 6. (Even worse, the host network stack may then recompute the
UDP checksum, "correcting" it to match the corrupt data before sending
it out a physical interface.)

Correct this by tracking the TSO context independently of the non-TSO
context, and selecting the appropriate context based on the TSE flag
in each transmit data descriptor.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000.c | 70 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 471cdd9..d642314 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -101,6 +101,7 @@ typedef struct E1000State_st {
         unsigned char sum_needed;
         bool cptse;
         e1000x_txd_props props;
+        e1000x_txd_props tso_props;
         uint16_t tso_frames;
     } tx;
 
@@ -541,35 +542,37 @@ xmit_seg(E1000State *s)
     uint16_t len;
     unsigned int frames = s->tx.tso_frames, css, sofar;
     struct e1000_tx *tp = &s->tx;
+    struct e1000x_txd_props *props = tp->cptse ? &tp->tso_props : &tp->props;
 
-    if (tp->props.tse && tp->cptse) {
-        css = tp->props.ipcss;
+    if (tp->cptse) {
+        css = props->ipcss;
         DBGOUT(TXSUM, "frames %d size %d ipcss %d\n",
                frames, tp->size, css);
-        if (tp->props.ip) {    /* IPv4 */
+        if (props->ip) {    /* IPv4 */
             stw_be_p(tp->data+css+2, tp->size - css);
             stw_be_p(tp->data+css+4,
                      lduw_be_p(tp->data + css + 4) + frames);
         } else {         /* IPv6 */
             stw_be_p(tp->data+css+4, tp->size - css);
         }
-        css = tp->props.tucss;
+        css = props->tucss;
         len = tp->size - css;
-        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", tp->props.tcp, css, len);
-        if (tp->props.tcp) {
-            sofar = frames * tp->props.mss;
+        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", props->tcp, css, len);
+        if (props->tcp) {
+            sofar = frames * props->mss;
             stl_be_p(tp->data+css+4, ldl_be_p(tp->data+css+4)+sofar); /* seq */
-            if (tp->props.paylen - sofar > tp->props.mss) {
+            if (props->paylen - sofar > props->mss) {
                 tp->data[css + 13] &= ~9;    /* PSH, FIN */
             } else if (frames) {
                 e1000x_inc_reg_if_not_full(s->mac_reg, TSCTC);
             }
-        } else    /* UDP */
+        } else {    /* UDP */
             stw_be_p(tp->data+css+4, len);
+        }
         if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
             unsigned int phsum;
             // add pseudo-header length before checksum calculation
-            void *sp = tp->data + tp->props.tucso;
+            void *sp = tp->data + props->tucso;
 
             phsum = lduw_be_p(sp) + len;
             phsum = (phsum >> 16) + (phsum & 0xffff);
@@ -579,12 +582,10 @@ xmit_seg(E1000State *s)
     }
 
     if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
-        putsum(tp->data, tp->size, tp->props.tucso,
-               tp->props.tucss, tp->props.tucse);
+        putsum(tp->data, tp->size, props->tucso, props->tucss, props->tucse);
     }
     if (tp->sum_needed & E1000_TXD_POPTS_IXSM) {
-        putsum(tp->data, tp->size, tp->props.ipcso,
-               tp->props.ipcss, tp->props.ipcse);
+        putsum(tp->data, tp->size, props->ipcso, props->ipcss, props->ipcse);
     }
     if (tp->vlan_needed) {
         memmove(tp->vlan, tp->data, 4);
@@ -616,11 +617,11 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 
     s->mit_ide |= (txd_lower & E1000_TXD_CMD_IDE);
     if (dtype == E1000_TXD_CMD_DEXT) {    /* context descriptor */
-        e1000x_read_tx_ctx_descr(xp, &tp->props);
-        tp->tso_frames = 0;
-        if (tp->props.tucso == 0) {    /* this is probably wrong */
-            DBGOUT(TXSUM, "TCP/UDP: cso 0!\n");
-            tp->props.tucso = tp->props.tucss + (tp->props.tcp ? 16 : 6);
+        if (le32_to_cpu(xp->cmd_and_length) & E1000_TXD_CMD_TSE) {
+            e1000x_read_tx_ctx_descr(xp, &tp->tso_props);
+            tp->tso_frames = 0;
+        } else {
+            e1000x_read_tx_ctx_descr(xp, &tp->props);
         }
         return;
     } else if (dtype == (E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D)) {
@@ -645,8 +646,8 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
     }
 
     addr = le64_to_cpu(dp->buffer_addr);
-    if (tp->props.tse && tp->cptse) {
-        msh = tp->props.hdr_len + tp->props.mss;
+    if (tp->cptse) {
+        msh = tp->tso_props.hdr_len + tp->tso_props.mss;
         do {
             bytes = split_size;
             if (tp->size + bytes > msh)
@@ -655,21 +656,19 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
             bytes = MIN(sizeof(tp->data) - tp->size, bytes);
             pci_dma_read(d, addr, tp->data + tp->size, bytes);
             sz = tp->size + bytes;
-            if (sz >= tp->props.hdr_len && tp->size < tp->props.hdr_len) {
-                memmove(tp->header, tp->data, tp->props.hdr_len);
+            if (sz >= tp->tso_props.hdr_len
+                && tp->size < tp->tso_props.hdr_len) {
+                memmove(tp->header, tp->data, tp->tso_props.hdr_len);
             }
             tp->size = sz;
             addr += bytes;
             if (sz == msh) {
                 xmit_seg(s);
-                memmove(tp->data, tp->header, tp->props.hdr_len);
-                tp->size = tp->props.hdr_len;
+                memmove(tp->data, tp->header, tp->tso_props.hdr_len);
+                tp->size = tp->tso_props.hdr_len;
             }
             split_size -= bytes;
         } while (bytes && split_size);
-    } else if (!tp->props.tse && tp->cptse) {
-        // context descriptor TSE is not set, while data descriptor TSE is set
-        DBGOUT(TXERR, "TCP segmentation error\n");
     } else {
         split_size = MIN(sizeof(tp->data) - tp->size, split_size);
         pci_dma_read(d, addr, tp->data + tp->size, split_size);
@@ -678,7 +677,7 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 
     if (!(txd_lower & E1000_TXD_CMD_EOP))
         return;
-    if (!(tp->props.tse && tp->cptse && tp->size < tp->props.hdr_len)) {
+    if (!(tp->cptse && tp->size < tp->tso_props.hdr_len)) {
         xmit_seg(s);
     }
     tp->tso_frames = 0;
@@ -1435,7 +1434,7 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
 
 static const VMStateDescription vmstate_e1000 = {
     .name = "e1000",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 1,
     .pre_save = e1000_pre_save,
     .post_load = e1000_post_load,
@@ -1508,6 +1507,17 @@ static const VMStateDescription vmstate_e1000 = {
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, RA, 32),
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, MTA, 128),
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, VFTA, 128),
+        VMSTATE_UINT8_V(tx.tso_props.ipcss, E1000State, 3),
+        VMSTATE_UINT8_V(tx.tso_props.ipcso, E1000State, 3),
+        VMSTATE_UINT16_V(tx.tso_props.ipcse, E1000State, 3),
+        VMSTATE_UINT8_V(tx.tso_props.tucss, E1000State, 3),
+        VMSTATE_UINT8_V(tx.tso_props.tucso, E1000State, 3),
+        VMSTATE_UINT16_V(tx.tso_props.tucse, E1000State, 3),
+        VMSTATE_UINT32_V(tx.tso_props.paylen, E1000State, 3),
+        VMSTATE_UINT8_V(tx.tso_props.hdr_len, E1000State, 3),
+        VMSTATE_UINT16_V(tx.tso_props.mss, E1000State, 3),
+        VMSTATE_INT8_V(tx.tso_props.ip, E1000State, 3),
+        VMSTATE_INT8_V(tx.tso_props.tcp, E1000State, 3),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
-- 
1.9.1
