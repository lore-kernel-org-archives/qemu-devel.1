Received: from eggs.gnu.org ([2001:4830:134:3::10]:60365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0VKd-0000p4-9x
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0VKc-0002E6-AL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0VKc-0002Dn-3Q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:50 -0400
Received: by mail-pf0-x243.google.com with SMTP id j2so7738147pff.10
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Mar 2018 00:50:30 +0800
Message-Id: <20180326165030.875-2-richard.henderson@linaro.org>
In-Reply-To: <20180326165030.875-1-richard.henderson@linaro.org>
References: <20180326165030.875-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/1] target/hppa: Include priv level in
 user-only iaoq
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

A recent glibc change relies on the fact that the iaoq must be 3,
and computes an address based on that.  QEMU had been ignoring the
priv level for user-only, which produced an incorrect address.

Reported-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  4 ++--
 target/hppa/translate.c | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 19dd12a93e..861bbb1f16 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -305,8 +305,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
        incomplete virtual address.  This also means that we must separate
        out current cpu priviledge from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f;
-    *cs_base = env->iaoq_b;
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
 #else
     /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
     flags |= env->psw & (PSW_W | PSW_C | PSW_D);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6499b392f9..c532889b1f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1909,9 +1909,6 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
  */
 static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
 {
-#ifdef CONFIG_USER_ONLY
-    return offset;
-#else
     TCGv_reg dest;
     switch (ctx->privilege) {
     case 0:
@@ -1931,7 +1928,6 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
         break;
     }
     return dest;
-#endif
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -1967,7 +1963,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
         goto do_sigill;
     }
 
-    switch (ctx->iaoq_f) {
+    switch (ctx->iaoq_f & -4) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_IMP);
         return DISAS_NORETURN;
@@ -1978,7 +1974,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_st_reg(cpu_gr[26], cpu_env, offsetof(CPUHPPAState, cr[27]));
-        tcg_gen_mov_reg(cpu_iaoq_f, cpu_gr[31]);
+        tcg_gen_ori_reg(cpu_iaoq_f, cpu_gr[31], 3);
         tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
         return DISAS_IAQ_N_UPDATED;
 
@@ -4697,8 +4693,8 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_USER_IDX;
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_f = ctx->base.pc_first;
-    ctx->iaoq_b = ctx->base.tb->cs_base;
+    ctx->iaoq_f = ctx->base.pc_first | MMU_USER_IDX;
+    ctx->iaoq_b = ctx->base.tb->cs_base | MMU_USER_IDX;
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D ? ctx->privilege : MMU_PHYS_IDX);
-- 
2.14.3
