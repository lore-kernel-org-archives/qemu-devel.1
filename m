Received: from eggs.gnu.org ([2001:4830:134:3::10]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWT-0004a7-50
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWR-0007ZK-ND
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWR-0007XQ-Fy
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:47 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWQ-0007bC-G0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:04 +0000
Message-Id: <1513188761-20784-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/43] xilinx_spips: Update striping to be
 big-endian bit order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Update striping functionality to be big-endian bit order (as according to
the Zynq-7000 Technical Reference Manual). Output thereafter the even bits
into the flash memory connected to the lower QSPI bus and the odd bits into
the flash memory connected to the upper QSPI bus.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-7-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 559fa79e..231aa5b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -208,14 +208,14 @@ static void xilinx_spips_reset(DeviceState *d)
     xilinx_spips_update_cs_lines(s);
 }
 
-/* N way (num) in place bit striper. Lay out row wise bits (LSB to MSB)
+/* N way (num) in place bit striper. Lay out row wise bits (MSB to LSB)
  * column wise (from element 0 to N-1). num is the length of x, and dir
  * reverses the direction of the transform. Best illustrated by example:
  * Each digit in the below array is a single bit (num == 3):
  *
- * {{ 76543210, }  ----- stripe (dir == false) -----> {{ FCheb630, }
- *  { hgfedcba, }                                      { GDAfc741, }
- *  { HGFEDCBA, }} <---- upstripe (dir == true) -----  { HEBgda52, }}
+ * {{ 76543210, }  ----- stripe (dir == false) -----> {{ 741gdaFC, }
+ *  { hgfedcba, }                                      { 630fcHEB, }
+ *  { HGFEDCBA, }} <---- upstripe (dir == true) -----  { 52hebGDA, }}
  */
 
 static inline void stripe8(uint8_t *x, int num, bool dir)
@@ -223,15 +223,15 @@ static inline void stripe8(uint8_t *x, int num, bool dir)
     uint8_t r[num];
     memset(r, 0, sizeof(uint8_t) * num);
     int idx[2] = {0, 0};
-    int bit[2] = {0, 0};
+    int bit[2] = {0, 7};
     int d = dir;
 
     for (idx[0] = 0; idx[0] < num; ++idx[0]) {
-        for (bit[0] = 0; bit[0] < 8; ++bit[0]) {
-            r[idx[d]] |= x[idx[!d]] & 1 << bit[!d] ? 1 << bit[d] : 0;
+        for (bit[0] = 7; bit[0] >= 0; bit[0]--) {
+            r[idx[!d]] |= x[idx[d]] & 1 << bit[d] ? 1 << bit[!d] : 0;
             idx[1] = (idx[1] + 1) % num;
             if (!idx[1]) {
-                bit[1]++;
+                bit[1]--;
             }
         }
     }
@@ -266,8 +266,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
+            int bus = num_effective_busses(s) - 1 - i;
             DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
-            tx_rx[i] = ssi_transfer(s->spi[i], (uint32_t)tx_rx[i]);
+            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
             DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
         }
 
-- 
2.7.4
