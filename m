Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIL-0001gz-Tk
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIK-0003Zo-OZ
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:17 +1000
Message-Id: <20170424015927.8933-38-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/47] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The default LPC bus of a multichip system is on chip 0. It's
recognized by the firmware (skiboot) using a "primary" property in the
device tree.

We introduce a pnv_chip_lpc_offset() routine to locate the LPC node of
a chip and set the property directly from the machine level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c     | 22 ++++++++++++++++++++++
 hw/ppc/pnv_lpc.c |  9 ---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 27589b9..9468e99 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -255,6 +255,18 @@ static void powernv_populate_icp(PnvChip *chip, void=
 *fdt, uint32_t pir,
     g_free(reg);
 }
=20
+static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
+{
+    char *name;
+    int offset;
+
+    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
+                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
+    offset =3D fdt_path_offset(fdt, name);
+    g_free(name);
+    return offset;
+}
+
 static void powernv_populate_chip(PnvChip *chip, void *fdt)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
@@ -264,6 +276,16 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
=20
     pnv_xscom_populate(chip, fdt, 0);
=20
+    /* The default LPC bus of a multichip system is on chip 0. It's
+     * recognized by the firmware (skiboot) using a "primary"
+     * property.
+     */
+    if (chip->chip_id =3D=3D 0x0) {
+        int lpc_offset =3D pnv_chip_lpc_offset(chip, fdt);
+
+        _FDT((fdt_setprop(fdt, lpc_offset, "primary", NULL, 0)));
+    }
+
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
=20
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 5d20c15..f03a80a 100644
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
@@ -119,7 +111,6 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, v=
oid *fdt, int xscom_offset)
     _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
     _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
-    _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
     _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
     return 0;
 }
--=20
2.9.3
