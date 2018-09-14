Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhc-0003PW-Hv
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhZ-0003wi-6E
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:40 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:33305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g0hhY-0003uv-SQ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:37 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.18])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2523724C6E
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 08:35:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Sep 2018 08:35:05 +0200
Message-Id: <20180914063506.20815-3-clg@kaod.org>
In-Reply-To: <20180914063506.20815-1-clg@kaod.org>
References: <20180914063506.20815-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] aspeed/i2c: Handle receive command in
 separate function
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

Receive command handling may have to be deferred if a previous receive
done interrupt was not yet acknowledged. Move receive command handling
into a separate function to prepare for the necessary changes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index de6b08378675..d81f86587af7 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -192,6 +192,26 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bu=
s)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
=20
+static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
+{
+    int ret;
+
+    aspeed_i2c_set_state(bus, I2CD_MRXD);
+    ret =3D i2c_recv(bus->bus);
+    if (ret < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
+        ret =3D 0xff;
+    } else {
+        bus->intr_status |=3D I2CD_INTR_RX_DONE;
+    }
+    bus->buf =3D (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT=
;
+    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
+        i2c_nack(bus->bus);
+    }
+    bus->cmd &=3D ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
+    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -238,22 +258,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
     }
=20
     if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
-        int ret;
-
-        aspeed_i2c_set_state(bus, I2CD_MRXD);
-        ret =3D i2c_recv(bus->bus);
-        if (ret < 0) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__=
);
-            ret =3D 0xff;
-        } else {
-            bus->intr_status |=3D I2CD_INTR_RX_DONE;
-        }
-        bus->buf =3D (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_S=
HIFT;
-        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
-            i2c_nack(bus->bus);
-        }
-        bus->cmd &=3D ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
-        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
+        aspeed_i2c_handle_rx_cmd(bus);
     }
=20
     if (bus->cmd & I2CD_M_STOP_CMD) {
--=20
2.17.1
