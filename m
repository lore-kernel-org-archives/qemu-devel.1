Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uz-000815-Nb
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uy-0001FY-EG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:41 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8uy-0001EM-8R
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:40 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2F12063A76
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:39 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:14 +0200
Message-Id: <1494827476-1487-5-git-send-email-clg@kaod.org>
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] aspeed: add some I2C devices to the Aspeed
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Let's add an RTC to the palmetto BMC and a LM75 temperature sensor to
the AST2500 EVB to start with.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 283c03881493..e824ea87a9af 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -39,6 +39,7 @@ typedef struct AspeedBoardConfig {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedBoardConfig;
=20
 enum {
@@ -82,6 +83,9 @@ enum {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              =
\
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
=20
+static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
+static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
+
 static const AspeedBoardConfig aspeed_boards[] =3D {
     [PALMETTO_BMC] =3D {
         .soc_name  =3D "ast2400-a1",
@@ -89,6 +93,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .fmc_model =3D "n25q256a",
         .spi_model =3D "mx25l25635e",
         .num_cs    =3D 1,
+        .i2c_init  =3D palmetto_bmc_i2c_init,
     },
     [AST2500_EVB]  =3D {
         .soc_name  =3D "ast2500-a1",
@@ -96,6 +101,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .fmc_model =3D "n25q256a",
         .spi_model =3D "mx25l25635e",
         .num_cs    =3D 1,
+        .i2c_init  =3D ast2500_evb_i2c_init,
     },
     [ROMULUS_BMC]  =3D {
         .soc_name  =3D "ast2500-a1",
@@ -223,9 +229,22 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.ram_size =3D ram_size;
     aspeed_board_binfo.loader_start =3D sc->info->sdram_base;
=20
+    if (cfg->i2c_init) {
+        cfg->i2c_init(bmc);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
 }
=20
+static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc =3D &bmc->soc;
+
+    /* The palmetto platform expects a ds3231 RTC but a ds1338 is
+     * enough to provide basic RTC features. Alarms will be missing */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338",=
 0x68);
+}
+
 static void palmetto_bmc_init(MachineState *machine)
 {
     aspeed_board_init(machine, &aspeed_boards[PALMETTO_BMC]);
@@ -250,6 +269,14 @@ static const TypeInfo palmetto_bmc_type =3D {
     .class_init =3D palmetto_bmc_class_init,
 };
=20
+static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc =3D &bmc->soc;
+
+    /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x4d);
+}
+
 static void ast2500_evb_init(MachineState *machine)
 {
     aspeed_board_init(machine, &aspeed_boards[AST2500_EVB]);
--=20
2.7.4
