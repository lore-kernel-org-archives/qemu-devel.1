Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehom-0003Lu-RJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehol-0003Dx-W3
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehol-0003Co-OW
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehok-0006yS-Eb
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:28 +0000
Message-Id: <1516887809-6265-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/21] xilinx_spips: Correct usage of an
 uninitialized local variable
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

Coverity found that the variable tx_rx in the function
xilinx_spips_flush_txfifo was being used uninitialized (CID 1383841). This
patch corrects this by always initializing tx_rx to zeros.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20180124215708.30400-1-frasse.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 85c5d0c..8af36ca 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -210,6 +210,9 @@
 #define SNOOP_NONE 0xEE
 #define SNOOP_STRIPING 0
 
+#define MIN_NUM_BUSSES 1
+#define MAX_NUM_BUSSES 2
+
 static inline int num_effective_busses(XilinxSPIPS *s)
 {
     return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
@@ -573,7 +576,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
     for (;;) {
         int i;
         uint8_t tx = 0;
-        uint8_t tx_rx[num_effective_busses(s)];
+        uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
         uint8_t dummy_cycles = 0;
         uint8_t addr_length;
 
@@ -1221,6 +1224,19 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
 
     DB_PRINT_L(0, "realized spips\n");
 
+    if (s->num_busses > MAX_NUM_BUSSES) {
+        error_setg(errp,
+                   "requested number of SPI busses %u exceeds maximum %d",
+                   s->num_busses, MAX_NUM_BUSSES);
+        return;
+    }
+    if (s->num_busses < MIN_NUM_BUSSES) {
+        error_setg(errp,
+                   "requested number of SPI busses %u is below minimum %d",
+                   s->num_busses, MIN_NUM_BUSSES);
+        return;
+    }
+
     s->spi = g_new(SSIBus *, s->num_busses);
     for (i = 0; i < s->num_busses; ++i) {
         char bus_name[16];
-- 
2.7.4
