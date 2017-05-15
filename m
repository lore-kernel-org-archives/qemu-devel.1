Received: from eggs.gnu.org ([2001:4830:134:3::10]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8vB-0008AP-4M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8v6-0001Ja-LT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:53 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:47462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8v6-0001JP-FN
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:48 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6CA86640D7
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:16 +0200
Message-Id: <1494827476-1487-7-git-send-email-clg@kaod.org>
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] aspeed: add a temp sensor device on I2C
 bus 3
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

Temperatures can be changed from the monitor with :

	(qemu) qom-set /machine/unattached/device[2] temperature0 12000

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e824ea87a9af..155eeb242b8a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -239,10 +239,19 @@ static void aspeed_board_init(MachineState *machine=
,
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
+    DeviceState *dev;
=20
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338",=
 0x68);
+
+    /* add a TMP423 temperature sensor */
+    dev =3D i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
+                           "tmp423", 0x4c);
+    object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_a=
bort);
+    object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_a=
bort);
+    object_property_set_int(OBJECT(dev), 20000, "temperature2", &error_a=
bort);
+    object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_=
abort);
 }
=20
 static void palmetto_bmc_init(MachineState *machine)
--=20
2.7.4
