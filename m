Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5v-0004ds-Du
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5s-0001dx-9k
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:07 -0500
Received: from 8.mo53.mail-out.ovh.net ([87.98.185.57]:44617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cbp5s-0001cs-3u
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:04 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id B2D3B38276
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 14:49:02 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Feb 2017 14:47:37 +0100
Message-Id: <1486648058-520-4-git-send-email-clg@kaod.org>
In-Reply-To: <1486648058-520-1-git-send-email-clg@kaod.org>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] aspeed/smc: handle dummies only in fast
 read mode
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

HW works fine in normal read mode with dummy bytes being set. So let's
check this case to not transfer bytes.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 087b29e8da10..70177078a8f2 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -536,10 +536,13 @@ static uint64_t aspeed_smc_flash_read(void *opaque,=
 hwaddr addr, unsigned size)
         /*
          * Use fake transfers to model dummy bytes. The value should
          * be configured to some non-zero value in fast read mode and
-         * zero in read mode.
+         * zero in read mode. But, as the HW allows inconsistent
+         * settings, let's check for fast read mode.
          */
-        for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
-            ssi_transfer(fl->controller->spi, 0xFF);
+        if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
+            for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
+                ssi_transfer(fl->controller->spi, 0xFF);
+            }
         }
=20
         for (i =3D 0; i < size; i++) {
--=20
2.7.4
