Received: from eggs.gnu.org ([2001:4830:134:3::10]:48871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJj-0005gb-G2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJb-0006J2-LQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:55 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJb-0006Ht-9q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:47 -0400
Received: by mail-pf0-x241.google.com with SMTP id f20so17212800pfn.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:56 -0700
Message-Id: <20180509175458.15642-27-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 26/28] target/riscv: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 72 ++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a98033ca77..1fee5b51dc 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
+#include "exec/translator.h"
 #include "exec/log.h"
 
 #include "instmap.h"
@@ -46,7 +47,7 @@ typedef struct DisasContext {
     uint32_t flags;
     uint32_t mem_idx;
     int singlestep_enabled;
-    int bstate;
+    DisasJumpType is_jmp;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
        no previous fp instruction.  Note that we exit the TB when writing
@@ -55,13 +56,6 @@ typedef struct DisasContext {
     int frm;
 } DisasContext;
 
-enum {
-    BS_NONE     = 0, /* When seen outside of translation while loop, indicates
-                     need to exit tb due to end of page. */
-    BS_STOP     = 1, /* Need to exit tb for syscall, sret, etc. */
-    BS_BRANCH   = 2, /* Need to exit tb for branch, jal, etc. */
-};
-
 /* convert riscv funct3 to qemu memop for load/store */
 static const int tcg_memop_lookup[8] = {
     [0 ... 7] = -1,
@@ -88,7 +82,7 @@ static void generate_exception(DisasContext *ctx, int excp)
     TCGv_i32 helper_tmp = tcg_const_i32(excp);
     gen_helper_raise_exception(cpu_env, helper_tmp);
     tcg_temp_free_i32(helper_tmp);
-    ctx->bstate = BS_BRANCH;
+    ctx->is_jmp = DISAS_NORETURN;
 }
 
 static void generate_exception_mbadaddr(DisasContext *ctx, int excp)
@@ -98,7 +92,7 @@ static void generate_exception_mbadaddr(DisasContext *ctx, int excp)
     TCGv_i32 helper_tmp = tcg_const_i32(excp);
     gen_helper_raise_exception(cpu_env, helper_tmp);
     tcg_temp_free_i32(helper_tmp);
-    ctx->bstate = BS_BRANCH;
+    ctx->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_exception_debug(void)
@@ -531,7 +525,7 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     }
 
     gen_goto_tb(ctx, 0, ctx->pc + imm); /* must use this for safety */
-    ctx->bstate = BS_BRANCH;
+    ctx->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
@@ -562,7 +556,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_set_label(misaligned);
             gen_exception_inst_addr_mis(ctx);
         }
-        ctx->bstate = BS_BRANCH;
+        ctx->is_jmp = DISAS_NORETURN;
         break;
 
     default:
@@ -616,7 +610,7 @@ static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     } else {
         gen_goto_tb(ctx, 0, ctx->pc + bimm);
     }
-    ctx->bstate = BS_BRANCH;
+    ctx->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
@@ -1344,12 +1338,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             /* always generates U-level ECALL, fixed in do_interrupt handler */
             generate_exception(ctx, RISCV_EXCP_U_ECALL);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->bstate = BS_BRANCH;
+            ctx->is_jmp = DISAS_NORETURN;
             break;
         case 0x1: /* EBREAK */
             generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->bstate = BS_BRANCH;
+            ctx->is_jmp = DISAS_NORETURN;
             break;
 #ifndef CONFIG_USER_ONLY
         case 0x002: /* URET */
@@ -1359,7 +1353,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             if (riscv_has_ext(env, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
                 tcg_gen_exit_tb(0); /* no chaining */
-                ctx->bstate = BS_BRANCH;
+                ctx->is_jmp = DISAS_NORETURN;
             } else {
                 gen_exception_illegal(ctx);
             }
@@ -1370,7 +1364,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         case 0x302: /* MRET */
             gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->bstate = BS_BRANCH;
+            ctx->is_jmp = DISAS_NORETURN;
             break;
         case 0x7b2: /* DRET */
             gen_exception_illegal(ctx);
@@ -1419,7 +1413,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         /* end tb since we may be changing priv modes, to get mmu_index right */
         tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
         tcg_gen_exit_tb(0); /* no chaining */
-        ctx->bstate = BS_BRANCH;
+        ctx->is_jmp = DISAS_NORETURN;
         break;
     }
     tcg_temp_free(source1);
@@ -1812,7 +1806,7 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
              * however we need to end the translation block */
             tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
             tcg_gen_exit_tb(0);
-            ctx->bstate = BS_BRANCH;
+            ctx->is_jmp = DISAS_NORETURN;
         } else {
             /* FENCE is a full memory barrier. */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
@@ -1862,7 +1856,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     ctx.singlestep_enabled = cs->singlestep_enabled;
 
     ctx.tb = tb;
-    ctx.bstate = BS_NONE;
+    ctx.is_jmp = DISAS_NEXT;
     ctx.flags = tb->flags;
     ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
     ctx.frm = -1;  /* unknown rounding mode */
@@ -1877,13 +1871,13 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
     gen_tb_start(tb);
 
-    while (ctx.bstate == BS_NONE) {
+    while (ctx.is_jmp == DISAS_NEXT) {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
 
         if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
             tcg_gen_movi_tl(cpu_pc, ctx.pc);
-            ctx.bstate = BS_BRANCH;
+            ctx.is_jmp = DISAS_NORETURN;
             gen_exception_debug();
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
@@ -1901,31 +1895,20 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         decode_opc(env, &ctx);
         ctx.pc = ctx.next_pc;
 
-        if (cs->singlestep_enabled) {
-            break;
+        if (ctx.is_jmp == DISAS_NEXT &&
+            (cs->singlestep_enabled ||
+             ctx.pc - page_start >= TARGET_PAGE_SIZE ||
+             tcg_op_buf_full() ||
+             num_insns >= max_insns ||
+             singlestep)) {
+            ctx.is_jmp = DISAS_TOO_MANY;
         }
-        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
-            break;
-        }
-        if (tcg_op_buf_full()) {
-            break;
-        }
-        if (num_insns >= max_insns) {
-            break;
-        }
-        if (singlestep) {
-            break;
-        }
-
     }
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
-    switch (ctx.bstate) {
-    case BS_STOP:
-        gen_goto_tb(&ctx, 0, ctx.pc);
-        break;
-    case BS_NONE: /* handle end of page - DO NOT CHAIN. See gen_goto_tb. */
+    switch (ctx.is_jmp) {
+    case DISAS_TOO_MANY:
         tcg_gen_movi_tl(cpu_pc, ctx.pc);
         if (cs->singlestep_enabled) {
             gen_exception_debug();
@@ -1933,9 +1916,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             tcg_gen_exit_tb(0);
         }
         break;
-    case BS_BRANCH: /* ops using BS_BRANCH generate own exit seq */
-    default:
+    case DISAS_NORETURN:
         break;
+    default:
+        g_assert_not_reached();
     }
 done_generating:
     gen_tb_end(tb, num_insns);
-- 
2.17.0
