Received: from eggs.gnu.org ([2001:4830:134:3::10]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9M-0005Uo-OG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9L-0005Ot-Id
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:36 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU9L-0005Ob-A3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:35 -0400
Received: by mail-pf0-x243.google.com with SMTP id q22so1645412pff.11
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:35 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:27 +1200
Message-Id: <1524699938-6764-25-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 24/35] RISC-V: Allow setting and clearing
 multiple irqs
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

Change the API of riscv_set_local_interrupt to take a
write mask and value to allow setting and clearing of
multiple local interrupts atomically in a single call.
Rename the new function to riscv_cpu_update_mip.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_clint.c  |  8 ++++----
 hw/riscv/sifive_plic.c   |  4 ++--
 target/riscv/cpu.h       |  8 +++-----
 target/riscv/op_helper.c | 23 ++++++++++++++---------
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 7cc606e..909929b 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -47,12 +47,12 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
     if (cpu->env.timecmp <= rtc_r) {
         /* if we're setting an MTIMECMP value in the "past",
            immediately raise the timer interrupt */
-        riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+        riscv_cpu_update_mip(cpu, MIP_MTIP, -1);
         return;
     }
 
     /* otherwise, set up the future timer interrupt */
-    riscv_set_local_interrupt(cpu, MIP_MTIP, 0);
+    riscv_cpu_update_mip(cpu, MIP_MTIP, 0);
     diff = cpu->env.timecmp - rtc_r;
     /* back to ns (note args switched in muldiv64) */
     next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
@@ -67,7 +67,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
 static void sifive_clint_timer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-    riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+    riscv_cpu_update_mip(cpu, MIP_MTIP, -1);
 }
 
 /* CPU wants to read rtc or timecmp register */
@@ -132,7 +132,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
         if (!env) {
             error_report("clint: invalid timecmp hartid: %zu", hartid);
         } else if ((addr & 0x3) == 0) {
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MSIP, value != 0);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MSIP, -!!value);
         } else {
             error_report("clint: invalid sip write: %08x", (uint32_t)addr);
         }
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 04e39e4..fa0298d 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -141,10 +141,10 @@ static void sifive_plic_update(SiFivePLICState *plic)
         int level = sifive_plic_irqs_pending(plic, addrid);
         switch (mode) {
         case PLICMode_M:
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MEIP, level);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, -!!level);
             break;
         case PLICMode_S:
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_SEIP, level);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, -!!level);
             break;
         default:
             break;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e0608e6..5ac1482 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -247,7 +247,6 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                     uintptr_t retaddr);
 int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                               int rw, int mmu_idx);
-
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
@@ -256,6 +255,9 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
 
+#ifndef CONFIG_USER_ONLY
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
+#endif
 void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
@@ -286,10 +288,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         target_ulong csrno);
 target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
 
-#ifndef CONFIG_USER_ONLY
-void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value);
-#endif
-
 #include "exec/cpu-all.h"
 
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 7d3f1ee..2a7f045 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -171,10 +171,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
          */
         qemu_mutex_lock_iothread();
         RISCVCPU *cpu = riscv_env_get_cpu(env);
-        riscv_set_local_interrupt(cpu, MIP_SSIP,
-                                  (val_to_write & MIP_SSIP) != 0);
-        riscv_set_local_interrupt(cpu, MIP_STIP,
-                                  (val_to_write & MIP_STIP) != 0);
+        riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
+                                  (val_to_write & (MIP_SSIP | MIP_STIP)));
         /*
          * csrs, csrc on mip.SEIP is not decomposable into separate read and
          * write steps, so a different implementation is needed
@@ -643,16 +641,23 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 #ifndef CONFIG_USER_ONLY
 
 /* iothread_mutex must be held */
-void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value)
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
 {
-    target_ulong old_mip = cpu->env.mip;
-    cpu->env.mip = (old_mip & ~mask) | (value ? mask : 0);
+    CPURISCVState *env = &cpu->env;
+    uint32_t old_mip, new_mip;
 
-    if (cpu->env.mip && !old_mip) {
+    do {
+        old_mip = atomic_read(&env->mip);
+        new_mip = (old_mip & ~mask) | (value & mask);
+    } while (atomic_cmpxchg(&env->mip, old_mip, new_mip) != old_mip);
+
+    if (new_mip && !old_mip) {
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else if (!cpu->env.mip && old_mip) {
+    } else if (!new_mip && old_mip) {
         cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
     }
+
+    return old_mip;
 }
 
 void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
-- 
2.7.0
