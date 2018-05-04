Received: from eggs.gnu.org ([2001:4830:134:3::10]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETks-00062z-1w
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkq-0007NO-N0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:18 +1000
Message-Id: <20180504055930.3786-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/17] spapr: Clean up rtas_start_cpu() &
 rtas_stop_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This makes several minor cleanups to these functions:
  * Follow usual convention of an early exit on error, rather than having
    most of the body in an if
  * Clearer naming of cpu and cpu_.  Now callcpu is the cpu from which th=
e
    RTAS call is invoked, newcpu is the cpu which we're starting
  * Use cpu_synchronize_state() instead of kvm_cpu_synchronize_state()
    directly
  * Remove pointless comment describing what cpu_synchronize_state() does
  * Use ppc_store_lpcr() instead of directly writing the register field

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_rtas.c | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4cfe..b251c130cb 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -32,7 +32,7 @@
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
=20
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -45,6 +45,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
+#include "target/ppc/mmu-hash64.h"
=20
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
                                    uint32_t token, uint32_t nargs,
@@ -140,13 +141,15 @@ static void spapr_cpu_set_endianness(PowerPCCPU *cp=
u)
     }
 }
=20
-static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
+static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr=
,
                            uint32_t token, uint32_t nargs,
                            target_ulong args,
                            uint32_t nret, target_ulong rets)
 {
     target_ulong id, start, r3;
-    PowerPCCPU *cpu;
+    PowerPCCPU *newcpu;
+    CPUPPCState *env;
+    PowerPCCPUClass *pcc;
=20
     if (nargs !=3D 3 || nret !=3D 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -157,41 +160,37 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRM=
achineState *spapr,
     start =3D rtas_ld(args, 1);
     r3 =3D rtas_ld(args, 2);
=20
-    cpu =3D spapr_find_cpu(id);
-    if (cpu !=3D NULL) {
-        CPUState *cs =3D CPU(cpu);
-        CPUPPCState *env =3D &cpu->env;
-        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
+    newcpu =3D spapr_find_cpu(id);
+    if (!newcpu) {
+        /* Didn't find a matching cpu */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
=20
-        if (!cs->halted) {
-            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
-            return;
-        }
+    env =3D &newcpu->env;
+    pcc =3D POWERPC_CPU_GET_CLASS(newcpu);
=20
-        /* This will make sure qemu state is up to date with kvm, and
-         * mark it dirty so our changes get flushed back before the
-         * new cpu enters */
-        kvm_cpu_synchronize_state(cs);
+    if (!CPU(newcpu)->halted) {
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        return;
+    }
=20
-        env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
+    cpu_synchronize_state(CPU(newcpu));
=20
-        /* Enable Power-saving mode Exit Cause exceptions for the new CP=
U */
-        env->spr[SPR_LPCR] |=3D pcc->lpcr_pm;
+    env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
+    spapr_cpu_set_endianness(newcpu);
+    spapr_cpu_update_tb_offset(newcpu);
+    /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
+    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
=20
-        env->nip =3D start;
-        env->gpr[3] =3D r3;
-        cs->halted =3D 0;
-        spapr_cpu_set_endianness(cpu);
-        spapr_cpu_update_tb_offset(cpu);
+    env->nip =3D start;
+    env->gpr[3] =3D r3;
=20
-        qemu_cpu_kick(cs);
+    CPU(newcpu)->halted =3D 0;
=20
-        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-        return;
-    }
+    qemu_cpu_kick(CPU(newcpu));
=20
-    /* Didn't find a matching cpu */
-    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
 static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
@@ -203,13 +202,12 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
-    cs->halted =3D 1;
-    qemu_cpu_kick(cs);
-
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This could deliver an interrupt on a dying CPU and crash the
      * guest */
-    env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
+    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
+    cs->halted =3D 1;
+    qemu_cpu_kick(cs);
 }
=20
 static inline int sysparm_st(target_ulong addr, target_ulong len,
--=20
2.17.0
