Received: from eggs.gnu.org ([2001:4830:134:3::10]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGgT-0002BN-1K
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGgP-0006Mk-Tu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:27:21 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duGgP-0006Lp-Mo
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:27:17 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6DF70632BF
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:27:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Sep 2017 13:26:43 +0200
Message-Id: <20170919112645.8574-4-clg@kaod.org>
In-Reply-To: <20170919112645.8574-1-clg@kaod.org>
References: <20170919112645.8574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Aspeed boards have at least one EEPROM to hold the Vital Product
Data (VPD).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 362b683e9021..3e74970d7ad2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -251,6 +251,17 @@ static void aspeed_board_init(MachineState *machine,
     arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
 }
=20
+static void aspeed_i2c_add_eeprom(I2CBus *bus, uint8_t address, size_t s=
ize)
+{
+    uint8_t *eeprom_buf =3D g_malloc0(size);
+    DeviceState *dev;
+
+    dev =3D qdev_create((BusState *) bus, "smbus-eeprom");
+    qdev_prop_set_uint8(dev, "address", address);
+    qdev_prop_set_ptr(dev, "data", eeprom_buf);
+    qdev_init_nofail(dev);
+}
+
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -260,6 +271,9 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *b=
mc)
      * enough to provide basic RTC features. Alarms will be missing */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338",=
 0x68);
=20
+    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50=
,
+                          256 * 1024);
+
     /* add a TMP423 temperature sensor */
     dev =3D i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
                            "tmp423", 0x4c);
@@ -298,6 +312,9 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bm=
c)
 {
     AspeedSoCState *soc =3D &bmc->soc;
=20
+    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50=
,
+                          8 * 1024);
+
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x4d);
=20
@@ -377,6 +394,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 i=
s
      * good enough */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
+
+    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x5=
1,
+                          8 * 1024);
 }
=20
 static void witherspoon_bmc_init(MachineState *machine)
--=20
2.13.5
