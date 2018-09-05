Received: from eggs.gnu.org ([2001:4830:134:3::10]:57675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0P-0001C5-Ai
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0K-0003zx-S9
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0H-0003le-53
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:26 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed,  5 Sep 2018 15:09:27 -0700
Message-Id: <20180905220932.6152-5-alistair.francis@wdc.com>
In-Reply-To: <20180905220932.6152-1-alistair.francis@wdc.com>
References: <20180905220932.6152-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 04/10] RISC-V: Simplify
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
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

This commit is intended to improve readability.
There is no change to the logic.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 1f0527e07f..63b3386b76 100644
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
2.17.1
