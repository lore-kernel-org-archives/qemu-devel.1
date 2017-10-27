Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xdI-0005qM-JX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xdE-00086I-NX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:39 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:44271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e7xdE-00083M-8h
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:36 -0400
Received: by mail-lf0-x241.google.com with SMTP id 75so6150717lfx.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 22:56:34 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Fri, 27 Oct 2017 07:56:11 +0200
Message-Id: <20171027055612.2488-13-frasse.iglesias@gmail.com>
In-Reply-To: <20171027055612.2488-1-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v4 12/13] xilinx_spips: Add support for the
 ZynqMP Generic QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

From: Francisco Iglesias <francisco.iglesias@feimtech.se>

Add support for the Zynq Ultrascale MPSoc Generic QSPI.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 default-configs/arm-softmmu.mak |   1 +
 hw/ssi/xilinx_spips.c           | 449 +++++++++++++++++++++++++++++++++++-----
 include/hw/ssi/xilinx_spips.h   |  29 ++-
 3 files changed, 429 insertions(+), 50 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5059d13..d09fd34 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -130,3 +130,4 @@ CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
+CONFIG_XILINX_AXI=y
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 159a89d..f8d2018 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -31,6 +31,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
 #include "hw/register.h"
+#include "sysemu/dma.h"
 #include "migration/blocker.h"
 
 #ifndef XILINX_SPIPS_ERR_DEBUG
@@ -69,13 +70,30 @@
 #define R_INTR_DIS          (0x0C / 4)
 #define R_INTR_MASK         (0x10 / 4)
 #define IXR_TX_FIFO_UNDERFLOW   (1 << 6)
+/* Poll timeout not implemented */
+#define IXR_RX_FIFO_EMPTY       (1 << 11)
+#define IXR_GENERIC_FIFO_FULL   (1 << 10)
+#define IXR_GENERIC_FIFO_NOT_FULL (1 << 9)
+#define IXR_TX_FIFO_EMPTY       (1 << 8)
+#define IXR_GENERIC_FIFO_EMPTY  (1 << 7)
 #define IXR_RX_FIFO_FULL        (1 << 5)
 #define IXR_RX_FIFO_NOT_EMPTY   (1 << 4)
 #define IXR_TX_FIFO_FULL        (1 << 3)
 #define IXR_TX_FIFO_NOT_FULL    (1 << 2)
 #define IXR_TX_FIFO_MODE_FAIL   (1 << 1)
 #define IXR_RX_FIFO_OVERFLOW    (1 << 0)
-#define IXR_ALL                 ((IXR_TX_FIFO_UNDERFLOW<<1)-1)
+#define IXR_ALL                 ((1 << 13) - 1)
+#define GQSPI_IXR_MASK          0xFBE
+#define IXR_SELF_CLEAR \
+(IXR_GENERIC_FIFO_EMPTY \
+| IXR_GENERIC_FIFO_FULL  \
+| IXR_GENERIC_FIFO_NOT_FULL \
+| IXR_TX_FIFO_EMPTY \
+| IXR_TX_FIFO_FULL  \
+| IXR_TX_FIFO_NOT_FULL \
+| IXR_RX_FIFO_EMPTY \
+| IXR_RX_FIFO_FULL  \
+| IXR_RX_FIFO_NOT_EMPTY)
 
 #define R_EN                (0x14 / 4)
 #define R_DELAY             (0x18 / 4)
@@ -116,9 +134,54 @@
 
 #define R_MOD_ID            (0xFC / 4)
 
+#define R_GQSPI_SELECT          (0x144 / 4)
+    FIELD(GQSPI_SELECT, GENERIC_QSPI_EN, 0, 1)
+#define R_GQSPI_ISR         (0x104 / 4)
+#define R_GQSPI_IER         (0x108 / 4)
+#define R_GQSPI_IDR         (0x10c / 4)
+#define R_GQSPI_IMR         (0x110 / 4)
+#define R_GQSPI_TX_THRESH   (0x128 / 4)
+#define R_GQSPI_RX_THRESH   (0x12c / 4)
+#define R_GQSPI_CNFG        (0x100 / 4)
+    FIELD(GQSPI_CNFG, MODE_EN, 30, 2)
+    FIELD(GQSPI_CNFG, GEN_FIFO_START_MODE, 29, 1)
+    FIELD(GQSPI_CNFG, GEN_FIFO_START, 28, 1)
+    FIELD(GQSPI_CNFG, ENDIAN, 26, 1)
+    /* Poll timeout not implemented */
+    FIELD(GQSPI_CNFG, EN_POLL_TIMEOUT, 20, 1)
+    /* QEMU doesnt care about any of these last three */
+    FIELD(GQSPI_CNFG, BR, 3, 3)
+    FIELD(GQSPI_CNFG, CPH, 2, 1)
+    FIELD(GQSPI_CNFG, CPL, 1, 1)
+#define R_GQSPI_GEN_FIFO        (0x140 / 4)
+#define R_GQSPI_TXD             (0x11c / 4)
+#define R_GQSPI_RXD             (0x120 / 4)
+#define R_GQSPI_FIFO_CTRL       (0x14c / 4)
+    FIELD(GQSPI_FIFO_CTRL, RX_FIFO_RESET, 2, 1)
+    FIELD(GQSPI_FIFO_CTRL, TX_FIFO_RESET, 1, 1)
+    FIELD(GQSPI_FIFO_CTRL, GENERIC_FIFO_RESET, 0, 1)
+#define R_GQSPI_GFIFO_THRESH    (0x150 / 4)
+#define R_GQSPI_DATA_STS (0x15c / 4)
+/* We use the snapshot register to hold the core state for the currently
+ * or most recently executed command. So the generic fifo format is defined
+ * for the snapshot register
+ */
+#define R_GQSPI_GF_SNAPSHOT (0x160 / 4)
+    FIELD(GQSPI_GF_SNAPSHOT, POLL, 19, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, STRIPE, 18, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, RECIEVE, 17, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, TRANSMIT, 16, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, DATA_BUS_SELECT, 14, 2)
+    FIELD(GQSPI_GF_SNAPSHOT, CHIP_SELECT, 12, 2)
+    FIELD(GQSPI_GF_SNAPSHOT, SPI_MODE, 10, 2)
+    FIELD(GQSPI_GF_SNAPSHOT, EXPONENT, 9, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, DATA_XFER, 8, 1)
+    FIELD(GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA, 0, 8)
+#define R_GQSPI_MOD_ID        (0x168 / 4)
+#define R_GQSPI_MOD_ID_VALUE  0x010A0000
 /* size of TXRX FIFOs */
-#define RXFF_A          32
-#define TXFF_A          32
+#define RXFF_A          (128)
+#define TXFF_A          (128)
 
 #define RXFF_A_Q          (64 * 4)
 #define TXFF_A_Q          (64 * 4)
@@ -137,42 +200,54 @@ static inline int num_effective_busses(XilinxSPIPS *s)
             s->regs[R_LQSPI_CFG] & LQSPI_CFG_TWO_MEM) ? s->num_busses : 1;
 }
 
-static inline bool xilinx_spips_cs_is_set(XilinxSPIPS *s, int i, int field)
+static void xilinx_spips_update_cs_lines_legacy(XilinxSPIPS *s, int *field)
 {
-    return ~field & (1 << i) && (s->regs[R_CONFIG] & MANUAL_CS
-                    || !fifo8_is_empty(&s->tx_fifo));
+    *field = ~((s->regs[R_CONFIG] & CS) >> CS_SHIFT);
+    /* In dual parallel, mirror low CS to both */
+    if (num_effective_busses(s) == 2) {
+        /* Single bit chip-select for qspi */
+        *field &= 0x1;
+        *field |= *field << 1;
+    /* Dual stack U-Page */
+    } else if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_TWO_MEM &&
+               s->regs[R_LQSPI_STS] & LQSPI_CFG_U_PAGE) {
+        /* Single bit chip-select for qspi */
+        *field &= 0x1;
+        /* change from CS0 to CS1 */
+        *field <<= 1;
+    }
+    /* Auto CS */
+    if (!(s->regs[R_CONFIG] & MANUAL_CS) &&
+        fifo8_is_empty(&s->tx_fifo)) {
+        *field = 0;
+    }
 }
 
 static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
 {
-    int i, j;
-    bool found = false;
-    int field = s->regs[R_CONFIG] >> CS_SHIFT;
+    int i;
+    int field = 0;
 
+    if (!ARRAY_FIELD_EX32(s->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
+        xilinx_spips_update_cs_lines_legacy(s, &field);
+    } else if (s->regs[R_GQSPI_GF_SNAPSHOT]) {
+        field = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, CHIP_SELECT);
+    } else {
+        /* Do nothing */
+        return;
+    }
     for (i = 0; i < s->num_cs; i++) {
-        for (j = 0; j < num_effective_busses(s); j++) {
-            int upage = !!(s->regs[R_LQSPI_STS] & LQSPI_CFG_U_PAGE);
-            int cs_to_set = (j * s->num_cs + i + upage) %
-                                (s->num_cs * s->num_busses);
-
-            if (xilinx_spips_cs_is_set(s, i, field) && !found) {
-                DB_PRINT_L(0, "selecting slave %d\n", i);
-                qemu_set_irq(s->cs_lines[cs_to_set], 0);
-                if (s->cs_lines_state[cs_to_set]) {
-                    s->cs_lines_state[cs_to_set] = false;
-                    s->rx_discard = ARRAY_FIELD_EX32(s->regs, CMND, RX_DISCARD);
-                }
-            } else {
-                DB_PRINT_L(0, "deselecting slave %d\n", i);
-                qemu_set_irq(s->cs_lines[cs_to_set], 1);
-                s->cs_lines_state[cs_to_set] = true;
-            }
-        }
-        if (xilinx_spips_cs_is_set(s, i, field)) {
-            found = true;
+        bool old_state = s->cs_lines_state[i];
+        bool new_state = field & (1 << i);
+
+        if (old_state != new_state) {
+            s->cs_lines_state[i] = new_state;
+            s->rx_discard = ARRAY_FIELD_EX32(s->regs, CMND, RX_DISCARD);
+            DB_PRINT_L(0, "%sselecting slave %d\n", new_state ? "" : "de", i);
         }
+        qemu_set_irq(s->cs_lines[i], !new_state);
     }
-    if (!found) {
+    if (!(field & ((1 << s->num_cs) - 1))) {
         s->snoop_state = SNOOP_CHECKING;
         s->cmd_dummies = 0;
         s->link_state = 1;
@@ -184,22 +259,46 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
 
 static void xilinx_spips_update_ixr(XilinxSPIPS *s)
 {
-    if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE) {
-        return;
+    int new_irqline;
+    uint32_t qspi_int;
+    uint32_t gqspi_int;
+
+    s->regs[R_GQSPI_ISR] &= ~IXR_SELF_CLEAR;
+    s->regs[R_GQSPI_ISR] |=
+        (fifo32_is_empty(&s->fifo_g) ? IXR_GENERIC_FIFO_EMPTY : 0) |
+        (fifo32_is_full(&s->fifo_g) ? IXR_GENERIC_FIFO_FULL : 0) |
+        (s->fifo_g.fifo.num < s->regs[R_GQSPI_GFIFO_THRESH] ?
+                                    IXR_GENERIC_FIFO_NOT_FULL : 0) |
+        (fifo8_is_empty(&s->rx_fifo_g) ? IXR_RX_FIFO_EMPTY : 0) |
+        (fifo8_is_full(&s->rx_fifo_g) ? IXR_RX_FIFO_FULL : 0) |
+        (s->rx_fifo_g.num >= s->regs[R_GQSPI_RX_THRESH] ?
+                                    IXR_RX_FIFO_NOT_EMPTY : 0) |
+        (fifo8_is_empty(&s->tx_fifo_g) ? IXR_TX_FIFO_EMPTY : 0) |
+        (fifo8_is_full(&s->tx_fifo_g) ? IXR_TX_FIFO_FULL : 0) |
+        (s->tx_fifo_g.num < s->regs[R_GQSPI_TX_THRESH] ?
+                                    IXR_TX_FIFO_NOT_FULL : 0);
+
+    if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
+        s->regs[R_INTR_STATUS] &= ~IXR_SELF_CLEAR;
+        s->regs[R_INTR_STATUS] |=
+            (fifo8_is_full(&s->rx_fifo) ? IXR_RX_FIFO_FULL : 0) |
+            (s->rx_fifo.num >= s->regs[R_RX_THRES] ?
+                                    IXR_RX_FIFO_NOT_EMPTY : 0) |
+            (fifo8_is_full(&s->tx_fifo) ? IXR_TX_FIFO_FULL : 0) |
+            (s->tx_fifo.num < s->regs[R_TX_THRES] ? IXR_TX_FIFO_NOT_FULL : 0);
+        if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {
+            s->regs[R_INTR_STATUS] |= fifo8_is_empty(&s->tx_fifo) ?
+                                     IXR_TX_FIFO_EMPTY : 0;
+        }
     }
-    /* These are set/cleared as they occur */
-    s->regs[R_INTR_STATUS] &= (IXR_TX_FIFO_UNDERFLOW | IXR_RX_FIFO_OVERFLOW |
-                                IXR_TX_FIFO_MODE_FAIL);
-    /* these are pure functions of fifo state, set them here */
-    s->regs[R_INTR_STATUS] |=
-        (fifo8_is_full(&s->rx_fifo) ? IXR_RX_FIFO_FULL : 0) |
-        (s->rx_fifo.num >= s->regs[R_RX_THRES] ? IXR_RX_FIFO_NOT_EMPTY : 0) |
-        (fifo8_is_full(&s->tx_fifo) ? IXR_TX_FIFO_FULL : 0) |
-        (s->tx_fifo.num < s->regs[R_TX_THRES] ? IXR_TX_FIFO_NOT_FULL : 0);
+    /* QSPI/SPI Interrupt Trigger Status */
+    qspi_int = s->regs[R_INTR_MASK] & s->regs[R_INTR_STATUS];
+    /* GQSPI Interrupt Trigger Status */
+    gqspi_int = (~s->regs[R_GQSPI_IMR]) & s->regs[R_GQSPI_ISR] & GQSPI_IXR_MASK;
     /* drive external interrupt pin */
-    int new_irqline = !!(s->regs[R_INTR_MASK] & s->regs[R_INTR_STATUS] &
-                                                                IXR_ALL);
+    new_irqline = !!((qspi_int | gqspi_int) & IXR_ALL);
     if (new_irqline != s->irqline) {
+        DB_PRINT_L(0, "IRQ state: %x -> %x\n", s->irqline, new_irqline);
         s->irqline = new_irqline;
         qemu_set_irq(s->irq, s->irqline);
     }
@@ -216,11 +315,18 @@ static void xilinx_spips_reset(DeviceState *d)
 
     fifo8_reset(&s->rx_fifo);
     fifo8_reset(&s->rx_fifo);
+    fifo8_reset(&s->rx_fifo_g);
+    fifo8_reset(&s->rx_fifo_g);
+    fifo32_reset(&s->fifo_g);
     /* non zero resets */
     s->regs[R_CONFIG] |= MODEFAIL_GEN_EN;
     s->regs[R_SLAVE_IDLE_COUNT] = 0xFF;
     s->regs[R_TX_THRES] = 1;
     s->regs[R_RX_THRES] = 1;
+    s->regs[R_GQSPI_TX_THRESH] = 1;
+    s->regs[R_GQSPI_RX_THRESH] = 1;
+    s->regs[R_GQSPI_GFIFO_THRESH] = 1;
+    s->regs[R_GQSPI_IMR] = GQSPI_IXR_MASK;
     /* FIXME: move magic number definition somewhere sensible */
     s->regs[R_MOD_ID] = 0x01090106;
     s->regs[R_LQSPI_CFG] = R_LQSPI_CFG_RESET;
@@ -230,6 +336,7 @@ static void xilinx_spips_reset(DeviceState *d)
     s->snoop_state = SNOOP_CHECKING;
     s->cmd_dummies = 0;
     s->man_start_com = false;
+    s->man_start_com_g = false;
     xilinx_spips_update_ixr(s);
     xilinx_spips_update_cs_lines(s);
 }
@@ -264,6 +371,108 @@ static inline void stripe8(uint8_t *x, int num, bool dir)
     memcpy(x, r, sizeof(uint8_t) * num);
 }
 
+static void xilinx_spips_flush_fifo_g(XilinxSPIPS *s)
+{
+    while (s->regs[R_GQSPI_DATA_STS] || !fifo32_is_empty(&s->fifo_g)) {
+        uint8_t tx_rx[2] = { 0 };
+        int num_stripes = 1;
+        uint8_t busses;
+        int i;
+
+        if (!s->regs[R_GQSPI_DATA_STS]) {
+            uint8_t imm;
+
+            s->regs[R_GQSPI_GF_SNAPSHOT] = fifo32_pop(&s->fifo_g);
+            DB_PRINT_L(0, "GQSPI command: %x\n", s->regs[R_GQSPI_GF_SNAPSHOT]);
+            if (!s->regs[R_GQSPI_GF_SNAPSHOT]) {
+                DB_PRINT_L(0, "Dummy GQSPI Delay Command Entry, Do nothing");
+                continue;
+            }
+            xilinx_spips_update_cs_lines(s);
+
+            imm = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA);
+            if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_XFER)) {
+                /* immedate transfer */
+                if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) ||
+                    ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
+                    s->regs[R_GQSPI_DATA_STS] = 1;
+                /* CS setup/hold - do nothing */
+                } else {
+                    s->regs[R_GQSPI_DATA_STS] = 0;
+                }
+            } else if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, EXPONENT)) {
+                if (imm > 31) {
+                    qemu_log_mask(LOG_UNIMP, "QSPI exponential transfer too"
+                                  " long - 2 ^ %" PRId8 " requested\n", imm);
+                }
+                s->regs[R_GQSPI_DATA_STS] = 1ul << imm;
+            } else {
+                s->regs[R_GQSPI_DATA_STS] = imm;
+            }
+        }
+        /* Zero length transfer check */
+        if (!s->regs[R_GQSPI_DATA_STS]) {
+            continue;
+        }
+        if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE) &&
+            fifo8_is_full(&s->rx_fifo_g)) {
+            /* No space in RX fifo for transfer - try again later */
+            return;
+        }
+        if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, STRIPE) &&
+            (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) ||
+             ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE))) {
+            num_stripes = 2;
+        }
+        if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_XFER)) {
+            tx_rx[0] = ARRAY_FIELD_EX32(s->regs,
+                                        GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA);
+        } else if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT)) {
+            for (i = 0; i < num_stripes; ++i) {
+                if (!fifo8_is_empty(&s->tx_fifo_g)) {
+                    tx_rx[i] = fifo8_pop(&s->tx_fifo_g);
+                    s->tx_fifo_g_align++;
+                } else {
+                    return;
+                }
+            }
+        }
+        if (num_stripes == 1) {
+            /* mirror */
+            tx_rx[1] = tx_rx[0];
+        }
+        busses = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_BUS_SELECT);
+        for (i = 0; i < 2; ++i) {
+            DB_PRINT_L(1, "bus %d tx = %02x\n", i, tx_rx[i]);
+            tx_rx[i] = ssi_transfer(s->spi[i], tx_rx[i]);
+            DB_PRINT_L(1, "bus %d rx = %02x\n", i, tx_rx[i]);
+        }
+        if (s->regs[R_GQSPI_DATA_STS] > 1 &&
+            busses == 0x3 && num_stripes == 2) {
+            s->regs[R_GQSPI_DATA_STS] -= 2;
+        } else if (s->regs[R_GQSPI_DATA_STS] > 0) {
+            s->regs[R_GQSPI_DATA_STS]--;
+        }
+        if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
+            for (i = 0; i < 2; ++i) {
+                if (busses & (1 << i)) {
+                    DB_PRINT_L(1, "bus %d push_byte = %02x\n", i, tx_rx[i]);
+                    fifo8_push(&s->rx_fifo_g, tx_rx[i]);
+                    s->rx_fifo_g_align++;
+                }
+            }
+        }
+        if (!s->regs[R_GQSPI_DATA_STS]) {
+            for (; s->tx_fifo_g_align % 4; s->tx_fifo_g_align++) {
+                fifo8_pop(&s->tx_fifo_g);
+            }
+            for (; s->rx_fifo_g_align % 4; s->rx_fifo_g_align++) {
+                fifo8_push(&s->rx_fifo_g, 0);
+            }
+        }
+    }
+}
+
 static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
 {
     if (!qs) {
@@ -487,15 +696,27 @@ static void xilinx_spips_check_zero_pump(XilinxSPIPS *s)
 
 static void xilinx_spips_check_flush(XilinxSPIPS *s)
 {
-    if (s->man_start_com ||
-        (!fifo8_is_empty(&s->tx_fifo) &&
-         !(s->regs[R_CONFIG] & MAN_START_EN))) {
-        xilinx_spips_check_zero_pump(s);
-        xilinx_spips_flush_txfifo(s);
+    bool gqspi_has_work = s->regs[R_GQSPI_DATA_STS] ||
+                          !fifo32_is_empty(&s->fifo_g);
+
+    if (ARRAY_FIELD_EX32(s->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
+        if (s->man_start_com_g || (gqspi_has_work &&
+             !ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, GEN_FIFO_START_MODE))) {
+            xilinx_spips_flush_fifo_g(s);
+        }
+    } else {
+        if (s->man_start_com || (!fifo8_is_empty(&s->tx_fifo) &&
+             !(s->regs[R_CONFIG] & MAN_START_EN))) {
+            xilinx_spips_check_zero_pump(s);
+            xilinx_spips_flush_txfifo(s);
+        }
     }
     if (fifo8_is_empty(&s->tx_fifo) && !s->regs[R_TRANSFER_SIZE]) {
         s->man_start_com = false;
     }
+    if (!gqspi_has_work) {
+        s->man_start_com_g = false;
+    }
     xilinx_spips_update_ixr(s);
 }
 
@@ -509,6 +730,53 @@ static inline int rx_data_bytes(Fifo8 *fifo, uint8_t *value, int max)
     return max - i;
 }
 
+static const void *pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num)
+{
+    void *ret;
+
+    if (max == 0 || max > fifo->num) {
+        abort();
+    }
+    *num = MIN(fifo->capacity - fifo->head, max);
+    ret = &fifo->data[fifo->head];
+    fifo->head += *num;
+    fifo->head %= fifo->capacity;
+    fifo->num -= *num;
+    return ret;
+}
+
+static void xlnx_zynqmp_qspips_notify(void *opaque)
+{
+    XlnxZynqMPQSPIPS *rq = XLNX_ZYNQMP_QSPIPS(opaque);
+    XilinxSPIPS *s = XILINX_SPIPS(rq);
+    Fifo8 *recv_fifo;
+
+    if (ARRAY_FIELD_EX32(s->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
+        if (!(ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, MODE_EN) == 2)) {
+            return;
+        }
+        recv_fifo = &s->rx_fifo_g;
+    } else {
+        if (!(s->regs[R_CMND] & R_CMND_DMA_EN)) {
+            return;
+        }
+        recv_fifo = &s->rx_fifo;
+    }
+    while (recv_fifo->num >= 4
+           && stream_can_push(rq->dma, xlnx_zynqmp_qspips_notify, rq))
+    {
+        size_t ret;
+        uint32_t num;
+        const void *rxd = pop_buf(recv_fifo, 4, &num);
+
+        memcpy(rq->dma_buf, rxd, num);
+
+        ret = stream_push(rq->dma, rq->dma_buf, 4);
+        assert(ret == 4);
+        xilinx_spips_check_flush(s);
+    }
+}
+
 static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
                                                         unsigned size)
 {
@@ -556,6 +824,23 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
             ret <<= 8 * shortfall;
         }
         DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
+        xilinx_spips_check_flush(s);
+        xilinx_spips_update_ixr(s);
+        return ret;
+    case R_GQSPI_RXD:
+        if (fifo8_is_empty(&s->rx_fifo_g)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Read from empty GQSPI RX FIFO\n");
+            return 0;
+        }
+        memset(rx_buf, 0, sizeof(rx_buf));
+        shortfall = rx_data_bytes(&s->rx_fifo_g, rx_buf, s->num_txrx_bytes);
+        ret = ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, ENDIAN) ?
+              cpu_to_be32(*(uint32_t *)rx_buf) :
+              cpu_to_le32(*(uint32_t *)rx_buf);
+        if (!ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, ENDIAN)) {
+            ret <<= 8 * shortfall;
+        }
+        xilinx_spips_check_flush(s);
         xilinx_spips_update_ixr(s);
         return ret;
     }
@@ -619,6 +904,49 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
         tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
                       s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
+    case R_GQSPI_CNFG:
+        mask = ~(R_GQSPI_CNFG_GEN_FIFO_START_MASK);
+        if (FIELD_EX32(value, GQSPI_CNFG, GEN_FIFO_START) &&
+            ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, GEN_FIFO_START_MODE)) {
+            s->man_start_com_g = true;
+        }
+        break;
+    case R_GQSPI_GEN_FIFO:
+        if (!fifo32_is_full(&s->fifo_g)) {
+            fifo32_push(&s->fifo_g, value);
+        }
+        goto no_reg_update;
+    case R_GQSPI_TXD:
+        tx_data_bytes(&s->tx_fifo_g, (uint32_t)value, 4,
+                      ARRAY_FIELD_EX32(s->regs, GQSPI_CNFG, ENDIAN));
+        goto no_reg_update;
+    case R_GQSPI_FIFO_CTRL:
+        mask = 0;
+        if (FIELD_EX32(value, GQSPI_FIFO_CTRL, GENERIC_FIFO_RESET)) {
+            fifo32_reset(&s->fifo_g);
+        }
+        if (FIELD_EX32(value, GQSPI_FIFO_CTRL, TX_FIFO_RESET)) {
+            fifo8_reset(&s->tx_fifo_g);
+        }
+        if (FIELD_EX32(value, GQSPI_FIFO_CTRL, RX_FIFO_RESET)) {
+            fifo8_reset(&s->rx_fifo_g);
+        }
+        break;
+    case R_GQSPI_IDR:
+        s->regs[R_GQSPI_IMR] |= value;
+        goto no_reg_update;
+    case R_GQSPI_IER:
+        s->regs[R_GQSPI_IMR] &= ~value;
+        goto no_reg_update;
+    case R_GQSPI_ISR:
+        s->regs[R_GQSPI_ISR] &= ~value;
+        goto no_reg_update;
+    case R_GQSPI_IMR:
+    case R_GQSPI_RXD:
+    case R_GQSPI_GF_SNAPSHOT:
+    case R_GQSPI_MOD_ID:
+        mask = 0;
+        break;
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
@@ -662,6 +990,9 @@ static void xilinx_qspips_write(void *opaque, hwaddr addr,
     if (s->regs[R_CMND] & R_CMND_RXFIFO_DRAIN) {
         fifo8_reset(&s->rx_fifo);
     }
+    if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {
+        xlnx_zynqmp_qspips_notify(s);
+    }
 }
 
 static const MemoryRegionOps qspips_ops = {
@@ -825,6 +1156,9 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
 
     fifo8_create(&s->rx_fifo, xsc->rx_fifo_size);
     fifo8_create(&s->tx_fifo, xsc->tx_fifo_size);
+    fifo8_create(&s->rx_fifo_g, xsc->rx_fifo_size);
+    fifo8_create(&s->tx_fifo_g, xsc->tx_fifo_size);
+    fifo32_create(&s->fifo_g, 32);
 }
 
 static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
@@ -856,6 +1190,17 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void xlnx_zynqmp_qspips_init(Object *obj)
+{
+    XlnxZynqMPQSPIPS *rq = XLNX_ZYNQMP_QSPIPS(obj);
+
+    object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SLAVE,
+                             (Object **)&rq->dma,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             NULL);
+}
+
 static int xilinx_spips_post_load(void *opaque, int version_id)
 {
     xilinx_spips_update_ixr((XilinxSPIPS *)opaque);
@@ -936,10 +1281,18 @@ static const TypeInfo xilinx_qspips_info = {
     .class_init = xilinx_qspips_class_init,
 };
 
+static const TypeInfo xlnx_zynqmp_qspips_info = {
+    .name  = TYPE_XLNX_ZYNQMP_QSPIPS,
+    .parent = TYPE_XILINX_QSPIPS,
+    .instance_size  = sizeof(XlnxZynqMPQSPIPS),
+    .instance_init = xlnx_zynqmp_qspips_init,
+};
+
 static void xilinx_spips_register_types(void)
 {
     type_register_static(&xilinx_spips_info);
     type_register_static(&xilinx_qspips_info);
+    type_register_static(&xlnx_zynqmp_qspips_info);
 }
 
 type_init(xilinx_spips_register_types)
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index ad2175a..35f6a6f 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -26,11 +26,12 @@
 #define XILINX_SPIPS_H
 
 #include "hw/ssi/ssi.h"
-#include "qemu/fifo8.h"
+#include "qemu/fifo32.h"
+#include "hw/stream.h"
 
 typedef struct XilinxSPIPS XilinxSPIPS;
 
-#define XLNX_SPIPS_R_MAX        (0x100 / 4)
+#define XLNX_SPIPS_R_MAX        0x200
 
 /* Bite off 4k chunks at a time */
 #define LQSPI_CACHE_SIZE 1024
@@ -71,6 +72,18 @@ struct XilinxSPIPS {
 
     Fifo8 rx_fifo;
     Fifo8 tx_fifo;
+    /* GQSPI has seperate tx/rx fifos */
+    Fifo8 rx_fifo_g;
+    Fifo8 tx_fifo_g;
+    Fifo32 fifo_g;
+    /*
+     * at the end of each generic command, misaligned extra bytes are discard
+     * or padded to tx and rx respectively to round it out (and avoid need for
+     * individual byte access. Since we use byte fifos, keep track of the
+     * alignment WRT to word access.
+     */
+    uint8_t rx_fifo_g_align;
+    uint8_t tx_fifo_g_align;
 
     uint8_t num_txrx_bytes;
     uint32_t rx_discard;
@@ -78,6 +91,7 @@ struct XilinxSPIPS {
     uint32_t regs[XLNX_SPIPS_R_MAX];
 
     bool man_start_com;
+    bool man_start_com_g;
 };
 
 typedef struct {
@@ -89,6 +103,13 @@ typedef struct {
     bool mmio_execution_enabled;
 } XilinxQSPIPS;
 
+typedef struct {
+    XilinxQSPIPS parent_obj;
+
+    StreamSlave *dma;
+    uint8_t dma_buf[4];
+} XlnxZynqMPQSPIPS;
+
 typedef struct XilinxSPIPSClass {
     SysBusDeviceClass parent_class;
 
@@ -100,6 +121,7 @@ typedef struct XilinxSPIPSClass {
 
 #define TYPE_XILINX_SPIPS "xlnx.ps7-spi"
 #define TYPE_XILINX_QSPIPS "xlnx.ps7-qspi"
+#define TYPE_XLNX_ZYNQMP_QSPIPS "xlnx.usmp-gqspi"
 
 #define XILINX_SPIPS(obj) \
      OBJECT_CHECK(XilinxSPIPS, (obj), TYPE_XILINX_SPIPS)
@@ -111,4 +133,7 @@ typedef struct XilinxSPIPSClass {
 #define XILINX_QSPIPS(obj) \
      OBJECT_CHECK(XilinxQSPIPS, (obj), TYPE_XILINX_QSPIPS)
 
+#define XLNX_ZYNQMP_QSPIPS(obj) \
+     OBJECT_CHECK(XlnxZynqMPQSPIPS, (obj), TYPE_XLNX_ZYNQMP_QSPIPS)
+
 #endif /* XILINX_SPIPS_H */
-- 
2.9.3
