Received: from eggs.gnu.org ([2001:4830:134:3::10]:45376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclc-0000xR-8h
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclY-0004Hw-Bo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:52 -0500
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:51494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQclY-0004Hg-4q
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:48 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 82350D0D9
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:25:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:41 +0100
Message-Id: <1483979087-32663-6-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/11] aspeed/smc: unfold the
 AspeedSMCController array
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

This is getting difficult to read. Also add a 'has_dma' field for each
controller type.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/ssi/aspeed_smc.c         | 91 ++++++++++++++++++++++++++++++++++++---=
------
 include/hw/ssi/aspeed_smc.h |  1 +
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index d62221a6de58..1ab5575dc848 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -173,24 +173,79 @@ static const AspeedSegments aspeed_segments_ast2500=
_spi2[] =3D {
 };
=20
 static const AspeedSMCController controllers[] =3D {
-    { "aspeed.smc.smc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 5, aspeed_segments_legacy,
-      ASPEED_SOC_SMC_FLASH_BASE, 0x6000000 },
-    { "aspeed.smc.fmc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 5, aspeed_segments_fmc,
-      ASPEED_SOC_FMC_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.spi", R_SPI_CONF, 0xff, R_SPI_CTRL0, R_SPI_TIMINGS,
-      SPI_CONF_ENABLE_W0, 1, aspeed_segments_spi,
-      ASPEED_SOC_SPI_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.ast2500-fmc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 3, aspeed_segments_ast2500_fmc,
-      ASPEED_SOC_FMC_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.ast2500-spi1", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 2, aspeed_segments_ast2500_spi1,
-      ASPEED_SOC_SPI_FLASH_BASE, 0x8000000 },
-    { "aspeed.smc.ast2500-spi2", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 2, aspeed_segments_ast2500_spi2,
-      ASPEED_SOC_SPI2_FLASH_BASE, 0x8000000 },
+    {
+        .name              =3D "aspeed.smc.smc",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 5,
+        .segments          =3D aspeed_segments_legacy,
+        .flash_window_base =3D ASPEED_SOC_SMC_FLASH_BASE,
+        .flash_window_size =3D 0x6000000,
+        .has_dma           =3D false,
+    }, {
+        .name              =3D "aspeed.smc.fmc",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 5,
+        .segments          =3D aspeed_segments_fmc,
+        .flash_window_base =3D ASPEED_SOC_FMC_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D true,
+    }, {
+        .name              =3D "aspeed.smc.spi",
+        .r_conf            =3D R_SPI_CONF,
+        .r_ce_ctrl         =3D 0xff,
+        .r_ctrl0           =3D R_SPI_CTRL0,
+        .r_timings         =3D R_SPI_TIMINGS,
+        .conf_enable_w0    =3D SPI_CONF_ENABLE_W0,
+        .max_slaves        =3D 1,
+        .segments          =3D aspeed_segments_spi,
+        .flash_window_base =3D ASPEED_SOC_SPI_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D false,
+    }, {
+        .name              =3D "aspeed.smc.ast2500-fmc",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 3,
+        .segments          =3D aspeed_segments_ast2500_fmc,
+        .flash_window_base =3D ASPEED_SOC_FMC_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D true,
+    }, {
+        .name              =3D "aspeed.smc.ast2500-spi1",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 2,
+        .segments          =3D aspeed_segments_ast2500_spi1,
+        .flash_window_base =3D ASPEED_SOC_SPI_FLASH_BASE,
+        .flash_window_size =3D 0x8000000,
+        .has_dma           =3D false,
+    }, {
+        .name              =3D "aspeed.smc.ast2500-spi2",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 2,
+        .segments          =3D aspeed_segments_ast2500_spi2,
+        .flash_window_base =3D ASPEED_SOC_SPI2_FLASH_BASE,
+        .flash_window_size =3D 0x8000000,
+        .has_dma           =3D false,
+    },
 };
=20
 /*
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index bdfbcc0ffa7d..861120b6e213 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -44,6 +44,7 @@ typedef struct AspeedSMCController {
     const AspeedSegments *segments;
     hwaddr flash_window_base;
     uint32_t flash_window_size;
+    bool has_dma;
 } AspeedSMCController;
=20
 typedef struct AspeedSMCFlash {
--=20
2.7.4
