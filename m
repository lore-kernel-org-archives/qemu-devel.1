Received: from eggs.gnu.org ([2001:4830:134:3::10]:46866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9j-0005rw-R0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9i-0005ZF-SJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:59 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU9i-0005Z0-MK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id j11so14459620pgf.2
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:58 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:33 +1200
Message-Id: <1524699938-6764-31-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 30/35] RISC-V: Split out mstatus_fs from
 tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Richard Henderson <richard.henderson@linaro.org>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.h       |  6 +++---
 target/riscv/translate.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3fed92d..6fb0014 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -270,8 +270,8 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
 target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
 void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
 
-#define TB_FLAGS_MMU_MASK  3
-#define TB_FLAGS_FP_ENABLE MSTATUS_FS
+#define TB_FLAGS_MMU_MASK   3
+#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
 
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
@@ -279,7 +279,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = 0;
 #ifdef CONFIG_USER_ONLY
-    *flags = TB_FLAGS_FP_ENABLE;
+    *flags = TB_FLAGS_MSTATUS_FS;
 #else
     *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c0e6a04..4180c42 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -43,7 +43,7 @@ typedef struct DisasContext {
     target_ulong pc;
     target_ulong next_pc;
     uint32_t opcode;
-    uint32_t flags;
+    uint32_t mstatus_fs;
     uint32_t mem_idx;
     int singlestep_enabled;
     int bstate;
@@ -664,7 +664,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
 {
     TCGv t0;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -694,7 +694,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
 {
     TCGv t0;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -985,7 +985,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 {
     TCGv t0 = NULL;
 
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs == 0) {
         goto do_illegal;
     }
 
@@ -1863,8 +1863,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     ctx.tb = tb;
     ctx.bstate = BS_NONE;
-    ctx.flags = tb->flags;
     ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
+    ctx.mstatus_fs = tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx.frm = -1;  /* unknown rounding mode */
 
     num_insns = 0;
-- 
2.7.0
