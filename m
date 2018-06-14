Received: from eggs.gnu.org ([2001:4830:134:3::10]:46126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh7-0002le-8Y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh5-0001dt-Tv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:04:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 11:04:43 +1000
Message-Id: <20180614010446.30854-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180614010446.30854-1-david@gibson.dropbear.id.au>
References: <20180614010446.30854-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv2 4/7] pnv: Clean up cpu realize path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

pnv_cpu_init() is only called from the the pnv cpu core realize path, and
really only can be called from there.  So fold it into its caller, which
we also rename for brevity.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_core.c | 56 ++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1e40f01e98..f4c41d89d6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -54,28 +54,6 @@ static void pnv_cpu_reset(void *opaque)
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
 }
=20
-static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
-{
-    CPUPPCState *env =3D &cpu->env;
-    int core_pir;
-    int thread_index =3D 0; /* TODO: TCG supports only one thread */
-    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
-
-    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
-
-    /*
-     * The PIR of a thread is the core PIR + the thread index. We will
-     * need to find a way to get the thread index when TCG supports
-     * more than 1. We could use the object name ?
-     */
-    pir->default_value =3D core_pir + thread_index;
-
-    /* Set time-base frequency to 512 MHz */
-    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
-
-    qemu_register_reset(pnv_cpu_reset, cpu);
-}
-
 /*
  * These values are read by the PowerNV HW monitors under Linux
  */
@@ -121,29 +99,39 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D =
{
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
+static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **er=
rp)
 {
+    CPUPPCState *env =3D &cpu->env;
+    int core_pir;
+    int thread_index =3D 0; /* TODO: TCG supports only one thread */
+    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
     Error *local_err =3D NULL;
-    CPUState *cs =3D CPU(child);
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-    object_property_set_bool(child, true, "realized", &local_err);
+    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->intc =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    pnv_cpu_init(cpu, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
+
+    /*
+     * The PIR of a thread is the core PIR + the thread index. We will
+     * need to find a way to get the thread index when TCG supports
+     * more than 1. We could use the object name ?
+     */
+    pir->default_value =3D core_pir + thread_index;
+
+    /* Set time-base frequency to 512 MHz */
+    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
+
+    qemu_register_reset(pnv_cpu_reset, cpu);
 }
=20
 static void pnv_core_realize(DeviceState *dev, Error **errp)
@@ -178,9 +166,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        obj =3D OBJECT(pc->threads[j]);
-
-        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
+        pnv_realize_vcpu(pc->threads[j], XICS_FABRIC(xi), &local_err);
         if (local_err) {
             goto err;
         }
--=20
2.17.1
