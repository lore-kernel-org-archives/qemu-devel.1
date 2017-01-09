Received: from eggs.gnu.org ([2001:4830:134:3::10]:45414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclm-00016D-4a
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcli-0004Kq-43
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:02 -0500
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:59019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQclh-0004KH-UV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:58 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8538CD339
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:25:55 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:42 +0100
Message-Id: <1483979087-32663-7-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/11] aspeed/smc: adjust the size of the
 register region
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

The SPI controller of the AST2400 SoC has less registers. So we can
adjust the size of the memory region holding the registers depending
on the controller type. We can also remove the guest_error logging
which is useless as the range of the region is strict enough.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 hw/ssi/aspeed_smc.c         | 25 ++++++++++---------------
 include/hw/ssi/aspeed_smc.h |  1 +
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 1ab5575dc848..7103d0c5b64a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -130,6 +130,9 @@
 #define R_SPI_MISC_CTRL   (0x10 / 4)
 #define R_SPI_TIMINGS     (0x14 / 4)
=20
+#define ASPEED_SMC_R_SPI_MAX (0x20 / 4)
+#define ASPEED_SMC_R_SMC_MAX (0x20 / 4)
+
 #define ASPEED_SOC_SMC_FLASH_BASE   0x10000000
 #define ASPEED_SOC_FMC_FLASH_BASE   0x20000000
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
@@ -185,6 +188,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_SMC_FLASH_BASE,
         .flash_window_size =3D 0x6000000,
         .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_SMC_MAX,
     }, {
         .name              =3D "aspeed.smc.fmc",
         .r_conf            =3D R_CONF,
@@ -197,6 +201,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size =3D 0x10000000,
         .has_dma           =3D true,
+        .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
         .name              =3D "aspeed.smc.spi",
         .r_conf            =3D R_SPI_CONF,
@@ -209,6 +214,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size =3D 0x10000000,
         .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_SPI_MAX,
     }, {
         .name              =3D "aspeed.smc.ast2500-fmc",
         .r_conf            =3D R_CONF,
@@ -221,6 +227,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size =3D 0x10000000,
         .has_dma           =3D true,
+        .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
         .name              =3D "aspeed.smc.ast2500-spi1",
         .r_conf            =3D R_CONF,
@@ -233,6 +240,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size =3D 0x8000000,
         .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_MAX,
     }, {
         .name              =3D "aspeed.smc.ast2500-spi2",
         .r_conf            =3D R_CONF,
@@ -245,6 +253,7 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_base =3D ASPEED_SOC_SPI2_FLASH_BASE,
         .flash_window_size =3D 0x8000000,
         .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_MAX,
     },
 };
=20
@@ -522,13 +531,6 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr=
 addr, unsigned int size)
=20
     addr >>=3D 2;
=20
-    if (addr >=3D ARRAY_SIZE(s->regs)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
-                      __func__, addr);
-        return 0;
-    }
-
     if (addr =3D=3D s->r_conf ||
         addr =3D=3D s->r_timings ||
         addr =3D=3D s->r_ce_ctrl ||
@@ -551,13 +553,6 @@ static void aspeed_smc_write(void *opaque, hwaddr ad=
dr, uint64_t data,
=20
     addr >>=3D 2;
=20
-    if (addr >=3D ARRAY_SIZE(s->regs)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
-                      __func__, addr);
-        return;
-    }
-
     if (addr =3D=3D s->r_conf ||
         addr =3D=3D s->r_timings ||
         addr =3D=3D s->r_ce_ctrl) {
@@ -625,7 +620,7 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)
=20
     /* The memory region for the controller registers */
     memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_ops, s,
-                          s->ctrl->name, ASPEED_SMC_R_MAX * 4);
+                          s->ctrl->name, s->ctrl->nregs * 4);
     sysbus_init_mmio(sbd, &s->mmio);
=20
     /*
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 861120b6e213..e811742728f8 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -45,6 +45,7 @@ typedef struct AspeedSMCController {
     hwaddr flash_window_base;
     uint32_t flash_window_size;
     bool has_dma;
+    uint32_t nregs;
 } AspeedSMCController;
=20
 typedef struct AspeedSMCFlash {
--=20
2.7.4
