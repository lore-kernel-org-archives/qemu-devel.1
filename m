Received: from eggs.gnu.org ([2001:4830:134:3::10]:41339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1earCz-0004YV-0l
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1earBv-0003mw-22
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:56:57 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:46604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1earBu-0003lO-MX
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:55:50 -0500
Received: by mail-lf0-x242.google.com with SMTP id a12so11256602lfe.13
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:55:50 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sun, 14 Jan 2018 23:55:43 +0100
Message-Id: <20180114225543.24006-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH] xilinx_spips: Correct usage of an
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
 hw/ssi/xilinx_spips.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index d8187fa..77e1bbe 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -210,6 +210,8 @@
 #define SNOOP_NONE 0xEE
 #define SNOOP_STRIPING 0
 
+#define MAX_NUM_EFFECTIVE_BUSSES 2
+
 static inline int num_effective_busses(XilinxSPIPS *s)
 {
     return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
@@ -573,7 +575,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
     for (;;) {
         int i;
         uint8_t tx = 0;
-        uint8_t tx_rx[num_effective_busses(s)];
+        uint8_t tx_rx[MAX_NUM_EFFECTIVE_BUSSES] = { 0 };
         uint8_t dummy_cycles = 0;
         uint8_t addr_length;
 
-- 
2.9.3
