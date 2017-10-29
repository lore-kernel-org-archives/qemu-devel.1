Received: from eggs.gnu.org ([2001:4830:134:3::10]:46061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbS-0006aQ-8i
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbP-0007sa-EK
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:02 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:48803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e8kbP-0007sC-2I
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:13:59 -0400
Received: by mail-lf0-x244.google.com with SMTP id a69so11661275lfe.5
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 03:13:59 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sun, 29 Oct 2017 11:13:37 +0100
Message-Id: <20171029101343.15544-8-frasse.iglesias@gmail.com>
In-Reply-To: <20171029101343.15544-1-frasse.iglesias@gmail.com>
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v5 07/13] xilinx_spips: Add support for RX
 discard and RX drain
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

Add support for the RX discard and RX drain functionality. Also transmit
one byte per dummy cycle (to the flash memories) with commands that require
these.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c         | 167 +++++++++++++++++++++++++++++++++++++-----
 include/hw/ssi/xilinx_spips.h |   6 ++
 2 files changed, 155 insertions(+), 18 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 7accf5d..8634810 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -30,6 +30,7 @@
 #include "qemu/bitops.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
+#include "hw/register.h"
 #include "migration/blocker.h"
 
 #ifndef XILINX_SPIPS_ERR_DEBUG
@@ -100,6 +101,14 @@
 #define LQSPI_CFG_DUMMY_SHIFT   8
 #define LQSPI_CFG_INST_CODE     0xFF
 
+#define R_CMND        (0xc0 / 4)
+    #define R_CMND_RXFIFO_DRAIN   (1 << 19)
+    FIELD(CMND, PARTIAL_BYTE_LEN, 16, 3)
+#define R_CMND_EXT_ADD        (1 << 15)
+    FIELD(CMND, RX_DISCARD, 8, 7)
+    FIELD(CMND, DUMMY_CYCLES, 2, 6)
+#define R_CMND_DMA_EN         (1 << 1)
+#define R_CMND_PUSH_WAIT      (1 << 0)
 #define R_LQSPI_STS         (0xA4 / 4)
 #define LQSPI_STS_WR_RECVD      (1 << 1)
 
@@ -116,7 +125,8 @@
 #define LQSPI_ADDRESS_BITS 24
 
 #define SNOOP_CHECKING 0xFF
-#define SNOOP_NONE 0xFE
+#define SNOOP_ADDR 0xF0
+#define SNOOP_NONE 0xEE
 #define SNOOP_STRIPING 0
 
 static inline int num_effective_busses(XilinxSPIPS *s)
@@ -146,9 +156,14 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
             if (xilinx_spips_cs_is_set(s, i, field) && !found) {
                 DB_PRINT_L(0, "selecting slave %d\n", i);
                 qemu_set_irq(s->cs_lines[cs_to_set], 0);
+                if (s->cs_lines_state[cs_to_set]) {
+                    s->cs_lines_state[cs_to_set] = false;
+                    s->rx_discard = ARRAY_FIELD_EX32(s->regs, CMND, RX_DISCARD);
+                }
             } else {
                 DB_PRINT_L(0, "deselecting slave %d\n", i);
                 qemu_set_irq(s->cs_lines[cs_to_set], 1);
+                s->cs_lines_state[cs_to_set] = true;
             }
         }
         if (xilinx_spips_cs_is_set(s, i, field)) {
@@ -157,6 +172,10 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
     }
     if (!found) {
         s->snoop_state = SNOOP_CHECKING;
+        s->cmd_dummies = 0;
+        s->link_state = 1;
+        s->link_state_next = 1;
+        s->link_state_next_when = 0;
         DB_PRINT_L(1, "moving to snoop check state\n");
     }
 }
@@ -203,7 +222,11 @@ static void xilinx_spips_reset(DeviceState *d)
     /* FIXME: move magic number definition somewhere sensible */
     s->regs[R_MOD_ID] = 0x01090106;
     s->regs[R_LQSPI_CFG] = R_LQSPI_CFG_RESET;
+    s->link_state = 1;
+    s->link_state_next = 1;
+    s->link_state_next_when = 0;
     s->snoop_state = SNOOP_CHECKING;
+    s->cmd_dummies = 0;
     xilinx_spips_update_ixr(s);
     xilinx_spips_update_cs_lines(s);
 }
@@ -238,14 +261,69 @@ static inline void stripe8(uint8_t *x, int num, bool dir)
     memcpy(x, r, sizeof(uint8_t) * num);
 }
 
+static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
+{
+    if (!qs) {
+        /* The SPI device is not a QSPI device */
+        return -1;
+    }
+
+    switch (command) { /* check for dummies */
+    case READ: /* no dummy bytes/cycles */
+    case PP:
+    case DPP:
+    case QPP:
+    case READ_4:
+    case PP_4:
+    case QPP_4:
+        return 0;
+    case FAST_READ:
+    case DOR:
+    case QOR:
+    case DOR_4:
+    case QOR_4:
+        return 1;
+    case DIOR:
+    case FAST_READ_4:
+    case DIOR_4:
+        return 2;
+    case QIOR:
+    case QIOR_4:
+        return 5;
+    default:
+        return -1;
+    }
+}
+
+static inline uint8_t get_addr_length(XilinxSPIPS *s, uint8_t cmd)
+{
+   switch (cmd) {
+   case PP_4:
+   case QPP_4:
+   case READ_4:
+   case QIOR_4:
+   case FAST_READ_4:
+   case DOR_4:
+   case QOR_4:
+   case DIOR_4:
+       return 4;
+   default:
+       return (s->regs[R_CMND] & R_CMND_EXT_ADD) ? 4 : 3;
+   }
+}
+
 static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
 {
     int debug_level = 0;
+    XilinxQSPIPS *q = (XilinxQSPIPS *) object_dynamic_cast(OBJECT(s),
+                                                           TYPE_XILINX_QSPIPS);
 
     for (;;) {
         int i;
         uint8_t tx = 0;
         uint8_t tx_rx[num_effective_busses(s)];
+        uint8_t dummy_cycles = 0;
+        uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
             if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
@@ -258,54 +336,102 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
                 tx_rx[i] = fifo8_pop(&s->tx_fifo);
             }
             stripe8(tx_rx, num_effective_busses(s), false);
-        } else {
+        } else if (s->snoop_state >= SNOOP_ADDR) {
             tx = fifo8_pop(&s->tx_fifo);
             for (i = 0; i < num_effective_busses(s); ++i) {
                 tx_rx[i] = tx;
             }
+        } else {
+            /* Extract a dummy byte and generate dummy cycles according to the
+             * link state */
+            tx = fifo8_pop(&s->tx_fifo);
+            dummy_cycles = 8 / s->link_state;
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
             int bus = num_effective_busses(s) - 1 - i;
-            DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
-            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
-            DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
+            if (dummy_cycles) {
+                int d;
+                for (d = 0; d < dummy_cycles; ++d) {
+                    tx_rx[0] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[0]);
+                }
+            } else {
+                DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
+                tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
+                DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
+            }
         }
 
-        if (fifo8_is_full(&s->rx_fifo)) {
+        if (s->regs[R_CMND] & R_CMND_RXFIFO_DRAIN) {
+            DB_PRINT_L(debug_level, "dircarding drained rx byte\n");
+            /* Do nothing */
+        } else if (s->rx_discard) {
+            DB_PRINT_L(debug_level, "dircarding discarded rx byte\n");
+            s->rx_discard -= 8 / s->link_state;
+        } else if (fifo8_is_full(&s->rx_fifo)) {
             s->regs[R_INTR_STATUS] |= IXR_RX_FIFO_OVERFLOW;
             DB_PRINT_L(0, "rx FIFO overflow");
         } else if (s->snoop_state == SNOOP_STRIPING) {
             stripe8(tx_rx, num_effective_busses(s), true);
             for (i = 0; i < num_effective_busses(s); ++i) {
                 fifo8_push(&s->rx_fifo, (uint8_t)tx_rx[i]);
+                DB_PRINT_L(debug_level, "pushing striped rx byte\n");
             }
         } else {
+           DB_PRINT_L(debug_level, "pushing unstriped rx byte\n");
            fifo8_push(&s->rx_fifo, (uint8_t)tx_rx[0]);
         }
 
+        if (s->link_state_next_when) {
+            s->link_state_next_when--;
+            if (!s->link_state_next_when) {
+                s->link_state = s->link_state_next;
+            }
+        }
+
         DB_PRINT_L(debug_level, "initial snoop state: %x\n",
                    (unsigned)s->snoop_state);
         switch (s->snoop_state) {
         case (SNOOP_CHECKING):
-            switch (tx) { /* new instruction code */
-            case READ: /* 3 address bytes, no dummy bytes/cycles */
-            case PP:
+            /* Store the count of dummy bytes in the txfifo */
+            s->cmd_dummies = xilinx_spips_num_dummies(q, tx);
+            addr_length = get_addr_length(s, tx);
+            if (s->cmd_dummies < 0) {
+                s->snoop_state = SNOOP_NONE;
+            } else {
+                s->snoop_state = SNOOP_ADDR + addr_length - 1;
+            }
+            switch (tx) {
             case DPP:
-            case QPP:
-                s->snoop_state = 3;
-                break;
-            case FAST_READ: /* 3 address bytes, 1 dummy byte */
             case DOR:
+            case DOR_4:
+                s->link_state_next = 2;
+                s->link_state_next_when = addr_length + s->cmd_dummies;
+                break;
+            case QPP:
+            case QPP_4:
             case QOR:
-            case DIOR: /* FIXME: these vary between vendor - set to spansion */
-                s->snoop_state = 4;
+            case QOR_4:
+                s->link_state_next = 4;
+                s->link_state_next_when = addr_length + s->cmd_dummies;
+                break;
+            case DIOR:
+            case DIOR_4:
+                s->link_state = 2;
                 break;
-            case QIOR: /* 3 address bytes, 2 dummy bytes */
-                s->snoop_state = 6;
+            case QIOR:
+            case QIOR_4:
+                s->link_state = 4;
                 break;
-            default:
+            }
+            break;
+        case (SNOOP_ADDR):
+            /* Address has been transmitted, transmit dummy cycles now if
+             * needed */
+            if (s->cmd_dummies < 0) {
                 s->snoop_state = SNOOP_NONE;
+            } else {
+                s->snoop_state = s->cmd_dummies;
             }
             break;
         case (SNOOP_STRIPING):
@@ -483,6 +609,7 @@ static void xilinx_qspips_write(void *opaque, hwaddr addr,
                                 uint64_t value, unsigned size)
 {
     XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
+    XilinxSPIPS *s = XILINX_SPIPS(opaque);
 
     xilinx_spips_write(opaque, addr, value, size);
     addr >>= 2;
@@ -490,6 +617,9 @@ static void xilinx_qspips_write(void *opaque, hwaddr addr,
     if (addr == R_LQSPI_CFG) {
         xilinx_qspips_invalidate_mmio_ptr(q);
     }
+    if (s->regs[R_CMND] & R_CMND_RXFIFO_DRAIN) {
+        fifo8_reset(&s->rx_fifo);
+    }
 }
 
 static const MemoryRegionOps qspips_ops = {
@@ -632,6 +762,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
     }
 
     s->cs_lines = g_new0(qemu_irq, s->num_cs * s->num_busses);
+    s->cs_lines_state = g_new0(bool, s->num_cs * s->num_busses);
     for (i = 0, cs = s->cs_lines; i < s->num_busses; ++i, cs += s->num_cs) {
         ssi_auto_connect_slaves(DEVICE(s), cs, s->spi[i]);
     }
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 7f9e2fc..bac90a5 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -61,13 +61,19 @@ struct XilinxSPIPS {
     uint8_t num_busses;
 
     uint8_t snoop_state;
+    int cmd_dummies;
+    uint8_t link_state;
+    uint8_t link_state_next;
+    uint8_t link_state_next_when;
     qemu_irq *cs_lines;
+    bool *cs_lines_state;
     SSIBus **spi;
 
     Fifo8 rx_fifo;
     Fifo8 tx_fifo;
 
     uint8_t num_txrx_bytes;
+    uint32_t rx_discard;
 
     uint32_t regs[XLNX_SPIPS_R_MAX];
 };
-- 
2.9.3
