Received: from eggs.gnu.org ([2001:4830:134:3::10]:45696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPt-0000fF-FA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPq-0003Pi-0E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:05 +1000
Message-Id: <20180622103528.28598-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/25] ppc/pnv: introduce a new isa_create()
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
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This moves the details of the ISA bus creation under the LPC model but
more important, the new PnvChip operation will let us choose the chip
class to use when we introduce the different chip classes for Power9
and Power8. It hides away the processor chip controllers from the
machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             | 34 +++++++++++++++++++---------------
 hw/ppc/pnv_lpc.c         | 30 +++++++++++++++++++++++++-----
 include/hw/ppc/pnv.h     |  1 +
 include/hw/ppc/pnv_lpc.h |  3 +--
 4 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c7e127ae97..ac828d1331 100644
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
index 402c4fefa8..d7721320a2 100644
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
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index e934e84f55..563279f3e0 100644
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
index 53fdd5bb64..d657489b07 100644
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
--=20
2.17.1
