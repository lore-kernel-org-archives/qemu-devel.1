Received: from eggs.gnu.org ([2001:4830:134:3::10]:48262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75F1-0002uJ-3Z
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75Ey-0003UG-1F
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:59 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:47340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e75Ex-0003T4-Lj
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:55 -0400
Received: by mail-lf0-x243.google.com with SMTP id k40so25315925lfi.4
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:51:55 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Tue, 24 Oct 2017 21:51:34 +0200
Message-Id: <20171024195139.28179-9-frasse.iglesias@gmail.com>
In-Reply-To: <20171024195139.28179-1-frasse.iglesias@gmail.com>
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 08/13] xilinx_spips: Make tx/rx_data_bytes
 more generic and reusable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Make tx/rx_data_bytes more generic so they can be reused (when adding
support for the Zynqmp Generic QSPI).

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 64 +++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 2ee70e9..ad9f1a0 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -47,7 +47,7 @@
 /* config register */
 #define R_CONFIG            (0x00 / 4)
 #define IFMODE              (1U << 31)
-#define ENDIAN              (1 << 26)
+#define R_CONFIG_ENDIAN     (1 << 26)
 #define MODEFAIL_GEN_EN     (1 << 17)
 #define MAN_START_COM       (1 << 16)
 #define MAN_START_EN        (1 << 15)
@@ -445,13 +445,28 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
     }
 }
 
-static inline void rx_data_bytes(XilinxSPIPS *s, uint8_t *value, int max)
+static inline void tx_data_bytes(Fifo8 *fifo, uint32_t value, int num, bool be)
 {
     int i;
+    for (i = 0; i < num && !fifo8_is_full(fifo); ++i) {
+        if (be) {
+            fifo8_push(fifo, (uint8_t)(value >> 24));
+            value <<= 8;
+        } else {
+            fifo8_push(fifo, (uint8_t)value);
+            value >>= 8;
+        }
+    }
+}
 
-    for (i = 0; i < max && !fifo8_is_empty(&s->rx_fifo); ++i) {
-        value[i] = fifo8_pop(&s->rx_fifo);
+static inline int rx_data_bytes(Fifo8 *fifo, uint8_t *value, int max)
+{
+    int i;
+
+    for (i = 0; i < max && !fifo8_is_empty(fifo); ++i) {
+        value[i] = fifo8_pop(fifo);
     }
+    return max - i;
 }
 
 static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
@@ -461,6 +476,7 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
     uint32_t mask = ~0;
     uint32_t ret;
     uint8_t rx_buf[4];
+    int shortfall;
 
     addr >>= 2;
     switch (addr) {
@@ -491,9 +507,13 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
         break;
     case R_RX_DATA:
         memset(rx_buf, 0, sizeof(rx_buf));
-        rx_data_bytes(s, rx_buf, s->num_txrx_bytes);
-        ret = s->regs[R_CONFIG] & ENDIAN ? cpu_to_be32(*(uint32_t *)rx_buf)
-                        : cpu_to_le32(*(uint32_t *)rx_buf);
+        shortfall = rx_data_bytes(&s->rx_fifo, rx_buf, s->num_txrx_bytes);
+        ret = s->regs[R_CONFIG] & R_CONFIG_ENDIAN ?
+                        cpu_to_be32(*(uint32_t *)rx_buf) :
+                        cpu_to_le32(*(uint32_t *)rx_buf);
+        if (!(s->regs[R_CONFIG] & R_CONFIG_ENDIAN)) {
+            ret <<= 8 * shortfall;
+        }
         DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
         xilinx_spips_update_ixr(s);
         return ret;
@@ -504,20 +524,6 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
 
 }
 
-static inline void tx_data_bytes(XilinxSPIPS *s, uint32_t value, int num)
-{
-    int i;
-    for (i = 0; i < num && !fifo8_is_full(&s->tx_fifo); ++i) {
-        if (s->regs[R_CONFIG] & ENDIAN) {
-            fifo8_push(&s->tx_fifo, (uint8_t)(value >> 24));
-            value <<= 8;
-        } else {
-            fifo8_push(&s->tx_fifo, (uint8_t)value);
-            value >>= 8;
-        }
-    }
-}
-
 static void xilinx_spips_write(void *opaque, hwaddr addr,
                                         uint64_t value, unsigned size)
 {
@@ -558,16 +564,20 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
         mask = 0;
         break;
     case R_TX_DATA:
-        tx_data_bytes(s, (uint32_t)value, s->num_txrx_bytes);
+        tx_data_bytes(&s->tx_fifo, (uint32_t)value, s->num_txrx_bytes,
+                      s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
     case R_TXD1:
-        tx_data_bytes(s, (uint32_t)value, 1);
+        tx_data_bytes(&s->tx_fifo, (uint32_t)value, 1,
+                      s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
     case R_TXD2:
-        tx_data_bytes(s, (uint32_t)value, 2);
+        tx_data_bytes(&s->tx_fifo, (uint32_t)value, 2,
+                      s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
     case R_TXD3:
-        tx_data_bytes(s, (uint32_t)value, 3);
+        tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
+                      s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
@@ -677,11 +687,11 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
 
         while (cache_entry < LQSPI_CACHE_SIZE) {
             for (i = 0; i < 64; ++i) {
-                tx_data_bytes(s, 0, 1);
+                tx_data_bytes(&s->tx_fifo, 0, 1, false);
             }
             xilinx_spips_flush_txfifo(s);
             for (i = 0; i < 64; ++i) {
-                rx_data_bytes(s, &q->lqspi_buf[cache_entry++], 1);
+                rx_data_bytes(&s->rx_fifo, &q->lqspi_buf[cache_entry++], 1);
             }
         }
 
-- 
2.9.3
