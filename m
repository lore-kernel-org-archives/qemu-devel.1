Received: from eggs.gnu.org ([2001:4830:134:3::10]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fdii8-0000j3-Md
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fdii7-0006BC-F1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:01:12 -0400
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu, 12 Jul 2018 14:00:52 -0700
Message-Id: <20180712210052.28432-1-mdavidsaver@gmail.com>
In-Reply-To: <20180709062509.GH22363@umbus.fritz.box>
References: <20180709062509.GH22363@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] etsec: fix IRQ (un)masking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Interrupt conditions occurring while masked are not being
signaled when later unmasked.
The fix is to raise/lower IRQs when IMASK is changed.

To avoid problems like this in future, consolidate
IRQ pin update logic in one function.

Also fix probable typo "IEVENT_TXF | IEVENT_TXF",
and update IRQ pins on reset.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/net/fsl_etsec/etsec.c     | 68 +++++++++++++++++++++++---------------------
 hw/net/fsl_etsec/etsec.h     |  2 ++
 hw/net/fsl_etsec/registers.h | 10 +++++++
 hw/net/fsl_etsec/rings.c     | 12 +-------
 4 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 9da1932970..0b66274ce3 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -49,6 +49,28 @@ static const int debug_etsec;
     }                                          \
     } while (0)
 
+/* call after any change to IEVENT or IMASK */
+void etsec_update_irq(eTSEC *etsec)
+{
+    uint32_t ievent = etsec->regs[IEVENT].value;
+    uint32_t imask  = etsec->regs[IMASK].value;
+    uint32_t active = ievent & imask;
+
+    int tx  = !!(active & IEVENT_TX_MASK);
+    int rx  = !!(active & IEVENT_RX_MASK);
+    int err = !!(active & IEVENT_ERR_MASK);
+
+    DPRINTF("%s IRQ ievent=%"PRIx32" imask=%"PRIx32" %c%c%c",
+            __func__, ievent, imask,
+            tx  ? 'T' : '_',
+            rx  ? 'R' : '_',
+            err ? 'E' : '_');
+
+    qemu_set_irq(etsec->tx_irq, tx);
+    qemu_set_irq(etsec->rx_irq, rx);
+    qemu_set_irq(etsec->err_irq, err);
+}
+
 static uint64_t etsec_read(void *opaque, hwaddr addr, unsigned size)
 {
     eTSEC          *etsec     = opaque;
@@ -139,31 +161,6 @@ static void write_rbasex(eTSEC          *etsec,
     etsec->regs[RBPTR0 + (reg_index - RBASE0)].value = value & ~0x7;
 }
 
-static void write_ievent(eTSEC          *etsec,
-                         eTSEC_Register *reg,
-                         uint32_t        reg_index,
-                         uint32_t        value)
-{
-    /* Write 1 to clear */
-    reg->value &= ~value;
-
-    if (!(reg->value & (IEVENT_TXF | IEVENT_TXF))) {
-        qemu_irq_lower(etsec->tx_irq);
-    }
-    if (!(reg->value & (IEVENT_RXF | IEVENT_RXF))) {
-        qemu_irq_lower(etsec->rx_irq);
-    }
-
-    if (!(reg->value & (IEVENT_MAG | IEVENT_GTSC | IEVENT_GRSC | IEVENT_TXC |
-                        IEVENT_RXC | IEVENT_BABR | IEVENT_BABT | IEVENT_LC |
-                        IEVENT_CRL | IEVENT_FGPI | IEVENT_FIR | IEVENT_FIQ |
-                        IEVENT_DPE | IEVENT_PERR | IEVENT_EBERR | IEVENT_TXE |
-                        IEVENT_XFUN | IEVENT_BSY | IEVENT_MSRO | IEVENT_MMRD |
-                        IEVENT_MMRW))) {
-        qemu_irq_lower(etsec->err_irq);
-    }
-}
-
 static void write_dmactrl(eTSEC          *etsec,
                           eTSEC_Register *reg,
                           uint32_t        reg_index,
@@ -178,9 +175,7 @@ static void write_dmactrl(eTSEC          *etsec,
         } else {
             /* Graceful receive stop now */
             etsec->regs[IEVENT].value |= IEVENT_GRSC;
-            if (etsec->regs[IMASK].value & IMASK_GRSCEN) {
-                qemu_irq_raise(etsec->err_irq);
-            }
+            etsec_update_irq(etsec);
         }
     }
 
@@ -191,9 +186,7 @@ static void write_dmactrl(eTSEC          *etsec,
         } else {
             /* Graceful transmit stop now */
             etsec->regs[IEVENT].value |= IEVENT_GTSC;
-            if (etsec->regs[IMASK].value & IMASK_GTSCEN) {
-                qemu_irq_raise(etsec->err_irq);
-            }
+            etsec_update_irq(etsec);
         }
     }
 
@@ -222,7 +215,16 @@ static void etsec_write(void     *opaque,
 
     switch (reg_index) {
     case IEVENT:
-        write_ievent(etsec, reg, reg_index, value);
+        /* Write 1 to clear */
+        reg->value &= ~value;
+
+        etsec_update_irq(etsec);
+        break;
+
+    case IMASK:
+        reg->value = value;
+
+        etsec_update_irq(etsec);
         break;
 
     case DMACTRL:
@@ -337,6 +339,8 @@ static void etsec_reset(DeviceState *d)
         MII_SR_EXTENDED_STATUS  | MII_SR_100T2_HD_CAPS | MII_SR_100T2_FD_CAPS |
         MII_SR_10T_HD_CAPS      | MII_SR_10T_FD_CAPS   | MII_SR_100X_HD_CAPS  |
         MII_SR_100X_FD_CAPS     | MII_SR_100T4_CAPS;
+
+    etsec_update_irq(etsec);
 }
 
 static ssize_t etsec_receive(NetClientState *nc,
diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 30c828e241..877988572e 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -163,6 +163,8 @@ DeviceState *etsec_create(hwaddr        base,
                           qemu_irq      rx_irq,
                           qemu_irq      err_irq);
 
+void etsec_update_irq(eTSEC *etsec);
+
 void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr);
 void etsec_walk_rx_ring(eTSEC *etsec, int ring_nbr);
 ssize_t etsec_rx_ring_write(eTSEC *etsec, const uint8_t *buf, size_t size);
diff --git a/hw/net/fsl_etsec/registers.h b/hw/net/fsl_etsec/registers.h
index c4ed2b9d62..f085537ecd 100644
--- a/hw/net/fsl_etsec/registers.h
+++ b/hw/net/fsl_etsec/registers.h
@@ -74,6 +74,16 @@ extern const eTSEC_Register_Definition eTSEC_registers_def[];
 #define IEVENT_RXC   (1 << 30)
 #define IEVENT_BABR  (1 << 31)
 
+/* Mapping between interrupt pin and interrupt flags */
+#define IEVENT_RX_MASK (IEVENT_RXF | IEVENT_RXB)
+#define IEVENT_TX_MASK (IEVENT_TXF | IEVENT_TXB)
+#define IEVENT_ERR_MASK (IEVENT_MAG | IEVENT_GTSC | IEVENT_GRSC | IEVENT_TXC | \
+    IEVENT_RXC | IEVENT_BABR | IEVENT_BABT | IEVENT_LC | \
+    IEVENT_CRL | IEVENT_FGPI | IEVENT_FIR | IEVENT_FIQ | \
+    IEVENT_DPE | IEVENT_PERR | IEVENT_EBERR | IEVENT_TXE | \
+    IEVENT_XFUN | IEVENT_BSY | IEVENT_MSRO | IEVENT_MMRD | \
+    IEVENT_MMRW)
+
 #define IMASK_RXFEN  (1 <<  7)
 #define IMASK_GRSCEN (1 <<  8)
 #define IMASK_RXBEN  (1 << 15)
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index d0f93eebfc..337a55fc95 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -152,17 +152,7 @@ static void ievent_set(eTSEC    *etsec,
 {
     etsec->regs[IEVENT].value |= flags;
 
-    if ((flags & IEVENT_TXB && etsec->regs[IMASK].value & IMASK_TXBEN)
-        || (flags & IEVENT_TXF && etsec->regs[IMASK].value & IMASK_TXFEN)) {
-        qemu_irq_raise(etsec->tx_irq);
-        RING_DEBUG("%s Raise Tx IRQ\n", __func__);
-    }
-
-    if ((flags & IEVENT_RXB && etsec->regs[IMASK].value & IMASK_RXBEN)
-        || (flags & IEVENT_RXF && etsec->regs[IMASK].value & IMASK_RXFEN)) {
-        qemu_irq_raise(etsec->rx_irq);
-        RING_DEBUG("%s Raise Rx IRQ\n", __func__);
-    }
+    etsec_update_irq(etsec);
 }
 
 static void tx_padding_and_crc(eTSEC *etsec, uint32_t min_frame_len)
-- 
2.11.0
