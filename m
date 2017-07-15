Received: from eggs.gnu.org ([2001:4830:134:3::10]:38125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbV-0003k6-8H
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbS-0003Gi-N5
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:13 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbS-0003GS-DQ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:10 -0400
Received: by mail-pf0-x244.google.com with SMTP id q85so13697918pfq.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:18 -1000
Message-Id: <20170715094243.28371-10-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 09/34] target/i386: [tcg] Port to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002098212.22386.17313318023406046314.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 140 ++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 11bc455..7825593 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -95,6 +95,8 @@ static int x86_64_hregs;
 #endif
 
 typedef struct DisasContext {
+    DisasContextBase base;
+
     /* current insn context */
     int override; /* -1 if no override */
     int prefix;
@@ -102,8 +104,6 @@ typedef struct DisasContext {
     TCGMemOp dflag;
     target_ulong pc_start;
     target_ulong pc; /* pc = eip + cs_base */
-    int is_jmp; /* 1 = means jump (stop translation), 2 means CPU
-                   static state change (stop translation) */
     /* current block context */
     target_ulong cs_base; /* base of CS segment */
     int pe;     /* protected mode */
@@ -124,12 +124,10 @@ typedef struct DisasContext {
     int cpl;
     int iopl;
     int tf;     /* TF cpu flag */
-    int singlestep_enabled; /* "hardware" single step enabled */
     int jmp_opt; /* use direct block chaining for direct jumps */
     int repz_opt; /* optimize jumps within repz instructions */
     int mem_index; /* select memory access functions */
     uint64_t flags; /* all execution flags */
-    struct TranslationBlock *tb;
     int popl_esp_hack; /* for correct popl with esp base handling */
     int rip_offset; /* only used in x86_64, but left for simplicity */
     int cpuid_features;
@@ -1119,7 +1117,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_EDI(s);
@@ -1134,14 +1132,14 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
 
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_ESI(s);
@@ -1154,7 +1152,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -2137,7 +2135,7 @@ static inline int insn_const_size(TCGMemOp ot)
 static inline bool use_goto_tb(DisasContext *s, target_ulong pc)
 {
 #ifndef CONFIG_USER_ONLY
-    return (pc & TARGET_PAGE_MASK) == (s->tb->pc & TARGET_PAGE_MASK) ||
+    return (pc & TARGET_PAGE_MASK) == (s->base.tb->pc & TARGET_PAGE_MASK) ||
            (pc & TARGET_PAGE_MASK) == (s->pc_start & TARGET_PAGE_MASK);
 #else
     return true;
@@ -2152,8 +2150,8 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         gen_jmp_im(eip);
-        tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
-        s->is_jmp = DISAS_NORETURN;
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
+        s->base.is_jmp = DISAS_NORETURN;
     } else {
         /* jump to another page */
         gen_jmp_im(eip);
@@ -2244,12 +2242,12 @@ static void gen_movl_seg_T0(DisasContext *s, int seg_reg)
            stop as a special handling must be done to disable hardware
            interrupts for the next instruction */
         if (seg_reg == R_SS || (s->code32 && seg_reg < R_FS)) {
-            s->is_jmp = DISAS_TOO_MANY;
+            s->base.is_jmp = DISAS_TOO_MANY;
         }
     } else {
         gen_op_movl_seg_T0_vm(seg_reg);
         if (seg_reg == R_SS) {
-            s->is_jmp = DISAS_TOO_MANY;
+            s->base.is_jmp = DISAS_TOO_MANY;
         }
     }
 }
@@ -2422,7 +2420,7 @@ static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 /* Generate #UD for the current instruction.  The assumption here is that
@@ -2460,7 +2458,7 @@ static void gen_interrupt(DisasContext *s, int intno,
     gen_jmp_im(cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
@@ -2468,7 +2466,7 @@ static void gen_debug(DisasContext *s, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_debug(cpu_env);
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2524,10 +2522,10 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
-    if (s->tb->flags & HF_RF_MASK) {
+    if (s->base.tb->flags & HF_RF_MASK) {
         gen_helper_reset_rf(cpu_env);
     }
-    if (s->singlestep_enabled) {
+    if (s->base.singlestep_enabled) {
         gen_helper_debug(cpu_env);
     } else if (recheck_tf) {
         gen_helper_rechecking_single_step(cpu_env);
@@ -2543,7 +2541,7 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
     } else {
         tcg_gen_exit_tb(0);
     }
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 static inline void
@@ -4416,7 +4414,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
     }
 }
 
-/* convert one instruction. s->is_jmp is set if the translation must
+/* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                target_ulong pc_start)
@@ -5376,7 +5374,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_movl_seg_T0(s, reg);
         gen_pop_update(s, ot);
         /* Note that reg == R_SS in gen_movl_seg_T0 always sets is_jmp.  */
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg == R_SS) {
                 s->tf = 0;
@@ -5391,7 +5389,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         ot = gen_pop_T0(s);
         gen_movl_seg_T0(s, (b >> 3) & 7);
         gen_pop_update(s, ot);
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -5442,7 +5440,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
         gen_movl_seg_T0(s, reg);
         /* Note that reg == R_SS in gen_movl_seg_T0 always sets is_jmp.  */
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg == R_SS) {
                 s->tf = 0;
@@ -5651,7 +5649,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(ot, reg, cpu_T1);
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -6307,7 +6305,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6322,7 +6320,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6338,14 +6336,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6359,14 +6357,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6377,14 +6375,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6397,14 +6395,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6943,7 +6941,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x9b: /* fwait */
@@ -7112,11 +7110,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         gen_helper_rdtsc(cpu_env);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7188,7 +7186,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x100:
@@ -7371,7 +7369,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(0);
-            s->is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_NORETURN;
             break;
 
         case 0xd9: /* VMMCALL */
@@ -7571,11 +7569,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_rdtscp(cpu_env);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
@@ -7940,24 +7938,24 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_update_cc_op(s);
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(reg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                 }
@@ -8383,15 +8381,13 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
     CPUX86State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
-    target_ulong pc_ptr;
     uint32_t flags;
-    target_ulong pc_start;
     target_ulong cs_base;
     int num_insns;
     int max_insns;
 
     /* generate intermediate code */
-    pc_start = tb->pc;
+    dc->base.pc_first = tb->pc;
     cs_base = tb->cs_base;
     flags = tb->flags;
 
@@ -8404,11 +8400,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->cpl = (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl = (flags >> IOPL_SHIFT) & 3;
     dc->tf = (flags >> TF_SHIFT) & 1;
-    dc->singlestep_enabled = cs->singlestep_enabled;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_dirty = false;
     dc->cs_base = cs_base;
-    dc->tb = tb;
+    dc->base.tb = tb;
     dc->popl_esp_hack = 0;
     /* select memory access functions */
     dc->mem_index = 0;
@@ -8458,8 +8454,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_ptr1 = tcg_temp_new_ptr();
     cpu_cc_srcT = tcg_temp_local_new();
 
-    dc->is_jmp = DISAS_NEXT;
-    pc_ptr = pc_start;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.pc_next = dc->base.pc_first;
     num_insns = 0;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -8471,37 +8467,38 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(pc_ptr, dc->cc_op);
+        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
         num_insns++;
 
         /* If RF is set, suppress an internally generated breakpoint.  */
-        if (unlikely(cpu_breakpoint_test(cs, pc_ptr,
+        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next,
                                          tb->flags & HF_RF_MASK
                                          ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, pc_ptr - dc->cs_base);
+            gen_debug(dc, dc->base.pc_next - dc->cs_base);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            pc_ptr += 1;
+            dc->base.pc_next += 1;
             goto done_generating;
         }
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
 
-        pc_ptr = disas_insn(env, dc, pc_ptr);
+        dc->base.pc_next = disas_insn(env, dc, dc->base.pc_next);
         /* stop translation if indicated */
-        if (dc->is_jmp)
+        if (dc->base.is_jmp) {
             break;
+        }
         /* if single step mode, we generate only one instruction and
            generate an exception */
         /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
            the flag and abort the translation to give the irqs a
            change to be happen */
-        if (dc->tf || dc->singlestep_enabled ||
+        if (dc->tf || dc->base.singlestep_enabled ||
             (flags & HF_INHIBIT_IRQ_MASK)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
@@ -8512,23 +8509,23 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
            because an exception hasn't stopped this code.
          */
         if ((tb->cflags & CF_USE_ICOUNT)
-            && ((pc_ptr & TARGET_PAGE_MASK)
-                != ((pc_ptr + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_MASK)
-                || (pc_ptr & ~TARGET_PAGE_MASK) == 0)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            && ((dc->base.pc_next & TARGET_PAGE_MASK)
+                != ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_MASK)
+                || (dc->base.pc_next & ~TARGET_PAGE_MASK) == 0)) {
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
-            (pc_ptr - pc_start) >= (TARGET_PAGE_SIZE - 32) ||
+            (dc->base.pc_next - dc->base.pc_first) >= (TARGET_PAGE_SIZE - 32) ||
             num_insns >= max_insns) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         if (singlestep) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
@@ -8540,24 +8537,25 @@ done_generating:
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(dc->base.pc_first)) {
         int disas_flags;
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
 #ifdef TARGET_X86_64
         if (dc->code64)
             disas_flags = 2;
         else
 #endif
             disas_flags = !dc->code32;
-        log_target_disas(cs, pc_start, pc_ptr - pc_start, disas_flags);
+        log_target_disas(cs, dc->base.pc_first, dc->base.pc_next - dc->base.pc_first,
+                         disas_flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
 
-    tb->size = pc_ptr - pc_start;
+    tb->size = dc->base.pc_next - dc->base.pc_first;
     tb->icount = num_insns;
 }
 
-- 
2.9.4
