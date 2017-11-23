Received: from eggs.gnu.org ([2001:4830:134:3::10]:40228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcj-0002TV-Of
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcg-0003cD-IZ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:33:01 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:41950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcg-0003bT-CF
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:58 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 06667175B19
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:53 +0100
Message-Id: <20171123132955.1261-24-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/25] spapr: toggle the ICP depending on the
 selected interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Each interrupt mode has its own specific interrupt presenter object,
that we store under the CPU object, one for XICS and one for XIVE. The
active presenter, corresponding to the current interrupt mode, is
simply selected with a lookup on the children of the CPU.

Migration and CPU hotplug also need to reflect the current interrupt
mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c                  | 21 ++++++++++++++++++++-
 hw/ppc/spapr_cpu_core.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_cpu_core.h |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a91ec1c0751a..b7389dbdf5ca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1128,8 +1128,10 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
=20
     /* /interrupt controller */
     if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_cpu_core_set_icp(spapr->icp_type);
         spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
     } else {
+        spapr_cpu_core_set_icp(TYPE_SPAPR_XIVE_ICP);
         /* Populate device tree for XIVE */
         spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHANDL=
E_XICP);
         spapr_xive_mmio_map(spapr);
@@ -1615,6 +1617,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
     }
=20
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_cpu_core_set_icp(TYPE_SPAPR_XIVE_ICP);
         spapr_xive_mmio_map(spapr);
     }
=20
@@ -3610,7 +3613,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
vcpu_id)
 Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp)
 {
     Error *local_err =3D NULL;
-    Object *obj;
+    Object *obj, *obj_xive;
=20
     obj =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_e=
rr);
     if (local_err) {
@@ -3618,6 +3621,22 @@ Object *spapr_icp_create(sPAPRMachineState *spapr,=
 CPUState *cs, Error **errp)
         return NULL;
     }
=20
+    /* Add a XIVE interrupt presenter. The machine will switch the CPU
+     * ICP depending on the interrupt model negotiated at CAS time.
+     */
+    obj_xive =3D icp_create(cs, TYPE_SPAPR_XIVE_ICP, XICS_FABRIC(spapr),
+                          &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    /* when hotplugged, the CPU should have the correct ICP */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return obj_xive;
+    }
+
     return obj;
 }
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 61a9850e688b..b0e39270f262 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -257,3 +257,34 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
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
+void spapr_cpu_core_set_icp(const char *icp_type)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        ForeachFindICPArgs args =3D { icp_type, NULL };
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        object_child_foreach(OBJECT(cs), spapr_cpu_core_find_icp, &args)=
;
+        g_assert(args.icp);
+
+        cpu->intc =3D args.icp;
+    }
+}
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index f2d48d6a6786..a657dfb8863c 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,5 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_core_set_icp(const char *icp_type);
 #endif
--=20
2.13.6
