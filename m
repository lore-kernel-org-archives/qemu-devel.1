Received: from eggs.gnu.org ([209.51.188.92]:38918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9V-0001FC-OV
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000Ht-M3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:03 +1100
Message-Id: <20190204090124.26191-17-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/37] ppc/pnv: introduce a CPU machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Include the interrupt presenter under the machine_data as we plan to
remove it from under PowerPCCPU

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c              |  7 ++++---
 hw/ppc/pnv_core.c         | 12 +++++++++++-
 include/hw/ppc/pnv_core.h |  9 +++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d84acef55b..da540860a2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -673,6 +673,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
 {
     Error *local_err =3D NULL;
     Object *obj;
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
     obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
                      &local_err);
@@ -681,7 +682,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
         return;
     }
=20
-    cpu->icp =3D ICP(obj);
+    pnv_cpu->icp =3D ICP(obj);
 }
=20
 /*
@@ -1099,7 +1100,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? cpu->icp : NULL;
+    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1112,7 +1113,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(cpu->icp, mon);
+        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index b98f277f1e..7c806da720 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -155,7 +155,10 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
+        PowerPCCPU *cpu;
+
         obj =3D object_new(typename);
+        cpu =3D POWERPC_CPU(obj);
=20
         pc->threads[i] =3D POWERPC_CPU(obj);
=20
@@ -163,6 +166,9 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
         object_property_add_child(OBJECT(pc), name, obj, &error_abort);
         object_property_add_alias(obj, "core-pir", OBJECT(pc),
                                   "pir", &error_abort);
+
+        cpu->machine_data =3D g_new0(PnvCPUState, 1);
+
         object_unref(obj);
     }
=20
@@ -189,9 +195,13 @@ err:
=20
 static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
 {
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(OBJECT(cpu->icp));
+    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
     cpu_remove_sync(CPU(cpu));
+    cpu->machine_data =3D NULL;
+    g_free(pnv_cpu);
     object_unparent(OBJECT(cpu));
 }
=20
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 447ae761f7..9961ea3a92 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
=20
+typedef struct PnvCPUState {
+    struct ICPState *icp;
+} PnvCPUState;
+
+static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
+{
+    return (PnvCPUState *)cpu->machine_data;
+}
+
 #endif /* _PPC_PNV_CORE_H */
--=20
2.20.1
