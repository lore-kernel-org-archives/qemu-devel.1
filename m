Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbO-0006XT-Sg
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8kbN-0007ry-U9
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:13:58 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e8kbN-0007rd-M0
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:13:57 -0400
Received: by mail-lf0-x241.google.com with SMTP id 75so11678810lfx.1
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 03:13:57 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sun, 29 Oct 2017 11:13:36 +0100
Message-Id: <20171029101343.15544-7-frasse.iglesias@gmail.com>
In-Reply-To: <20171029101343.15544-1-frasse.iglesias@gmail.com>
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v5 06/13] xilinx_spips: Update striping to be
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
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Update striping functionality to be big-endian bit order and output even
bits into flash memory connected to the lower QSPI bus and odd bits into
the flash memory connected to the upper QSPI bus.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 559fa79..7accf5d 100644
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
+        for (bit[0] = 7; bit[0] != -1; bit[0] += -1) {
+            r[idx[!d]] |= x[idx[d]] & 1 << bit[d] ? 1 << bit[!d] : 0;
             idx[1] = (idx[1] + 1) % num;
             if (!idx[1]) {
-                bit[1]++;
+                bit[1] += -1;
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
2.9.3
