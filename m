Received: from eggs.gnu.org ([2001:4830:134:3::10]:42047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSn-0007vj-Vr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSm-0000eC-G3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:09 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:36531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHSm-0000dm-8U
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:08 -0400
Received: by mail-pg0-x232.google.com with SMTP id u7-v6so66595pgp.3
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:08 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:53 +1200
Message-Id: <1527034517-7851-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 06/30] RISC-V: Move non-ops from op_helper
 to cpu_helper
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

This patch makes op_helper.c contain only instruction
operation helpers used by translate.c and moves any
unrelated cpu helpers into cpu_helper.c. No logic is
changed by this patch.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/{helper.c => cpu_helper.c} | 35 ++++++++++++++++++++++++++++++++-
 target/riscv/op_helper.c                | 34 --------------------------------
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
index 47d116e9c13f..6c886e99055a 100644
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
index 5a02795bf931..2b9dd9da6486 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -652,39 +652,6 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
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
@@ -735,7 +702,6 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
     return retpc;
 }
 
-
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
-- 
2.7.0
