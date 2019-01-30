Received: from eggs.gnu.org ([209.51.188.92]:38418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn5-0004gU-7S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn3-00006y-Vz
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:47 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotn3-0008S7-QZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:45 -0500
Received: by mail-pg1-x536.google.com with SMTP id t13so107536pgr.11
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:26 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:56 -0800
Message-Id: <20190130173601.3268-6-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 05/10] RISC-V: Add priv_ver to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

The gen methods should access state from DisasContext. Add priv_ver
field to the DisasContext struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0581b3c1f7d7..35eb6bdfe099 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -43,6 +43,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
+    target_ulong priv_ver;
     uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t mem_idx;
@@ -1330,7 +1331,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
 #ifndef CONFIG_USER_ONLY
     /* Extract funct7 value and check whether it matches SFENCE.VMA */
     if ((opc == OPC_RISC_ECALL) && ((csr >> 5) == 9)) {
-        if (env->priv_ver == PRIV_VERSION_1_10_0) {
+        if (ctx->priv_ver == PRIV_VERSION_1_10_0) {
             /* sfence.vma */
             /* TODO: handle ASID specific fences */
             gen_helper_tlb_flush(cpu_env);
@@ -1384,7 +1385,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_helper_wfi(cpu_env);
             break;
         case 0x104: /* SFENCE.VM */
-            if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            if (ctx->priv_ver <= PRIV_VERSION_1_09_1) {
                 gen_helper_tlb_flush(cpu_env);
             } else {
                 gen_exception_illegal(ctx);
@@ -1854,10 +1855,12 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
 static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPURISCVState *env = cs->env_ptr;
 
     ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
+    ctx->priv_ver = env->priv_ver;
     ctx->frm = -1;  /* unknown rounding mode */
 }
 
-- 
2.18.1
