Received: from eggs.gnu.org ([2001:4830:134:3::10]:34792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNunu-0002Ys-4E
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNunq-0001EG-5Y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:50 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:50896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNunp-0001Dh-VX
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:46 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.46])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 76C8116BD1
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:41:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:40:47 +0200
Message-Id: <20180530064049.27976-6-clg@kaod.org>
In-Reply-To: <20180530064049.27976-1-clg@kaod.org>
References: <20180530064049.27976-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 5/7] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Aspeed boards have at least one EEPROM to hold the Vital Product
Data (VPD).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8efa783722c5..2ad94b494ed2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -17,6 +17,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
+#include "hw/i2c/smbus.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
@@ -264,11 +265,15 @@ static void palmetto_bmc_i2c_init(AspeedBoardState =
*bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
     DeviceState *dev;
+    uint8_t *eeprom_buf =3D g_malloc0(32 * 1024);
=20
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338",=
 0x68);
=20
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50=
,
+                          eeprom_buf);
+
     /* add a TMP423 temperature sensor */
     dev =3D i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
                            "tmp423", 0x4c);
@@ -305,6 +310,10 @@ static const TypeInfo palmetto_bmc_type =3D {
 static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
+    uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50=
,
+                          eeprom_buf);
=20
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x4d);
@@ -374,6 +383,7 @@ static const TypeInfo romulus_bmc_type =3D {
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
+    uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
=20
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423",=
 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423",=
 0x4c);
@@ -384,6 +394,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 i=
s
      * good enough */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x5=
1,
+                          eeprom_buf);
 }
=20
 static void witherspoon_bmc_init(MachineState *machine)
--=20
2.13.6
