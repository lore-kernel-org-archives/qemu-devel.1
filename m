Received: from eggs.gnu.org ([209.51.188.92]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toS-0001IJ-T5
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toP-0001Va-5y
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:03 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:31 +1100
Message-Id: <20190310082703.1245-29-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/60] ppc/pnv: introduce a new pic_print_info()
 operation to the chip model
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

The POWER9 and POWER8 processors have different interrupt controllers,
and reporting their state requires calling different helper routines.

However, the interrupt presenters are still handled in the higher
level pic_print_info() routine because they are not related to the
chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 27 ++++++++++++++++++++++++---
 include/hw/ppc/pnv.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 087541a91a..7660eaa22c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -567,6 +567,20 @@ static ISABus *pnv_isa_create(PnvChip *chip, Error *=
*errp)
     return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
 }
=20
+static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
+{
+    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
+
+    ics_pic_print_info(&chip8->psi.ics, mon);
+}
+
+static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
+{
+    Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
+
+    pnv_xive_pic_print_info(&chip9->xive, mon);
+}
+
 static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(machine);
@@ -878,6 +892,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
+    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
@@ -897,6 +912,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
+    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
=20
@@ -916,6 +932,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
+    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
@@ -977,6 +994,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->intc_create =3D pnv_chip_power9_intc_create;
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
+    k->pic_print_info =3D pnv_chip_power9_pic_print_info;
     k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
=20
@@ -1164,12 +1182,15 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+        if (pnv_chip_is_power9(pnv->chips[0])) {
+            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc)=
, mon);
+        } else {
+            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+        }
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
-        ics_pic_print_info(&chip8->psi.ics, mon);
+        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i],=
 mon);
     }
 }
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fa9ec50fd5..eb4bba25b3 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -103,6 +103,7 @@ typedef struct PnvChipClass {
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
+    void (*pic_print_info)(PnvChip *chip, Monitor *mon);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
--=20
2.20.1
