Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta4-0002T6-1l
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta3-0001KD-5r
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:24 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLta2-0001K5-Vk
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:23 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta2-0003vD-4m
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:22 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:07 +0000
Message-Id: <1482852077-19397-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/25] aspeed: extend the board configuration
 with flash models
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

Future machine will use different flash models for the FMC and the SPI
controllers.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-7-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c7206fd..159d562 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -34,6 +34,8 @@ typedef struct AspeedBoardState {
 typedef struct AspeedBoardConfig {
     const char *soc_name;
     uint32_t hw_strap1;
+    const char *fmc_model;
+    const char *spi_model;
 } AspeedBoardConfig;
 
 enum {
@@ -65,8 +67,18 @@ enum {
         ~SCU_HW_STRAP_2ND_BOOT_WDT)
 
 static const AspeedBoardConfig aspeed_boards[] = {
-    [PALMETTO_BMC] = { "ast2400-a0", PALMETTO_BMC_HW_STRAP1 },
-    [AST2500_EVB]  = { "ast2500-a1", AST2500_EVB_HW_STRAP1 },
+    [PALMETTO_BMC] = {
+        .soc_name  = "ast2400-a0",
+        .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
+        .fmc_model = "n25q256a",
+        .spi_model = "mx25l25635e",
+    },
+    [AST2500_EVB]  = {
+        .soc_name  = "ast2500-a1",
+        .hw_strap1 = AST2500_EVB_HW_STRAP1,
+        .fmc_model = "n25q256a",
+        .spi_model = "mx25l25635e",
+    },
 };
 
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
@@ -128,8 +140,8 @@ static void aspeed_board_init(MachineState *machine,
     object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc->ram),
                                    &error_abort);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc, "n25q256a", &error_abort);
-    aspeed_board_init_flashes(&bmc->soc.spi[0], "mx25l25635e", &error_abort);
+    aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
+    aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
 
     aspeed_board_binfo.kernel_filename = machine->kernel_filename;
     aspeed_board_binfo.initrd_filename = machine->initrd_filename;
-- 
2.7.4
