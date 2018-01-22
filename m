Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0e-0005lr-Qs
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0a-0006cO-6t
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:00 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0Z-0006by-V4
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:56 -0500
Received: by mail-pf0-x243.google.com with SMTP id t12so6084412pfg.2
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:58 -0800
Message-Id: <20180122034217.19593-25-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 24/43] target/hppa: Implement LPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/helper.h     |  1 +
 target/hppa/mem_helper.c | 13 +++++++++++++
 target/hppa/op_helper.c  | 10 +++++-----
 target/hppa/translate.c  | 30 ++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 31a3702684..a6e4091b6a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -344,5 +344,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 extern const MemoryRegionOps hppa_io_eir_ops;
 void hppa_cpu_alarm_timer(void *);
 #endif
+void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index f059ddf3b9..1e733b7926 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -90,4 +90,5 @@ DEF_HELPER_FLAGS_3(itlba, TCG_CALL_NO_RWG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(itlbp, TCG_CALL_NO_RWG, void, env, tl, tr)
 DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tr, env, tl)
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b5e2e35908..9d93894019 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -305,4 +305,17 @@ void HELPER(ptlbe)(CPUHPPAState *env)
     memset(env->tlb, 0, sizeof(env->tlb));
     tlb_flush_by_mmuidx(src, 0xf);
 }
+
+target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
+{
+    hwaddr phys;
+    int prot, excp;
+
+    excp = hppa_get_physical_address(env, addr, MMU_KERNEL_IDX,
+                                     MMU_DATA_LOAD, &phys, &prot);
+    if (excp == EXCP_DTLB_MISS) {
+        hppa_dynamic_excp(env, EXCP_NA_DTLB_MISS, GETPC());
+    }
+    return phys;
+}
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 6d19cab6c9..d270f94e31 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -34,7 +34,7 @@ void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
     cpu_loop_exit(cs);
 }
 
-static void QEMU_NORETURN dynexcp(CPUHPPAState *env, int excp, uintptr_t ra)
+void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
 {
     HPPACPU *cpu = hppa_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
@@ -46,14 +46,14 @@ static void QEMU_NORETURN dynexcp(CPUHPPAState *env, int excp, uintptr_t ra)
 void HELPER(tsv)(CPUHPPAState *env, target_ureg cond)
 {
     if (unlikely((target_sreg)cond < 0)) {
-        dynexcp(env, EXCP_OVERFLOW, GETPC());
+        hppa_dynamic_excp(env, EXCP_OVERFLOW, GETPC());
     }
 }
 
 void HELPER(tcond)(CPUHPPAState *env, target_ureg cond)
 {
     if (unlikely(cond)) {
-        dynexcp(env, EXCP_COND, GETPC());
+        hppa_dynamic_excp(env, EXCP_COND, GETPC());
     }
 }
 
@@ -237,7 +237,7 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
     env->fr[0] = (uint64_t)shadow << 32;
 
     if (hard_exp & shadow) {
-        dynexcp(env, EXCP_ASSIST, ra);
+        hppa_dynamic_excp(env, EXCP_ASSIST, ra);
     }
 }
 
@@ -645,7 +645,7 @@ target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
     /* ??? On second reading this condition simply seems
        to be undefined rather than a diagnosed trap.  */
     if (nsm & ~psw & PSW_Q) {
-        dynexcp(env, EXCP_ILL, GETPC());
+        hppa_dynamic_excp(env, EXCP_ILL, GETPC());
     }
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
     return psw & PSW_SM;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5b49cc5332..bbef2f0d7f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2422,6 +2422,35 @@ static DisasJumpType trans_pxtlbx(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
                        ? DISAS_IAQ_N_STALE : DISAS_NEXT);
 }
+
+static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned sp = extract32(insn, 14, 2);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    TCGv_tl vaddr;
+    TCGv_reg ofs, paddr;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    form_gva(ctx, &vaddr, &ofs, rb, rx, 0, 0, sp, m, false);
+
+    paddr = tcg_temp_new();
+    gen_helper_lpa(paddr, cpu_env, vaddr);
+
+    /* Note that physical address result overrides base modification.  */
+    if (m) {
+        save_gpr(ctx, rb, ofs);
+    }
+    save_gpr(ctx, rt, paddr);
+    tcg_temp_free(paddr);
+
+    return nullify_end(ctx, DISAS_NEXT);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_mem_mgmt[] = {
@@ -2449,6 +2478,7 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04000240u, 0xfc001fdfu, trans_pxtlbx },       /* pitlbe */
     { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
     { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
+    { 0x04001340u, 0xfc003fc0u, trans_lpa },
 #endif
 };
 
-- 
2.14.3
