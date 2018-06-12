Received: from eggs.gnu.org ([2001:4830:134:3::10]:33502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFS-0004h9-Pl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFP-0001dj-MX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:46 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:44311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSdFP-0001d1-Fq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:43 -0400
Received: from player797.ha.ovh.net (unknown [10.109.120.5])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id DB40D1BADC7
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:57:41 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 12 Jun 2018 08:57:15 +0200
Message-Id: <20180612065716.10587-3-clg@kaod.org>
In-Reply-To: <20180612065716.10587-1-clg@kaod.org>
References: <20180612065716.10587-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] aspeed/smc: fix HW strapping
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

Only the flash type is strapped by HW. The 4BYTE mode is set by
firmware when the flash device is detected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index fce126e6ee92..b15370893583 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -639,23 +639,17 @@ static void aspeed_smc_reset(DeviceState *d)
             aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
     }
=20
-    /* HW strapping for AST2500 FMC controllers  */
+    /* HW strapping flash type for FMC controllers  */
     if (s->ctrl->segments =3D=3D aspeed_segments_ast2500_fmc) {
         /* flash type is fixed to SPI for CE0 and CE1 */
         s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
         s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1=
);
-
-        /* 4BYTE mode is autodetected for CE0. Let's force it to 1 for
-         * now */
-        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
     }
=20
     /* HW strapping for AST2400 FMC controllers (SCU70). Let's use the
      * configuration of the palmetto-bmc machine */
     if (s->ctrl->segments =3D=3D aspeed_segments_fmc) {
         s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
-
-        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
     }
 }
=20
--=20
2.13.6
