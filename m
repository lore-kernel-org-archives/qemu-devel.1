Received: from eggs.gnu.org ([2001:4830:134:3::10]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCtto-0006QM-Fm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttm-0005j3-BL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gCttk-0005VR-J4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id t70-v6so13156470pgd.12
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 15:02:25 -0700 (PDT)
Date: Wed, 17 Oct 2018 14:54:19 -0700
Message-Id: <20181017215422.3973-3-palmer@sifive.com>
In-Reply-To: <20181017215422.3973-1-palmer@sifive.com>
References: <20181017215422.3973-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 2/5] RISC-V: Move non-ops from op_helper to
 cpu_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.orgMichael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

This patch makes op_helper.c contain only instruction
operation helpers used by translate.c and moves any
unrelated cpu helpers into cpu_helper.c. No logic is
changed by this patch.

Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/{helper.c => cpu_helper.c} | 35 ++++++++++++++++++++++++-
 target/riscv/op_helper.c                | 34 ------------------------
 3 files changed, 35 insertions(+), 36 deletions(-)
 rename target/riscv/{helper.c => cpu_helper.c} (95%)

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index abd0a7cde333..fcc5d34c1f2e 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1 @@
-obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
diff --git a/target/riscv/helper.c b/target/riscv/cpu_helper.c
similarity index 95%
rename from target/riscv/helper.c
rename to target/riscv/cpu_helper.c
index 63b3386b765e..86f9f4730c88 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1,5 +1,5 @@
 /*
- * RISC-V emulation helpers for qemu.
+ * RISC-V CPU helpers for qemu.
  *
  * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
  * Copyright (c) 2017-2018 SiFive, Inc.
@@ -72,6 +72,39 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+/* iothread_mutex must be held */
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
+{
+    CPURISCVState *env = &cpu->env;
+    uint32_t old, new, cmp = atomic_read(&env->mip);
+
+    do {
+        old = cmp;
+        new = (old & ~mask) | (value & mask);
+        cmp = atomic_cmpxchg(&env->mip, old, new);
+    } while (old != cmp);
+
+    if (new && !old) {
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    } else if (!new && old) {
+        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    }
+
+    return old;
+}
+
+void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
+{
+    if (newpriv > PRV_M) {
+        g_assert_not_reached();
+    }
+    if (newpriv == PRV_H) {
+        newpriv = PRV_U;
+    }
+    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
+    env->priv = newpriv;
+}
+
 /* get_physical_address - get the physical address for this virtual address
  *
  * Do a page table walk to obtain the physical address corresponding to a
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index d0883d329b41..495390ab1c32 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -654,39 +654,6 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
 #ifndef CONFIG_USER_ONLY
 
-/* iothread_mutex must be held */
-uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
-{
-    CPURISCVState *env = &cpu->env;
-    uint32_t old, new, cmp = atomic_read(&env->mip);
-
-    do {
-        old = cmp;
-        new = (old & ~mask) | (value & mask);
-        cmp = atomic_cmpxchg(&env->mip, old, new);
-    } while (old != cmp);
-
-    if (new && !old) {
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else if (!new && old) {
-        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    }
-
-    return old;
-}
-
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
-{
-    if (newpriv > PRV_M) {
-        g_assert_not_reached();
-    }
-    if (newpriv == PRV_H) {
-        newpriv = PRV_U;
-    }
-    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
-    env->priv = newpriv;
-}
-
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >= PRV_S)) {
@@ -737,7 +704,6 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
     return retpc;
 }
 
-
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
-- 
2.18.1
