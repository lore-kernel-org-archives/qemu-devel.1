Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5n-0004Wy-4R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5m-0001Z6-47
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:59 -0500
Received: from 10.mo53.mail-out.ovh.net ([87.98.189.210]:40663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cbp5l-0001Yn-V3
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:58 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id DB58B2AA29
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 14:48:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Feb 2017 14:47:36 +0100
Message-Id: <1486648058-520-3-git-send-email-clg@kaod.org>
In-Reply-To: <1486648058-520-1-git-send-email-clg@kaod.org>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] aspeed: remove useless comment on
 controller segment size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The flash devices used for the FMC controller (BMC firmware) are well
defined for each Aspeed machine and are all smaller than the default
mapping window size, at least for CE0 which is the chip the SoC boots
from.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ac9cbd66b72a..283c03881493 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -148,10 +148,6 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
         DriveInfo *dinfo =3D drive_get_next(IF_MTD);
         qemu_irq cs_line;
=20
-        /*
-         * FIXME: check that we are not using a flash module exceeding
-         * the controller segment size
-         */
         fl->flash =3D ssi_create_slave_no_init(s->spi, flashtype);
         if (dinfo) {
             qdev_prop_set_drive(fl->flash, "drive", blk_by_legacy_dinfo(=
dinfo),
@@ -210,7 +206,9 @@ static void aspeed_board_init(MachineState *machine,
=20
         /*
          * create a ROM region using the default mapping window size of
-         * the flash module.
+         * the flash module. The window size is 64MB for the AST2400
+         * SoC and 128MB for the AST2500 SoC, which is twice as big as
+         * needed by the flash modules of the Aspeed machines.
          */
         memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
                                fl->size, &error_abort);
--=20
2.7.4
