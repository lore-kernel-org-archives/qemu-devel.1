Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqc0-00042a-Cv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqbx-0006mv-8E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:26:04 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:53177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTqbx-0006mH-29
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:26:01 -0400
Received: from player794.ha.ovh.net (unknown [10.109.122.50])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id EA3BAB68D6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:25:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Jun 2018 17:25:36 +0200
Message-Id: <20180615152536.30093-5-clg@kaod.org>
In-Reply-To: <20180615152536.30093-1-clg@kaod.org>
References: <20180615152536.30093-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] ppc/pnv: consolidate the creation of
 the ISA bus device tree
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

The device tree node of the ISA bus was being partially done in
different places. Move all the nodes creation under the same routine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b416a1a6ed63..8969ccdd7ba3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -265,18 +265,6 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uin=
t32_t pir,
     g_free(reg);
 }
=20
-static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
-{
-    char *name;
-    int offset;
-
-    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
-                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
-    offset =3D fdt_path_offset(fdt, name);
-    g_free(name);
-    return offset;
-}
-
 static void pnv_dt_chip(PnvChip *chip, void *fdt)
 {
     const char *typename =3D pnv_chip_core_typename(chip);
@@ -285,16 +273,6 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
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
@@ -418,16 +396,35 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
     return 0;
 }
=20
-static void pnv_dt_isa(ISABus *bus, void *fdt, int lpc_offset)
+static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
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
+/* The default LPC bus of a multichip system is on chip 0. It's
+ * recognized by the firmware (skiboot) using a "primary" property.
+ */
+static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
 {
+    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
     ForeachPopulateArgs args =3D {
         .fdt =3D fdt,
-        .offset =3D lpc_offset,
+        .offset =3D isa_offset,
     };
=20
+    _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
+
     /* ISA devices are not necessarily parented to the ISA bus so we
      * can not use object_child_foreach() */
-    qbus_walk_children(BUS(bus), pnv_dt_isa_device, NULL, NULL, NULL, &a=
rgs);
+    qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,
+                       &args);
 }
=20
 static void *pnv_dt_create(MachineState *machine)
@@ -438,7 +435,6 @@ static void *pnv_dt_create(MachineState *machine)
     char *buf;
     int off;
     int i;
-    int lpc_offset;
=20
     fdt =3D g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -480,8 +476,7 @@ static void *pnv_dt_create(MachineState *machine)
     }
=20
     /* Populate ISA devices on chip 0 */
-    lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
-    pnv_dt_isa(pnv->isa_bus, fdt, lpc_offset);
+    pnv_dt_isa(pnv, fdt);
=20
     if (pnv->bmc) {
         pnv_dt_bmc_sensors(pnv->bmc, fdt);
--=20
2.13.6
