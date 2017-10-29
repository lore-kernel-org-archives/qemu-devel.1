Received: from eggs.gnu.org ([2001:4830:134:3::10]:46073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbT-0006b3-1u
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbR-0007tl-Vo
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:03 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e8kbR-0007tE-Nq
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:01 -0400
Received: by mail-lf0-x243.google.com with SMTP id n69so11664765lfn.2
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 03:14:01 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sun, 29 Oct 2017 11:13:39 +0100
Message-Id: <20171029101343.15544-10-frasse.iglesias@gmail.com>
In-Reply-To: <20171029101343.15544-1-frasse.iglesias@gmail.com>
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v5 09/13] xilinx_spips: Add support for zero
 pumping
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

Add support for zero pumping according to the transfer size register.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c         | 47 ++++++++++++++++++++++++++++++++++++-------
 include/hw/ssi/xilinx_spips.h |  2 ++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e37d005..3a98799 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -109,6 +109,7 @@
     FIELD(CMND, DUMMY_CYCLES, 2, 6)
 #define R_CMND_DMA_EN         (1 << 1)
 #define R_CMND_PUSH_WAIT      (1 << 0)
+#define R_TRANSFER_SIZE     (0xc4 / 4)
 #define R_LQSPI_STS         (0xA4 / 4)
 #define LQSPI_STS_WR_RECVD      (1 << 1)
 
@@ -227,6 +228,7 @@ static void xilinx_spips_reset(DeviceState *d)
     s->link_state_next_when = 0;
     s->snoop_state = SNOOP_CHECKING;
     s->cmd_dummies = 0;
+    s->man_start_com = false;
     xilinx_spips_update_ixr(s);
     xilinx_spips_update_cs_lines(s);
 }
@@ -464,6 +466,41 @@ static inline void tx_data_bytes(Fifo8 *fifo, uint32_t value, int num, bool be)
     }
 }
 
+static void xilinx_spips_check_zero_pump(XilinxSPIPS *s)
+{
+    if (!s->regs[R_TRANSFER_SIZE]) {
+        return;
+    }
+    if (!fifo8_is_empty(&s->tx_fifo) && s->regs[R_CMND] & R_CMND_PUSH_WAIT) {
+        return;
+    }
+    /*
+     * The zero pump must never fill tx fifo such that rx overflow is
+     * possible
+     */
+    while (s->regs[R_TRANSFER_SIZE] &&
+           s->rx_fifo.num + s->tx_fifo.num < RXFF_A_Q - 3) {
+        /* endianess just doesn't matter when zero pumping */
+        tx_data_bytes(&s->tx_fifo, 0, 4, false);
+        s->regs[R_TRANSFER_SIZE] &= ~0x03ull;
+        s->regs[R_TRANSFER_SIZE] -= 4;
+    }
+}
+
+static void xilinx_spips_check_flush(XilinxSPIPS *s)
+{
+    if (s->man_start_com ||
+        (!fifo8_is_empty(&s->tx_fifo) &&
+         !(s->regs[R_CONFIG] & MAN_START_EN))) {
+        xilinx_spips_check_zero_pump(s);
+        xilinx_spips_flush_txfifo(s);
+    }
+    if (fifo8_is_empty(&s->tx_fifo) && !s->regs[R_TRANSFER_SIZE]) {
+        s->man_start_com = false;
+    }
+    xilinx_spips_update_ixr(s);
+}
+
 static inline int rx_data_bytes(Fifo8 *fifo, uint8_t *value, int max)
 {
     int i;
@@ -533,7 +570,6 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
                                         uint64_t value, unsigned size)
 {
     int mask = ~0;
-    int man_start_com = 0;
     XilinxSPIPS *s = opaque;
 
     DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
@@ -541,8 +577,8 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
     switch (addr) {
     case R_CONFIG:
         mask = ~(R_CONFIG_RSVD | MAN_START_COM);
-        if (value & MAN_START_COM) {
-            man_start_com = 1;
+        if ((value & MAN_START_COM) && (s->regs[R_CONFIG] & MAN_START_EN)) {
+            s->man_start_com = true;
         }
         break;
     case R_INTR_STATUS:
@@ -588,10 +624,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
     xilinx_spips_update_cs_lines(s);
-    if ((man_start_com && s->regs[R_CONFIG] & MAN_START_EN) ||
-            (fifo8_is_empty(&s->tx_fifo) && s->regs[R_CONFIG] & MAN_START_EN)) {
-        xilinx_spips_flush_txfifo(s);
-    }
+    xilinx_spips_check_flush(s);
     xilinx_spips_update_cs_lines(s);
     xilinx_spips_update_ixr(s);
 }
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index bac90a5..ad2175a 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -76,6 +76,8 @@ struct XilinxSPIPS {
     uint32_t rx_discard;
 
     uint32_t regs[XLNX_SPIPS_R_MAX];
+
+    bool man_start_com;
 };
 
 typedef struct {
-- 
2.9.3
