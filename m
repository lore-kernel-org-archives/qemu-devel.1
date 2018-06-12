Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFZ-0004nK-Du
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFW-0001gm-AF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:53 -0400
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSdFW-0001fx-2z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:50 -0400
Received: from player797.ha.ovh.net (unknown [10.109.120.78])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1D284B2763
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:57:48 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 12 Jun 2018 08:57:16 +0200
Message-Id: <20180612065716.10587-4-clg@kaod.org>
In-Reply-To: <20180612065716.10587-1-clg@kaod.org>
References: <20180612065716.10587-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] aspeed/smc: rename
 aspeed_smc_flash_send_addr() to aspeed_smc_flash_setup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Also handle the fake transfers for dummy bytes in this setup
routine. It will be useful when we activate MMIO execution.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index b15370893583..b29bfd3124a9 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -503,10 +503,11 @@ static int aspeed_smc_flash_dummies(const AspeedSMC=
Flash *fl)
     return dummies;
 }
=20
-static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr=
)
+static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
 {
     const AspeedSMCState *s =3D fl->controller;
     uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
+    int i;
=20
     /* Flash access can not exceed CS segment */
     addr =3D aspeed_smc_check_segment_addr(fl, addr);
@@ -519,6 +520,18 @@ static void aspeed_smc_flash_send_addr(AspeedSMCFlas=
h *fl, uint32_t addr)
     ssi_transfer(s->spi, (addr >> 16) & 0xff);
     ssi_transfer(s->spi, (addr >> 8) & 0xff);
     ssi_transfer(s->spi, (addr & 0xff));
+
+    /*
+     * Use fake transfers to model dummy bytes. The value should
+     * be configured to some non-zero value in fast read mode and
+     * zero in read mode. But, as the HW allows inconsistent
+     * settings, let's check for fast read mode.
+     */
+    if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
+        for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
+                ssi_transfer(fl->controller->spi, 0xFF);
+        }
+    }
 }
=20
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigne=
d size)
@@ -537,19 +550,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, =
hwaddr addr, unsigned size)
     case CTRL_READMODE:
     case CTRL_FREADMODE:
         aspeed_smc_flash_select(fl);
-        aspeed_smc_flash_send_addr(fl, addr);
-
-        /*
-         * Use fake transfers to model dummy bytes. The value should
-         * be configured to some non-zero value in fast read mode and
-         * zero in read mode. But, as the HW allows inconsistent
-         * settings, let's check for fast read mode.
-         */
-        if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
-            for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
-                ssi_transfer(fl->controller->spi, 0xFF);
-            }
-        }
+        aspeed_smc_flash_setup(fl, addr);
=20
         for (i =3D 0; i < size; i++) {
             ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
@@ -586,7 +587,7 @@ static void aspeed_smc_flash_write(void *opaque, hwad=
dr addr, uint64_t data,
         break;
     case CTRL_WRITEMODE:
         aspeed_smc_flash_select(fl);
-        aspeed_smc_flash_send_addr(fl, addr);
+        aspeed_smc_flash_setup(fl, addr);
=20
         for (i =3D 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
--=20
2.13.6
