Received: from eggs.gnu.org ([2001:4830:134:3::10]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDI-000343-6Z
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDG-0004io-Tw
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:16 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDG-0004iB-Mr
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:14 -0500
Received: by mail-pl0-x242.google.com with SMTP id 1so21073905plv.0
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:26 -0800
Message-Id: <20171229063145.29167-20-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/38] target/hppa: Implement external
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/helper.h     |  2 ++
 target/hppa/cpu.c        |  6 +++++
 target/hppa/int_helper.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 16 ++++++++++++-
 5 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index d09f9faa86..bd91ec57e6 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -342,6 +342,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
 #else
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               MMUAccessType type, hwaddr *pphys, int *pprot);
+extern const MemoryRegionOps hppa_io_eir_ops;
 #endif
 
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 79d22ae486..535f086ab4 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -80,5 +80,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
+DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
+DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index fbda7956bc..8e10649aaa 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -51,6 +51,11 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
+static bool hppa_cpu_has_work(CPUState *cs)
+{
+    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+}
+
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
@@ -151,6 +156,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     dc->realize = hppa_cpu_realizefn;
 
     cc->class_by_name = hppa_cpu_class_by_name;
+    cc->has_work = hppa_cpu_has_work;
     cc->do_interrupt = hppa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
     cc->dump_state = hppa_cpu_dump_state;
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index e66ca26941..74ab34f306 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -24,6 +24,65 @@
 #include "exec/helper-proto.h"
 #include "qom/cpu.h"
 
+#ifndef CONFIG_USER_ONLY
+static void eval_interrupt(HPPACPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    if (cpu->env.cr[CR_EIRR] & cpu->env.cr[CR_EIEM]) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+/* Each CPU has a word mapped into the GSC bus.  Anything on the GSC bus
+ * can write to this word to raise an external interrupt on the target CPU.
+ * This includes the system controler (DINO) for regular devices, or
+ * another CPU for SMP interprocessor interrupts.
+ */
+static uint64_t io_eir_read(void *opaque, hwaddr addr, unsigned size)
+{
+    HPPACPU *cpu = opaque;
+
+    /* ??? What does a read of this register over the GSC bus do?  */
+    return cpu->env.cr[CR_EIRR];
+}
+
+static void io_eir_write(void *opaque, hwaddr addr,
+                         uint64_t data, unsigned size)
+{
+    HPPACPU *cpu = opaque;
+    int le_bit = ~data & (TARGET_REGISTER_BITS - 1);
+
+    cpu->env.cr[CR_EIRR] |= (target_ureg)1 << le_bit;
+    eval_interrupt(cpu);
+}
+
+const MemoryRegionOps hppa_io_eir_ops = {
+    .read = io_eir_read,
+    .write = io_eir_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
+{
+    env->cr[CR_EIRR] &= ~val;
+    qemu_mutex_lock_iothread();
+    eval_interrupt(hppa_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
+{
+    env->cr[CR_EIEM] = val;
+    qemu_mutex_lock_iothread();
+    eval_interrupt(hppa_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+}
+#endif /* !CONFIG_USER_ONLY */
 
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d928bfe335..ce2a6c21d6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2115,12 +2115,25 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
     /* All other control registers are privileged or read-only.  */
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
 
+#ifdef CONFIG_USER_ONLY
+    g_assert_not_reached();
+#else
+    DisasJumpType ret = DISAS_NEXT;
+
     nullify_over(ctx);
     switch (ctl) {
     case CR_IT:
         /* ??? modify interval timer offset */
         break;
 
+    case CR_EIRR:
+        gen_helper_write_eirr(cpu_env, reg);
+        break;
+    case CR_EIEM:
+        gen_helper_write_eiem(cpu_env, reg);
+        ret = DISAS_IAQ_N_STALE_EXIT;
+        break;
+
     case CR_IIASQ:
     case CR_IIAOQ:
         /* FIXME: Respect PSW_Q bit */
@@ -2137,7 +2150,8 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
         tcg_gen_st_reg(reg, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
         break;
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx, ret);
+#endif
 }
 
 static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
-- 
2.14.3
