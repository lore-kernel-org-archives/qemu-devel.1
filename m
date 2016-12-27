Received: from eggs.gnu.org ([2001:4830:134:3::10]:35521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta7-0002Vt-TI
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta6-0001Kg-Rr
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:27 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLta6-0001KY-K1
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:26 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta5-0003va-Pp
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:08 +0000
Message-Id: <1482852077-19397-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/25] aspeed: add support for the romulus-bmc
 board
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

The Romulus machine is an OpenPOWER system with an AST2500 SoC for
the BMC and a POWER9 chip for the host. It does not make much
difference for qemu a part from the fact that the FMC controller has
two SPI flash module.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 1480434248-27138-8-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 159d562..3509011 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -41,8 +41,10 @@ typedef struct AspeedBoardConfig {
 enum {
     PALMETTO_BMC,
     AST2500_EVB,
+    ROMULUS_BMC,
 };
 
+/* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
         SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=6, CWL=5 */) | \
@@ -56,6 +58,7 @@ enum {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
+/* AST2500 evb hardware value: 0xF100C2E6 */
 #define AST2500_EVB_HW_STRAP1 ((                                        \
         AST2500_HW_STRAP1_DEFAULTS |                                    \
         SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
@@ -66,6 +69,16 @@ enum {
         SCU_HW_STRAP_MAC0_RGMII) &                                      \
         ~SCU_HW_STRAP_2ND_BOOT_WDT)
 
+/* Romulus hardware value: 0xF10AD206 */
+#define ROMULUS_BMC_HW_STRAP1 (                                         \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
+
 static const AspeedBoardConfig aspeed_boards[] = {
     [PALMETTO_BMC] = {
         .soc_name  = "ast2400-a0",
@@ -79,6 +92,12 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
     },
+    [ROMULUS_BMC]  = {
+        .soc_name  = "ast2500-a1",
+        .hw_strap1 = ROMULUS_BMC_HW_STRAP1,
+        .fmc_model = "n25q256a",
+        .spi_model = "mx66l1g45g",
+    },
 };
 
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
@@ -200,10 +219,35 @@ static const TypeInfo ast2500_evb_type = {
     .class_init = ast2500_evb_class_init,
 };
 
+static void romulus_bmc_init(MachineState *machine)
+{
+    aspeed_board_init(machine, &aspeed_boards[ROMULUS_BMC]);
+}
+
+static void romulus_bmc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "OpenPOWER Romulus BMC (ARM1176)";
+    mc->init = romulus_bmc_init;
+    mc->max_cpus = 1;
+    mc->no_sdcard = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+}
+
+static const TypeInfo romulus_bmc_type = {
+    .name = MACHINE_TYPE_NAME("romulus-bmc"),
+    .parent = TYPE_MACHINE,
+    .class_init = romulus_bmc_class_init,
+};
+
 static void aspeed_machine_init(void)
 {
     type_register_static(&palmetto_bmc_type);
     type_register_static(&ast2500_evb_type);
+    type_register_static(&romulus_bmc_type);
 }
 
 type_init(aspeed_machine_init)
-- 
2.7.4
