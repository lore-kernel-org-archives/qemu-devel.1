Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFM-0004ZQ-P0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFJ-0001b0-Gk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:40 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:46940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSdFJ-0001aA-9Y
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:37 -0400
Received: from player797.ha.ovh.net (unknown [10.109.105.109])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id A29FEB635E
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:57:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 12 Jun 2018 08:57:14 +0200
Message-Id: <20180612065716.10587-2-clg@kaod.org>
In-Reply-To: <20180612065716.10587-1-clg@kaod.org>
References: <20180612065716.10587-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] aspeed/smc: fix dummy cycles count when in
 dual IO mode
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

When configured in dual I/O mode, address and data are sent in dual
mode, including the dummy byte cycles in between. Adapt the count to
the IO setting.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5059396bc623..fce126e6ee92 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -66,6 +66,8 @@
=20
 /* CEx Control Register */
 #define R_CTRL0           (0x10 / 4)
+#define   CTRL_IO_DUAL_DATA        (1 << 29)
+#define   CTRL_IO_DUAL_ADDR_DATA   (1 << 28) /* Includes dummies */
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
 #define   CTRL_DUMMY_HIGH_SHIFT    14
@@ -492,8 +494,13 @@ static int aspeed_smc_flash_dummies(const AspeedSMCF=
lash *fl)
     uint32_t r_ctrl0 =3D s->regs[s->r_ctrl0 + fl->id];
     uint32_t dummy_high =3D (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
     uint32_t dummy_low =3D (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
+    uint32_t dummies =3D ((dummy_high << 2) | dummy_low) * 8;
=20
-    return ((dummy_high << 2) | dummy_low) * 8;
+    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
+        dummies /=3D 2;
+    }
+
+    return dummies;
 }
=20
 static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr=
)
--=20
2.13.6
