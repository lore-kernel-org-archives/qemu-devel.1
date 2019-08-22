Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A29C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D1A233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="POsPyu9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D1A233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kHp-0001ll-TP
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDI-0005tm-CH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDG-0005XM-9a
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:04 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:43882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1i0kDF-0005TB-9m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GTsqVEyoahLFqtXHbQcMV+LcUV0gu3CL297OUf1p/ug=; b=POsPyu9HaaSJH+HZF3Oo+3XVFu
 u8Vg2D7FQXEHN4n7Fe+jDZGoyx8MzPp5NRlZuOn2xXO/TIEjhIqVMH1w3tCChm3SyYISPLMM7QNJq
 o4H5FMDmstXIKHh6owiQu8WKSFLaaDJ5ZXcykJYyfv7WnZWOUBB+4MIofwWkhqK/lcYw=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 12:20:42 +0200
Message-Id: <20190822102046.8765-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
References: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.22.101216, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 1/5] target/tricore: Use DisasContextBase API
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this gets rid of the copied fields of TriCore's DisasContext and now
uses the shared DisasContextBase, which is necessary for the conversion
to translate_loop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 98 +++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dc2a65f3f9..ca67b6cd4c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -30,6 +30,7 @@
 #include "exec/helper-gen.h"
 
 #include "tricore-opcodes.h"
+#include "exec/translator.h"
 #include "exec/log.h"
 
 /*
@@ -64,24 +65,14 @@ static const char *regnames_d[] = {
     };
 
 typedef struct DisasContext {
-    struct TranslationBlock *tb;
-    target_ulong pc, saved_pc, next_pc;
+    DisasContextBase base;
+    target_ulong pc_succ_insn;
     uint32_t opcode;
-    int singlestep_enabled;
     /* Routine used to access memory */
     int mem_idx;
     uint32_t hflags, saved_hflags;
-    int bstate;
 } DisasContext;
 
-enum {
-
-    BS_NONE   = 0,
-    BS_STOP   = 1,
-    BS_BRANCH = 2,
-    BS_EXCP   = 3,
-};
-
 enum {
     MODE_LL = 0,
     MODE_LU = 1,
@@ -3230,12 +3221,12 @@ static inline void gen_save_pc(target_ulong pc)
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(ctx->singlestep_enabled)) {
+    if (unlikely(ctx->base.singlestep_enabled)) {
         return false;
     }
 
 #ifndef CONFIG_USER_ONLY
-    return (ctx->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -3246,10 +3237,10 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         gen_save_pc(dest);
-        tcg_gen_exit_tb(ctx->tb, n);
+        tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         gen_save_pc(dest);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             /* raise exception debug */
         }
         tcg_gen_exit_tb(NULL, 0);
@@ -3261,9 +3252,9 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     TCGv_i32 classtemp = tcg_const_i32(class);
     TCGv_i32 tintemp = tcg_const_i32(tin);
 
-    gen_save_pc(ctx->pc);
+    gen_save_pc(ctx->base.pc_next);
     gen_helper_raise_exception_sync(cpu_env, classtemp, tintemp);
-    ctx->bstate = BS_EXCP;
+    ctx->base.is_jmp = DISAS_NORETURN;
 
     tcg_temp_free(classtemp);
     tcg_temp_free(tintemp);
@@ -3275,10 +3266,10 @@ static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
     TCGLabel *jumpLabel = gen_new_label();
     tcg_gen_brcond_tl(cond, r1, r2, jumpLabel);
 
-    gen_goto_tb(ctx, 1, ctx->next_pc);
+    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
 
     gen_set_label(jumpLabel);
-    gen_goto_tb(ctx, 0, ctx->pc + address * 2);
+    gen_goto_tb(ctx, 0, ctx->base.pc_next + address * 2);
 }
 
 static inline void gen_branch_condi(DisasContext *ctx, TCGCond cond, TCGv r1,
@@ -3295,9 +3286,9 @@ static void gen_loop(DisasContext *ctx, int r1, int32_t offset)
 
     tcg_gen_subi_tl(cpu_gpr_a[r1], cpu_gpr_a[r1], 1);
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr_a[r1], -1, l1);
-    gen_goto_tb(ctx, 1, ctx->pc + offset);
+    gen_goto_tb(ctx, 1, ctx->base.pc_next + offset);
     gen_set_label(l1);
-    gen_goto_tb(ctx, 0, ctx->next_pc);
+    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
 }
 
 static void gen_fcall_save_ctx(DisasContext *ctx)
@@ -3306,7 +3297,7 @@ static void gen_fcall_save_ctx(DisasContext *ctx)
 
     tcg_gen_addi_tl(temp, cpu_gpr_a[10], -4);
     tcg_gen_qemu_st_tl(cpu_gpr_a[11], temp, ctx->mem_idx, MO_LESL);
-    tcg_gen_movi_tl(cpu_gpr_a[11], ctx->next_pc);
+    tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
     tcg_gen_mov_tl(cpu_gpr_a[10], temp);
 
     tcg_temp_free(temp);
@@ -3321,7 +3312,7 @@ static void gen_fret(DisasContext *ctx)
     tcg_gen_addi_tl(cpu_gpr_a[10], cpu_gpr_a[10], 4);
     tcg_gen_mov_tl(cpu_PC, temp);
     tcg_gen_exit_tb(NULL, 0);
-    ctx->bstate = BS_BRANCH;
+    ctx->base.is_jmp = DISAS_NORETURN;
 
     tcg_temp_free(temp);
 }
@@ -3336,12 +3327,12 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
 /* SB-format jumps */
     case OPC1_16_SB_J:
     case OPC1_32_B_J:
-        gen_goto_tb(ctx, 0, ctx->pc + offset * 2);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_32_B_CALL:
     case OPC1_16_SB_CALL:
-        gen_helper_1arg(call, ctx->next_pc);
-        gen_goto_tb(ctx, 0, ctx->pc + offset * 2);
+        gen_helper_1arg(call, ctx->pc_succ_insn);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_16_SB_JZ:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], 0, offset);
@@ -3433,26 +3424,26 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         break;
 /* B-format */
     case OPC1_32_B_CALLA:
-        gen_helper_1arg(call, ctx->next_pc);
+        gen_helper_1arg(call, ctx->pc_succ_insn);
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_FCALL:
         gen_fcall_save_ctx(ctx);
-        gen_goto_tb(ctx, 0, ctx->pc + offset * 2);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_32_B_FCALLA:
         gen_fcall_save_ctx(ctx);
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JLA:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->next_pc);
+        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
         /* fall through */
     case OPC1_32_B_JA:
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JL:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->next_pc);
-        gen_goto_tb(ctx, 0, ctx->pc + offset * 2);
+        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
 /* BOL format */
     case OPCM_32_BRC_EQ_NEQ:
@@ -3551,7 +3542,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
             gen_loop(ctx, r2, offset * 2);
         } else {
             /* OPC2_32_BRR_LOOPU */
-            gen_goto_tb(ctx, 0, ctx->pc + offset * 2);
+            gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         }
         break;
     case OPCM_32_BRR_JNE:
@@ -3585,7 +3576,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    ctx->bstate = BS_BRANCH;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 
@@ -3933,7 +3924,7 @@ static void decode_sr_system(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_16_SR_RFE:
         gen_helper_rfe(cpu_env);
         tcg_gen_exit_tb(NULL, 0);
-        ctx->bstate = BS_BRANCH;
+        ctx->base.is_jmp = DISAS_NORETURN;
         break;
     case OPC2_16_SR_DEBUG:
         /* raise EXCP_DEBUG */
@@ -6557,11 +6548,11 @@ static void decode_rr_idirect(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_JLI:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->next_pc);
+        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_CALLI:
-        gen_helper_1arg(call, ctx->next_pc);
+        gen_helper_1arg(call, ctx->pc_succ_insn);
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_FCALLI:
@@ -6572,7 +6563,7 @@ static void decode_rr_idirect(CPUTriCoreState *env, DisasContext *ctx)
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
     tcg_gen_exit_tb(NULL, 0);
-    ctx->bstate = BS_BRANCH;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
@@ -8391,7 +8382,7 @@ static void decode_sys_interrupts(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_SYS_RFE:
         gen_helper_rfe(cpu_env);
         tcg_gen_exit_tb(NULL, 0);
-        ctx->bstate = BS_BRANCH;
+        ctx->base.is_jmp = DISAS_NORETURN;
         break;
     case OPC2_32_SYS_RFM:
         if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM) {
@@ -8404,7 +8395,7 @@ static void decode_sys_interrupts(CPUTriCoreState *env, DisasContext *ctx)
             gen_helper_rfm(cpu_env);
             gen_set_label(l1);
             tcg_gen_exit_tb(NULL, 0);
-            ctx->bstate = BS_BRANCH;
+            ctx->base.is_jmp = DISAS_NORETURN;
             tcg_temp_free(tmp);
         } else {
             /* generate privilege trap */
@@ -8790,11 +8781,11 @@ static void decode_opc(CPUTriCoreState *env, DisasContext *ctx, int *is_branch)
 {
     /* 16-Bit Instruction */
     if ((ctx->opcode & 0x1) == 0) {
-        ctx->next_pc = ctx->pc + 2;
+        ctx->pc_succ_insn = ctx->base.pc_next + 2;
         decode_16Bit_opc(env, ctx);
     /* 32-Bit Instruction */
     } else {
-        ctx->next_pc = ctx->pc + 4;
+        ctx->pc_succ_insn = ctx->base.pc_next + 4;
         decode_32Bit_opc(env, ctx);
     }
 }
@@ -8807,33 +8798,32 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     int num_insns = 0;
 
     pc_start = tb->pc;
-    ctx.pc = pc_start;
-    ctx.saved_pc = -1;
-    ctx.tb = tb;
-    ctx.singlestep_enabled = cs->singlestep_enabled;
-    ctx.bstate = BS_NONE;
+    ctx.base.pc_next = pc_start;
+    ctx.base.tb = tb;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.is_jmp = DISAS_NEXT;
     ctx.mem_idx = cpu_mmu_index(env, false);
     ctx.hflags = (uint32_t)tb->flags;
 
     tcg_clear_temp_count();
     gen_tb_start(tb);
-    while (ctx.bstate == BS_NONE) {
-        tcg_gen_insn_start(ctx.pc);
+    while (ctx.base.is_jmp == DISAS_NEXT) {
+        tcg_gen_insn_start(ctx.base.pc_next);
         num_insns++;
 
-        ctx.opcode = cpu_ldl_code(env, ctx.pc);
+        ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
         decode_opc(env, &ctx, 0);
 
         if (num_insns >= max_insns || tcg_op_buf_full()) {
-            gen_save_pc(ctx.next_pc);
+            gen_save_pc(ctx.pc_succ_insn);
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-        ctx.pc = ctx.next_pc;
+        ctx.base.pc_next = ctx.pc_succ_insn;
     }
 
     gen_tb_end(tb, num_insns);
-    tb->size = ctx.pc - pc_start;
+    tb->size = ctx.base.pc_next - pc_start;
     tb->icount = num_insns;
 
     if (tcg_check_temp_count()) {
@@ -8845,7 +8835,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start);
+        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.23.0


