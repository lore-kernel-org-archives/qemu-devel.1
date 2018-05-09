Received: from eggs.gnu.org ([2001:4830:134:3::10]:48678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJb-0005XE-Sy
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJP-0005xE-9e
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:46 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJO-0005vY-LV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:35 -0400
Received: by mail-pg0-x244.google.com with SMTP id i194-v6so23006549pgd.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:48 -0700
Message-Id: <20180509175458.15642-19-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/28] target/mips: convert to DisasContextBase
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/translate.c | 346 ++++++++++++++++++++--------------------
 1 file changed, 175 insertions(+), 171 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 83a484822e..31c7425cfe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1430,17 +1430,15 @@ static TCGv_i64 msa_wr_d[64];
     } while(0)
 
 typedef struct DisasContext {
-    struct TranslationBlock *tb;
-    target_ulong pc, saved_pc;
+    DisasContextBase base;
+    target_ulong saved_pc;
     uint32_t opcode;
-    int singlestep_enabled;
     int insn_flags;
     int32_t CP0_Config1;
     /* Routine used to access memory */
     int mem_idx;
     TCGMemOp default_tcg_memop_mask;
     uint32_t hflags, saved_hflags;
-    DisasJumpType is_jmp;
     target_ulong btarget;
     bool ulri;
     int kscrexist;
@@ -1517,8 +1515,9 @@ static const char * const msaregnames[] = {
         if (MIPS_DEBUG_DISAS) {                                               \
             qemu_log_mask(CPU_LOG_TB_IN_ASM,                                  \
                           TARGET_FMT_lx ": %08x Invalid %s %03x %03x %03x\n", \
-                          ctx->pc, ctx->opcode, op, ctx->opcode >> 26,        \
-                          ctx->opcode & 0x3F, ((ctx->opcode >> 16) & 0x1F));  \
+                          ctx->base.pc_next, ctx->opcode, op,                 \
+                          ctx->opcode >> 26, ctx->opcode & 0x3F,              \
+                          ((ctx->opcode >> 16) & 0x1F));                      \
         }                                                                     \
     } while (0)
 
@@ -1594,9 +1593,9 @@ static inline void gen_save_pc(target_ulong pc)
 static inline void save_cpu_state(DisasContext *ctx, int do_save_pc)
 {
     LOG_DISAS("hflags %08x saved %08x\n", ctx->hflags, ctx->saved_hflags);
-    if (do_save_pc && ctx->pc != ctx->saved_pc) {
-        gen_save_pc(ctx->pc);
-        ctx->saved_pc = ctx->pc;
+    if (do_save_pc && ctx->base.pc_next != ctx->saved_pc) {
+        gen_save_pc(ctx->base.pc_next);
+        ctx->saved_pc = ctx->base.pc_next;
     }
     if (ctx->hflags != ctx->saved_hflags) {
         tcg_gen_movi_i32(hflags, ctx->hflags);
@@ -1635,7 +1634,7 @@ static inline void generate_exception_err(DisasContext *ctx, int excp, int err)
     gen_helper_raise_exception_err(cpu_env, texcp, terr);
     tcg_temp_free_i32(terr);
     tcg_temp_free_i32(texcp);
-    ctx->is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static inline void generate_exception(DisasContext *ctx, int excp)
@@ -2126,7 +2125,7 @@ static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
 
 static target_ulong pc_relative_pc (DisasContext *ctx)
 {
-    target_ulong pc = ctx->pc;
+    target_ulong pc = ctx->base.pc_next;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         int branch_bytes = ctx->hflags & MIPS_HFLAG_BDS16 ? 2 : 4;
@@ -4275,12 +4274,12 @@ static void gen_trap (DisasContext *ctx, uint32_t opc,
 
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
@@ -4291,10 +4290,10 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         gen_save_pc(dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
     } else {
         gen_save_pc(dest);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             save_cpu_state(ctx, 0);
             gen_helper_raise_exception_debug(cpu_env);
         }
@@ -4317,7 +4316,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->pc);
+                  TARGET_FMT_lx "\n", ctx->base.pc_next);
 #endif
         generate_exception_end(ctx, EXCP_RI);
         goto out;
@@ -4335,7 +4334,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
             gen_load_gpr(t1, rt);
             bcond_compute = 1;
         }
-        btgt = ctx->pc + insn_bytes + offset;
+        btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_BGEZ:
     case OPC_BGEZAL:
@@ -4354,7 +4353,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
             gen_load_gpr(t0, rs);
             bcond_compute = 1;
         }
-        btgt = ctx->pc + insn_bytes + offset;
+        btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_BPOSGE32:
 #if defined(TARGET_MIPS64)
@@ -4364,13 +4363,14 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
         tcg_gen_andi_tl(t0, cpu_dspctrl, 0x3F);
 #endif
         bcond_compute = 1;
-        btgt = ctx->pc + insn_bytes + offset;
+        btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_J:
     case OPC_JAL:
     case OPC_JALX:
         /* Jump to immediate */
-        btgt = ((ctx->pc + insn_bytes) & (int32_t)0xF0000000) | (uint32_t)offset;
+        btgt = ((ctx->base.pc_next + insn_bytes) & (int32_t)0xF0000000) |
+            (uint32_t)offset;
         break;
     case OPC_JR:
     case OPC_JALR:
@@ -4416,19 +4416,19 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
             /* Handle as an unconditional branch to get correct delay
                slot checking.  */
             blink = 31;
-            btgt = ctx->pc + insn_bytes + delayslot_size;
+            btgt = ctx->base.pc_next + insn_bytes + delayslot_size;
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_BLTZALL: /* 0 < 0 likely */
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->pc + 8);
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 8);
             /* Skip the instruction in the delay slot */
-            ctx->pc += 4;
+            ctx->base.pc_next += 4;
             goto out;
         case OPC_BNEL:    /* rx != rx likely */
         case OPC_BGTZL:   /* 0 > 0 likely */
         case OPC_BLTZL:   /* 0 < 0 likely */
             /* Skip the instruction in the delay slot */
-            ctx->pc += 4;
+            ctx->base.pc_next += 4;
             goto out;
         case OPC_J:
             ctx->hflags |= MIPS_HFLAG_B;
@@ -4540,7 +4540,8 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
         int post_delay = insn_bytes + delayslot_size;
         int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
 
-        tcg_gen_movi_tl(cpu_gpr[blink], ctx->pc + post_delay + lowbit);
+        tcg_gen_movi_tl(cpu_gpr[blink],
+                        ctx->base.pc_next + post_delay + lowbit);
     }
 
  out:
@@ -5322,18 +5323,18 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
-            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
 	    }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
                after reading count. DISAS_STOP isn't sufficient, we need to
                ensure we break completely out of translated code.  */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -5729,7 +5730,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS32);
 
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -5901,7 +5902,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_pagegrain(cpu_env, arg);
             rn = "PageGrain";
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 2:
             CP0_CHECK(ctx->sc);
@@ -5962,7 +5963,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_hwrena(cpu_env, arg);
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "HWREna";
             break;
         default:
@@ -6025,29 +6026,29 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "SRSMap";
             break;
         default:
@@ -6062,8 +6063,8 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* Stop translation as we may have triggered an interrupt.
              * DISAS_STOP isn't sufficient, we need to ensure we break out of
              * translated code to check for pending interrupts.  */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Cause";
             break;
         default:
@@ -6101,7 +6102,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_config0(cpu_env, arg);
             rn = "Config";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 1:
             /* ignored, read only */
@@ -6111,24 +6112,24 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_config2(cpu_env, arg);
             rn = "Config2";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 3:
             gen_helper_mtc0_config3(cpu_env, arg);
             rn = "Config3";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 4:
             gen_helper_mtc0_config4(cpu_env, arg);
             rn = "Config4";
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 5:
             gen_helper_mtc0_config5(cpu_env, arg);
             rn = "Config5";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         /* 6,7 are implementation dependent */
         case 6:
@@ -6218,34 +6219,34 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Debug";
             break;
         case 1:
 //            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
             rn = "TraceControl";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             rn = "TraceControl2";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
         case 3:
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
 //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             rn = "UserTraceData";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "TraceBPC";
             goto cp0_unimplemented;
         default:
@@ -6305,7 +6306,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "ErrCtl";
             break;
         default:
@@ -6396,12 +6397,12 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("mtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         /* DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
-        gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXIT;
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
     }
     return;
 
@@ -6674,18 +6675,18 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
-            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
                after reading count. DISAS_STOP isn't sufficient, we need to
                ensure we break completely out of translated code.  */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
         /* 6,7 are implementation dependent */
@@ -7067,7 +7068,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS64);
 
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -7297,7 +7298,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_hwrena(cpu_env, arg);
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "HWREna";
             break;
         default:
@@ -7333,7 +7334,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         /* Stop translation as we may have switched the execution mode */
-        ctx->is_jmp = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
         break;
     case 10:
         switch (sel) {
@@ -7356,7 +7357,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         /* Stop translation as we may have switched the execution mode */
-        ctx->is_jmp = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
         break;
     case 12:
         switch (sel) {
@@ -7364,29 +7365,29 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "SRSMap";
             break;
         default:
@@ -7401,8 +7402,8 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* Stop translation as we may have triggered an interrupt.
              * DISAS_STOP isn't sufficient, we need to ensure we break out of
              * translated code to check for pending interrupts.  */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Cause";
             break;
         default:
@@ -7440,7 +7441,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_config0(cpu_env, arg);
             rn = "Config";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 1:
             /* ignored, read only */
@@ -7450,13 +7451,13 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_config2(cpu_env, arg);
             rn = "Config2";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 3:
             gen_helper_mtc0_config3(cpu_env, arg);
             rn = "Config3";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case 4:
             /* currently ignored */
@@ -7466,7 +7467,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_config5(cpu_env, arg);
             rn = "Config5";
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         /* 6,7 are implementation dependent */
         default:
@@ -7546,32 +7547,32 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
-            gen_save_pc(ctx->pc + 4);
-            ctx->is_jmp = DISAS_EXIT;
+            gen_save_pc(ctx->base.pc_next + 4);
+            ctx->base.is_jmp = DISAS_EXIT;
             rn = "Debug";
             break;
         case 1:
 //            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "TraceControl";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "TraceBPC";
             goto cp0_unimplemented;
         default:
@@ -7631,7 +7632,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             rn = "ErrCtl";
             break;
         default:
@@ -7722,12 +7723,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("dmtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         /* DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
-        gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXIT;
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
     }
     return;
 
@@ -8138,7 +8139,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
             tcg_temp_free_i32(fs_tmp);
         }
         /* Stop translation as we may have changed hflags */
-        ctx->is_jmp = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
         break;
     /* COP2: Not implemented. */
     case 4:
@@ -8297,7 +8298,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
                 check_insn(ctx, ISA_MIPS2);
                 gen_helper_eret(cpu_env);
             }
-            ctx->is_jmp = DISAS_EXIT;
+            ctx->base.is_jmp = DISAS_EXIT;
         }
         break;
     case OPC_DERET:
@@ -8312,7 +8313,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
             generate_exception_end(ctx, EXCP_RI);
         } else {
             gen_helper_deret(cpu_env);
-            ctx->is_jmp = DISAS_EXIT;
+            ctx->base.is_jmp = DISAS_EXIT;
         }
         break;
     case OPC_WAIT:
@@ -8323,11 +8324,11 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
             goto die;
         }
         /* If we get an exception, we want to restart at next instruction */
-        ctx->pc += 4;
+        ctx->base.pc_next += 4;
         save_cpu_state(ctx, 1);
-        ctx->pc -= 4;
+        ctx->base.pc_next -= 4;
         gen_helper_wait(cpu_env);
-        ctx->is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
         break;
     default:
  die:
@@ -8354,7 +8355,7 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
     if (cc != 0)
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
 
-    btarget = ctx->pc + 4 + offset;
+    btarget = ctx->base.pc_next + 4 + offset;
 
     switch (op) {
     case OPC_BC1F:
@@ -8457,7 +8458,7 @@ static void gen_compute_branch1_r6(DisasContext *ctx, uint32_t op,
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->pc);
+                  "\n", ctx->base.pc_next);
 #endif
         generate_exception_end(ctx, EXCP_RI);
         goto out;
@@ -8466,7 +8467,7 @@ static void gen_compute_branch1_r6(DisasContext *ctx, uint32_t op,
     gen_load_fpr64(ctx, t0, ft);
     tcg_gen_andi_i64(t0, t0, 1);
 
-    btarget = addr_add(ctx, ctx->pc + 4, offset);
+    btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     switch (op) {
     case OPC_BC1EQZ:
@@ -8752,7 +8753,7 @@ static void gen_cp1 (DisasContext *ctx, uint32_t opc, int rt, int fs)
             tcg_temp_free_i32(fs_tmp);
         }
         /* Stop translation as we may have changed hflags */
-        ctx->is_jmp = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DMFC1:
@@ -10751,19 +10752,19 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_store_gpr(t0, rt);
         break;
     case 2:
-        if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_rdhwr_cc(t0, cpu_env);
-        if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
         }
         gen_store_gpr(t0, rt);
         /* Break the TB to be able to take timer interrupts immediately
            after reading count. DISAS_STOP isn't sufficient, we need to ensure
            we break completely out of translated code.  */
-        gen_save_pc(ctx->pc + 4);
-        ctx->is_jmp = DISAS_EXIT;
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
         break;
     case 3:
         gen_helper_rdhwr_ccres(t0, cpu_env);
@@ -10813,7 +10814,7 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
 static inline void clear_branch_hflags(DisasContext *ctx)
 {
     ctx->hflags &= ~MIPS_HFLAG_BMASK;
-    if (ctx->is_jmp == DISAS_NEXT) {
+    if (ctx->base.is_jmp == DISAS_NEXT) {
         save_cpu_state(ctx, 0);
     } else {
         /* it is not safe to save ctx->hflags as hflags may be changed
@@ -10828,11 +10829,11 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
         int proc_hflags = ctx->hflags & MIPS_HFLAG_BMASK;
         /* Branches completion */
         clear_branch_hflags(ctx);
-        ctx->is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
         /* FIXME: Need to clear can_do_io.  */
         switch (proc_hflags & MIPS_HFLAG_BMASK_BASE) {
         case MIPS_HFLAG_FBNSLOT:
-            gen_goto_tb(ctx, 0, ctx->pc + insn_bytes);
+            gen_goto_tb(ctx, 0, ctx->base.pc_next + insn_bytes);
             break;
         case MIPS_HFLAG_B:
             /* unconditional branch */
@@ -10851,7 +10852,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
                 TCGLabel *l1 = gen_new_label();
 
                 tcg_gen_brcondi_tl(TCG_COND_NE, bcond, 0, l1);
-                gen_goto_tb(ctx, 1, ctx->pc + insn_bytes);
+                gen_goto_tb(ctx, 1, ctx->base.pc_next + insn_bytes);
                 gen_set_label(l1);
                 gen_goto_tb(ctx, 0, ctx->btarget);
             }
@@ -10874,7 +10875,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             } else {
                 tcg_gen_mov_tl(cpu_PC, btarget);
             }
-            if (ctx->singlestep_enabled) {
+            if (ctx->base.singlestep_enabled) {
                 save_cpu_state(ctx, 0);
                 gen_helper_raise_exception_debug(cpu_env);
             }
@@ -10899,7 +10900,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->pc);
+                  "\n", ctx->base.pc_next);
 #endif
         generate_exception_end(ctx, EXCP_RI);
         goto out;
@@ -10913,10 +10914,10 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
-        ctx->btarget = addr_add(ctx, ctx->pc + 4, offset);
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         if (rs <= rt && rs == 0) {
             /* OPC_BEQZALC, OPC_BNEZALC */
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->pc + 4 + m16_lowbit);
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
         }
         break;
     case OPC_BLEZC: /* OPC_BGEZC, OPC_BGEC */
@@ -10924,23 +10925,23 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
-        ctx->btarget = addr_add(ctx, ctx->pc + 4, offset);
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BLEZALC: /* OPC_BGEZALC, OPC_BGEUC */
     case OPC_BGTZALC: /* OPC_BLTZALC, OPC_BLTUC */
         if (rs == 0 || rs == rt) {
             /* OPC_BLEZALC, OPC_BGEZALC */
             /* OPC_BGTZALC, OPC_BLTZALC */
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->pc + 4 + m16_lowbit);
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
         }
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
-        ctx->btarget = addr_add(ctx, ctx->pc + 4, offset);
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BC:
     case OPC_BALC:
-        ctx->btarget = addr_add(ctx, ctx->pc + 4, offset);
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BEQZC:
     case OPC_BNEZC:
@@ -10948,7 +10949,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
             /* OPC_BEQZC, OPC_BNEZC */
             gen_load_gpr(t0, rs);
             bcond_compute = 1;
-            ctx->btarget = addr_add(ctx, ctx->pc + 4, offset);
+            ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
@@ -10971,13 +10972,13 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         /* Uncoditional compact branch */
         switch (opc) {
         case OPC_JIALC:
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->pc + 4 + m16_lowbit);
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
             /* Fallthrough */
         case OPC_JIC:
             ctx->hflags |= MIPS_HFLAG_BR;
             break;
         case OPC_BALC:
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->pc + 4 + m16_lowbit);
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
             /* Fallthrough */
         case OPC_BC:
             ctx->hflags |= MIPS_HFLAG_B;
@@ -11602,7 +11603,7 @@ static void decode_i64_mips16 (DisasContext *ctx,
 
 static int decode_extended_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
 {
-    int extend = cpu_lduw_code(env, ctx->pc + 2);
+    int extend = cpu_lduw_code(env, ctx->base.pc_next + 2);
     int op, rx, ry, funct, sa;
     int16_t imm, offset;
 
@@ -11842,7 +11843,7 @@ static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
         /* No delay slot, so just process as a normal instruction */
         break;
     case M16_OPC_JAL:
-        offset = cpu_lduw_code(env, ctx->pc + 2);
+        offset = cpu_lduw_code(env, ctx->base.pc_next + 2);
         offset = (((ctx->opcode & 0x1f) << 21)
                   | ((ctx->opcode >> 5) & 0x1f) << 16
                   | offset) << 2;
@@ -13570,7 +13571,7 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 gen_helper_di(t0, cpu_env);
                 gen_store_gpr(t0, rs);
                 /* Stop translation as we may have switched the execution mode */
-                ctx->is_jmp = DISAS_STOP;
+                ctx->base.is_jmp = DISAS_STOP;
                 tcg_temp_free(t0);
             }
             break;
@@ -13584,8 +13585,8 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 gen_store_gpr(t0, rs);
                 /* DISAS_STOP isn't sufficient, we need to ensure we break out
                    of translated code to check for pending interrupts.  */
-                gen_save_pc(ctx->pc + 4);
-                ctx->is_jmp = DISAS_EXIT;
+                gen_save_pc(ctx->base.pc_next + 4);
+                ctx->base.is_jmp = DISAS_EXIT;
                 tcg_temp_free(t0);
             }
             break;
@@ -13940,7 +13941,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
     uint32_t op, minor, minor2, mips32_op;
     uint32_t cond, fmt, cc;
 
-    insn = cpu_lduw_code(env, ctx->pc + 2);
+    insn = cpu_lduw_code(env, ctx->base.pc_next + 2);
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = (ctx->opcode >> 21) & 0x1f;
@@ -14741,7 +14742,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
                 /* SYNCI */
                 /* Break the TB to be able to sync copied instructions
                    immediately */
-                ctx->is_jmp = DISAS_STOP;
+                ctx->base.is_jmp = DISAS_STOP;
             } else {
                 /* TNEI */
                 mips32_op = OPC_TNEI;
@@ -14772,7 +14773,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
             /* Break the TB to be able to sync copied instructions
                immediately */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case BC2F:
         case BC2T:
@@ -15135,16 +15136,16 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             /* PCREL: ADDIUPC, AUIPC, ALUIPC, LWPC */
             switch ((ctx->opcode >> 16) & 0x1f) {
             case ADDIUPC_00 ... ADDIUPC_07:
-                gen_pcrel(ctx, OPC_ADDIUPC, ctx->pc & ~0x3, rt);
+                gen_pcrel(ctx, OPC_ADDIUPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             case AUIPC:
-                gen_pcrel(ctx, OPC_AUIPC, ctx->pc, rt);
+                gen_pcrel(ctx, OPC_AUIPC, ctx->base.pc_next, rt);
                 break;
             case ALUIPC:
-                gen_pcrel(ctx, OPC_ALUIPC, ctx->pc, rt);
+                gen_pcrel(ctx, OPC_ALUIPC, ctx->base.pc_next, rt);
                 break;
             case LWPC_08 ... LWPC_0F:
-                gen_pcrel(ctx, R6_OPC_LWPC, ctx->pc & ~0x3, rt);
+                gen_pcrel(ctx, R6_OPC_LWPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             default:
                 generate_exception(ctx, EXCP_RI);
@@ -15276,8 +15277,8 @@ static int decode_micromips_opc (CPUMIPSState *env, DisasContext *ctx)
     uint32_t op;
 
     /* make sure instructions are on a halfword boundary */
-    if (ctx->pc & 0x1) {
-        env->CP0_BadVAddr = ctx->pc;
+    if (ctx->base.pc_next & 0x1) {
+        env->CP0_BadVAddr = ctx->base.pc_next;
         generate_exception_end(ctx, EXCP_AdEL);
         return 2;
     }
@@ -18503,7 +18504,7 @@ static void gen_msa_branch(CPUMIPSState *env, DisasContext *ctx, uint32_t op1)
         break;
     }
 
-    ctx->btarget = ctx->pc + (s16 << 2) + 4;
+    ctx->btarget = ctx->base.pc_next + (s16 << 2) + 4;
 
     ctx->hflags |= MIPS_HFLAG_BC;
     ctx->hflags |= MIPS_HFLAG_BDS32;
@@ -19524,8 +19525,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     int16_t imm;
 
     /* make sure instructions are on a word boundary */
-    if (ctx->pc & 0x3) {
-        env->CP0_BadVAddr = ctx->pc;
+    if (ctx->base.pc_next & 0x3) {
+        env->CP0_BadVAddr = ctx->base.pc_next;
         generate_exception_err(ctx, EXCP_AdEL, EXCP_INST_NOTAVAIL);
         return;
     }
@@ -19536,7 +19537,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 
         tcg_gen_brcondi_tl(TCG_COND_NE, bcond, 0, l1);
         tcg_gen_movi_i32(hflags, ctx->hflags & ~MIPS_HFLAG_BMASK);
-        gen_goto_tb(ctx, 1, ctx->pc + 4);
+        gen_goto_tb(ctx, 1, ctx->base.pc_next + 4);
         gen_set_label(l1);
     }
 
@@ -19597,7 +19598,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, ISA_MIPS32R2);
             /* Break the TB to be able to sync copied instructions
                immediately */
-            ctx->is_jmp = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
             break;
         case OPC_BPOSGE32:    /* MIPS DSP branch */
 #if defined(TARGET_MIPS64)
@@ -19700,7 +19701,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_store_gpr(t0, rt);
                     /* Stop translation as we may have switched
                        the execution mode.  */
-                    ctx->is_jmp = DISAS_STOP;
+                    ctx->base.is_jmp = DISAS_STOP;
                     break;
                 case OPC_EI:
                     check_insn(ctx, ISA_MIPS32R2);
@@ -19709,8 +19710,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_store_gpr(t0, rt);
                     /* DISAS_STOP isn't sufficient, we need to ensure we break
                        out of translated code to check for pending interrupts */
-                    gen_save_pc(ctx->pc + 4);
-                    ctx->is_jmp = DISAS_EXIT;
+                    gen_save_pc(ctx->base.pc_next + 4);
+                    ctx->base.is_jmp = DISAS_EXIT;
                     break;
                 default:            /* Invalid */
                     MIPS_INVAL("mfmc0");
@@ -20184,7 +20185,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_PCREL:
         check_insn(ctx, ISA_MIPS32R6);
-        gen_pcrel(ctx, ctx->opcode, ctx->pc, rs);
+        gen_pcrel(ctx, ctx->opcode, ctx->base.pc_next, rs);
         break;
     default:            /* Invalid */
         MIPS_INVAL("major opcode");
@@ -20197,22 +20198,22 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
     CPUMIPSState *env = cs->env_ptr;
     DisasContext ctx;
-    target_ulong pc_start;
     target_ulong page_start;
-    int num_insns;
     int max_insns;
     int insn_bytes;
     int is_slot;
 
-    pc_start = tb->pc;
-    page_start = pc_start & TARGET_PAGE_MASK;
-    ctx.pc = pc_start;
+    ctx.base.tb = tb;
+    ctx.base.pc_first = tb->pc;
+    ctx.base.pc_next = tb->pc;
+    ctx.base.is_jmp = DISAS_NEXT;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.num_insns = 0;
+
+    page_start = ctx.base.pc_first & TARGET_PAGE_MASK;
     ctx.saved_pc = -1;
-    ctx.singlestep_enabled = cs->singlestep_enabled;
     ctx.insn_flags = env->insn_flags;
     ctx.CP0_Config1 = env->CP0_Config1;
-    ctx.tb = tb;
-    ctx.is_jmp = DISAS_NEXT;
     ctx.btarget = 0;
     ctx.kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
     ctx.rxi = (env->CP0_Config3 >> CP0C3_RXI) & 1;
@@ -20226,7 +20227,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx.cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-    ctx.hflags = (uint32_t)tb->flags; /* FIXME: maybe use 64 bits here? */
+    ctx.hflags = (uint32_t)ctx.base.tb->flags; /* FIXME: maybe use 64 bits? */
     ctx.ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
     ctx.ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
@@ -20242,7 +20243,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #endif
     ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
                                  MO_UNALN : MO_ALIGN;
-    num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -20253,36 +20253,37 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx.mem_idx, ctx.hflags);
     gen_tb_start(tb);
-    while (ctx.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx.pc, ctx.hflags & MIPS_HFLAG_BMASK, ctx.btarget);
-        num_insns++;
+    while (ctx.base.is_jmp == DISAS_NEXT) {
+        tcg_gen_insn_start(ctx.base.pc_next, ctx.hflags & MIPS_HFLAG_BMASK,
+                           ctx.btarget);
+        ctx.base.num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
             save_cpu_state(&ctx, 1);
-            ctx.is_jmp = DISAS_NORETURN;
+            ctx.base.is_jmp = DISAS_NORETURN;
             gen_helper_raise_exception_debug(cpu_env);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.pc += 4;
+            ctx.base.pc_next += 4;
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
+        if (ctx.base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
         is_slot = ctx.hflags & MIPS_HFLAG_BMASK;
         if (!(ctx.hflags & MIPS_HFLAG_M16)) {
-            ctx.opcode = cpu_ldl_code(env, ctx.pc);
+            ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
             insn_bytes = 4;
             decode_opc(env, &ctx);
         } else if (ctx.insn_flags & ASE_MICROMIPS) {
-            ctx.opcode = cpu_lduw_code(env, ctx.pc);
+            ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
             insn_bytes = decode_micromips_opc(env, &ctx);
         } else if (ctx.insn_flags & ASE_MIPS16) {
-            ctx.opcode = cpu_lduw_code(env, ctx.pc);
+            ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
             insn_bytes = decode_mips16_opc(env, &ctx);
         } else {
             generate_exception_end(&ctx, EXCP_RI);
@@ -20306,17 +20307,18 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         if (is_slot) {
             gen_branch(&ctx, insn_bytes);
         }
-        ctx.pc += insn_bytes;
+        ctx.base.pc_next += insn_bytes;
 
         /* Execute a branch and its delay slot as a single instruction.
            This is what GDB expects and is consistent with what the
            hardware does (e.g. if a delay slot instruction faults, the
            reported PC is the PC of the branch).  */
-        if (cs->singlestep_enabled && (ctx.hflags & MIPS_HFLAG_BMASK) == 0) {
+        if (ctx.base.singlestep_enabled &&
+            (ctx.hflags & MIPS_HFLAG_BMASK) == 0) {
             break;
         }
 
-        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
+        if (ctx.base.pc_next - page_start >= TARGET_PAGE_SIZE) {
             break;
         }
 
@@ -20324,8 +20326,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns >= max_insns)
+        if (ctx.base.num_insns >= max_insns) {
             break;
+        }
 
         if (singlestep)
             break;
@@ -20333,18 +20336,18 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    if (cs->singlestep_enabled && ctx.is_jmp != DISAS_NORETURN) {
-        save_cpu_state(&ctx, ctx.is_jmp != DISAS_EXIT);
+    if (ctx.base.singlestep_enabled && ctx.base.is_jmp != DISAS_NORETURN) {
+        save_cpu_state(&ctx, ctx.base.is_jmp != DISAS_EXIT);
         gen_helper_raise_exception_debug(cpu_env);
     } else {
-        switch (ctx.is_jmp) {
+        switch (ctx.base.is_jmp) {
         case DISAS_STOP:
-            gen_save_pc(ctx.pc);
+            gen_save_pc(ctx.base.pc_next);
             tcg_gen_lookup_and_goto_ptr();
             break;
         case DISAS_NEXT:
             save_cpu_state(&ctx, 0);
-            gen_goto_tb(&ctx, 0, ctx.pc);
+            gen_goto_tb(&ctx, 0, ctx.base.pc_next);
             break;
         case DISAS_EXIT:
             tcg_gen_exit_tb(0);
@@ -20355,18 +20358,19 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
     }
 done_generating:
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, ctx.base.num_insns);
 
-    tb->size = ctx.pc - pc_start;
-    tb->icount = num_insns;
+    tb->size = ctx.base.pc_next - ctx.base.pc_first;
+    tb->icount = ctx.base.num_insns;
 
 #ifdef DEBUG_DISAS
     LOG_DISAS("\n");
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(ctx.base.pc_first)) {
         qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start);
+        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
+        log_target_disas(cs, ctx.base.pc_first,
+                         ctx.base.pc_next - ctx.base.pc_first);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.17.0
