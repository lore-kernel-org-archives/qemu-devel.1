Received: from eggs.gnu.org ([2001:4830:134:3::10]:59388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ebvMP-00060C-Ul
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ebvMP-00027U-6e
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:35:05 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1ebvMO-00026s-VV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:35:05 -0500
Received: by mail-lf0-x242.google.com with SMTP id t139so9083417lff.0
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 13:35:04 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed, 17 Jan 2018 22:34:58 +0100
Message-Id: <20180117213458.17560-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2] xilinx_spips: Correct usage of an
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
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

Coverity found that the variable tx_rx in the function
xilinx_spips_flush_txfifo was being used uninitialized (CID 1383841). This
patch corrects this by always initializing tx_rx to zeros.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>

---
v2. Add a sanity check on the num_busses property when realizing the
    devices.
---
 hw/ssi/xilinx_spips.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 85c5d0c..12f1de9 100644
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
 
@@ -1221,6 +1224,14 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
 
     DB_PRINT_L(0, "realized spips\n");
 
+    if (s->num_busses < MIN_NUM_BUSSES || s->num_busses > MAX_NUM_BUSSES) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid number of spi busses requested, "
+                      "will default to use one bus\n",
+                      __func__);
+        s->num_busses = 1;
+    }
+
     s->spi = g_new(SSIBus *, s->num_busses);
     for (i = 0; i < s->num_busses; ++i) {
         char bus_name[16];
-- 
2.9.3
