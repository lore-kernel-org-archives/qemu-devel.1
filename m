Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEf-0005Sw-Gh
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEd-00047c-Fs
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:22 +1000
Message-Id: <20180618035324.19907-27-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/28] ppc/pnv: introduce a
 pnv_chip_core_realize() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This extracts from the PvChip realize routine the part creating the
cores. On Power9, we will need to create the cores after the Xive
interrupt controller is created.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b9508d94d..0d2b79f798 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -849,9 +849,8 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error=
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
@@ -863,14 +862,6 @@ static void pnv_chip_realize(DeviceState *dev, Error=
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
@@ -918,6 +909,27 @@ static void pnv_chip_realize(DeviceState *dev, Error=
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
2.17.1
