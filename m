Received: from eggs.gnu.org ([209.51.188.92]:58521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09J-0006SK-R7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09I-00078d-Gp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:51 +1100
Message-Id: <20190108224600.23125-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/29] spapr: modify the prototype of the
 cpu_intc_create() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Today, the interrupt presenter is linked to a CPU using the
cpu_intc_create() method of the sPAPR IRQ backend. The resulting
object is assigned to the PowerPCCPU 'intc' pointer whatever the
interrupt mode, XICS or XIVE.

To support the 'dual' interrupt mode, we will need to distinguish
between the two presenter objects and for that, we plan to introduce a
second interrupt presenter object pointer under the PowerPCCPU. The
modifications below move the assignment of the presenter object under
the cpu_intc_create() method to prepare ground for the future changes.

Both sPAPR and PowerNV machines are impacted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 23 ++++++++++++++++-------
 hw/ppc/pnv_core.c          |  2 +-
 hw/ppc/spapr_cpu_core.c    |  2 +-
 hw/ppc/spapr_irq.c         | 34 ++++++++++++++++++++++++++--------
 include/hw/ppc/pnv.h       |  2 +-
 include/hw/ppc/spapr_irq.h |  4 ++--
 6 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 346f5e7aed..8e83be54fc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -668,11 +668,20 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip,=
 uint32_t core_id)
     return (chip->chip_id << 7) | (core_id << 3);
 }
=20
-static Object *pnv_chip_power8_intc_create(PnvChip *chip, Object *child,
-                                           Error **errp)
+static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
+                                        Error **errp)
 {
-    return icp_create(child, TYPE_PNV_ICP, XICS_FABRIC(qdev_get_machine(=
)),
-                      errp);
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
+                     &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu->intc =3D obj;
 }
=20
 /*
@@ -690,10 +699,10 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip,=
 uint32_t core_id)
     return (chip->chip_id << 8) | (core_id << 2);
 }
=20
-static Object *pnv_chip_power9_intc_create(PnvChip *chip, Object *child,
-                                           Error **errp)
+static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
+                                        Error **errp)
 {
-    return NULL;
+    return;
 }
=20
 /* Allowed core identifiers on a POWER8 Processor Chip :
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index ad1bcc7990..1202737748 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -114,7 +114,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip=
 *chip, Error **errp)
         return;
     }
=20
-    cpu->intc =3D pcc->intc_create(chip, OBJECT(cpu), &local_err);
+    pcc->intc_create(chip, cpu, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 82666436e9..2739b2a4b8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -232,7 +232,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
=20
-    cpu->intc =3D spapr->irq->cpu_intc_create(spapr, OBJECT(cpu), &local=
_err);
+    spapr->irq->cpu_intc_create(spapr, cpu, &local_err);
     if (local_err) {
         goto error_unregister;
     }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index be5fe531a8..eca2317cf3 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -190,10 +190,20 @@ static void spapr_irq_print_info_xics(sPAPRMachineS=
tate *spapr, Monitor *mon)
     ics_pic_print_info(spapr->ics, mon);
 }
=20
-static Object *spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
-                                              Object *cpu, Error **errp)
+static void spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
+                                           PowerPCCPU *cpu, Error **errp=
)
 {
-    return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
+                     &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu->intc =3D obj;
 }
=20
 static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
@@ -311,17 +321,25 @@ static void spapr_irq_print_info_xive(sPAPRMachineS=
tate *spapr,
     spapr_xive_pic_print_info(spapr->xive, mon);
 }
=20
-static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
-                                              Object *cpu, Error **errp)
+static void spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
+                                           PowerPCCPU *cpu, Error **errp=
)
 {
-    Object *obj =3D xive_tctx_create(cpu, XIVE_ROUTER(spapr->xive), errp=
);
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu->intc =3D obj;
=20
     /*
      * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
-     * don't benificiate from the reset of the XIVE IRQ backend
+     * don't beneficiate from the reset of the XIVE IRQ backend
      */
     spapr_xive_set_tctx_os_cam(XIVE_TCTX(obj));
-    return obj;
 }
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 86d5f54e54..6b65397b7e 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -98,7 +98,7 @@ typedef struct PnvChipClass {
     DeviceRealize parent_realize;
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
-    Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
+    void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
 } PnvChipClass;
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b34d5a0038..d03d4d7ce6 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,8 +42,8 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
     void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
-    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
-                               Error **errp);
+    void (*cpu_intc_create)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+                            Error **errp);
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
     void (*reset)(sPAPRMachineState *spapr, Error **errp);
 } sPAPRIrq;
--=20
2.20.1
