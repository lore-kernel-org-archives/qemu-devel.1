Received: from eggs.gnu.org ([2001:4830:134:3::10]:50047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhj-0003Uy-4f
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhf-00045M-Uo
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:47 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:60099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g0hhf-00043r-Jf
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:43 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.5])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 57607D834B
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 08:35:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Sep 2018 08:35:06 +0200
Message-Id: <20180914063506.20815-4-clg@kaod.org>
In-Reply-To: <20180914063506.20815-1-clg@kaod.org>
References: <20180914063506.20815-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] aspeed/i2c: Fix receive done interrupt
 handling
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

From: Guenter Roeck <linux@roeck-us.net>

The AST2500 datasheet says:

I2CD10 Interrupt Status Register
       bit 2 Receive Done Interrupt status
             S/W needs to clear this status bit to allow next data receiv=
ing

The Rx interrrupt done interrupt status bit needs to be cleared
explicitly before the next byte can be received, and must therefore
not be auto-cleared. Also, receiving the next byte must be delayed
until the bit has been cleared.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index d81f86587af7..7ae99bc8baec 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -257,7 +257,8 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *b=
us, uint64_t value)
         aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
=20
-    if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
+    if ((bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) &&
+        !(bus->intr_status & I2CD_INTR_RX_DONE)) {
         aspeed_i2c_handle_rx_cmd(bus);
     }
=20
@@ -279,6 +280,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr=
 offset,
                                  uint64_t value, unsigned size)
 {
     AspeedI2CBus *bus =3D opaque;
+    bool handle_rx;
=20
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
@@ -299,11 +301,17 @@ static void aspeed_i2c_bus_write(void *opaque, hwad=
dr offset,
         bus->intr_ctrl =3D value & 0x7FFF;
         break;
     case I2CD_INTR_STS_REG:
+        handle_rx =3D (bus->intr_status & I2CD_INTR_RX_DONE) &&
+                (value & I2CD_INTR_RX_DONE);
         bus->intr_status &=3D ~(value & 0x7FFF);
         if (!bus->intr_status) {
             bus->controller->intr_status &=3D ~(1 << bus->id);
             qemu_irq_lower(bus->controller->irq);
         }
+        if (handle_rx && (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LA=
ST))) {
+            aspeed_i2c_handle_rx_cmd(bus);
+            aspeed_i2c_bus_raise_interrupt(bus);
+        }
         break;
     case I2CD_DEV_ADDR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
--=20
2.17.1
