Received: from eggs.gnu.org ([2001:4830:134:3::10]:47639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duZ1O-0004pu-DB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duZ1K-0008Vn-EC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:02:10 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:40413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duZ1K-0008Ui-9J
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:02:06 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D7119AC964
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:02:04 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 20 Sep 2017 09:01:30 +0200
Message-Id: <20170920070135.31379-2-clg@kaod.org>
In-Reply-To: <20170920070135.31379-1-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
Let's add support for their BMC including a couple of I2C devices as
found on real HW.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad490af..81f522f711ae 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -46,6 +46,7 @@ enum {
     PALMETTO_BMC,
     AST2500_EVB,
     ROMULUS_BMC,
+    WITHERSPOON_BMC,
 };
=20
 /* Palmetto hardware value: 0x120CE416 */
@@ -83,8 +84,12 @@ enum {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              =
\
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
=20
+/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
+#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
+
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
 static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
+static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
=20
 static const AspeedBoardConfig aspeed_boards[] =3D {
     [PALMETTO_BMC] =3D {
@@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .spi_model =3D "mx66l1g45g",
         .num_cs    =3D 2,
     },
+    [WITHERSPOON_BMC]  =3D {
+        .soc_name  =3D "ast2500-a1",
+        .hw_strap1 =3D WITHERSPOON_BMC_HW_STRAP1,
+        .fmc_model =3D "mx25l25635e",
+        .spi_model =3D "mx66l1g45g",
+        .num_cs    =3D 2,
+        .i2c_init  =3D witherspoon_bmc_i2c_init,
+    },
 };
=20
 #define FIRMWARE_ADDR 0x0
@@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D {
     .class_init =3D romulus_bmc_class_init,
 };
=20
+static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc =3D &bmc->soc;
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423",=
 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423",=
 0x4c);
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105",=
 0x4a);
+}
+
+static void witherspoon_bmc_init(MachineState *machine)
+{
+    aspeed_board_init(machine, &aspeed_boards[WITHERSPOON_BMC]);
+}
+
+static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->desc =3D "OpenPOWER Witherspoon BMC (ARM1176)";
+    mc->init =3D witherspoon_bmc_init;
+    mc->max_cpus =3D 1;
+    mc->no_sdcard =3D 1;
+    mc->no_floppy =3D 1;
+    mc->no_cdrom =3D 1;
+    mc->no_parallel =3D 1;
+    mc->ignore_memory_transaction_failures =3D true;
+}
+
+static const TypeInfo witherspoon_bmc_type =3D {
+    .name =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
+    .parent =3D TYPE_MACHINE,
+    .class_init =3D witherspoon_bmc_class_init,
+};
+
 static void aspeed_machine_init(void)
 {
     type_register_static(&palmetto_bmc_type);
     type_register_static(&ast2500_evb_type);
     type_register_static(&romulus_bmc_type);
+    type_register_static(&witherspoon_bmc_type);
 }
=20
 type_init(aspeed_machine_init)
--=20
2.13.5
