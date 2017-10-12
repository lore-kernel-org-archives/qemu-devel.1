Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e2nNl-00075p-Dv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e2nNi-0004UG-9V
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:59:17 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:54675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1e2nNi-0004Ql-0P
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:59:14 -0400
Received: by mail-pf0-x22f.google.com with SMTP id m28so7213452pfi.11
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 16:59:12 -0700 (PDT)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 12 Oct 2017 16:59:03 -0700
Message-Id: <1507852743-51639-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [RFC] e1000: Faulty tx checksum offload corrupts
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eswierk@skyportsystems.com, qemu-devel@nongnu.org

The transmit checksum offload implementation in QEMU's e1000 device is
deficient and causes packet data corruption in some situations.

According to the Intel 8254x software developer's manual[1], the
device maintains two separate contexts: the TCP segmentation offload
context includes parameters for both segmentation offload and checksum
offload, and the normal (checksum-offload-only) context includes only
checksum offload parameters. These parameters specify over which
packet data to compute the checksum, and where in the packet to store
the computed checksum(s).

[1] https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf

The e1000 driver can update either of these contexts by sending a
transmit context descriptor. The TSE bit in the TUCMD field controls
which context is modified by the descriptor. Crucially, a transmit
context descriptor with TSE=1 changes only the TSO context, leaving
the SUM context unchanged; with TSE=0 the opposite is true.

Fields in the transmit data descriptor determine which (if either) of
these two contexts the device uses when actually transmitting some
data:

- If the TSE bit in the DCMD field is set, then the device performs
  TCP segmentation offload using the parameters previously set in the
  TSO context. In addition, if TXSM and/or IXSM is set in the POPTS
  field, the device performs the appropriate checksum offloads using
  the parameters in the same (TSO) context.

- Otherwise, if the TSE bit in the DCMD field is clear, then there is
  no TCP segmentation offload. If TXSM and/or IXSM is set in the POPTS
  field, the device performs the appropriate checksum offloads using
  the parameters in the SUM context.

The e1000 driver is free to set up the TSO and SUM contexts and then
transmit a mixture of data, with each data descriptor using a
different (or neither) context. This is what the e1000 driver for
Windows (Intel(R) PRO/1000 MT Network Connection, aka E1G6023E.sys)
does in certain cases. Sometimes with quite undesirable results, since
the QEMU e1000 device doesn't work as described above.

Instead, the QEMU e1000 device maintains only one context in its state
structure. When it receives a transmit context descriptor from the
driver, it overwrites the context parameters regardless of the TSE bit
in the TUCMD field.

To see why this is wrong, suppose the driver first sets up a SUM
context with UDP checksum offload parameters (say, TUCSO pointing to
the appropriate offset for a UDP checksum, 6 bytes into the header),
and then sets up a TSO context with TCP checksum offload parameters
(TUCSO pointing to the appropriate offset for a TCP checksum, 16 bytes
into the header). The driver then sends a transmit data descriptor
with TSO=0 and TXSM=1 along with a UDP datagram. The QEMU e1000 device
computes the checksum using the last set of checksum offload
parameters, and writes the checksum to offset 16, stomping on two
bytes of UDP data, and leaving the wrong checksum in the UDP checksum
field.

To make matters worse, if the network stack on the host running QEMU
treats data transmitted from a VM as locally originated, it may do its
own UDP checksum computation, "correcting" it to match the corrupt
data before sending it on the wire. Now the corrupt UDP packet makes
its way all the way to the destination.

(A separate layer of icing on the cake is that QEMU ignores the
requirement that a UDP checksum computed as zero be sent as 0xffff,
since zero is a special value meaning no checksum. So even when QEMU
doesn't corrupt the packet data, the packet sometimes leaves the box
with no checksum at all.)

I have instrumented QEMU and reproduced this behavior with a Windows
10 guest (rather easily with a TCP iperf and a UDPi iperf running in
parallel). I have also attempted a fix, which is below in very rough
form.

Before I spend too much time refining a patch, I'd like to get
feedback on my approach.

One puzzle is what to do about e1000e: it shares shares some data
structures and a bit of code with e1000, but little else, which is
surprising given how similar they are (or should be). The e1000e's
handling of TCP segmentation offload and checksum offload is totally
different, and problematic for other reasons (it totally ignores most
of the context parameters provided by the driver and basically does
what it thinks is best by digging into the packet data). Is this
divergence intentional? Is there a reason not to change e1000e as long
as I'm trying to make e1000 more datasheet-conformant?

--Ed

---
 hw/net/e1000.c         | 176 ++++++++++++++++++++++++++++++++++---------------
 hw/net/e1000x_common.h |   4 +-
 2 files changed, 126 insertions(+), 54 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9324949..e45746f 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -98,7 +98,10 @@ typedef struct E1000State_st {
         unsigned char data[0x10000];
         uint16_t size;
         unsigned char vlan_needed;
-        e1000x_txd_props props;
+        unsigned char sum_needed;
+        bool cptse;
+        e1000x_txd_props sum_props;
+        e1000x_txd_props tso_props;
         uint16_t tso_frames;
     } tx;
 
@@ -534,56 +537,91 @@ e1000_send_packet(E1000State *s, const uint8_t *buf, int size)
 }
 
 static void
+debug_csum(struct e1000_tx *tp)
+{
+    e1000x_txd_props *props = tp->cptse ? &tp->tso_props : &tp->sum_props;
+    uint8_t proto = tp->data[14 + 9];
+    uint32_t sumoff = props->tucso - props->tucss;
+    uint16_t oldsum = lduw_be_p(tp->data + props->tucso);
+
+    if ((proto == 17 && sumoff != 6) ||
+        (proto == 6 && sumoff != 16)) {
+        DBGOUT(TXERR, "txsum bug! ver %d src %08x dst %08x len %d proto %d cptse %d sum_needed %x oldsum %x newsum %x realsum %x\n",
+               tp->data[14] >> 4,
+               ldl_be_p(tp->data + 14 + 12),
+               ldl_be_p(tp->data + 14 + 16),
+               lduw_be_p(tp->data + 14 + 2),
+               proto,
+               tp->cptse,
+               tp->sum_needed,
+               oldsum,
+               lduw_be_p(tp->data + props->tucso),
+               lduw_be_p(tp->data + props->tucss + (proto == 6 ? 16 : 6)));
+    }
+}
+
+static void
 xmit_seg(E1000State *s)
 {
     uint16_t len;
     unsigned int frames = s->tx.tso_frames, css, sofar;
     struct e1000_tx *tp = &s->tx;
 
-    if (tp->props.tse && tp->props.cptse) {
-        css = tp->props.ipcss;
+    if (tp->cptse) {
+        css = tp->tso_props.ipcss;
         DBGOUT(TXSUM, "frames %d size %d ipcss %d\n",
                frames, tp->size, css);
-        if (tp->props.ip) {    /* IPv4 */
+        if (tp->tso_props.ip) {    /* IPv4 */
             stw_be_p(tp->data+css+2, tp->size - css);
             stw_be_p(tp->data+css+4,
                      lduw_be_p(tp->data + css + 4) + frames);
         } else {         /* IPv6 */
             stw_be_p(tp->data+css+4, tp->size - css);
         }
-        css = tp->props.tucss;
+        css = tp->tso_props.tucss;
         len = tp->size - css;
-        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", tp->props.tcp, css, len);
-        if (tp->props.tcp) {
-            sofar = frames * tp->props.mss;
+        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", tp->tso_props.tcp, css, len);
+        if (tp->tso_props.tcp) {
+            sofar = frames * tp->tso_props.mss;
             stl_be_p(tp->data+css+4, ldl_be_p(tp->data+css+4)+sofar); /* seq */
-            if (tp->props.paylen - sofar > tp->props.mss) {
+            if (tp->tso_props.paylen - sofar > tp->tso_props.mss) {
                 tp->data[css + 13] &= ~9;    /* PSH, FIN */
             } else if (frames) {
                 e1000x_inc_reg_if_not_full(s->mac_reg, TSCTC);
             }
         } else    /* UDP */
             stw_be_p(tp->data+css+4, len);
-        if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
+        if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
             unsigned int phsum;
             // add pseudo-header length before checksum calculation
-            void *sp = tp->data + tp->props.tucso;
+            void *sp = tp->data + tp->tso_props.tucso;
 
             phsum = lduw_be_p(sp) + len;
             phsum = (phsum >> 16) + (phsum & 0xffff);
             stw_be_p(sp, phsum);
         }
         tp->tso_frames++;
+        if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
+            putsum(tp->data, tp->size, tp->tso_props.tucso,
+                   tp->tso_props.tucss, tp->tso_props.tucse);
+            debug_csum(tp);
+        }
+        if (tp->sum_needed & E1000_TXD_POPTS_IXSM) {
+            putsum(tp->data, tp->size, tp->tso_props.ipcso,
+                   tp->tso_props.ipcss, tp->tso_props.ipcse);
+        }
+    } else {
+        if (tp->sum_needed & E1000_TXD_POPTS_TXSM) {
+            putsum(tp->data, tp->size, tp->sum_props.tucso,
+                   tp->sum_props.tucss, tp->sum_props.tucse);
+            debug_csum(tp);
+        }
+        if (tp->sum_needed & E1000_TXD_POPTS_IXSM) {
+            putsum(tp->data, tp->size, tp->sum_props.ipcso,
+                   tp->sum_props.ipcss, tp->sum_props.ipcse);
+        }
     }
 
-    if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
-        putsum(tp->data, tp->size, tp->props.tucso,
-               tp->props.tucss, tp->props.tucse);
-    }
-    if (tp->props.sum_needed & E1000_TXD_POPTS_IXSM) {
-        putsum(tp->data, tp->size, tp->props.ipcso,
-               tp->props.ipcss, tp->props.ipcse);
-    }
     if (tp->vlan_needed) {
         memmove(tp->vlan, tp->data, 4);
         memmove(tp->data, tp->data + 4, 8);
@@ -601,6 +639,39 @@ xmit_seg(E1000State *s)
 }
 
 static void
+debug_ctx_desc(e1000x_txd_props *props)
+{
+    DBGOUT(TXERR, "context descriptor: tse %d ip %d tcp %d ipcss %d ipcso %d ipcse %d tucss %d tucso %d tucse %d\n",
+           props->tse,
+           props->ip,
+           props->tcp,
+           props->ipcss,
+           props->ipcso,
+           props->ipcse,
+           props->tucss,
+           props->tucso,
+           props->tucse);
+}
+
+static void
+debug_data_desc(struct e1000_tx *tp)
+{
+    DBGOUT(TXERR, "data descriptor: size %d sum_needed %d cptse %d\n",
+           tp->size,
+           tp->sum_needed,
+           tp->cptse);
+}
+
+static void
+debug_legacy_desc(struct e1000_tx *tp)
+{
+    DBGOUT(TXERR, "legacy descriptor: size %d sum_needed %d cptse %d\n",
+           tp->size,
+           tp->sum_needed,
+           tp->cptse);
+}
+
+static void
 process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 {
     PCIDevice *d = PCI_DEVICE(s);
@@ -614,27 +685,31 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 
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
+            debug_ctx_desc(&tp->tso_props);
+        } else {
+            e1000x_read_tx_ctx_descr(xp, &tp->sum_props);
+            debug_ctx_desc(&tp->sum_props);
         }
         return;
     } else if (dtype == (E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D)) {
         // data descriptor
         if (tp->size == 0) {
-            tp->props.sum_needed = le32_to_cpu(dp->upper.data) >> 8;
+            tp->sum_needed = le32_to_cpu(dp->upper.data) >> 8;
         }
-        tp->props.cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
+        tp->cptse = (txd_lower & E1000_TXD_CMD_TSE) ? 1 : 0;
+        debug_data_desc(tp);
     } else {
         // legacy descriptor
-        tp->props.cptse = 0;
+        tp->cptse = 0;
+        debug_legacy_desc(tp);
     }
 
     if (e1000x_vlan_enabled(s->mac_reg) &&
         e1000x_is_vlan_txd(txd_lower) &&
-        (tp->props.cptse || txd_lower & E1000_TXD_CMD_EOP)) {
+        (tp->cptse || txd_lower & E1000_TXD_CMD_EOP)) {
         tp->vlan_needed = 1;
         stw_be_p(tp->vlan_header,
                       le16_to_cpu(s->mac_reg[VET]));
@@ -643,8 +718,8 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
     }
 
     addr = le64_to_cpu(dp->buffer_addr);
-    if (tp->props.tse && tp->props.cptse) {
-        msh = tp->props.hdr_len + tp->props.mss;
+    if (tp->cptse) {
+        msh = tp->tso_props.hdr_len + tp->tso_props.mss;
         do {
             bytes = split_size;
             if (tp->size + bytes > msh)
@@ -653,21 +728,18 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
             bytes = MIN(sizeof(tp->data) - tp->size, bytes);
             pci_dma_read(d, addr, tp->data + tp->size, bytes);
             sz = tp->size + bytes;
-            if (sz >= tp->props.hdr_len && tp->size < tp->props.hdr_len) {
-                memmove(tp->header, tp->data, tp->props.hdr_len);
+            if (sz >= tp->tso_props.hdr_len && tp->size < tp->tso_props.hdr_len) {
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
-    } else if (!tp->props.tse && tp->props.cptse) {
-        // context descriptor TSE is not set, while data descriptor TSE is set
-        DBGOUT(TXERR, "TCP segmentation error\n");
     } else {
         split_size = MIN(sizeof(tp->data) - tp->size, split_size);
         pci_dma_read(d, addr, tp->data + tp->size, split_size);
@@ -676,14 +748,14 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
 
     if (!(txd_lower & E1000_TXD_CMD_EOP))
         return;
-    if (!(tp->props.tse && tp->props.cptse && tp->size < tp->props.hdr_len)) {
+    if (!(tp->cptse && tp->size < tp->tso_props.hdr_len)) {
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
@@ -1448,20 +1520,20 @@ static const VMStateDescription vmstate_e1000 = {
         VMSTATE_UINT16(eecd_state.bitnum_out, E1000State),
         VMSTATE_UINT16(eecd_state.reading, E1000State),
         VMSTATE_UINT32(eecd_state.old_eecd, E1000State),
-        VMSTATE_UINT8(tx.props.ipcss, E1000State),
-        VMSTATE_UINT8(tx.props.ipcso, E1000State),
-        VMSTATE_UINT16(tx.props.ipcse, E1000State),
-        VMSTATE_UINT8(tx.props.tucss, E1000State),
-        VMSTATE_UINT8(tx.props.tucso, E1000State),
-        VMSTATE_UINT16(tx.props.tucse, E1000State),
-        VMSTATE_UINT32(tx.props.paylen, E1000State),
-        VMSTATE_UINT8(tx.props.hdr_len, E1000State),
-        VMSTATE_UINT16(tx.props.mss, E1000State),
+        VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
+        VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
+        VMSTATE_UINT16(tx.tso_props.ipcse, E1000State),
+        VMSTATE_UINT8(tx.tso_props.tucss, E1000State),
+        VMSTATE_UINT8(tx.tso_props.tucso, E1000State),
+        VMSTATE_UINT16(tx.tso_props.tucse, E1000State),
+        VMSTATE_UINT32(tx.tso_props.paylen, E1000State),
+        VMSTATE_UINT8(tx.tso_props.hdr_len, E1000State),
+        VMSTATE_UINT16(tx.tso_props.mss, E1000State),
         VMSTATE_UINT16(tx.size, E1000State),
         VMSTATE_UINT16(tx.tso_frames, E1000State),
-        VMSTATE_UINT8(tx.props.sum_needed, E1000State),
-        VMSTATE_INT8(tx.props.ip, E1000State),
-        VMSTATE_INT8(tx.props.tcp, E1000State),
+        VMSTATE_UINT8(tx.tso_props.sum_needed, E1000State),
+        VMSTATE_INT8(tx.tso_props.ip, E1000State),
+        VMSTATE_INT8(tx.tso_props.tcp, E1000State),
         VMSTATE_BUFFER(tx.header, E1000State),
         VMSTATE_BUFFER(tx.data, E1000State),
         VMSTATE_UINT16_ARRAY(eeprom_data, E1000State, 64),
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 21bf28e..bd27d63 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -193,7 +193,7 @@ void e1000x_update_regs_on_autoneg_done(uint32_t *mac, uint16_t *phy);
 void e1000x_increase_size_stats(uint32_t *mac, const int *size_regs, int size);
 
 typedef struct e1000x_txd_props {
-    unsigned char sum_needed;
+    unsigned char sum_needed; // doesn't belong here
     uint8_t ipcss;
     uint8_t ipcso;
     uint16_t ipcse;
@@ -206,7 +206,7 @@ typedef struct e1000x_txd_props {
     int8_t ip;
     int8_t tcp;
     bool tse;
-    bool cptse;
+    bool cptse; // doesn't belong here
 } e1000x_txd_props;
 
 void e1000x_read_tx_ctx_descr(struct e1000_context_desc *d,
-- 
1.9.1
