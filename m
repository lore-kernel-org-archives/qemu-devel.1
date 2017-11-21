Received: from eggs.gnu.org ([2001:4830:134:3::10]:35645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard@rpsys.net>) id 1eHCPn-00068p-WC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard@rpsys.net>) id 1eHCPm-0001hh-TP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:32:56 -0500
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 21 Nov 2017 17:32:18 +0000
Message-Id: <1511285538-22883-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix system lockups caused by
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
 target/ppc/excp_helper.c | 12 +++++++++---
 target/ppc/helper_regs.h |  8 ++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e6009e7..f175c21 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -207,7 +207,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
                         "Entering checkstop state\n");
             }
             cs->halted = 1;
-            cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+            qemu_mutex_lock_iothread();
+            cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+            qemu_mutex_unlock_iothread();
         }
         if (env->msr_mask & MSR_HVB) {
             /* ISA specifies HV, but can be delivered to guest with HV clear
@@ -940,7 +942,9 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
 
     if (excp != 0) {
         CPUState *cs = CPU(ppc_env_get_cpu(env));
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        qemu_mutex_lock_iothread();
+        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        qemu_mutex_unlock_iothread();
         raise_exception(env, excp);
     }
 }
@@ -995,7 +999,9 @@ static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
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
index 2627a70..13dd0b8 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -114,11 +114,15 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
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
