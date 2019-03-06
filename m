Received: from eggs.gnu.org ([209.51.188.92]:55340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH2-0006Xi-Vz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH0-00020W-S7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGy-0001Et-J4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mVW8103348
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2axy0bgm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:52 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:49 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:13 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-9-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/27] ppc/pnv: introduce a new
 pic_print_info() operation to the chip model
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

The POWER9 and POWER8 processors have different interrupt controllers,
and reporting their state requires calling different helper routines.

However, the interrupt presenters are still handled in the higher
level pic_print_info() routine because they are not related to the
chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  1 +
 hw/ppc/pnv.c         | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fa9ec50fd5be..eb4bba25b3e9 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 087541a91a72..7660eaa22cf9 100644
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
--=20
2.20.1
