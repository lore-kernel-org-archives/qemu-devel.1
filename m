Received: from eggs.gnu.org ([2001:4830:134:3::10]:35667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmH-0001gY-K5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmF-0001RS-Nb
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cOzmF-0001Qf-EM
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v054XnCL043711
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 23:35:46 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27s6qcjjub-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:35:46 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 5 Jan 2017 14:35:43 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu,  5 Jan 2017 15:34:30 +1100
In-Reply-To: <20170105043430.3176-1-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
Message-Id: <20170105043430.3176-8-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v5 7/7] arm: Add an RX8900 RTC to the ASpeed
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>, Chris Smart <chris@distroguy.com>

From: Alastair D'Silva <alastair@d-silva.org>

Connect an RX8900 RTC to i2c12 of the AST2500 SOC at address 0x32

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Chris Smart <chris@distroguy.com>
---
 hw/arm/aspeed.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 40c1383..ef63fd0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -26,6 +26,12 @@ static struct arm_boot_info aspeed_board_binfo = {
     .nb_cpus = 1,
 };
 
+typedef struct AspeedI2CDevice {
+    const char *type;
+    uint8_t address;
+    int bus;
+} AspeedI2CDevice;
+
 typedef struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram;
@@ -37,6 +43,7 @@ typedef struct AspeedBoardConfig {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    const AspeedI2CDevice *i2c_devices;
 } AspeedBoardConfig;
 
 enum {
@@ -80,6 +87,11 @@ enum {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+
+static const AspeedI2CDevice ast2500_i2c_devices[] = {
+        {"rx8900", 0x32, 11}
+};
+
 static const AspeedBoardConfig aspeed_boards[] = {
     [PALMETTO_BMC] = {
         .soc_name  = "ast2400-a1",
@@ -94,6 +106,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
+        .i2c_devices = ast2500_i2c_devices,
     },
     [ROMULUS_BMC]  = {
         .soc_name  = "ast2500-a1",
@@ -104,6 +117,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
     },
 };
 
+
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                       Error **errp)
 {
@@ -130,6 +144,19 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
+static void aspeed_i2c_init(AspeedBoardState *bmc,
+        const AspeedBoardConfig *cfg)
+{
+    AspeedSoCState *soc = &bmc->soc;
+    const AspeedI2CDevice *dev;
+
+    for (dev = cfg->i2c_devices; dev != NULL && dev->type != NULL; dev++) {
+        I2CBus *i2c_bus = aspeed_i2c_get_bus((DeviceState *)&soc->i2c,
+                                             dev->bus);
+        (void)i2c_create_slave(i2c_bus, dev->type, dev->address);
+    }
+}
+
 static void aspeed_board_init(MachineState *machine,
                               const AspeedBoardConfig *cfg)
 {
@@ -174,6 +201,8 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->info->sdram_base;
 
+    aspeed_i2c_init(bmc, cfg);
+
     arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
 }
 
-- 
2.9.3
