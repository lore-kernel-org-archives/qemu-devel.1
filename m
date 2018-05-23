Received: from eggs.gnu.org ([2001:4830:134:3::10]:42007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSg-0007qp-4U
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSf-0000Zu-2L
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:02 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHSe-0000ZL-T4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:01 -0400
Received: by mail-pg0-x234.google.com with SMTP id a13-v6so8571054pgu.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:00 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:51 +1200
Message-Id: <1527034517-7851-5-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 04/30] RISC-V: Simplify
 riscv_cpu_local_irqs_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

This commit is intended to improve readability.
There is no change to the logic.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 3b57e1360549..47d116e9c13f 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -35,28 +35,18 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 }
 
 #ifndef CONFIG_USER_ONLY
-/*
- * Return RISC-V IRQ number if an interrupt should be taken, else -1.
- * Used in cpu-exec.c
- *
- * Adapted from Spike's processor_t::take_interrupt()
- */
-static int riscv_cpu_hw_interrupts_pending(CPURISCVState *env)
+static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
-    target_ulong pending_interrupts = atomic_read(&env->mip) & env->mie;
-
-    target_ulong mie = get_field(env->mstatus, MSTATUS_MIE);
-    target_ulong m_enabled = env->priv < PRV_M || (env->priv == PRV_M && mie);
-    target_ulong enabled_interrupts = pending_interrupts &
-                                      ~env->mideleg & -m_enabled;
-
-    target_ulong sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong s_enabled = env->priv < PRV_S || (env->priv == PRV_S && sie);
-    enabled_interrupts |= pending_interrupts & env->mideleg &
-                          -s_enabled;
-
-    if (enabled_interrupts) {
-        return ctz64(enabled_interrupts); /* since non-zero */
+    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
+    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
+    target_ulong pending = atomic_read(&env->mip) & env->mie;
+    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong irqs = (pending & ~env->mideleg & -mie) |
+                        (pending &  env->mideleg & -sie);
+
+    if (irqs) {
+        return ctz64(irqs); /* since non-zero */
     } else {
         return EXCP_NONE; /* indicates no pending interrupt */
     }
@@ -69,7 +59,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
-        int interruptno = riscv_cpu_hw_interrupts_pending(env);
+        int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
             riscv_cpu_do_interrupt(cs);
-- 
2.7.0
