Received: from eggs.gnu.org ([2001:4830:134:3::10]:41752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGf-00086e-ML
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGb-00014j-Pl
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:33 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:48764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkGb-00014J-Jd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:29 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3391349D35
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:42:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:29 +0200
Message-Id: <1491396106-26376-5-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Multi chip systems only have one LPC bus, on chip 0. The PnvLPC object
will still be created under the PnvChip objects but only the one under
chip 0 will be advertise in the device tree.

Also remove the comment which is slightly wrong. Only chip 0 has a LPC
device node : xscom@3fc0000000000/isa@b0020

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 hw/ppc/pnv.c             |  2 ++
 hw/ppc/pnv_lpc.c         | 20 ++++++++++++--------
 include/hw/ppc/pnv_lpc.h |  2 ++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 78133e5d20e1..493c7eed7980 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -811,6 +811,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
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
index 20cbb6a0dbbd..1a212a2a399f 100644
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
@@ -110,6 +102,12 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
         cpu_to_be32(lpc_pcba),
         cpu_to_be32(PNV_XSCOM_LPC_SIZE)
     };
+    PnvLpcController *lpc =3D PNV_LPC(dev);
+
+    /* Only populate one LPC bus per system, the one on chip 0.*/
+    if (lpc->chip_id) {
+        return 0;
+    }
=20
     name =3D g_strdup_printf("isa@%x", lpc_pcba);
     offset =3D fdt_add_subnode(fdt, xscom_offset, name);
@@ -486,6 +484,11 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
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
@@ -494,6 +497,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
     xdc->populate =3D pnv_lpc_populate;
=20
     dc->realize =3D pnv_lpc_realize;
+    dc->props =3D pnv_lpc_properties;
 }
=20
 static const TypeInfo pnv_lpc_info =3D {
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 53040026c37b..dcfadda90090 100644
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
 #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to .=
.. */
--=20
2.7.4
