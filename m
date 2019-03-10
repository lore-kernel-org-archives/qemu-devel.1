Received: from eggs.gnu.org ([209.51.188.92]:43526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpD-00025O-LF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpC-00022r-Td
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:50 +1100
Message-Id: <20190310082703.1245-48-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 47/60] ppc/pnv: add a 'dt_isa_nodename' to the
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The ISA bus has a different DT nodename on POWER9. Compute the name
when the PnvChip is realized, that is before it is used by the machine
to populate the device tree with the ISA devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 18 +++++-------------
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 922e3ec48b..6625562d27 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -417,24 +417,12 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
     return 0;
 }
=20
-static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
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
 /* The default LPC bus of a multichip system is on chip 0. It's
  * recognized by the firmware (skiboot) using a "primary" property.
  */
 static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
 {
-    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
+    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nodena=
me);
     ForeachPopulateArgs args =3D {
         .fdt =3D fdt,
         .offset =3D isa_offset,
@@ -866,6 +854,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
=20
+    chip->dt_isa_nodename =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x=
",
+                                            (uint64_t) PNV_XSCOM_BASE(ch=
ip),
+                                            PNV_XSCOM_LPC_BASE);
+
     /* Interrupt Management Area. This is the memory region holding
      * all the Interrupt Control Presenter (ICP) registers */
     pnv_chip_icp_realize(chip8, &local_err);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 8d80cb34ee..c81f157f41 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -58,6 +58,8 @@ typedef struct PnvChip {
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
+
+    gchar        *dt_isa_nodename;
 } PnvChip;
=20
 #define TYPE_PNV8_CHIP "pnv8-chip"
--=20
2.20.1
