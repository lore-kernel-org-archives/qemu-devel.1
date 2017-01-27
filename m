Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vx-00019l-VP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vx-0005BX-1q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vw-000541-Ri
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vf-0003L6-3A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:19 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:31:56 +0000
Message-Id: <1485531137-2362-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/22] aspeed/smc: handle dummy bytes when doing
 fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

When doing fast read, a certain amount of dummy bytes should be sent
before the read. This number is configurable in the controler CE0
Control Register and needs to be modeled using fake transfers to the
flash module.

This only supports command mode. User mode requires more work and a
possible extension of the m25p80 device model.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
Message-id: 1484751701-2646-1-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index ae1ad2d..087b29e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -69,7 +69,9 @@
 #define R_CTRL0           (0x10 / 4)
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
+#define   CTRL_DUMMY_HIGH_SHIFT    14
 #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
+#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
 #define     CTRL_READMODE          0x0
@@ -485,6 +487,16 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     return addr;
 }
 
+static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s = fl->controller;
+    uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->id];
+    uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
+    uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
+
+    return ((dummy_high << 2) | dummy_low) * 8;
+}
+
 static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
 {
     const AspeedSMCState *s = fl->controller;
@@ -521,6 +533,15 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
         aspeed_smc_flash_select(fl);
         aspeed_smc_flash_send_addr(fl, addr);
 
+        /*
+         * Use fake transfers to model dummy bytes. The value should
+         * be configured to some non-zero value in fast read mode and
+         * zero in read mode.
+         */
+        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+            ssi_transfer(fl->controller->spi, 0xFF);
+        }
+
         for (i = 0; i < size; i++) {
             ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
         }
-- 
2.7.4
