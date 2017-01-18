Received: from eggs.gnu.org ([2001:4830:134:3::10]:48567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTrkT-0003nm-9a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTrkM-0001ey-MI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:02 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:52040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTrkM-0001eb-Fw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:01:58 -0500
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5C9673CC3B
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:01:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 18 Jan 2017 16:01:41 +0100
Message-Id: <1484751701-2646-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] aspeed/smc: handle dummy bytes when doing
 fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <mar.krzeminski@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When doing fast read, a certain amount of dummy bytes should be sent
before the read. This number is configurable in the controler CE0
Control Register and needs to be modeled using fake transfers to the
flash module.

This only supports command mode. User mode requires more work and a
possible extension of the m25p80 device model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2:

 - handled dummies under read routine and removed the test on the spi
   command READ_FAST (0xb)

 hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index a0a816407fc1..fc3cccec0566 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -69,7 +69,9 @@
 #define R_CTRL0           (0x10 / 4)
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
+#define   CTRL_DUMMY_HIGH_SHIFT    14
 #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
+#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
 #define     CTRL_READMODE          0x0
@@ -490,6 +492,16 @@ static uint32_t aspeed_smc_check_segment_addr(const =
AspeedSMCFlash *fl,
     return addr;
 }
=20
+static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s =3D fl->controller;
+    uint32_t r_ctrl0 =3D s->regs[s->r_ctrl0 + fl->id];
+    uint32_t dummy_high =3D (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
+    uint32_t dummy_low =3D (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
+
+    return ((dummy_high << 2) | dummy_low) * 8;
+}
+
 static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr=
)
 {
     const AspeedSMCState *s =3D fl->controller;
@@ -526,6 +538,15 @@ static uint64_t aspeed_smc_flash_read(void *opaque, =
hwaddr addr, unsigned size)
         aspeed_smc_flash_select(fl);
         aspeed_smc_flash_send_addr(fl, addr);
=20
+        /*
+         * Use fake transfers to model dummy bytes. The value should
+         * be configured to some non-zero value in fast read mode and
+         * zero in read mode.
+         */
+        for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
+            ssi_transfer(fl->controller->spi, 0xFF);
+        }
+
         for (i =3D 0; i < size; i++) {
             ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
         }
--=20
2.7.4
