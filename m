Received: from eggs.gnu.org ([2001:4830:134:3::10]:50525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlp-000359-Gw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-0004GX-O8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGln-0004Ei-GH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlc-0003bh-8P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:49 +0100
Message-Id: <20180608124517.29475-4-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/31] aspeed: add support for the
 witherspoon-bmc board
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

The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
Add support for their BMC including a couple of I2C devices as found
on real HW.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180530064049.27976-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4d7201d74a0..732c034cca4 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -45,6 +45,7 @@ enum {
     PALMETTO_BMC,
     AST2500_EVB,
     ROMULUS_BMC,
+    WITHERSPOON_BMC,
 };
 
 /* Palmetto hardware value: 0x120CE416 */
@@ -82,8 +83,12 @@ enum {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
+#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
+
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
 static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
+static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
 
 static const AspeedBoardConfig aspeed_boards[] = {
     [PALMETTO_BMC] = {
@@ -109,6 +114,14 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
     },
+    [WITHERSPOON_BMC]  = {
+        .soc_name  = "ast2500-a1",
+        .hw_strap1 = WITHERSPOON_BMC_HW_STRAP1,
+        .fmc_model = "mx25l25635e",
+        .spi_model = "mx66l1g45g",
+        .num_cs    = 2,
+        .i2c_init  = witherspoon_bmc_i2c_init,
+    },
 };
 
 #define FIRMWARE_ADDR 0x0
@@ -342,11 +355,47 @@ static const TypeInfo romulus_bmc_type = {
     .class_init = romulus_bmc_class_init,
 };
 
+static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
+
+    /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105", 0x4a);
+}
+
+static void witherspoon_bmc_init(MachineState *machine)
+{
+    aspeed_board_init(machine, &aspeed_boards[WITHERSPOON_BMC]);
+}
+
+static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "OpenPOWER Witherspoon BMC (ARM1176)";
+    mc->init = witherspoon_bmc_init;
+    mc->max_cpus = 1;
+    mc->no_sdcard = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+}
+
+static const TypeInfo witherspoon_bmc_type = {
+    .name = MACHINE_TYPE_NAME("witherspoon-bmc"),
+    .parent = TYPE_MACHINE,
+    .class_init = witherspoon_bmc_class_init,
+};
+
 static void aspeed_machine_init(void)
 {
     type_register_static(&palmetto_bmc_type);
     type_register_static(&ast2500_evb_type);
     type_register_static(&romulus_bmc_type);
+    type_register_static(&witherspoon_bmc_type);
 }
 
 type_init(aspeed_machine_init)
-- 
2.17.1
