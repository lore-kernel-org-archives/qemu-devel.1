Received: from eggs.gnu.org ([2001:4830:134:3::10]:46374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0002yn-Fy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0006W0-5c
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:39 +1100
Message-Id: <20170112020327.24882-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/67] ppc/spapr: implement H_SIGNAL_SYS_RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nicholas Piggin <npiggin@gmail.com>

The H_SIGNAL_SYS_RESET hcall allows a guest CPU to raise a system reset
exception on CPUs within the same guest -- all CPUs, all-but-self, or a
specific CPU (including self).

This has not made its way to a PAPR release yet, but we have an hcall
number assigned.

  H_SIGNAL_SYS_RESET = 0x380

  Syntax:
    hcall(uint64 H_SIGNAL_SYS_RESET, int64 target);

  Generate a system reset NMI on the threads indicated by target.

  Values for target:
    -1 = target all online threads including the caller
    -2 = target all online threads except for the caller
    All other negative values: reserved
    Positive values: The thread to be targeted, obtained from the value
    of the "ibm,ppc-interrupt-server#s" property of the CPU in the OF
    device tree.

  Semantics:
    - Invalid target: return H_Parameter.
    - Otherwise: Generate a system reset NMI on target thread(s),
      return H_Success.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  4 ++--
 hw/ppc/spapr_hcall.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f921be3..cfadc46 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2265,7 +2265,7 @@ static void spapr_machine_finalizefn(Object *obj)
     g_free(spapr->kvm_type);
 }
 
-static void ppc_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
+void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
@@ -2276,7 +2276,7 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     CPUState *cs;
 
     CPU_FOREACH(cs) {
-        async_run_on_cpu(cs, ppc_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+        async_run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
     }
 }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 35499ae..fd9f1d4 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -881,6 +881,46 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return ret;
 }
 
+#define H_SIGNAL_SYS_RESET_ALL         -1
+#define H_SIGNAL_SYS_RESET_ALLBUTSELF  -2
+
+static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
+                                       sPAPRMachineState *spapr,
+                                       target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+
+    if (target < 0) {
+        /* Broadcast */
+        if (target < H_SIGNAL_SYS_RESET_ALLBUTSELF) {
+            return H_PARAMETER;
+        }
+
+        CPU_FOREACH(cs) {
+            PowerPCCPU *c = POWERPC_CPU(cs);
+
+            if (target == H_SIGNAL_SYS_RESET_ALLBUTSELF) {
+                if (c == cpu) {
+                    continue;
+                }
+            }
+            run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
+        }
+        return H_SUCCESS;
+
+    } else {
+        /* Unicast */
+        CPU_FOREACH(cs) {
+            if (cpu->cpu_dt_id == target) {
+                run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
+                return H_SUCCESS;
+            }
+        }
+        return H_PARAMETER;
+    }
+}
+
 typedef struct {
     uint32_t compat_pvr;
     Error *err;
@@ -1097,6 +1137,7 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
     spapr_register_hypercall(H_SET_SPRG0, h_set_sprg0);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 04d2821..a2d8964 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -347,7 +347,8 @@ struct sPAPRMachineState {
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
-#define MAX_HCALL_OPCODE        H_SET_MODE
+#define H_SIGNAL_SYS_RESET      0x380
+#define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
@@ -660,4 +661,6 @@ int spapr_rng_populate_dt(void *fdt);
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
 
+void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
+
 #endif /* HW_SPAPR_H */
-- 
2.9.3
