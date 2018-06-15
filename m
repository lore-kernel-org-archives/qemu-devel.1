Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqbs-0003vp-Uw
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqbp-0006dL-Pt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:56 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:45507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTqbp-0006bM-Ft
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:53 -0400
Received: from player794.ha.ovh.net (unknown [10.109.108.22])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E139CE7C91
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:25:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Jun 2018 17:25:34 +0200
Message-Id: <20180615152536.30093-3-clg@kaod.org>
In-Reply-To: <20180615152536.30093-1-clg@kaod.org>
References: <20180615152536.30093-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/4] ppc/pnv: introduce a new isa_create()
 operation to the chip model
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

This moves the details of the ISA bus creation under the LPC model but
more important, the new PnvChip operation will let us choose the chip
class to use when we introduce the different chip classes for Power9
and Power8. It hides away the processor chip controllers from the
machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 pnv_isa_create() is a onliner but it looks better like that than to
 use it directly with pnv->chips[0]

 include/hw/ppc/pnv.h     |  1 +
 include/hw/ppc/pnv_lpc.h |  3 +--
 hw/ppc/pnv.c             | 34 +++++++++++++++++++---------------
 hw/ppc/pnv_lpc.c         | 30 +++++++++++++++++++++++++-----
 4 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index e934e84f555e..563279f3e00c 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -77,6 +77,7 @@ typedef struct PnvChipClass {
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
+    ISABus *(*isa_create)(PnvChip *chip, Error **errp);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 53fdd5bb6450..d657489b07ce 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -70,7 +70,6 @@ typedef struct PnvLpcController {
     PnvPsi *psi;
 } PnvLpcController;
=20
-qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
-                                 int nirqs);
+ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
=20
 #endif /* _PPC_PNV_LPC_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c7e127ae97db..ac828d133173 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -529,24 +529,24 @@ static void pnv_reset(void)
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
=20
-static ISABus *pnv_isa_create(PnvChip *chip)
+static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
 {
-    PnvLpcController *lpc =3D &chip->lpc;
-    ISABus *isa_bus;
-    qemu_irq *irqs;
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
+    return pnv_lpc_isa_create(&chip->lpc, true, errp);
+}
=20
-    /* let isa_bus_new() create its own bridge on SysBus otherwise
-     * devices speficied on the command line won't find the bus and
-     * will fail to create.
-     */
-    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
-                          &error_fatal);
+static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp=
)
+{
+    return pnv_lpc_isa_create(&chip->lpc, false, errp);
+}
=20
-    irqs =3D pnv_lpc_isa_irq_create(lpc, pcc->chip_type, ISA_NUM_IRQS);
+static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
+{
+    return NULL;
+}
=20
-    isa_bus_irqs(isa_bus, irqs);
-    return isa_bus;
+static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
+{
+    return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
 }
=20
 static void pnv_init(MachineState *machine)
@@ -646,7 +646,7 @@ static void pnv_init(MachineState *machine)
     g_free(chip_typename);
=20
     /* Instantiate ISA bus on chip 0 */
-    pnv->isa_bus =3D pnv_isa_create(pnv->chips[0]);
+    pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
=20
     /* Create serial port */
     serial_hds_isa_init(pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
@@ -735,6 +735,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->cores_mask =3D POWER8E_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->isa_create =3D pnv_chip_power8_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
 }
@@ -749,6 +750,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->isa_create =3D pnv_chip_power8_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
 }
@@ -763,6 +765,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
 }
@@ -777,6 +780,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->intc_create =3D pnv_chip_power9_intc_create;
+    k->isa_create =3D pnv_chip_power9_isa_create;
     k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
 }
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 402c4fefa886..d7721320a25b 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "hw/isa/isa.h"
=20
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_lpc.h"
@@ -535,16 +536,35 @@ static void pnv_lpc_isa_irq_handler(void *opaque, i=
nt n, int level)
     }
 }
=20
-qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
-                                 int nirqs)
+ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp)
 {
+    Error *local_err =3D NULL;
+    ISABus *isa_bus;
+    qemu_irq *irqs;
+    qemu_irq_handler handler;
+
+    /* let isa_bus_new() create its own bridge on SysBus otherwise
+     * devices speficied on the command line won't find the bus and
+     * will fail to create.
+     */
+    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io, &local_er=
r);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
     /* Not all variants have a working serial irq decoder. If not,
      * handling of LPC interrupts becomes a platform issue (some
      * platforms have a CPLD to do it).
      */
-    if (chip_type =3D=3D PNV_CHIP_POWER8NVL) {
-        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler, lpc, nirqs);
+    if (use_cpld) {
+        handler =3D pnv_lpc_isa_irq_handler_cpld;
     } else {
-        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, lpc, nir=
qs);
+        handler =3D pnv_lpc_isa_irq_handler;
     }
+
+    irqs =3D qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
+
+    isa_bus_irqs(isa_bus, irqs);
+    return isa_bus;
 }
--=20
2.13.6
