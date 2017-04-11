Received: from eggs.gnu.org ([2001:4830:134:3::10]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxka-0006dM-71
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkX-0003bm-2R
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:36 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:55037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxxkW-0003ax-Sd
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:33 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 85793313B4
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:30:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Apr 2017 17:30:00 +0200
Message-Id: <1491924606-20026-3-git-send-email-clg@kaod.org>
In-Reply-To: <1491924606-20026-1-git-send-email-clg@kaod.org>
References: <1491924606-20026-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/8] ppc/pnv: enable only one LPC bus
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

The default LPC bus of a multichip system is on chip 0. It's
recognized by the firmware (skiboot) using a "primary" property in the
device tree.

We introduce a pnv_chip_lpc_offset() routine to locate the LPC node of
a chip and set the property directly from the machine level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2:

 - introduced a pnv_chip_lpc_offset() routine to locate the lpc node
   of a chip in the device tree and set the property from the machine
 =20
 Changes since v1:

 - the device tree is populated for all LPC busses of the system but
   only the one on chip 0 has the "primary" property.

 hw/ppc/pnv.c     | 22 ++++++++++++++++++++++
 hw/ppc/pnv_lpc.c |  9 ---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 27589b91d1cf..9468e991bfb2 100644
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
index 5d20c15e6729..f03a80a29bf6 100644
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
2.7.4
