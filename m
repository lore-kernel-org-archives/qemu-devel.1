Received: from eggs.gnu.org ([2001:4830:134:3::10]:39729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0002l7-IN
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQy-0001Yc-6n
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQx-0001Vb-VV
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQs-00032Q-9V
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:04 +0100
Message-Id: <20180426104715.21702-9-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/19] target/arm: Fetch GICv3 state directly
 from CPUARMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

This eliminates the need for fetching it from el_change_hook_opaque, and
allows for supporting multiple el_change_hooks without having to hack
something together to find the registered opaque belonging to GICv3.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1523997485-1905-6-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 10 ----------
 hw/intc/arm_gicv3_cpuif.c | 10 ++--------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 19a0c03f9b..6bd8ff5917 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2902,16 +2902,6 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
                                  void *opaque);
 
-/**
- * arm_get_el_change_hook_opaque:
- * Return the opaque data that will be used by the el_change_hook
- * for this CPU.
- */
-static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
-{
-    return cpu->el_change_hook_opaque;
-}
-
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 26f5eeda94..cb9a3a542d 100644
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
-- 
2.17.0
