Received: from eggs.gnu.org ([2001:4830:134:3::10]:43928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZot-0007Vr-80
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZoo-0002Pw-Ew
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:27 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:47643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxZoo-0002Ow-7u
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:22 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0B8FF35710
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:57:20 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Apr 2017 15:56:52 +0200
Message-Id: <1491832618-27536-3-git-send-email-clg@kaod.org>
In-Reply-To: <1491832618-27536-1-git-send-email-clg@kaod.org>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/8] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The firmware (skiboot) chooses the default LPC bus of a multichip
systems using a "primary" property. The LPC bus of chip 0 should be
the only connected in the system. Let's advertise it in the device
tree.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Changes since v1:

 - the device tree is populated for all LPC busses of the system but
   only the one on chip 0 has the "primary" property.

 hw/ppc/pnv.c             |  2 ++
 hw/ppc/pnv_lpc.c         | 23 ++++++++++++++---------
 include/hw/ppc/pnv_lpc.h |  2 ++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 27589b91d1cf..7d742b6e34e1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -765,6 +765,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
     g_free(typename);
=20
     /* Create LPC controller */
+    object_property_set_int(OBJECT(&chip->lpc), chip->chip_id, "chip-id"=
,
+                            &error_fatal);
     object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index baee366d386a..13d7a695678d 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -92,14 +92,6 @@ enum {
 #define LPC_HC_REGS_OPB_SIZE    0x00001000
=20
=20
-/*
- * TODO: the "primary" cell should only be added on chip 0. This is
- * how skiboot chooses the default LPC controller on multichip
- * systems.
- *
- * It would be easly done if we can change the populate() interface to
- * replace the PnvXScomInterface parameter by a PnvChip one
- */
 static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
     const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
@@ -110,6 +102,7 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, v=
oid *fdt, int xscom_offset)
         cpu_to_be32(lpc_pcba),
         cpu_to_be32(PNV_XSCOM_LPC_SIZE)
     };
+    PnvLpcController *lpc =3D PNV_LPC(dev);
=20
     name =3D g_strdup_printf("isa@%x", lpc_pcba);
     offset =3D fdt_add_subnode(fdt, xscom_offset, name);
@@ -119,7 +112,13 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
     _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
     _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
-    _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
+
+    /* The firmware (skiboot) chooses the default LPC bus of the
+     * system using a "primary" property.
+     */
+    if (lpc->chip_id =3D=3D 0x0) {
+        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
+    }
     _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
     return 0;
 }
@@ -486,6 +485,11 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
     lpc->psi =3D PNV_PSI(obj);
 }
=20
+static Property pnv_lpc_properties[] =3D {
+    DEFINE_PROP_UINT32("chip-id", PnvLpcController, chip_id, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -494,6 +498,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
     xdc->populate =3D pnv_lpc_populate;
=20
     dc->realize =3D pnv_lpc_realize;
+    dc->props =3D pnv_lpc_properties;
 }
=20
 static const TypeInfo pnv_lpc_info =3D {
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index ccf969af9448..c78ee4a98c62 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -67,6 +67,8 @@ typedef struct PnvLpcController {
=20
     /* PSI to generate interrupts */
     PnvPsi *psi;
+
+    uint32_t chip_id;
 } PnvLpcController;
=20
 qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
--=20
2.7.4
