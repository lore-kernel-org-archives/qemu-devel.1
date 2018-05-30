Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvsF-00064l-UQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvsB-00019s-R5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:23 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:59289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNvsB-00019W-Ci
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:19 -0400
Received: from player770.ha.ovh.net (unknown [10.109.108.61])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C525B15B8E7
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 09:50:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 09:49:59 +0200
Message-Id: <20180530075002.4618-2-clg@kaod.org>
In-Reply-To: <20180530075002.4618-1-clg@kaod.org>
References: <20180530075002.4618-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] aspeed/smc: fix HW strapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Only the flash type is strapped by HW. The 4BYTE mode is set by
firmware when the flash device is detected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5059396bc623..f33ec87fcb74 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -632,23 +632,17 @@ static void aspeed_smc_reset(DeviceState *d)
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
