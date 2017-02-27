Received: from eggs.gnu.org ([2001:4830:134:3::10]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLz-00032P-S9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLv-0008Jb-Ru
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:43 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:58180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLv-0008Iw-Iu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:39 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5950CB35D7
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:30 +0100
Message-Id: <1488205773-30436-24-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 23/26] ppc/xics: remove the XICSState classes
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
 hw/ppc/spapr.c         | 45 ++++++++++++++++----------------------------=
-
 include/hw/ppc/spapr.h |  1 -
 include/hw/ppc/xics.h  | 35 -----------------------------------
 6 files changed, 16 insertions(+), 103 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 51e6c0c85fca..159cd131420a 100644
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
@@ -752,7 +742,6 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi)
=20
 static void xics_register_types(void)
 {
-    type_register_static(&xics_common_info);
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
     type_register_static(&icp_info);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 99836112cd12..14de5d4bb8cc 100644
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
index 3caef0c7e683..1d0daef5ad3e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -95,24 +95,15 @@
=20
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
-static XICSState *try_create_xics(sPAPRMachineState *spapr,
-                                  const char *type, const char *type_ics=
,
-                                  const char *type_icp, int nr_servers,
-                                  int nr_irqs, Error **errp)
+static int try_create_xics(sPAPRMachineState *spapr, const char *type_ic=
s,
+                           const char *type_icp, int nr_servers,
+                           int nr_irqs, Error **errp)
 {
     XICSFabric *xi =3D XICS_FABRIC(spapr);
     Error *err =3D NULL, *local_err =3D NULL;
-    XICSState *xics;
     ICSState *ics =3D NULL;
     int i;
=20
-    xics =3D XICS_COMMON(object_new(type));
-    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
-    object_property_set_bool(OBJECT(xics), true, "realized", &err);
-    if (err) {
-        goto error;
-    }
-
     ics =3D ICS_SIMPLE(object_new(type_ics));
     qdev_set_parent_bus(DEVICE(ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
@@ -142,32 +133,30 @@ static XICSState *try_create_xics(sPAPRMachineState=
 *spapr,
     }
=20
     spapr->ics =3D ics;
-    return xics;
+    return 0;
=20
 error:
     error_propagate(errp, err);
     if (ics) {
         object_unparent(OBJECT(ics));
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
-                                   TYPE_KVM_ICP, nr_servers, nr_irqs, &e=
rr);
+            rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_KVM,
+                                 TYPE_KVM_ICP, nr_servers, nr_irqs, &err=
);
         }
-        if (machine_kernel_irqchip_required(machine) && !xics) {
+        if (machine_kernel_irqchip_required(machine) && rc < 0) {
             error_reportf_err(err,
                               "kernel_irqchip requested but unavailable:=
 ");
         } else {
@@ -175,14 +164,13 @@ static XICSState *xics_system_init(MachineState *ma=
chine,
         }
     }
=20
-    if (!xics) {
+    if (rc < 0) {
         xics_spapr_init(SPAPR_MACHINE(machine), errp);
-        xics =3D try_create_xics(SPAPR_MACHINE(machine),
-                               TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE,
+        rc =3D try_create_xics(SPAPR_MACHINE(machine), TYPE_ICS_SIMPLE,
                                TYPE_ICP, nr_servers, nr_irqs, errp);
     }
=20
-    return xics;
+    return rc;
 }
=20
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
@@ -1947,9 +1935,8 @@ static void ppc_spapr_init(MachineState *machine)
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
index b0b01e2975df..2514cfd86ea9 100644
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
@@ -62,8 +39,6 @@
  * (the kernel implementation supports more but we don't exploit
  *  that yet)
  */
-typedef struct XICSStateClass XICSStateClass;
-typedef struct XICSState XICSState;
 typedef struct ICPStateClass ICPStateClass;
 typedef struct ICPState ICPState;
 typedef struct ICSStateClass ICSStateClass;
@@ -71,16 +46,6 @@ typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
 typedef struct XICSFabric XICSFabric;
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
