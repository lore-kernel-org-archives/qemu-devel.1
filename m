Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcc-0001B8-CI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcb-0006Fq-2L
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTca-0006F8-RW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:53 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcZ-0007Up-SW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:31 +0100
Message-Id: <1496337035-30213-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/27] aspeed: add some I2C devices to the
 Aspeed machines
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

Let's add an RTC to the palmetto BMC and a LM75 temperature sensor to
the AST2500 EVB to start with.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1494827476-1487-5-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 283c038..e824ea8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -39,6 +39,7 @@ typedef struct AspeedBoardConfig {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedBoardConfig;
 
 enum {
@@ -82,6 +83,9 @@ enum {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
+static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
+
 static const AspeedBoardConfig aspeed_boards[] = {
     [PALMETTO_BMC] = {
         .soc_name  = "ast2400-a1",
@@ -89,6 +93,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
+        .i2c_init  = palmetto_bmc_i2c_init,
     },
     [AST2500_EVB]  = {
         .soc_name  = "ast2500-a1",
@@ -96,6 +101,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
+        .i2c_init  = ast2500_evb_i2c_init,
     },
     [ROMULUS_BMC]  = {
         .soc_name  = "ast2500-a1",
@@ -223,9 +229,22 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->info->sdram_base;
 
+    if (cfg->i2c_init) {
+        cfg->i2c_init(bmc);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
 }
 
+static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    /* The palmetto platform expects a ds3231 RTC but a ds1338 is
+     * enough to provide basic RTC features. Alarms will be missing */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
+}
+
 static void palmetto_bmc_init(MachineState *machine)
 {
     aspeed_board_init(machine, &aspeed_boards[PALMETTO_BMC]);
@@ -250,6 +269,14 @@ static const TypeInfo palmetto_bmc_type = {
     .class_init = palmetto_bmc_class_init,
 };
 
+static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x4d);
+}
+
 static void ast2500_evb_init(MachineState *machine)
 {
     aspeed_board_init(machine, &aspeed_boards[AST2500_EVB]);
-- 
2.7.4
