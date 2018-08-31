Received: from eggs.gnu.org ([208.118.235.92]:37358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvhVt-0005Hg-Hm
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvhPX-0004eB-8H
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:16:23 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:56024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvhPX-0004dw-1Q
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:16:19 -0400
Received: from player714.ha.ovh.net (unknown [10.109.143.238])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D6685C07FF
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 13:16:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 13:15:55 +0200
Message-Id: <20180831111555.15008-2-clg@kaod.org>
In-Reply-To: <20180831111555.15008-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831111555.15008-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/11] aspeed/smc: Add dummy data register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The SMC controllers have a register containing the byte that will be
used as dummy output. It can be modified by software.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index da2fedfcd3cd..f31bbc895caa 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -102,8 +102,8 @@
 /* Misc Control Register #1 */
 #define R_MISC_CTRL1      (0x50 / 4)
=20
-/* Misc Control Register #2 */
-#define R_MISC_CTRL2      (0x54 / 4)
+/* SPI dummy cycle data */
+#define R_DUMMY_DATA      (0x54 / 4)
=20
 /* DMA Control/Status Register */
 #define R_DMA_CTRL        (0x80 / 4)
@@ -548,7 +548,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl=
, uint32_t addr)
      */
     if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
         for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
-            ssi_transfer(fl->controller->spi, 0xFF);
+            ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0x=
ff);
         }
     }
 }
@@ -680,6 +680,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
         addr =3D=3D s->r_timings ||
         addr =3D=3D s->r_ce_ctrl ||
         addr =3D=3D R_INTR_CTRL ||
+        addr =3D=3D R_DUMMY_DATA ||
         (s->ctrl->has_dma && addr =3D=3D R_DMA_CTRL) ||
         (s->ctrl->has_dma && addr =3D=3D R_DMA_FLASH_ADDR) ||
         (s->ctrl->has_dma && addr =3D=3D R_DMA_DRAM_ADDR) ||
@@ -912,6 +913,8 @@ static void aspeed_smc_write(void *opaque, hwaddr add=
r, uint64_t data,
         }
     } else if (addr =3D=3D R_INTR_CTRL) {
         s->regs[addr] =3D value;
+    } else if (addr =3D=3D R_DUMMY_DATA) {
+        s->regs[addr] =3D value & 0xff ;
     } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_CTRL) {
         aspeed_smc_dma_ctrl(s, value);
     } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_DRAM_ADDR) {
--=20
2.17.1
