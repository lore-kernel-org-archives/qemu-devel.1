Received: from eggs.gnu.org ([2001:4830:134:3::10]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uv-0007xc-2N
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uq-0001AV-Ij
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:37 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:43053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8uq-00019x-Cl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:32 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E380964085
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:30 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:12 +0200
Message-Id: <1494827476-1487-3-git-send-email-clg@kaod.org>
In-Reply-To: <1494827476-1487-1-git-send-email-clg@kaod.org>
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] aspeed/i2c: handle LAST command under the
 RX command
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

Today, the LAST command is handled with the STOP command but this is
incorrect. Also nack the I2C bus when a LAST is issued.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 56a4fdf5c542..67004c675359 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -203,7 +203,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *b=
us, uint64_t value)
         bus->cmd &=3D ~I2CD_M_TX_CMD;
     }
=20
-    if (bus->cmd & I2CD_M_RX_CMD) {
+    if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
         int ret =3D i2c_recv(bus->bus);
         if (ret < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__=
);
@@ -212,10 +212,13 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus =
*bus, uint64_t value)
             bus->intr_status |=3D I2CD_INTR_RX_DONE;
         }
         bus->buf =3D (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_S=
HIFT;
-        bus->cmd &=3D ~I2CD_M_RX_CMD;
+        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
+            i2c_nack(bus->bus);
+        }
+        bus->cmd &=3D ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
     }
=20
-    if (bus->cmd & (I2CD_M_STOP_CMD | I2CD_M_S_RX_CMD_LAST)) {
+    if (bus->cmd & I2CD_M_STOP_CMD) {
         if (!i2c_bus_busy(bus->bus)) {
             bus->intr_status |=3D I2CD_INTR_ABNORMAL;
         } else {
--=20
2.7.4
