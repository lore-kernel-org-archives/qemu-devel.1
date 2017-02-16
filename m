Received: from eggs.gnu.org ([2001:4830:134:3::10]:38077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQB-0001Op-Kw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQ8-00053J-CE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:31 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQ8-000539-2K
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:28 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E72C624103
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:48:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:26 +0100
Message-Id: <1487252865-12064-4-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/22] ppc/xics: store the ICS object under
 the sPAPR machine
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

A list of ICS objects was introduced under the XICS object for the
PowerNV machine, but, for the sPAPR machine, it brings extra complexity
as there is only a single ICS. To simplify the code, let's add the ICS
pointer under the sPAPR machine and try to reduce the use of this list
where possible.

Also, change the xics_spapr_*() routines to use an ICS object instead
of an XICSState and change their name to reflect that these are
specific to the sPAPR ICS object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c   | 22 +++++++++-------------
 hw/ppc/spapr.c         | 29 ++++++++++++++++-------------
 hw/ppc/spapr_events.c  |  4 ++--
 hw/ppc/spapr_pci.c     |  8 ++++----
 hw/ppc/spapr_vio.c     |  2 +-
 include/hw/ppc/spapr.h |  1 +
 include/hw/ppc/xics.h  |  6 +++---
 7 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 859b5675e175..1501e796e5e0 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -118,7 +118,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
                           uint32_t nargs, target_ulong args,
                           uint32_t nret, target_ulong rets)
 {
-    ICSState *ics =3D QLIST_FIRST(&spapr->xics->ics);
+    ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno, server, priority;
=20
     if ((nargs !=3D 3) || (nret !=3D 1)) {
@@ -151,7 +151,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
                           uint32_t nargs, target_ulong args,
                           uint32_t nret, target_ulong rets)
 {
-    ICSState *ics =3D QLIST_FIRST(&spapr->xics->ics);
+    ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
     if ((nargs !=3D 1) || (nret !=3D 3)) {
@@ -181,7 +181,7 @@ static void rtas_int_off(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
                          uint32_t nargs, target_ulong args,
                          uint32_t nret, target_ulong rets)
 {
-    ICSState *ics =3D QLIST_FIRST(&spapr->xics->ics);
+    ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
     if ((nargs !=3D 1) || (nret !=3D 1)) {
@@ -212,7 +212,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
                         uint32_t nargs, target_ulong args,
                         uint32_t nret, target_ulong rets)
 {
-    ICSState *ics =3D QLIST_FIRST(&spapr->xics->ics);
+    ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
     if ((nargs !=3D 1) || (nret !=3D 1)) {
@@ -294,9 +294,8 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
     return -1;
 }
=20
-int xics_spapr_alloc(XICSState *xics, int irq_hint, bool lsi, Error **er=
rp)
+int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)
 {
-    ICSState *ics =3D QLIST_FIRST(&xics->ics);
     int irq;
=20
     if (!ics) {
@@ -327,10 +326,9 @@ int xics_spapr_alloc(XICSState *xics, int irq_hint, =
bool lsi, Error **errp)
  * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
  * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
  */
-int xics_spapr_alloc_block(XICSState *xics, int num, bool lsi, bool alig=
n,
-                           Error **errp)
+int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi,
+                          bool align, Error **errp)
 {
-    ICSState *ics =3D QLIST_FIRST(&xics->ics);
     int i, first =3D -1;
=20
     if (!ics) {
@@ -380,11 +378,9 @@ static void ics_free(ICSState *ics, int srcno, int n=
um)
     }
 }
=20
-void xics_spapr_free(XICSState *xics, int irq, int num)
+void spapr_ics_free(ICSState *ics, int irq, int num)
 {
-    ICSState *ics =3D xics_find_source(xics, irq);
-
-    if (ics) {
+    if (ics_valid_irq(ics, irq)) {
         trace_xics_ics_free(0, irq, num);
         ics_free(ics, irq - ics->offset, num);
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5d7c35de8cd9..045f2323a4e9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -95,13 +95,13 @@
=20
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
-static XICSState *try_create_xics(const char *type, const char *type_ics=
,
+static XICSState *try_create_xics(sPAPRMachineState *spapr,
+                                  const char *type, const char *type_ics=
,
                                   const char *type_icp, int nr_servers,
                                   int nr_irqs, Error **errp)
 {
     Error *err =3D NULL, *local_err =3D NULL;
     XICSState *xics;
-    ICSState *ics =3D NULL;
     int i;
=20
     xics =3D XICS_COMMON(object_new(type));
@@ -111,16 +111,17 @@ static XICSState *try_create_xics(const char *type,=
 const char *type_ics,
         goto error;
     }
=20
-    ics =3D ICS_SIMPLE(object_new(type_ics));
-    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL);
-    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
-    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xics), NU=
LL);
-    object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
+    spapr->ics =3D ICS_SIMPLE(object_new(type_ics));
+    object_property_add_child(OBJECT(spapr), "ics", OBJECT(spapr->ics), =
NULL);
+    object_property_set_int(OBJECT(spapr->ics), nr_irqs, "nr-irqs", &err=
);
+    object_property_add_const_link(OBJECT(spapr->ics), "xics", OBJECT(xi=
cs),
+                                   NULL);
+    object_property_set_bool(OBJECT(spapr->ics), true, "realized", &loca=
l_err);
     error_propagate(&err, local_err);
     if (err) {
         goto error;
     }
-    QLIST_INSERT_HEAD(&xics->ics, ics, list);
+    QLIST_INSERT_HEAD(&xics->ics, spapr->ics, list);
=20
     xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
     xics->nr_servers =3D nr_servers;
@@ -142,8 +143,8 @@ static XICSState *try_create_xics(const char *type, c=
onst char *type_ics,
=20
 error:
     error_propagate(errp, err);
-    if (ics) {
-        object_unparent(OBJECT(ics));
+    if (spapr->ics) {
+        object_unparent(OBJECT(spapr->ics));
     }
     object_unparent(OBJECT(xics));
     return NULL;
@@ -158,7 +159,8 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
         Error *err =3D NULL;
=20
         if (machine_kernel_irqchip_allowed(machine)) {
-            xics =3D try_create_xics(TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
+            xics =3D try_create_xics(SPAPR_MACHINE(machine),
+                                   TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
                                    TYPE_KVM_ICP, nr_servers, nr_irqs, &e=
rr);
         }
         if (machine_kernel_irqchip_required(machine) && !xics) {
@@ -170,8 +172,9 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
     }
=20
     if (!xics) {
-        xics =3D try_create_xics(TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE, TYPE_=
ICP,
-                               nr_servers, nr_irqs, errp);
+        xics =3D try_create_xics(SPAPR_MACHINE(machine),
+                               TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE,
+                               TYPE_ICP, nr_servers, nr_irqs, errp);
     }
=20
     return xics;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f85a9c32a7fc..38b4258a9be7 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -752,7 +752,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
     spapr->event_sources =3D spapr_event_sources_new();
=20
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 xics_spapr_alloc(spapr->xics, 0, false,
+                                 spapr_ics_alloc(spapr->ics, 0, false,
                                                   &error_fatal));
=20
     /* NOTE: if machine supports modern/dedicated hotplug event source,
@@ -765,7 +765,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
      */
     if (spapr->use_hotplug_event_source) {
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
-                                     xics_spapr_alloc(spapr->xics, 0, fa=
lse,
+                                     spapr_ics_alloc(spapr->ics, 0, fals=
e,
                                                       &error_fatal));
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index fd6fc1d95344..01d5c92425ed 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
             return;
         }
=20
-        xics_spapr_free(spapr->xics, msi->first_irq, msi->num);
+        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
         }
@@ -363,7 +363,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    irq =3D xics_spapr_alloc_block(spapr->xics, req_num, false,
+    irq =3D spapr_ics_alloc_block(spapr->ics, req_num, false,
                            ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
@@ -374,7 +374,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
-        xics_spapr_free(spapr->xics, msi->first_irq, msi->num);
+        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
         g_hash_table_remove(phb->msi, &config_addr);
     }
=20
@@ -1485,7 +1485,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
         uint32_t irq;
         Error *local_err =3D NULL;
=20
-        irq =3D xics_spapr_alloc_block(spapr->xics, 1, true, false, &loc=
al_err);
+        irq =3D spapr_ics_alloc_block(spapr->ics, 1, true, false, &local=
_err);
         if (local_err) {
             error_propagate(errp, local_err);
             error_prepend(errp, "can't allocate LSIs: ");
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 8bfc5f971f8e..a0ee4fd26586 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -454,7 +454,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
         dev->qdev.id =3D id;
     }
=20
-    dev->irq =3D xics_spapr_alloc(spapr->xics, dev->irq, false, &local_e=
rr);
+    dev->irq =3D spapr_ics_alloc(spapr->ics, dev->irq, false, &local_err=
);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f9b17d860a75..21e506b13cfa 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -59,6 +59,7 @@ struct sPAPRMachineState {
     QLIST_HEAD(, sPAPRPHBState) phbs;
     struct sPAPRNVRAM *nvram;
     XICSState *xics;
+    ICSState *ics;
     DeviceState *rtc;
=20
     void *htab;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index fc4abcd4e796..6d443ce09dba 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -180,10 +180,10 @@ struct ICSIRQState {
 #define XICS_IRQS_SPAPR               1024
=20
 qemu_irq xics_get_qirq(XICSState *icp, int irq);
-int xics_spapr_alloc(XICSState *icp, int irq_hint, bool lsi, Error **err=
p);
-int xics_spapr_alloc_block(XICSState *icp, int num, bool lsi, bool align=
,
+int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)=
;
+int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
                            Error **errp);
-void xics_spapr_free(XICSState *icp, int irq, int num);
+void spapr_ics_free(ICSState *ics, int irq, int num);
 void spapr_dt_xics(XICSState *xics, void *fdt, uint32_t phandle);
=20
 void xics_cpu_setup(XICSState *icp, PowerPCCPU *cpu);
--=20
2.7.4
