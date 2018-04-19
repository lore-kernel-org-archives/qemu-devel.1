Received: from eggs.gnu.org ([2001:4830:134:3::10]:57831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wW-0000mi-K0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wS-0000UX-MW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:40 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:39048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wS-0000Tn-CD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:36 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.111])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E8AAE149ADB
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:34 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:15 +0200
Message-Id: <20180419124331.3915-20-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/35] spapr: toggle the ICP depending on
 the selected interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Each interrupt mode has its own specific interrupt presenter object,
that we store under the CPU object, one for XICS and one for XIVE. The
active presenter, corresponding to the current interrupt mode, is
simply selected with a lookup on the children of the CPU.

Migration and CPU hotplug also need to reflect the current interrupt
mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c                  | 19 ++++++++++++++++++
 hw/ppc/spapr.c                  | 40 +++++++++++++++++++++++++++++++++++=
++
 hw/ppc/spapr_cpu_core.c         | 44 +++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr.h          |  1 +
 include/hw/ppc/spapr_cpu_core.h |  2 ++
 include/hw/ppc/xive.h           |  1 +
 6 files changed, 107 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 20e216f03c5b..2daa36f77a6b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -88,6 +88,25 @@ static void xive_eq_push(XiveEQ *eq, uint32_t data)
  * XIVE Interrupt Presenter
  */
=20
+Object *xive_nvt_create(Object *cpu, const char *type, Error **errp)
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
+
 /* Convert a priority number to an Interrupt Pending Buffer (IPB)
  * register, which indicates a pending interrupt at the priority
  * corresponding to the bit number
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32c7801b249e..0c59816bf3d6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -251,6 +251,7 @@ static void xive_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
=20
     spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE, nr_irqs, e=
rrp);
     if (spapr->xive) {
+        spapr->nvt_type =3D TYPE_XIVE_NVT;
         spapr_xive_hcall_init(spapr);
     }
 }
@@ -1522,13 +1523,32 @@ static int spapr_reset_drcs(Object *child, void *=
opaque)
 /* Setup XIVE exploitation or legacy mode as required by CAS */
 static void spapr_reset_interrupt(sPAPRMachineState *spapr, Error **errp=
)
 {
+    Error *local_err =3D NULL;
+    const char *intc_type;
+
     /* Reset XIVE if enabled */
     if (spapr->xive_exploitation) {
         spapr_xive_mmio_unmap(spapr->xive);
     }
=20
+    /* Reset CPU ICPs */
+    spapr_cpu_core_reset_icp(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
         spapr_xive_mmio_map(spapr->xive);
+        intc_type =3D spapr->nvt_type;
+    } else {
+        intc_type =3D spapr->icp_type;
+    }
+
+    spapr_cpu_core_set_icp(intc_type, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
 }
=20
@@ -3963,6 +3983,26 @@ Object *spapr_icp_create(sPAPRMachineState *spapr,=
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
+        obj_xive =3D xive_nvt_create(cpu, spapr->nvt_type, &local_err);
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
index 76bff4cc372d..3df2bda53f50 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -256,3 +256,47 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
 };
=20
 DEFINE_TYPES(spapr_cpu_core_type_infos)
+
+void spapr_cpu_core_reset_icp(Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        cpu->intc =3D NULL;
+    }
+}
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d5e168f5ad4e..43ef5f743974 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -168,6 +168,7 @@ struct sPAPRMachineState {
     const char *icp_type;
     uint8_t xive_exploitation;
     sPAPRXive  *xive;
+    const char *nvt_type;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 1129f344aa0c..c7ccc99d22e7 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_core_set_icp(const char *icp_type, Error **errp);
+void spapr_cpu_core_reset_icp(Error **errp);
 #endif
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 328b093eb9c3..24ce58812a7c 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -191,6 +191,7 @@ extern const MemoryRegionOps xive_tm_os_ops;
=20
 void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon);
 XiveEQ *xive_nvt_eq_get(XiveNVT *nvt, uint8_t priority);
+Object *xive_nvt_create(Object *cpu, const char *type, Error **errp);
=20
 void xive_eq_reset(XiveEQ *eq);
 void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon);
--=20
2.13.6
