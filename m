Received: from eggs.gnu.org ([2001:4830:134:3::10]:56491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard@rpsys.net>) id 1eKncP-00062y-V4
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard@rpsys.net>) id 1eKnbn-0006ap-Iv
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:52:49 -0500
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri,  1 Dec 2017 15:49:07 +0000
Message-Id: <1512143347-20128-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [Qemu-devel] [PATCH v2] target/ppc: Fix system lockups caused by
 interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-ppc@nongnu.org, Richard Purdie <richard.purdie@linuxfoundation.org>

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

This patch fixes the call sites to do this, fixing the hang.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 target/ppc/excp_helper.c | 16 +++++++++++++---
 target/ppc/helper_regs.h | 10 ++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

v2: Fixes a compile issue with master and ensures BQL is held in one case
where it potentially wasn't.

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e6009e7..8040277 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -207,7 +207,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
                         "Entering checkstop state\n");
             }
             cs->halted = 1;
-            cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+            if (!qemu_mutex_iothread_locked()) {
+                qemu_mutex_lock_iothread();
+                cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+                qemu_mutex_unlock_iothread();
+            } else {
+                cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+            }
         }
         if (env->msr_mask & MSR_HVB) {
             /* ISA specifies HV, but can be delivered to guest with HV clear
@@ -940,7 +946,9 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
 
     if (excp != 0) {
         CPUState *cs = CPU(ppc_env_get_cpu(env));
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        qemu_mutex_lock_iothread();
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        qemu_mutex_unlock_iothread();
         raise_exception(env, excp);
     }
 }
@@ -995,7 +1003,9 @@ static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     /* No need to raise an exception here,
      * as rfi is always the last insn of a TB
      */
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    qemu_mutex_lock_iothread();
+    cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+    qemu_mutex_unlock_iothread();
 
     /* Reset the reservation */
     env->reserve_addr = -1;
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 2627a70..0beaad5 100644
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
@@ -114,11 +116,15 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
     }
     if (((value >> MSR_IR) & 1) != msr_ir ||
         ((value >> MSR_DR) & 1) != msr_dr) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        qemu_mutex_lock_iothread();
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        qemu_mutex_unlock_iothread();
     }
     if ((env->mmu_model & POWERPC_MMU_BOOKE) &&
         ((value >> MSR_GS) & 1) != msr_gs) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        qemu_mutex_lock_iothread();
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        qemu_mutex_unlock_iothread();
     }
     if (unlikely((env->flags & POWERPC_FLAG_TGPR) &&
                  ((value ^ env->msr) & (1 << MSR_TGPR)))) {
-- 
2.7.4
