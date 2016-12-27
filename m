Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaS-0002mV-2d
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaR-0001Qu-1s
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaQ-0001Qc-Qi
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaP-0003xo-W1
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:14 +0000
Message-Id: <1482852077-19397-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/25] aspeed/smc: set the number of flash
 modules for the FMC controller
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

Add a new configuration field at the board level and propagate the
value using the "num-cs" property of the FMC controller model.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1480434248-27138-14-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c     | 6 ++++++
 hw/arm/aspeed_soc.c | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bc70b38..40c1383 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -36,6 +36,7 @@ typedef struct AspeedBoardConfig {
     uint32_t hw_strap1;
     const char *fmc_model;
     const char *spi_model;
+    uint32_t num_cs;
 } AspeedBoardConfig;
 
 enum {
@@ -85,18 +86,21 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
+        .num_cs    = 1,
     },
     [AST2500_EVB]  = {
         .soc_name  = "ast2500-a1",
         .hw_strap1 = AST2500_EVB_HW_STRAP1,
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
+        .num_cs    = 1,
     },
     [ROMULUS_BMC]  = {
         .soc_name  = "ast2500-a1",
         .hw_strap1 = ROMULUS_BMC_HW_STRAP1,
         .fmc_model = "n25q256a",
         .spi_model = "mx66l1g45g",
+        .num_cs    = 2,
     },
 };
 
@@ -143,6 +147,8 @@ static void aspeed_board_init(MachineState *machine,
                            &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap1, "hw-strap1",
                             &error_abort);
+    object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
+                            &error_abort);
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index d111d2e..b3e7f07 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -153,6 +153,8 @@ static void aspeed_soc_init(Object *obj)
     object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
     object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
     qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
+    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
+                              &error_abort);
 
     for (i = 0; i < sc->info->spis_num; i++) {
         object_initialize(&s->spi[i], sizeof(s->spi[i]),
@@ -250,10 +252,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        qdev_get_gpio_in(DEVICE(&s->vic), 12));
 
-    /* FMC */
-    object_property_set_int(OBJECT(&s->fmc), 1, "num-cs", &err);
-    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &local_err);
-    error_propagate(&err, local_err);
+    /* FMC, The number of CS is set at the board level */
+    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
-- 
2.7.4
