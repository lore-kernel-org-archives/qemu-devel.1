Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDmMn-0000eV-UP
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDmMk-00057l-LU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:39:57 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:43006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fDmMk-000571-Bo
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:39:54 -0400
Received: from player157.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 91A09EF479
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 09:39:52 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dafe2911-9755-2007-5723-686de5aeceb8@kaod.org>
Date: Wed, 2 May 2018 09:39:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180426071129.GJ8800@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

>> =20
>> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t server)
>> +{
>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
>> +
>> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
>> +}
>=20
> So this is a bit of a tangent, but I've been thinking of implementing
> a scheme where there's an opaque pointer in the cpu structure for the
> use of the machine.  I'm planning for that to replace the intc pointer
> (which isn't really used directly by the cpu). That would allow us to
> have spapr put a structure there and have both xics and xive pointers
> which could be useful later on.

Here is a quick try of the idea. Tested on pnv and spapr machines.
I lacked inspiration on the name so I called the object {Machine}Link.=20

Thanks,

C.


>From 107808feda62c09b2df9a60aba5b30127ffab976 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Wed, 2 May 2018 09:24:37 +0200
Subject: [PATCH] ppc: introduce a link Object between the CPU and the mac=
hine
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c    | 10 +++----
 hw/ppc/pnv.c            | 80 +++++++++++++++++++++++++++++++++++++++++++=
++++--
 hw/ppc/pnv_core.c       |  2 +-
 hw/ppc/spapr.c          | 77 +++++++++++++++++++++++++++++++++++++++++++=
++--
 hw/ppc/spapr_cpu_core.c |  5 ++--
 include/hw/ppc/pnv.h    |  3 ++
 include/hw/ppc/spapr.h  |  3 ++
 target/ppc/cpu.h        |  2 +-
 8 files changed, 167 insertions(+), 15 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e27b92b871a..9cd560bdd093 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -44,7 +44,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 {
     target_ulong cppr =3D args[0];
=20
-    icp_set_cppr(ICP(cpu->intc), cppr);
+    icp_set_cppr(spapr_link_icp(cpu), cppr);
     return H_SUCCESS;
 }
=20
@@ -65,7 +65,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
+    uint32_t xirr =3D icp_accept(spapr_link_icp(cpu));
=20
     args[0] =3D xirr;
     return H_SUCCESS;
@@ -74,7 +74,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
+    uint32_t xirr =3D icp_accept(spapr_link_icp(cpu));
=20
     args[0] =3D xirr;
     args[1] =3D cpu_get_host_ticks();
@@ -86,7 +86,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 {
     target_ulong xirr =3D args[0];
=20
-    icp_eoi(ICP(cpu->intc), xirr);
+    icp_eoi(spapr_link_icp(cpu), xirr);
     return H_SUCCESS;
 }
=20
@@ -94,7 +94,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     uint32_t mfrr;
-    uint32_t xirr =3D icp_ipoll(ICP(cpu->intc), &mfrr);
+    uint32_t xirr =3D icp_ipoll(spapr_link_icp(cpu), &mfrr);
=20
     args[0] =3D xirr;
     args[1] =3D mfrr;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 031488131629..64c35dfdf427 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -970,6 +970,75 @@ static void pnv_chip_class_init(ObjectClass *klass, =
void *data)
     dc->desc =3D "PowerNV Chip";
 }
=20
+#define TYPE_PNV_LINK "pnv-link"
+#define PNV_LINK(obj) OBJECT_CHECK(PnvLink, (obj), TYPE_PNV_LINK)
+
+typedef struct PnvLink {
+    DeviceState parent;
+
+    ICPState *icp;
+} PnvLink;
+
+static void pnv_link_realize(DeviceState *dev, Error **errp)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvLink *link =3D PNV_LINK(dev);
+    Object *cpu;
+    Error *local_err =3D NULL;
+
+    cpu =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
+    if (!cpu) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'cpu' not found: ");
+        return;
+    }
+
+    link->icp =3D ICP(icp_create(cpu, TYPE_PNV_ICP, XICS_FABRIC(pnv),
+                               &local_err));
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void pnv_link_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D pnv_link_realize;
+}
+
+static const TypeInfo pnv_link_info =3D {
+    .name =3D TYPE_PNV_LINK,
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(PnvLink),
+    .class_init =3D pnv_link_class_init,
+};
+
+Object *pnv_link_create(Object *cpu, Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(TYPE_PNV_LINK);
+    object_property_add_child(cpu, TYPE_PNV_LINK, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        obj =3D NULL;
+    }
+
+    return obj;
+}
+
+ICPState *pnv_link_icp(PowerPCCPU *cpu)
+{
+    return PNV_LINK(cpu->link)->icp;
+}
+
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(xi);
@@ -1013,7 +1082,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? pnv_link_icp(cpu) : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1026,7 +1095,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(pnv_link_icp(cpu), mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
@@ -1142,3 +1211,10 @@ static const TypeInfo types[] =3D {
 };
=20
 DEFINE_TYPES(types)
+
+static void pnv_machine_register_types(void)
+{
+    type_register_static(&pnv_link_info);
+}
+
+type_init(pnv_machine_register_types)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cbb64ad9e7e0..96f70ac2df8b 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -133,7 +133,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
         return;
     }
=20
-    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->link =3D pnv_link_create(child, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b35aff5d811c..d151460dc72c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1746,7 +1746,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
         CPUState *cs;
         CPU_FOREACH(cs) {
             PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-            icp_resend(ICP(cpu->intc));
+            icp_resend(spapr_link_icp(cpu));
         }
     }
=20
@@ -3763,6 +3763,76 @@ static void spapr_phb_placement(sPAPRMachineState =
*spapr, uint32_t index,
     *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
 }
=20
+
+#define TYPE_SPAPR_LINK "spapr-link"
+#define SPAPR_LINK(obj) OBJECT_CHECK(sPAPRLink, (obj), TYPE_SPAPR_LINK)
+
+typedef struct sPAPRLink {
+    DeviceState parent;
+
+    ICPState *icp;
+} sPAPRLink;
+
+static void spapr_link_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    sPAPRLink *link =3D SPAPR_LINK(dev);
+    Object *cpu;
+    Error *local_err =3D NULL;
+
+    cpu =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
+    if (!cpu) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'cpu' not found: ");
+        return;
+    }
+
+    link->icp =3D ICP(icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr=
),
+                               &local_err));
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void spapr_link_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D spapr_link_realize;
+}
+
+static const TypeInfo spapr_link_info =3D {
+    .name =3D TYPE_SPAPR_LINK,
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(sPAPRLink),
+    .class_init =3D spapr_link_class_init,
+};
+
+Object *spapr_link_create(Object *cpu, sPAPRMachineState *spapr, Error *=
*errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(TYPE_SPAPR_LINK);
+    object_property_add_child(cpu, TYPE_SPAPR_LINK, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        obj =3D NULL;
+    }
+
+    return obj;
+}
+
+ICPState *spapr_link_icp(PowerPCCPU *cpu)
+{
+    return SPAPR_LINK(cpu->link)->icp;
+}
+
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
@@ -3781,7 +3851,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
vcpu_id)
 {
     PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
=20
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? spapr_link_icp(cpu) : NULL;
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -3923,7 +3993,7 @@ static void spapr_pic_print_info(InterruptStatsProv=
ider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(spapr_link_icp(cpu), mon);
     }
=20
     ics_pic_print_info(spapr->ics, mon);
@@ -4472,6 +4542,7 @@ DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
+    type_register_static(&spapr_link_info);
 }
=20
 type_init(spapr_machine_register_types)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 01dbc6942410..f02a41d011e9 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -104,7 +104,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
         spapr_cpu_destroy(cpu);
-        object_unparent(cpu->intc);
+        object_unparent(cpu->link);
         cpu_remove_sync(cs);
         object_unparent(obj);
     }
@@ -128,8 +128,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
         goto error;
     }
=20
-    cpu->intc =3D icp_create(child, spapr->icp_type, XICS_FABRIC(spapr),
-                           &local_err);
+    cpu->link =3D spapr_link_create(child, spapr, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 90759240a7b1..f76b3aa16ceb 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -137,6 +137,9 @@ typedef struct PnvMachineState {
     Notifier     powerdown_notifier;
 } PnvMachineState;
=20
+Object *pnv_link_create(Object *cpu, Error **errp);
+ICPState *pnv_link_icp(PowerPCCPU *cpu);
+
 static inline bool pnv_chip_is_power9(const PnvChip *chip)
 {
     return PNV_CHIP_GET_CLASS(chip)->chip_type =3D=3D PNV_CHIP_POWER9;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d60b7c6d7a8b..5a160f75ac8f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -803,4 +803,7 @@ void spapr_caps_reset(sPAPRMachineState *spapr);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
=20
+Object *spapr_link_create(Object *cpu, sPAPRMachineState *spapr, Error *=
*errp);
+ICPState *spapr_link_icp(PowerPCCPU *cpu);
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8c9e03f54d3d..19f43bbe6723 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1204,7 +1204,7 @@ struct PowerPCCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
-    Object *intc;
+    Object *link;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
=20
--=20
2.13.6
