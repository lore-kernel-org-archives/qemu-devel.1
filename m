Received: from eggs.gnu.org ([2001:4830:134:3::10]:45340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclT-0000oZ-G0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclP-0004Fw-FE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:43 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:50333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQclO-0004Fa-V6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:39 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 727BAD1F4
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:25:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:40 +0100
Message-Id: <1483979087-32663-5-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/11] aspeed/smc: autostrap CE0/1
 configuration
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

On the AST2500 SoC, the FMC controller flash type is fixed to SPI for
CE0 and CE1 and 4BYTE mode is autodetected for CE0.

On the AST2400 SoC, the FMC controller flash type and 4BYTE mode are
strapped with register SCU70. We use the default settings from the
palmetto-bmc machine for now.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/ssi/aspeed_smc.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

 Changes since v1:

 - splitted ast2400 from ast2500 strapping as they should be handled
   in a different way. ast2400 strapping should be derived from SCU70
   but it seems a little overly complex to do it now.

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9b31d5d27012..3bd381b13bc2 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -39,11 +39,14 @@
 #define   CONF_ENABLE_W2       18
 #define   CONF_ENABLE_W1       17
 #define   CONF_ENABLE_W0       16
-#define   CONF_FLASH_TYPE4     9
-#define   CONF_FLASH_TYPE3     7
-#define   CONF_FLASH_TYPE2     5
-#define   CONF_FLASH_TYPE1     3
-#define   CONF_FLASH_TYPE0     1
+#define   CONF_FLASH_TYPE4     8
+#define   CONF_FLASH_TYPE3     6
+#define   CONF_FLASH_TYPE2     4
+#define   CONF_FLASH_TYPE1     2
+#define   CONF_FLASH_TYPE0     0
+#define      CONF_FLASH_TYPE_NOR   0x0
+#define      CONF_FLASH_TYPE_NAND  0x1
+#define      CONF_FLASH_TYPE_SPI   0x2
=20
 /* CE Control Register */
 #define R_CE_CTRL            (0x04 / 4)
@@ -436,6 +439,25 @@ static void aspeed_smc_reset(DeviceState *d)
         s->regs[R_SEG_ADDR0 + i] =3D
             aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
     }
+
+    /* HW strapping for AST2500 FMC controllers  */
+    if (s->ctrl->segments =3D=3D aspeed_segments_ast2500_fmc) {
+        /* flash type is fixed to SPI for CE0 and CE1 */
+        s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
+        s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1=
);
+
+        /* 4BYTE mode is autodetected for CE0. Let's force it to 1 for
+         * now */
+        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
+    }
+
+    /* HW strapping for AST2400 FMC controllers (SCU70). Let's use the
+     * configuration of the palmetto-bmc machine */
+    if (s->ctrl->segments =3D=3D aspeed_segments_fmc) {
+        s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
+
+        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
+    }
 }
=20
 static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int =
size)
--=20
2.7.4
