Received: from eggs.gnu.org ([2001:4830:134:3::10]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cveZt-0001UR-8n
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cveZq-0004FC-3N
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:38:01 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cveZp-0004Ex-QU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:37:58 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id F31DB47353
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 08:37:55 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 08:37:44 +0200
Message-Id: <1491374264-26293-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: remove the 'nr_servers' field from the
 machine
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

xics_system_init() does not need 'nr_servers' anymore as it is only
used to define the 'interrupt-controller' node in the device tree. So
let's just compute the value when calling spapr_dt_xics().

This also gives us an opportunity to simplify the xics_system_init()
routine and introduce a specific spapr_ics_create() helper to create
the sPAPR ICS object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 56 ++++++++++++++++++++++----------------------=
------
 include/hw/ppc/spapr.h |  1 -
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4e87ffe776ea..df231a3fc4a1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,45 +96,40 @@
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
@@ -142,13 +137,11 @@ static int xics_system_init(MachineState *machine,
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
@@ -912,6 +905,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     void *fdt;
     sPAPRPHBState *phb;
     char *buf;
+    int smt =3D kvmppc_smt_threads();
=20
     fdt =3D g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -951,7 +945,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr=
,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr->nr_servers, fdt, PHANDLE_XICP);
+    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDL=
E_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -1970,7 +1964,6 @@ static void ppc_spapr_init(MachineState *machine)
     hwaddr node0_size =3D spapr_node0_size();
     long load_limit, fw_size;
     char *filename;
-    int smt =3D kvmppc_smt_threads();
=20
     msi_nonbroken =3D true;
=20
@@ -2021,8 +2014,7 @@ static void ppc_spapr_init(MachineState *machine)
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
index db3d4acb18a6..742777f40a2d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -95,7 +95,6 @@ struct sPAPRMachineState {
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
=20
-    uint32_t nr_servers;
     const char *icp_type;
 };
=20
--=20
2.7.4
