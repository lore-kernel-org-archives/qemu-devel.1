Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5jI-0000G0-IU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5jH-0004ul-AO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:25:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  5 Dec 2017 16:25:01 +1100
Message-Id: <20171205052501.13414-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171205052501.13414-1-david@gibson.dropbear.id.au>
References: <20171205052501.13414-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/1] target/ppc: Fix system lockups caused by
 interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Purdie <richard.purdie@linuxfoundation.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Occasionally in Linux guests on x86_64 we're seeing logs like:

ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 => pending 00000100req 00000004

when they should read:

ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 => pending 00000100req 00000002

The "00000004" is CPU_INTERRUPT_EXITTB yet the code calls
cpu_interrupt(cs, CPU_INTERRUPT_HARD) ("00000002") in this function
just before the log message. Something is causing the HARD bit setting
to get lost.

The knock on effect of losing that bit is the decrementer timer interrupts
don't get delivered which causes the guest to sit idle in its idle handler
and 'hang'.

The issue occurs due to races from code which sets CPU_INTERRUPT_EXITTB.

Rather than poking directly into cs->interrupt_request, that code needs to:

a) hold BQL
b) use the cpu_interrupt() helper

This patch fixes the call sites to do this, fixing the hang. The calls
are made from a variety of contexts so a helper function is added to handle
the necessary locking. This can likely be improved and optimised in the future
but it ensures the code is correct and doesn't lockup as it stands today.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c |  7 +++----
 target/ppc/helper_regs.h | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e6009e70e5..37d2410726 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -207,7 +207,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
                         "Entering checkstop state\n");
             }
             cs->halted = 1;
-            cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+            cpu_interrupt_exittb(cs);
         }
         if (env->msr_mask & MSR_HVB) {
             /* ISA specifies HV, but can be delivered to guest with HV clear
@@ -940,7 +940,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
 
     if (excp != 0) {
         CPUState *cs = CPU(ppc_env_get_cpu(env));
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_exittb(cs);
         raise_exception(env, excp);
     }
 }
@@ -995,8 +995,7 @@ static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     /* No need to raise an exception here,
      * as rfi is always the last insn of a TB
      */
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
-
+    cpu_interrupt_exittb(cs);
     /* Reset the reservation */
     env->reserve_addr = -1;
 
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 2627a70176..84fd30c2db 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -20,6 +20,8 @@
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
+#include "qemu/main-loop.h"
+
 /* Swap temporary saved registers with GPRs */
 static inline void hreg_swap_gpr_tgpr(CPUPPCState *env)
 {
@@ -96,6 +98,17 @@ static inline void hreg_compute_hflags(CPUPPCState *env)
     env->hflags |= env->hflags_nmsr;
 }
 
+static inline void cpu_interrupt_exittb(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        qemu_mutex_lock_iothread();
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        qemu_mutex_unlock_iothread();
+    } else {
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+    }
+}
+
 static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
                                  int alter_hv)
 {
@@ -114,11 +127,11 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
     }
     if (((value >> MSR_IR) & 1) != msr_ir ||
         ((value >> MSR_DR) & 1) != msr_dr) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_exittb(cs);
     }
     if ((env->mmu_model & POWERPC_MMU_BOOKE) &&
         ((value >> MSR_GS) & 1) != msr_gs) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_exittb(cs);
     }
     if (unlikely((env->flags & POWERPC_FLAG_TGPR) &&
                  ((value ^ env->msr) & (1 << MSR_TGPR)))) {
-- 
2.14.3
