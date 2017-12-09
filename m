Received: from eggs.gnu.org ([2001:4830:134:3::10]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalW-00026T-Le
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalS-00088y-MC
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:46 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:49440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNalS-00086z-C2
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:42 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 46FAE1277CF
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:41 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:36 +0100
Message-Id: <20171209084338.29395-18-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/19] spapr: toggle the ICP depending on
 the selected interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Each interrupt mode has its own specific interrupt presenter object,
that we store under the CPU object, one for XICS and one for XIVE. The
active presenter, corresponding to the current interrupt mode, is
simply selected with a lookup on the children of the CPU.

Migration and CPU hotplug also need to reflect the current interrupt
mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:
=20
 - conditioned the creation of the sPAPRXiveNVT object to the
   xive_exploitation bool which false on older pseries machine.
 - moved the setting of the ICP under the machine reset handler.
 - introduced a spapr_xive_nvt_create() helper
 - handled errors in spapr_post_load() to return EINVAL

 hw/intc/spapr_xive.c            | 19 +++++++++++++++++++
 hw/ppc/spapr.c                  | 29 +++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_cpu_core.h |  1 +
 include/hw/ppc/spapr_xive.h     |  1 +
 5 files changed, 84 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e650ed69eb70..8e6997bb1deb 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -992,3 +992,22 @@ qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn)
=20
     return xive->qirqs[lisn];
 }
+
+Object *spapr_xive_nvt_create(Object *cpu, const char *type, Error **err=
p)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(type);
+    object_property_add_child(cpu, type, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort)=
;
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        obj =3D NULL;
+    }
+
+    return obj;
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 65fca10e5b30..4d7a3d64e51e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1539,7 +1539,10 @@ static void ppc_spapr_reset(void)
=20
     /* Setup XIVE resources if required by CAS */
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_cpu_core_set_icp(TYPE_SPAPR_XIVE_NVT, &error_fatal);
         spapr_xive_mmio_map(spapr->xive);
+    } else {
+        spapr_cpu_core_set_icp(spapr->icp_type, &error_fatal);
     }
=20
     fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
@@ -1651,7 +1654,13 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
=20
     /* Restore XIVE resources if required by CAS */
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        Error *local_err =3D NULL;
+
         spapr_xive_mmio_map(spapr->xive);
+        spapr_cpu_core_set_icp(TYPE_SPAPR_XIVE_NVT, &local_err);
+        if (local_err) {
+            return -EINVAL;
+        }
     }
=20
     return err;
@@ -3832,6 +3841,26 @@ Object *spapr_icp_create(sPAPRMachineState *spapr,=
 Object *cpu, Error **errp)
         return NULL;
     }
=20
+    if (spapr->xive_exploitation) {
+        Object *obj_xive;
+
+        /* Add a XIVE interrupt presenter. The machine will switch
+         * the CPU ICP depending on the interrupt model negotiated
+         * at CAS time.
+         */
+        obj_xive =3D spapr_xive_nvt_create(cpu, TYPE_SPAPR_XIVE_NVT, &lo=
cal_err);
+        if (local_err) {
+            object_unparent(obj);
+            error_propagate(errp, local_err);
+            return NULL;
+        }
+
+        /* when hotplugged, the CPU should have the correct ICP */
+        if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+            return obj_xive;
+        }
+    }
+
     return obj;
 }
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1bfe3ff55058..e5c39cdec998 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -253,3 +253,37 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
 };
=20
 DEFINE_TYPES(spapr_cpu_core_type_infos)
+
+typedef struct ForeachFindICPArgs {
+    const char *icp_type;
+    Object *icp;
+} ForeachFindICPArgs;
+
+static int spapr_cpu_core_find_icp(Object *child, void *opaque)
+{
+    ForeachFindICPArgs *args =3D opaque;
+
+    if (object_dynamic_cast(child, args->icp_type)) {
+        args->icp =3D child;
+    }
+
+    return args->icp !=3D NULL;
+}
+
+void spapr_cpu_core_set_icp(const char *icp_type, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        ForeachFindICPArgs args =3D { icp_type, NULL };
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        object_child_foreach(OBJECT(cs), spapr_cpu_core_find_icp, &args)=
;
+        if (!args.icp) {
+            error_setg(errp, "Couldn't find a '%s' icp", icp_type);
+            return;
+        }
+
+        cpu->intc =3D args.icp;
+    }
+}
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 1129f344aa0c..916aea6137a6 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,5 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_core_set_icp(const char *icp_type, Error **errp);
 #endif
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 8eefb09999de..22eb6e8a4d01 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -59,6 +59,7 @@ bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t li=
sn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 void spapr_xive_nvt_pic_print_info(sPAPRXiveNVT *nvt, Monitor *mon);
+Object *spapr_xive_nvt_create(Object *cpu, const char *type, Error **err=
p);
 void spapr_xive_mmio_map(sPAPRXive *xive);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn);
=20
--=20
2.13.6
