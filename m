Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHG-000258-1c
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-0007F7-2j
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHE-0007DT-Ry
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH3-0008T7-JA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:28 +0100
Message-Id: <20180626165658.31394-3-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/32] aspeed/smc: fix HW strapping
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

Only the flash type is strapped by HW. The 4BYTE mode is set by
firmware when the flash device is detected.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180612065716.10587-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index fce126e6ee9..b1537089358 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -639,23 +639,17 @@ static void aspeed_smc_reset(DeviceState *d)
             aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
     }
 
-    /* HW strapping for AST2500 FMC controllers  */
+    /* HW strapping flash type for FMC controllers  */
     if (s->ctrl->segments == aspeed_segments_ast2500_fmc) {
         /* flash type is fixed to SPI for CE0 and CE1 */
         s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
         s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1);
-
-        /* 4BYTE mode is autodetected for CE0. Let's force it to 1 for
-         * now */
-        s->regs[s->r_ce_ctrl] |= (1 << (CTRL_EXTENDED0));
     }
 
     /* HW strapping for AST2400 FMC controllers (SCU70). Let's use the
      * configuration of the palmetto-bmc machine */
     if (s->ctrl->segments == aspeed_segments_fmc) {
         s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
-
-        s->regs[s->r_ce_ctrl] |= (1 << (CTRL_EXTENDED0));
     }
 }
 
-- 
2.17.1
