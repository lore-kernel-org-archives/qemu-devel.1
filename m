Received: from eggs.gnu.org ([2001:4830:134:3::10]:47486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5n-0004Wz-MK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5m-0001Zb-S2
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:59 -0500
Received: from 9.mo53.mail-out.ovh.net ([87.98.186.128]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cbp5m-0001U4-MP
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:58 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id 2861F3843C
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 14:48:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Feb 2017 14:47:35 +0100
Message-Id: <1486648058-520-2-git-send-email-clg@kaod.org>
In-Reply-To: <1486648058-520-1-git-send-email-clg@kaod.org>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] aspeed: check for negative values returned
 by blk_getlength()
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

write_boot_rom() does not check for negative values. This is more a
problem for coverity than the actual code as the size of the flash
device is checked when the m25p80 object is created. If there is
anything wrong with the backing file, we should not even reach that
path.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a92c2f1c362b..ac9cbd66b72a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -113,9 +113,19 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr =
addr, size_t rom_size,
 {
     BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
     uint8_t *storage;
+    int64_t size;
=20
-    if (rom_size > blk_getlength(blk)) {
-        rom_size =3D blk_getlength(blk);
+    /* The block backend size should have already been 'validated' by
+     * the creation of the m25p80 object.
+     */
+    size =3D blk_getlength(blk);
+    if (size <=3D 0) {
+        error_setg(errp, "failed to get flash size");
+        return;
+    }
+
+    if (rom_size > size) {
+        rom_size =3D size;
     }
=20
     storage =3D g_new0(uint8_t, rom_size);
--=20
2.7.4
