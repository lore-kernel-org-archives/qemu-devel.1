Received: from eggs.gnu.org ([209.51.188.92]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGU-0005zO-EP
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGQ-0001LR-OA
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGP-0001Ep-Sh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mWlh114400
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2abwtdbs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:52 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:49 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:12 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-8-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/27] ppc/pnv: introduce a new dt_populate()
 operation to the chip model
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

The POWER9 and POWER8 processors have a different set of devices and a
different device tree layout.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  1 +
 hw/ppc/pnv.c         | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index ebbb3d0e9aa7..fa9ec50fd5be 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a7ec76dbd6c7..087541a91a72 100644
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
--=20
2.20.1
