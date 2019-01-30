Received: from eggs.gnu.org ([209.51.188.92]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn6-0004gY-N1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn4-00007P-7O
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:47 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotn3-0008LX-VS
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:46 -0500
Received: by mail-pl1-x62c.google.com with SMTP id b5so139199plr.4
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:17 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:52 -0800
Message-Id: <20190130173601.3268-2-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 01/10] RISC-V: Split out mstatus_fs from tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h       |  6 +++---
 target/riscv/translate.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 743f02c8b95a..681341f5d5a4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -275,8 +275,8 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
 target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
 void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
 
-#define TB_FLAGS_MMU_MASK  3
-#define TB_FLAGS_FP_ENABLE MSTATUS_FS
+#define TB_FLAGS_MMU_MASK   3
+#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
 
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
@@ -284,7 +284,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = 0;
 #ifdef CONFIG_USER_ONLY
-    *flags = TB_FLAGS_FP_ENABLE;
+    *flags = TB_FLAGS_MSTATUS_FS;
 #else
     *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 312bf298b3c2..3d07d651b60c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,7 +44,7 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     uint32_t opcode;
-    uint32_t flags;
+    uint32_t mstatus_fs;
     uint32_t mem_idx;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
@@ -656,7 +656,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
 {
     TCGv t0;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -686,7 +686,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
 {
     TCGv t0;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -945,7 +945,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 {
     TCGv t0 = NULL;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         goto do_illegal;
     }
 
@@ -1818,8 +1818,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     ctx->pc_succ_insn = ctx->base.pc_first;
-    ctx->flags = ctx->base.tb->flags;
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
+    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->frm = -1;  /* unknown rounding mode */
 }
 
-- 
2.18.1
