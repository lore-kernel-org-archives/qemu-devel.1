Received: from eggs.gnu.org ([2001:4830:134:3::10]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPw-00014L-PW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0005Dq-I2
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPr-0004w9-7c
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPc-000378-Nu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:00 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:29 +0000
Message-Id: <1484834995-26826-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/36] aspeed/smc: autostrap CE0/1 configuration
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

On the AST2500 SoC, the FMC controller flash type is fixed to SPI for
CE0 and CE1 and 4BYTE mode is autodetected for CE0.

On the AST2400 SoC, the FMC controller flash type and 4BYTE mode are
strapped with register SCU70. We use the default settings from the
palmetto-bmc machine for now.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-5-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9b31d5d..3bd381b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -39,11 +39,14 @@
 #define   CONF_ENABLE_W2       18
 #define   CONF_ENABLE_W1       17
 #define   CONF_ENABLE_W0       16
-#define   CONF_FLASH_TYPE4     9
-#define   CONF_FLASH_TYPE3     7
-#define   CONF_FLASH_TYPE2     5
-#define   CONF_FLASH_TYPE1     3
-#define   CONF_FLASH_TYPE0     1
+#define   CONF_FLASH_TYPE4     8
+#define   CONF_FLASH_TYPE3     6
+#define   CONF_FLASH_TYPE2     4
+#define   CONF_FLASH_TYPE1     2
+#define   CONF_FLASH_TYPE0     0
+#define      CONF_FLASH_TYPE_NOR   0x0
+#define      CONF_FLASH_TYPE_NAND  0x1
+#define      CONF_FLASH_TYPE_SPI   0x2
 
 /* CE Control Register */
 #define R_CE_CTRL            (0x04 / 4)
@@ -436,6 +439,25 @@ static void aspeed_smc_reset(DeviceState *d)
         s->regs[R_SEG_ADDR0 + i] =
             aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
     }
+
+    /* HW strapping for AST2500 FMC controllers  */
+    if (s->ctrl->segments == aspeed_segments_ast2500_fmc) {
+        /* flash type is fixed to SPI for CE0 and CE1 */
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1);
+
+        /* 4BYTE mode is autodetected for CE0. Let's force it to 1 for
+         * now */
+        s->regs[s->r_ce_ctrl] |= (1 << (CTRL_EXTENDED0));
+    }
+
+    /* HW strapping for AST2400 FMC controllers (SCU70). Let's use the
+     * configuration of the palmetto-bmc machine */
+    if (s->ctrl->segments == aspeed_segments_fmc) {
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
+
+        s->regs[s->r_ce_ctrl] |= (1 << (CTRL_EXTENDED0));
+    }
 }
 
 static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
-- 
2.7.4
