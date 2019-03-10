Received: from eggs.gnu.org ([209.51.188.92]:43008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001Lc-A4
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001YU-0J
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:30 +1100
Message-Id: <20190310082703.1245-28-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/60] ppc/pnv: introduce a new dt_populate()
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

The POWER9 and POWER8 processors have a different set of devices and a
different device tree layout.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 27 +++++++++++++++++++++++++--
 include/hw/ppc/pnv.h |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a7ec76dbd6..087541a91a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -267,7 +267,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint=
32_t pir,
     g_free(reg);
 }
=20
-static void pnv_dt_chip(PnvChip *chip, void *fdt)
+static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
     const char *typename =3D pnv_chip_core_typename(chip);
     size_t typesize =3D object_type_get_instance_size(typename);
@@ -289,6 +289,25 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
     }
 }
=20
+static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
+{
+    const char *typename =3D pnv_chip_core_typename(chip);
+    size_t typesize =3D object_type_get_instance_size(typename);
+    int i;
+
+    pnv_dt_xscom(chip, fdt, 0);
+
+    for (i =3D 0; i < chip->nr_cores; i++) {
+        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
+
+        pnv_dt_core(chip, pnv_core, fdt);
+    }
+
+    if (chip->ram_size) {
+        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
+    }
+}
+
 static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
 {
     uint32_t io_base =3D d->ioport_id;
@@ -474,7 +493,7 @@ static void *pnv_dt_create(MachineState *machine)
=20
     /* Populate device tree for each chip */
     for (i =3D 0; i < pnv->num_chips; i++) {
-        pnv_dt_chip(pnv->chips[i], fdt);
+        PNV_CHIP_GET_CLASS(pnv->chips[i])->dt_populate(pnv->chips[i], fd=
t);
     }
=20
     /* Populate ISA devices on chip 0 */
@@ -858,6 +877,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8_isa_create;
+    k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
@@ -876,6 +896,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8_isa_create;
+    k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
=20
@@ -894,6 +915,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
+    k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
@@ -954,6 +976,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->intc_create =3D pnv_chip_power9_intc_create;
     k->isa_create =3D pnv_chip_power9_isa_create;
+    k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index ebbb3d0e9a..fa9ec50fd5 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -102,6 +102,7 @@ typedef struct PnvChipClass {
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
+    void (*dt_populate)(PnvChip *chip, void *fdt);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
--=20
2.20.1
