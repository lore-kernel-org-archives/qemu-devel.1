Received: from eggs.gnu.org ([2001:4830:134:3::10]:49875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhV-0003Mu-Lc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhS-0003mF-DN
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:33 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:36803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g0hhS-0003iS-1S
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:30 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.220])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C33A211D225
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 08:35:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Sep 2018 08:35:04 +0200
Message-Id: <20180914063506.20815-2-clg@kaod.org>
In-Reply-To: <20180914063506.20815-1-clg@kaod.org>
References: <20180914063506.20815-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] aspeed/i2c: interrupts should be cleared
 by software only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

and the bus interrupt should be lowered when all interrupts have been
cleared. Also, the model does not implement correctly the RX_DONE bit
behavior which should be cleared to allow more data to be received.
Yet to be fixed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index c762c7366ad9..de6b08378675 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -52,6 +52,13 @@
 #define I2CD_AC_TIMING_REG2     0x08       /* Clock and AC Timing Contro=
l #1 */
 #define I2CD_INTR_CTRL_REG      0x0c       /* I2CD Interrupt Control */
 #define I2CD_INTR_STS_REG       0x10       /* I2CD Interrupt Status */
+
+#define   I2CD_INTR_SLAVE_ADDR_MATCH       (0x1 << 31) /* 0: addr1 1: ad=
dr2 */
+#define   I2CD_INTR_SLAVE_ADDR_RX_PENDING  (0x1 << 30)
+/* bits[19-16] Reserved */
+
+/* All bits below are cleared by writing 1 */
+#define   I2CD_INTR_SLAVE_INACTIVE_TIMEOUT (0x1 << 15)
 #define   I2CD_INTR_SDA_DL_TIMEOUT         (0x1 << 14)
 #define   I2CD_INTR_BUS_RECOVER_DONE       (0x1 << 13)
 #define   I2CD_INTR_SMBUS_ALERT            (0x1 << 12) /* Bus [0-3] only=
 */
@@ -59,11 +66,16 @@
 #define   I2CD_INTR_SMBUS_DEV_ALERT_ADDR   (0x1 << 10) /* Removed */
 #define   I2CD_INTR_SMBUS_DEF_ADDR         (0x1 << 9)  /* Removed */
 #define   I2CD_INTR_GCALL_ADDR             (0x1 << 8)  /* Removed */
-#define   I2CD_INTR_SLAVE_MATCH            (0x1 << 7)  /* use RX_DONE */
+#define   I2CD_INTR_SLAVE_ADDR_RX_MATCH    (0x1 << 7)  /* use RX_DONE */
 #define   I2CD_INTR_SCL_TIMEOUT            (0x1 << 6)
 #define   I2CD_INTR_ABNORMAL               (0x1 << 5)
 #define   I2CD_INTR_NORMAL_STOP            (0x1 << 4)
 #define   I2CD_INTR_ARBIT_LOSS             (0x1 << 3)
+
+/*
+ * TODO: handle correctly I2CD_INTR_RX_DONE which needs to be cleared
+ * to allow next data to be received.
+ */
 #define   I2CD_INTR_RX_DONE                (0x1 << 2)
 #define   I2CD_INTR_TX_NAK                 (0x1 << 1)
 #define   I2CD_INTR_TX_ACK                 (0x1 << 0)
@@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *b=
us, uint64_t value)
 {
     bus->cmd &=3D ~0xFFFF;
     bus->cmd |=3D value & 0xFFFF;
-    bus->intr_status =3D 0;
=20
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
@@ -284,8 +295,10 @@ static void aspeed_i2c_bus_write(void *opaque, hwadd=
r offset,
         break;
     case I2CD_INTR_STS_REG:
         bus->intr_status &=3D ~(value & 0x7FFF);
-        bus->controller->intr_status &=3D ~(1 << bus->id);
-        qemu_irq_lower(bus->controller->irq);
+        if (!bus->intr_status) {
+            bus->controller->intr_status &=3D ~(1 << bus->id);
+            qemu_irq_lower(bus->controller->irq);
+        }
         break;
     case I2CD_DEV_ADDR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
--=20
2.17.1
