Received: from eggs.gnu.org ([209.51.188.92]:54260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRk-0000p3-5k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRj-0006bz-4F
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:36 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:05 +0200
Message-Id: <20190412165416.7977-2-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/12] hw/arm/aspeed: Use
 TYPE_TMP105/TYPE_PCA9552 instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 996812498dc..1c23ebd9925 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -19,6 +19,8 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/misc/pca9552.h"
+#include "hw/misc/tmp105.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
@@ -267,7 +269,8 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bm=
c)
                           eeprom_buf);
=20
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x4d);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7),
+                     TYPE_TMP105, 0x4d);
=20
     /* The AST2500 EVB does not have an RTC. Let's pretend that one is
      * plugged on the I2C bus header */
@@ -288,13 +291,15 @@ static void witherspoon_bmc_i2c_init(AspeedBoardSta=
te *bmc)
     AspeedSoCState *soc =3D &bmc->soc;
     uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
=20
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552"=
, 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9=
552,
+                     0x60);
=20
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423",=
 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423",=
 0x4c);
=20
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105",=
 0x4a);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_TMP1=
05,
+                     0x4a);
=20
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 i=
s
      * good enough */
@@ -302,7 +307,7 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
=20
     smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x5=
1,
                           eeprom_buf);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9552=
",
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA=
9552,
                      0x60);
 }
=20
--=20
2.20.1
