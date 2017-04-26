Received: from eggs.gnu.org ([2001:4830:134:3::10]:56804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwr-0005M6-Ls
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwl-000869-8z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:21 +1000
Message-Id: <20170426070034.10727-36-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/48] spapr: remove the 'nr_servers' field from
 the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

xics_system_init() does not need 'nr_servers' anymore as it is only
used to define the 'interrupt-controller' node in the device tree. So
let's just compute the value when calling spapr_dt_xics().

This also gives us an opportunity to simplify the xics_system_init()
routine and introduce a specific spapr_ics_create() helper to create
the sPAPR ICS object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 56 ++++++++++++++++++++++----------------------=
------
 include/hw/ppc/spapr.h |  1 -
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 703b14a..80d12d0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -97,45 +97,40 @@
=20
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
-static int try_create_xics(sPAPRMachineState *spapr, const char *type_ic=
s,
-                           const char *type_icp, int nr_servers,
-                           int nr_irqs, Error **errp)
+static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
+                                  const char *type_ics,
+                                  int nr_irqs, Error **errp)
 {
-    XICSFabric *xi =3D XICS_FABRIC(spapr);
     Error *err =3D NULL, *local_err =3D NULL;
-    ICSState *ics =3D NULL;
+    Object *obj;
=20
-    ics =3D ICS_SIMPLE(object_new(type_ics));
-    object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
-    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
-    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xi), NULL=
);
-    object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
+    obj =3D object_new(type_ics);
+    object_property_add_child(OBJECT(spapr), "ics", obj, NULL);
+    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
+    object_property_set_int(obj, nr_irqs, "nr-irqs", &err);
+    object_property_set_bool(obj, true, "realized", &local_err);
     error_propagate(&err, local_err);
     if (err) {
         error_propagate(errp, err);
-        return -1;
+        return NULL;
     }
=20
-    spapr->nr_servers =3D nr_servers;
-    spapr->ics =3D ics;
-    spapr->icp_type =3D type_icp;
-    return 0;
+    return ICS_SIMPLE(obj);
 }
=20
-static int xics_system_init(MachineState *machine,
-                            int nr_servers, int nr_irqs, Error **errp)
+static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
 {
-    int rc =3D -1;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
=20
     if (kvm_enabled()) {
         Error *err =3D NULL;
=20
         if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(SPAPR_MACHINE(machine), errp)) {
-            rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_KVM,
-                                 TYPE_KVM_ICP, nr_servers, nr_irqs, &err=
);
+            !xics_kvm_init(spapr, errp)) {
+            spapr->icp_type =3D TYPE_KVM_ICP;
+            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, &err);
         }
-        if (machine_kernel_irqchip_required(machine) && rc < 0) {
+        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
             error_reportf_err(err,
                               "kernel_irqchip requested but unavailable:=
 ");
         } else {
@@ -143,13 +138,11 @@ static int xics_system_init(MachineState *machine,
         }
     }
=20
-    if (rc < 0) {
-        xics_spapr_init(SPAPR_MACHINE(machine), errp);
-        rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_SIMPLE,
-                               TYPE_ICP, nr_servers, nr_irqs, errp);
+    if (!spapr->ics) {
+        xics_spapr_init(spapr, errp);
+        spapr->icp_type =3D TYPE_ICP;
+        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
     }
-
-    return rc;
 }
=20
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
@@ -977,6 +970,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     void *fdt;
     sPAPRPHBState *phb;
     char *buf;
+    int smt =3D kvmppc_smt_threads();
=20
     fdt =3D g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -1016,7 +1010,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr->nr_servers, fdt, PHANDLE_XICP);
+    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDL=
E_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2045,7 +2039,6 @@ static void ppc_spapr_init(MachineState *machine)
     hwaddr node0_size =3D spapr_node0_size();
     long load_limit, fw_size;
     char *filename;
-    int smt =3D kvmppc_smt_threads();
=20
     msi_nonbroken =3D true;
=20
@@ -2096,8 +2089,7 @@ static void ppc_spapr_init(MachineState *machine)
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
     /* Set up Interrupt Controller before we create the VCPUs */
-    xics_system_init(machine, DIV_ROUND_UP(max_cpus * smt, smp_threads),
-                     XICS_IRQS_SPAPR, &error_fatal);
+    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
=20
     /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
     spapr->ov5 =3D spapr_ovec_new();
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7dbba57..5802f88 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -108,7 +108,6 @@ struct sPAPRMachineState {
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
=20
-    uint32_t nr_servers;
     const char *icp_type;
 };
=20
--=20
2.9.3
