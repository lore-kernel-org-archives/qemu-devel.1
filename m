Received: from eggs.gnu.org ([2001:4830:134:3::10]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0007Zl-Vl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd43-0000AI-EP
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd43-00009A-1n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd42-0005il-0y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:13 +0000
Message-Id: <1515677902-23436-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/26] imx_fec: Add support for multiple Tx DMA
 rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

More recent version of the IP block support more than one Tx DMA ring,
so add the code implementing that feature.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/imx_fec.h |  18 ++++++-
 hw/net/imx_fec.c         | 133 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 21 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index af0840a..91ef8f8 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -52,6 +52,8 @@
 #define ENET_TFWR              81
 #define ENET_FRBR              83
 #define ENET_FRSR              84
+#define ENET_TDSR1             89
+#define ENET_TDSR2             92
 #define ENET_RDSR              96
 #define ENET_TDSR              97
 #define ENET_MRBR              98
@@ -66,6 +68,8 @@
 #define ENET_FTRL              108
 #define ENET_TACC              112
 #define ENET_RACC              113
+#define ENET_TDAR1             121
+#define ENET_TDAR2             123
 #define ENET_MIIGSK_CFGR       192
 #define ENET_MIIGSK_ENR        194
 #define ENET_ATCR              256
@@ -105,13 +109,18 @@
 #define ENET_INT_WAKEUP        (1 << 17)
 #define ENET_INT_TS_AVAIL      (1 << 16)
 #define ENET_INT_TS_TIMER      (1 << 15)
+#define ENET_INT_TXF2          (1 <<  7)
+#define ENET_INT_TXB2          (1 <<  6)
+#define ENET_INT_TXF1          (1 <<  3)
+#define ENET_INT_TXB1          (1 <<  2)
 
 #define ENET_INT_MAC           (ENET_INT_HB | ENET_INT_BABR | ENET_INT_BABT | \
                                 ENET_INT_GRA | ENET_INT_TXF | ENET_INT_TXB | \
                                 ENET_INT_RXF | ENET_INT_RXB | ENET_INT_MII | \
                                 ENET_INT_EBERR | ENET_INT_LC | ENET_INT_RL | \
                                 ENET_INT_UN | ENET_INT_PLR | ENET_INT_WAKEUP | \
-                                ENET_INT_TS_AVAIL)
+                                ENET_INT_TS_AVAIL | ENET_INT_TXF1 | \
+                                ENET_INT_TXB1 | ENET_INT_TXF2 | ENET_INT_TXB2)
 
 /* RDAR */
 #define ENET_RDAR_RDAR         (1 << 24)
@@ -234,6 +243,9 @@ typedef struct {
 
 #define ENET_BD_BDU            (1 << 31)
 
+#define ENET_TX_RING_NUM       3
+
+
 typedef struct IMXFECState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -246,7 +258,9 @@ typedef struct IMXFECState {
 
     uint32_t regs[ENET_MAX];
     uint32_t rx_descriptor;
-    uint32_t tx_descriptor;
+
+    uint32_t tx_descriptor[ENET_TX_RING_NUM];
+    uint32_t tx_ring_num;
 
     uint32_t phy_status;
     uint32_t phy_control;
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 825c879..77d27f7 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -196,6 +196,31 @@ static const char *imx_eth_reg_name(IMXFECState *s, uint32_t index)
     }
 }
 
+/*
+ * Versions of this device with more than one TX descriptor save the
+ * 2nd and 3rd descriptors in a subsection, to maintain migration
+ * compatibility with previous versions of the device that only
+ * supported a single descriptor.
+ */
+static bool imx_eth_is_multi_tx_ring(void *opaque)
+{
+    IMXFECState *s = IMX_FEC(opaque);
+
+    return s->tx_ring_num > 1;
+}
+
+static const VMStateDescription vmstate_imx_eth_txdescs = {
+    .name = "imx.fec/txdescs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = imx_eth_is_multi_tx_ring,
+    .fields = (VMStateField[]) {
+         VMSTATE_UINT32(tx_descriptor[1], IMXFECState),
+         VMSTATE_UINT32(tx_descriptor[2], IMXFECState),
+         VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_imx_eth = {
     .name = TYPE_IMX_FEC,
     .version_id = 2,
@@ -203,15 +228,18 @@ static const VMStateDescription vmstate_imx_eth = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
         VMSTATE_UINT32(rx_descriptor, IMXFECState),
-        VMSTATE_UINT32(tx_descriptor, IMXFECState),
-
+        VMSTATE_UINT32(tx_descriptor[0], IMXFECState),
         VMSTATE_UINT32(phy_status, IMXFECState),
         VMSTATE_UINT32(phy_control, IMXFECState),
         VMSTATE_UINT32(phy_advertise, IMXFECState),
         VMSTATE_UINT32(phy_int, IMXFECState),
         VMSTATE_UINT32(phy_int_mask, IMXFECState),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_imx_eth_txdescs,
+        NULL
+    },
 };
 
 #define PHY_INT_ENERGYON            (1 << 7)
@@ -406,7 +434,7 @@ static void imx_fec_do_tx(IMXFECState *s)
 {
     int frame_size = 0, descnt = 0;
     uint8_t *ptr = s->frame;
-    uint32_t addr = s->tx_descriptor;
+    uint32_t addr = s->tx_descriptor[0];
 
     while (descnt++ < IMX_MAX_DESC) {
         IMXFECBufDesc bd;
@@ -447,16 +475,47 @@ static void imx_fec_do_tx(IMXFECState *s)
         }
     }
 
-    s->tx_descriptor = addr;
+    s->tx_descriptor[0] = addr;
 
     imx_eth_update(s);
 }
 
-static void imx_enet_do_tx(IMXFECState *s)
+static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
 {
     int frame_size = 0, descnt = 0;
+
     uint8_t *ptr = s->frame;
-    uint32_t addr = s->tx_descriptor;
+    uint32_t addr, int_txb, int_txf, tdsr;
+    size_t ring;
+
+    switch (index) {
+    case ENET_TDAR:
+        ring    = 0;
+        int_txb = ENET_INT_TXB;
+        int_txf = ENET_INT_TXF;
+        tdsr    = ENET_TDSR;
+        break;
+    case ENET_TDAR1:
+        ring    = 1;
+        int_txb = ENET_INT_TXB1;
+        int_txf = ENET_INT_TXF1;
+        tdsr    = ENET_TDSR1;
+        break;
+    case ENET_TDAR2:
+        ring    = 2;
+        int_txb = ENET_INT_TXB2;
+        int_txf = ENET_INT_TXF2;
+        tdsr    = ENET_TDSR2;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bogus value for index %x\n",
+                      __func__, index);
+        abort();
+        break;
+    }
+
+    addr = s->tx_descriptor[ring];
 
     while (descnt++ < IMX_MAX_DESC) {
         IMXENETBufDesc bd;
@@ -502,32 +561,32 @@ static void imx_enet_do_tx(IMXFECState *s)
 
             frame_size = 0;
             if (bd.option & ENET_BD_TX_INT) {
-                s->regs[ENET_EIR] |= ENET_INT_TXF;
+                s->regs[ENET_EIR] |= int_txf;
             }
         }
         if (bd.option & ENET_BD_TX_INT) {
-            s->regs[ENET_EIR] |= ENET_INT_TXB;
+            s->regs[ENET_EIR] |= int_txb;
         }
         bd.flags &= ~ENET_BD_R;
         /* Write back the modified descriptor.  */
         imx_enet_write_bd(&bd, addr);
         /* Advance to the next descriptor.  */
         if ((bd.flags & ENET_BD_W) != 0) {
-            addr = s->regs[ENET_TDSR];
+            addr = s->regs[tdsr];
         } else {
             addr += sizeof(bd);
         }
     }
 
-    s->tx_descriptor = addr;
+    s->tx_descriptor[ring] = addr;
 
     imx_eth_update(s);
 }
 
-static void imx_eth_do_tx(IMXFECState *s)
+static void imx_eth_do_tx(IMXFECState *s, uint32_t index)
 {
     if (!s->is_fec && (s->regs[ENET_ECR] & ENET_ECR_EN1588)) {
-        imx_enet_do_tx(s);
+        imx_enet_do_tx(s, index);
     } else {
         imx_fec_do_tx(s);
     }
@@ -585,7 +644,7 @@ static void imx_eth_reset(DeviceState *d)
     }
 
     s->rx_descriptor = 0;
-    s->tx_descriptor = 0;
+    memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
 
     /* We also reset the PHY */
     phy_reset(s);
@@ -791,6 +850,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     IMXFECState *s = IMX_FEC(opaque);
+    const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
     FEC_PRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
@@ -813,10 +873,18 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
             s->regs[index] = 0;
         }
         break;
-    case ENET_TDAR:
+    case ENET_TDAR1:    /* FALLTHROUGH */
+    case ENET_TDAR2:    /* FALLTHROUGH */
+        if (unlikely(single_tx_ring)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "[%s]%s: trying to access TDAR2 or TDAR1\n",
+                          TYPE_IMX_FEC, __func__);
+            return;
+        }
+    case ENET_TDAR:     /* FALLTHROUGH */
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             s->regs[index] = ENET_TDAR_TDAR;
-            imx_eth_do_tx(s);
+            imx_eth_do_tx(s, index);
         }
         s->regs[index] = 0;
         break;
@@ -828,8 +896,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
         if ((s->regs[index] & ENET_ECR_ETHEREN) == 0) {
             s->regs[ENET_RDAR] = 0;
             s->rx_descriptor = s->regs[ENET_RDSR];
-            s->regs[ENET_TDAR] = 0;
-            s->tx_descriptor = s->regs[ENET_TDSR];
+            s->regs[ENET_TDAR]  = 0;
+            s->regs[ENET_TDAR1] = 0;
+            s->regs[ENET_TDAR2] = 0;
+            s->tx_descriptor[0] = s->regs[ENET_TDSR];
+            s->tx_descriptor[1] = s->regs[ENET_TDSR1];
+            s->tx_descriptor[2] = s->regs[ENET_TDSR2];
         }
         break;
     case ENET_MMFR:
@@ -907,7 +979,29 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
         } else {
             s->regs[index] = value & ~7;
         }
-        s->tx_descriptor = s->regs[index];
+        s->tx_descriptor[0] = s->regs[index];
+        break;
+    case ENET_TDSR1:
+        if (unlikely(single_tx_ring)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "[%s]%s: trying to access TDSR1\n",
+                          TYPE_IMX_FEC, __func__);
+            return;
+        }
+
+        s->regs[index] = value & ~7;
+        s->tx_descriptor[1] = s->regs[index];
+        break;
+    case ENET_TDSR2:
+        if (unlikely(single_tx_ring)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "[%s]%s: trying to access TDSR2\n",
+                          TYPE_IMX_FEC, __func__);
+            return;
+        }
+
+        s->regs[index] = value & ~7;
+        s->tx_descriptor[2] = s->regs[index];
         break;
     case ENET_MRBR:
         s->regs[index] = value & 0x00003ff0;
@@ -1203,6 +1297,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
 static Property imx_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(IMXFECState, conf),
+    DEFINE_PROP_UINT32("tx-ring-num", IMXFECState, tx_ring_num, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
