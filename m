Received: from eggs.gnu.org ([2001:4830:134:3::10]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uy-0007zJ-50
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8ut-0001Bj-HZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:40 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:48955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8ut-00019O-B9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:35 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C25756408E
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:26 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:11 +0200
Message-Id: <1494827476-1487-2-git-send-email-clg@kaod.org>
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] aspeed/i2c: improve command handling
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

Multiple I2C commands can be fired simultaneously and the controller
execute the commands following these priorities:

  (1) Master Start Command
  (2) Master Transmit Command
  (3) Slave Transmit Command or Master Receive Command
  (4) Master Stop Command

The current code is incorrect with respect to the above sequence and
needs to be reworked to handle each individual command.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ce5b1f0fa493..56a4fdf5c542 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -171,6 +171,7 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwa=
ddr offset,
=20
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
+    bus->cmd &=3D ~0xFFFF;
     bus->cmd |=3D value & 0xFFFF;
     bus->intr_status =3D 0;
=20
@@ -182,15 +183,27 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus =
*bus, uint64_t value)
             bus->intr_status |=3D I2CD_INTR_TX_ACK;
         }
=20
-    } else if (bus->cmd & I2CD_M_TX_CMD) {
+        /* START command is also a TX command, as the slave address is
+         * sent on the bus */
+        bus->cmd &=3D ~(I2CD_M_START_CMD | I2CD_M_TX_CMD);
+
+        /* No slave found */
+        if (!i2c_bus_busy(bus->bus)) {
+            return;
+        }
+    }
+
+    if (bus->cmd & I2CD_M_TX_CMD) {
         if (i2c_send(bus->bus, bus->buf)) {
             bus->intr_status |=3D (I2CD_INTR_TX_NAK | I2CD_INTR_ABNORMAL=
);
             i2c_end_transfer(bus->bus);
         } else {
             bus->intr_status |=3D I2CD_INTR_TX_ACK;
         }
+        bus->cmd &=3D ~I2CD_M_TX_CMD;
+    }
=20
-    } else if (bus->cmd & I2CD_M_RX_CMD) {
+    if (bus->cmd & I2CD_M_RX_CMD) {
         int ret =3D i2c_recv(bus->bus);
         if (ret < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__=
);
@@ -199,6 +212,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *b=
us, uint64_t value)
             bus->intr_status |=3D I2CD_INTR_RX_DONE;
         }
         bus->buf =3D (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_S=
HIFT;
+        bus->cmd &=3D ~I2CD_M_RX_CMD;
     }
=20
     if (bus->cmd & (I2CD_M_STOP_CMD | I2CD_M_S_RX_CMD_LAST)) {
@@ -208,11 +222,8 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
             i2c_end_transfer(bus->bus);
             bus->intr_status |=3D I2CD_INTR_NORMAL_STOP;
         }
+        bus->cmd &=3D ~I2CD_M_STOP_CMD;
     }
-
-    /* command is handled, reset it and check for interrupts  */
-    bus->cmd &=3D ~0xFFFF;
-    aspeed_i2c_bus_raise_interrupt(bus);
 }
=20
 static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
@@ -262,6 +273,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr=
 offset,
         }
=20
         aspeed_i2c_bus_handle_cmd(bus, value);
+        aspeed_i2c_bus_raise_interrupt(bus);
         break;
=20
     default:
--=20
2.7.4
