Received: from eggs.gnu.org ([2001:4830:134:3::10]:35389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNx-0003Dt-5I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNv-0006XE-KY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  8 Jan 2018 16:53:48 +1100
Message-Id: <20180108055348.20444-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180108055348.20444-1-david@gibson.dropbear.id.au>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/12] spapr: Correct compatibility mode setting
 for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: surajjs@au1.ibm.com, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently the pseries machine sets the compatibility mode for the
guest's cpus in two places: 1) at machine reset and 2) after CAS
negotiation.

This means that if we set or negotiate a compatiblity mode, then
hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
will incorrectly have the full native features.

To correct this, we set the compatibility mode on a cpu when it is
brought online with the 'start-cpu' RTAS call.  Given that we no
longer need to set the compatibility mode on all CPUs at machine
reset, so we change that to only set the mode for the boot cpu.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c      | 2 +-
 hw/ppc/spapr_rtas.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6785a90c60..dfd352c473 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1504,7 +1504,7 @@ static void spapr_machine_reset(void)
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas = spapr_ovec_new();
 
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
+        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
     }
 
     fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 4bb939d3d1..2b89e1d448 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
         CPUState *cs = CPU(cpu);
         CPUPPCState *env = &cpu->env;
         PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+        Error *local_err = NULL;
 
         if (!cs->halted) {
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -174,6 +175,14 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
          * new cpu enters */
         kvm_cpu_synchronize_state(cs);
 
+        /* Set compatibility mode to match existing cpus */
+        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+            return;
+        }
+
         env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
 
         /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
-- 
2.14.3
