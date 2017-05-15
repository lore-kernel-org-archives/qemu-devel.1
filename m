Received: from eggs.gnu.org ([2001:4830:134:3::10]:55280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uv-0007xe-RW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uu-0001CT-F4
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:37 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:44316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8uu-0001BV-7k
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:36 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0E69C63AD3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:13 +0200
Message-Id: <1494827476-1487-4-git-send-email-clg@kaod.org>
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] aspeed/i2c: introduce a state machine
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

The Aspeed I2C controller maintains a state machine in the command
register, which is mostly used for debug.

Let's start adding a few states to handle abnormal STOP
commands. Today, the model uses the busy status of the bus as a
condition to do so but it is not precise enough.

Also remove the ABNORMAL bit for failing TX commands. This is
incorrect with respect to the specs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 67004c675359..c762c7366ad9 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -169,6 +169,21 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hw=
addr offset,
     }
 }
=20
+static void aspeed_i2c_set_state(AspeedI2CBus *bus, uint8_t state)
+{
+    bus->cmd &=3D ~(I2CD_TX_STATE_MASK << I2CD_TX_STATE_SHIFT);
+    bus->cmd |=3D (state & I2CD_TX_STATE_MASK) << I2CD_TX_STATE_SHIFT;
+}
+
+static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
+{
+    return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
+}
+
+/*
+ * The state machine needs some refinement. It is only used to track
+ * invalid STOP commands for the moment.
+ */
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
     bus->cmd &=3D ~0xFFFF;
@@ -176,6 +191,11 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
     bus->intr_status =3D 0;
=20
     if (bus->cmd & I2CD_M_START_CMD) {
+        uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
+            I2CD_MSTARTR : I2CD_MSTART;
+
+        aspeed_i2c_set_state(bus, state);
+
         if (i2c_start_transfer(bus->bus, extract32(bus->buf, 1, 7),
                                extract32(bus->buf, 0, 1))) {
             bus->intr_status |=3D I2CD_INTR_TX_NAK;
@@ -191,20 +211,26 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus =
*bus, uint64_t value)
         if (!i2c_bus_busy(bus->bus)) {
             return;
         }
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
=20
     if (bus->cmd & I2CD_M_TX_CMD) {
+        aspeed_i2c_set_state(bus, I2CD_MTXD);
         if (i2c_send(bus->bus, bus->buf)) {
-            bus->intr_status |=3D (I2CD_INTR_TX_NAK | I2CD_INTR_ABNORMAL=
);
+            bus->intr_status |=3D (I2CD_INTR_TX_NAK);
             i2c_end_transfer(bus->bus);
         } else {
             bus->intr_status |=3D I2CD_INTR_TX_ACK;
         }
         bus->cmd &=3D ~I2CD_M_TX_CMD;
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
=20
     if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
-        int ret =3D i2c_recv(bus->bus);
+        int ret;
+
+        aspeed_i2c_set_state(bus, I2CD_MRXD);
+        ret =3D i2c_recv(bus->bus);
         if (ret < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__=
);
             ret =3D 0xff;
@@ -216,16 +242,20 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus =
*bus, uint64_t value)
             i2c_nack(bus->bus);
         }
         bus->cmd &=3D ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
=20
     if (bus->cmd & I2CD_M_STOP_CMD) {
-        if (!i2c_bus_busy(bus->bus)) {
+        if (!(aspeed_i2c_get_state(bus) & I2CD_MACTIVE)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: abnormal stop\n", __func=
__);
             bus->intr_status |=3D I2CD_INTR_ABNORMAL;
         } else {
+            aspeed_i2c_set_state(bus, I2CD_MSTOP);
             i2c_end_transfer(bus->bus);
             bus->intr_status |=3D I2CD_INTR_NORMAL_STOP;
         }
         bus->cmd &=3D ~I2CD_M_STOP_CMD;
+        aspeed_i2c_set_state(bus, I2CD_IDLE);
     }
 }
=20
--=20
2.7.4
