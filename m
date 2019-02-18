Received: from eggs.gnu.org ([209.51.188.92]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxw-0006d3-Qd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxt-0003CM-OY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:32 +1100
Message-Id: <20190218143049.17142-27-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/43] xics: Drop the KVM ICS class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The KVM ICS class isn't used anymore. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023084177.1011724.14693955932559990358.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c    | 40 ----------------------------------------
 hw/ppc/spapr_irq.c    |  2 +-
 include/hw/ppc/xics.h |  3 ---
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index f34eacda03..a00d0a7962 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -279,39 +279,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int v=
al)
     }
 }
=20
-static void ics_kvm_realize(DeviceState *dev, Error **errp)
-{
-    ICSState *ics =3D ICS_KVM(dev);
-    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
-    Error *local_err =3D NULL;
-
-    icsc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
-static void ics_kvm_class_init(ObjectClass *klass, void *data)
-{
-    ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-
-    device_class_set_parent_realize(dc, ics_kvm_realize,
-                                    &icsc->parent_realize);
-}
-
-static const TypeInfo ics_kvm_info =3D {
-    .name =3D TYPE_ICS_KVM,
-    .parent =3D TYPE_ICS_BASE,
-    .instance_size =3D sizeof(ICSState),
-    .class_init =3D ics_kvm_class_init,
-};
-
-/*
- * XICS-KVM
- */
-
 static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                        uint32_t token,
                        uint32_t nargs, target_ulong args,
@@ -381,10 +348,3 @@ fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
     return -1;
 }
-
-static void xics_kvm_register_types(void)
-{
-    type_register_static(&ics_kvm_info);
-}
-
-type_init(xics_kvm_register_types)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 4aa8165307..4297eed600 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -208,7 +208,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachi=
neState *spapr,
=20
 static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
 {
-    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
+    if (!kvm_irqchip_in_kernel()) {
         CPUState *cs;
         CPU_FOREACH(cs) {
             PowerPCCPU *cpu =3D POWERPC_CPU(cs);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 61bd0fb978..d36bbe11ee 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -95,9 +95,6 @@ struct PnvICPState {
 #define TYPE_ICS_SIMPLE "ics"
 #define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
=20
-#define TYPE_ICS_KVM "icskvm"
-#define ICS_KVM(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_KVM)
-
 #define ICS_BASE_CLASS(klass) \
      OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
 #define ICS_BASE_GET_CLASS(obj) \
--=20
2.20.1
