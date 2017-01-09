Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcmT-00025O-P0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcmP-0004X9-P5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:45 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:40118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQcmP-0004Ws-Jm
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:41 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4E697AD77
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:26:40 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:47 +0100
Message-Id: <1483979087-32663-12-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes when
 doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When doing fast read, a certain amount of dummy bytes should be sent
before the read. This number is configurable in the controler CE0
Control Register and needs to be modeled using fake transfers the
flash module.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

 Changes since v1:

 - splitted user mode from command mode support.

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 28d563a5800f..7a76d3344df2 100644
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
@@ -141,6 +143,7 @@
=20
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
+#define SPI_OP_READ_FAST  0x0b    /* Read data bytes (high frequency) */
=20
 /*
  * Default segments mapping addresses and size for each slave per
@@ -490,10 +493,21 @@ static uint32_t aspeed_smc_check_segment_addr(const=
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
     uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
+    int i;
=20
     /* Flash access can not exceed CS segment */
     addr =3D aspeed_smc_check_segment_addr(fl, addr);
@@ -506,6 +520,13 @@ static void aspeed_smc_flash_send_addr(AspeedSMCFlas=
h *fl, uint32_t addr)
     ssi_transfer(s->spi, (addr >> 16) & 0xff);
     ssi_transfer(s->spi, (addr >> 8) & 0xff);
     ssi_transfer(s->spi, (addr & 0xff));
+
+    /* Handle dummies in case of fast read */
+    if (cmd =3D=3D SPI_OP_READ_FAST) {
+        for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
+            ssi_transfer(fl->controller->spi, 0xFF);
+        }
+    }
 }
=20
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigne=
d size)
--=20
2.7.4
