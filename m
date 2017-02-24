Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCzi-0006ye-9c
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCze-0000aI-6Z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:58 -0500
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:50225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCzd-0000ZN-Q3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:54 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A7B3ADCAF1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:20:52 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:23 +0100
Message-Id: <1487931503-10607-25-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 24/24] ppc/xics: remove the XICSState classes
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

The XICSState classes are not used anymore. They have now been fully
deprecated by the XICSFabric QOM interface. Do the cleanups.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c         | 11 -----------
 hw/intc/xics_kvm.c     | 13 -------------
 hw/intc/xics_spapr.c   | 14 --------------
 hw/ppc/spapr.c         | 41 +++++++++++++++--------------------------
 include/hw/ppc/spapr.h |  1 -
 include/hw/ppc/xics.h  | 35 -----------------------------------
 6 files changed, 15 insertions(+), 100 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 565b5ec0686a..5c078ce6950e 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -135,16 +135,6 @@ static void ics_simple_pic_print_info(InterruptStats=
Provider *obj,
 }
=20
 /*
- * XICS Common class - parent for emulated XICS and KVM-XICS
- */
-static const TypeInfo xics_common_info =3D {
-    .name          =3D TYPE_XICS_COMMON,
-    .parent        =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(XICSState),
-    .class_size    =3D sizeof(XICSStateClass),
-};
-
-/*
  * ICP: Presentation layer
  */
=20
@@ -706,7 +696,6 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi)
=20
 static void xics_register_types(void)
 {
-    type_register_static(&xics_common_info);
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
     type_register_static(&icp_info);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 4ea34ea6dac5..15e3e338f39c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -42,12 +42,6 @@
=20
 static int kernel_xics_fd =3D -1;
=20
-typedef struct KVMXICSState {
-    XICSState parent_obj;
-
-    int kernel_xics_fd;
-} KVMXICSState;
-
 /*
  * ICP-KVM
  */
@@ -429,15 +423,8 @@ fail:
     return -1;
 }
=20
-static const TypeInfo xics_spapr_kvm_info =3D {
-    .name          =3D TYPE_XICS_SPAPR_KVM,
-    .parent        =3D TYPE_XICS_COMMON,
-    .instance_size =3D sizeof(KVMXICSState),
-};
-
 static void xics_kvm_register_types(void)
 {
-    type_register_static(&xics_spapr_kvm_info);
     type_register_static(&ics_kvm_info);
     type_register_static(&icp_kvm_info);
 }
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index aaf6808cd220..84d24b2837a7 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -257,13 +257,6 @@ int xics_spapr_init(sPAPRMachineState *spapr, Error =
**errp)
     return 0;
 }
=20
-static const TypeInfo xics_spapr_info =3D {
-    .name          =3D TYPE_XICS_SPAPR,
-    .parent        =3D TYPE_XICS_COMMON,
-    .instance_size =3D sizeof(XICSState),
-    .class_size =3D sizeof(XICSStateClass),
-};
-
 #define ICS_IRQ_FREE(ics, srcno)   \
     (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
=20
@@ -400,10 +393,3 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint32=
_t phandle)
     _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
     _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
 }
-
-static void xics_spapr_register_types(void)
-{
-    type_register_static(&xics_spapr_info);
-}
-
-type_init(xics_spapr_register_types)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0a730bd69862..1e8e152c6f49 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -95,22 +95,13 @@
=20
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
-static XICSState *try_create_xics(sPAPRMachineState *spapr,
-                                  const char *type, const char *type_ics=
,
+static int try_create_xics(sPAPRMachineState *spapr, const char *type_ic=
s,
                                   const char *type_icp, int nr_servers,
                                   int nr_irqs, Error **errp)
 {
     Error *err =3D NULL, *local_err =3D NULL;
-    XICSState *xics;
     int i;
=20
-    xics =3D XICS_COMMON(object_new(type));
-    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
-    object_property_set_bool(OBJECT(xics), true, "realized", &err);
-    if (err) {
-        goto error;
-    }
-
     spapr->ics =3D ICS_SIMPLE(object_new(type_ics));
     qdev_set_parent_bus(DEVICE(spapr->ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(spapr->ics), =
NULL);
@@ -137,32 +128,31 @@ static XICSState *try_create_xics(sPAPRMachineState=
 *spapr,
         object_unref(OBJECT(icp));
     }
=20
-    return xics;
+    return 0;
=20
 error:
     error_propagate(errp, err);
     if (spapr->ics) {
         object_unparent(OBJECT(spapr->ics));
     }
-    object_unparent(OBJECT(xics));
-    return NULL;
+    return -1;
 }
=20
-static XICSState *xics_system_init(MachineState *machine,
-                                   int nr_servers, int nr_irqs, Error **=
errp)
+static int xics_system_init(MachineState *machine,
+                            int nr_servers, int nr_irqs, Error **errp)
 {
-    XICSState *xics =3D NULL;
+    int rc =3D -1;
=20
     if (kvm_enabled()) {
         Error *err =3D NULL;
=20
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(SPAPR_MACHINE(machine), errp)) {
-            xics =3D try_create_xics(SPAPR_MACHINE(machine),
-                                   TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
+            rc =3D try_create_xics(SPAPR_MACHINE(machine),
+                                   TYPE_ICS_KVM,
                                    TYPE_KVM_ICP, nr_servers, nr_irqs, &e=
rr);
         }
-        if (machine_kernel_irqchip_required(machine) && !xics) {
+        if (machine_kernel_irqchip_required(machine) && rc < 0) {
             error_reportf_err(err,
                               "kernel_irqchip requested but unavailable:=
 ");
         } else {
@@ -170,14 +160,14 @@ static XICSState *xics_system_init(MachineState *ma=
chine,
         }
     }
=20
-    if (!xics) {
+    if (rc < 0) {
         xics_spapr_init(SPAPR_MACHINE(machine), errp);
-        xics =3D try_create_xics(SPAPR_MACHINE(machine),
-                               TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE,
+        rc =3D try_create_xics(SPAPR_MACHINE(machine),
+                               TYPE_ICS_SIMPLE,
                                TYPE_ICP, nr_servers, nr_irqs, errp);
     }
=20
-    return xics;
+    return rc;
 }
=20
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
@@ -1939,9 +1929,8 @@ static void ppc_spapr_init(MachineState *machine)
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
     /* Set up Interrupt Controller before we create the VCPUs */
-    spapr->xics =3D xics_system_init(machine,
-                                   DIV_ROUND_UP(max_cpus * smt, smp_thre=
ads),
-                                   XICS_IRQS_SPAPR, &error_fatal);
+    xics_system_init(machine, DIV_ROUND_UP(max_cpus * smt, smp_threads),
+                     XICS_IRQS_SPAPR, &error_fatal);
=20
     /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
     spapr->ov5 =3D spapr_ovec_new();
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f5bbb040f941..cfd271129dd0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -58,7 +58,6 @@ struct sPAPRMachineState {
     struct VIOsPAPRBus *vio_bus;
     QLIST_HEAD(, sPAPRPHBState) phbs;
     struct sPAPRNVRAM *nvram;
-    XICSState *xics;
     ICSState *ics;
     DeviceState *rtc;
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index ac98d5448d19..d7f2ef143436 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -30,29 +30,6 @@
=20
 #include "hw/sysbus.h"
=20
-#define TYPE_XICS_COMMON "xics-common"
-#define XICS_COMMON(obj) OBJECT_CHECK(XICSState, (obj), TYPE_XICS_COMMON=
)
-
-/*
- * Retain xics as the type name to be compatible for migration. Rest all=
 the
- * functions, class and variables are renamed as xics_spapr.
- */
-#define TYPE_XICS_SPAPR "xics"
-#define XICS_SPAPR(obj) OBJECT_CHECK(XICSState, (obj), TYPE_XICS_SPAPR)
-
-#define TYPE_XICS_SPAPR_KVM "xics-spapr-kvm"
-#define XICS_SPAPR_KVM(obj) \
-     OBJECT_CHECK(KVMXICSState, (obj), TYPE_XICS_SPAPR_KVM)
-
-#define XICS_COMMON_CLASS(klass) \
-     OBJECT_CLASS_CHECK(XICSStateClass, (klass), TYPE_XICS_COMMON)
-#define XICS_SPAPR_CLASS(klass) \
-     OBJECT_CLASS_CHECK(XICSStateClass, (klass), TYPE_XICS_SPAPR)
-#define XICS_COMMON_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(XICSStateClass, (obj), TYPE_XICS_COMMON)
-#define XICS_SPAPR_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(XICSStateClass, (obj), TYPE_XICS_SPAPR)
-
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
 #define XICS_IRQ_BASE   (XICS_BUID << 12)
@@ -62,24 +39,12 @@
  * (the kernel implementation supports more but we don't exploit
  *  that yet)
  */
-typedef struct XICSStateClass XICSStateClass;
-typedef struct XICSState XICSState;
 typedef struct ICPStateClass ICPStateClass;
 typedef struct ICPState ICPState;
 typedef struct ICSStateClass ICSStateClass;
 typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
=20
-struct XICSStateClass {
-    DeviceClass parent_class;
-};
-
-struct XICSState {
-    /*< private >*/
-    DeviceState parent_obj;
-    /*< public >*/
-};
-
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
=20
--=20
2.7.4
