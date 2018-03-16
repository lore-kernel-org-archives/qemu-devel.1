Received: from eggs.gnu.org ([2001:4830:134:3::10]:44034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1O-0005ot-6j
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1N-0003Hk-6W
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:14 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:05 -0400
Message-Id: <1521232280-13089-8-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 07/22] target/arm: Fetch GICv3 state
 directly from CPUARMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

This eliminates the need for fetching it from el_change_hook_opaque, and
allows for supporting multiple el_change_hooks without having to hack
something together to find the registered opaque belonging to GICv3.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 hw/intc/arm_gicv3_cpuif.c | 10 ++--------
 target/arm/cpu.h          | 10 ----------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 5cbafaf..801f91b 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -29,11 +29,7 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 
 static GICv3CPUState *icc_cs_from_env(CPUARMState *env)
 {
-    /* Given the CPU, find the right GICv3CPUState struct.
-     * Since we registered the CPU interface with the EL change hook as
-     * the opaque pointer, we can just directly get from the CPU to it.
-     */
-    return arm_get_el_change_hook_opaque(arm_env_get_cpu(env));
+    return env->gicv3state;
 }
 
 static bool gicv3_use_ns_bank(CPUARMState *env)
@@ -2615,9 +2611,7 @@ void gicv3_init_cpuif(GICv3State *s)
          * it might be with code translated by CPU 0 but run by CPU 1, in
          * which case we'd get the wrong value.
          * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the ARMCPU by reading back
-         * the opaque pointer from the el_change_hook, which we're going
-         * to need to register anyway.
+         * get back to the GICv3CPUState from the CPUARMState.
          */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
         if (arm_feature(&cpu->env, ARM_FEATURE_EL2)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e7e1f8..f17592b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2904,16 +2904,6 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
                                  void *opaque);
 
 /**
- * arm_get_el_change_hook_opaque:
- * Return the opaque data that will be used by the el_change_hook
- * for this CPU.
- */
-static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
-{
-    return cpu->el_change_hook_opaque;
-}
-
-/**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
  */
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
