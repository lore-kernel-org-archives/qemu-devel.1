Received: from eggs.gnu.org ([2001:4830:134:3::10]:54517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoS-0007tK-Ga
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoM-00009p-GJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:20 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSoM-00009D-9x
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:14 -0400
Received: from player738.ha.ovh.net (unknown [10.109.108.77])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id BD535160540
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:01:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:41 +0200
Message-Id: <20180614140043.9231-5-clg@kaod.org>
In-Reply-To: <20180614140043.9231-1-clg@kaod.org>
References: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] ppc/pnv: introduce a
 pnv_chip_core_realize() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This extracts from the PvChip realize routine the part creating the
cores. On Power9, we will need to create the cores after the Xive
interrupt controller is created.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 72cfe4c2627c..b3b0dd44582f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -822,9 +822,8 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error=
 **errp)
     }
 }
=20
-static void pnv_chip_realize(DeviceState *dev, Error **errp)
+static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 {
-    PnvChip *chip =3D PNV_CHIP(dev);
     Error *error =3D NULL;
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     const char *typename =3D pnv_chip_core_typename(chip);
@@ -836,14 +835,6 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
-    /* XSCOM bridge */
-    pnv_xscom_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
-
     /* Cores */
     pnv_chip_core_sanitize(chip, &error);
     if (error) {
@@ -891,6 +882,27 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
                                 &PNV_CORE(pnv_core)->xscom_regs);
         i++;
     }
+}
+
+static void pnv_chip_realize(DeviceState *dev, Error **errp)
+{
+    PnvChip *chip =3D PNV_CHIP(dev);
+    Error *error =3D NULL;
+
+    /* XSCOM bridge */
+    pnv_xscom_realize(chip, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
+
+    /* Cores */
+    pnv_chip_core_realize(chip, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
=20
     /* Create LPC controller */
     object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
--=20
2.13.6
