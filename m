Received: from eggs.gnu.org ([2001:4830:134:3::10]:54401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoD-0007fI-0c
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSo9-0008Sw-Tk
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:05 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:55450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSo9-0008Rg-MT
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:01 -0400
Received: from player738.ha.ovh.net (unknown [10.109.105.21])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1FBEE108439
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:01:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:38 +0200
Message-Id: <20180614140043.9231-2-clg@kaod.org>
In-Reply-To: <20180614140043.9231-1-clg@kaod.org>
References: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] ppc/pnv: introduce a 'primary' field under
 the LPC model
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

When a PowerNV system is started, the firmware (skiboot) looks for a
"primary" property to determine which LPC bus is the default on a
multichip system. This property is currently populated in the main
routine creating the device tree of a chip, which is the not the right
place to do so.

Check the chip id to flag the LPC controller as "primary", or not, and
use that to add the property in the LPC device tree routine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_lpc.h |  2 ++
 hw/ppc/pnv.c             | 19 ++++++-------------
 hw/ppc/pnv_lpc.c         | 29 ++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 53fdd5bb6450..fddcb1c054b3 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -68,6 +68,8 @@ typedef struct PnvLpcController {
=20
     /* PSI to generate interrupts */
     PnvPsi *psi;
+
+    bool   primary;
 } PnvLpcController;
=20
 qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 031488131629..b419d3323100 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -285,16 +285,6 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
=20
     pnv_dt_xscom(chip, fdt, 0);
=20
-    /* The default LPC bus of a multichip system is on chip 0. It's
-     * recognized by the firmware (skiboot) using a "primary"
-     * property.
-     */
-    if (chip->chip_id =3D=3D 0x0) {
-        int lpc_offset =3D pnv_chip_lpc_offset(chip, fdt);
-
-        _FDT((fdt_setprop(fdt, lpc_offset, "primary", NULL, 0)));
-    }
-
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
=20
@@ -814,9 +804,12 @@ static void pnv_chip_init(Object *obj)
     object_property_add_const_link(OBJECT(&chip->occ), "psi",
                                    OBJECT(&chip->psi), &error_abort);
=20
-    /* The LPC controller needs PSI to generate interrupts */
-    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
-                                   OBJECT(&chip->psi), &error_abort);
+    /*
+     * The LPC controller needs a few things from the chip : to know
+     * if it's primary and PSI to generate interrupts
+     */
+    object_property_add_const_link(OBJECT(&chip->lpc), "chip",
+                                   OBJECT(chip), &error_abort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 402c4fefa886..1e70c8c19d52 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -113,6 +113,14 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
     _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
+
+    /*
+     * The default LPC bus of a multichip system is on chip 0. It's
+     * recognized by the firmware (skiboot) using a "primary" property.
+     */
+    if (PNV_LPC(dev)->primary) {
+        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
+    }
     return 0;
 }
=20
@@ -416,6 +424,18 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
     PnvLpcController *lpc =3D PNV_LPC(dev);
     Object *obj;
     Error *error =3D NULL;
+    PnvChip *chip;
+
+    /* get PSI object from chip */
+    obj =3D object_property_get_link(OBJECT(dev), "chip", &error);
+    if (!obj) {
+        error_propagate(errp, error);
+        error_prepend(errp, "required link 'chip' not found: ");
+        return;
+    }
+    chip =3D PNV_CHIP(obj);
+    lpc->psi =3D &chip->psi;
+    lpc->primary =3D chip->chip_id =3D=3D 0;
=20
     /* Reg inits */
     lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
@@ -460,15 +480,6 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
     pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
                           &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
                           PNV_XSCOM_LPC_SIZE);
-
-    /* get PSI object from chip */
-    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'psi' not found: %s",
-                   __func__, error_get_pretty(error));
-        return;
-    }
-    lpc->psi =3D PNV_PSI(obj);
 }
=20
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
--=20
2.13.6
