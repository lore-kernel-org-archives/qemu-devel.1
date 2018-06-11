Received: from eggs.gnu.org ([2001:4830:134:3::10]:56313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOh-0002UN-8y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOe-0000mC-RK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOe-0000jy-3j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:00 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:32 +0200
Message-Id: <20180611104935.20499-7-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 6/9] target/m68k: Convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Removed ctx->insn_pc in favour of ctx->base.pc_next.
Yes, it is annoying, but didn't want to waste its 4 bytes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-7-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 137 +++++++++++++++++++++++-------------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0cbd715550..12a74b0b59 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -111,14 +111,11 @@ void m68k_tcg_init(void)
 
 /* internal defines */
 typedef struct DisasContext {
+    DisasContextBase base;
     CPUM68KState *env;
-    target_ulong insn_pc; /* Start of the current instruction.  */
     target_ulong pc;
-    int is_jmp;
     CCOp cc_op; /* Current CC operation */
     int cc_op_synced;
-    struct TranslationBlock *tb;
-    int singlestep_enabled;
     TCGv_i64 mactmp;
     int done_mac;
     int writeback_mask;
@@ -203,10 +200,10 @@ static void do_writebacks(DisasContext *s)
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
 #else
-#define IS_USER(s)   (!(s->tb->flags & TB_FLAGS_MSR_S))
-#define SFC_INDEX(s) ((s->tb->flags & TB_FLAGS_SFC_S) ? \
+#define IS_USER(s)   (!(s->base.tb->flags & TB_FLAGS_MSR_S))
+#define SFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_SFC_S) ? \
                       MMU_KERNEL_IDX : MMU_USER_IDX)
-#define DFC_INDEX(s) ((s->tb->flags & TB_FLAGS_DFC_S) ? \
+#define DFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_DFC_S) ? \
                       MMU_KERNEL_IDX : MMU_USER_IDX)
 #endif
 
@@ -278,7 +275,7 @@ static void gen_jmp_im(DisasContext *s, uint32_t dest)
 {
     update_cc_op(s);
     tcg_gen_movi_i32(QREG_PC, dest);
-    s->is_jmp = DISAS_JUMP;
+    s->base.is_jmp = DISAS_JUMP;
 }
 
 /* Generate a jump to the address in qreg DEST.  */
@@ -286,7 +283,7 @@ static void gen_jmp(DisasContext *s, TCGv dest)
 {
     update_cc_op(s);
     tcg_gen_mov_i32(QREG_PC, dest);
-    s->is_jmp = DISAS_JUMP;
+    s->base.is_jmp = DISAS_JUMP;
 }
 
 static void gen_exception(DisasContext *s, uint32_t dest, int nr)
@@ -300,12 +297,12 @@ static void gen_exception(DisasContext *s, uint32_t dest, int nr)
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
 
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 static inline void gen_addr_fault(DisasContext *s)
 {
-    gen_exception(s, s->insn_pc, EXCP_ADDRESS);
+    gen_exception(s, s->base.pc_next, EXCP_ADDRESS);
 }
 
 /* Generate a load from the specified address.  Narrow values are
@@ -1003,7 +1000,7 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         break;
     case OS_EXTENDED:
         if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
             break;
         }
         tcg_gen_qemu_ld32u(tmp, addr, index);
@@ -1017,7 +1014,7 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         /* unimplemented data type on 68040/ColdFire
          * FIXME if needed for another FPU
          */
-        gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
         break;
     default:
         g_assert_not_reached();
@@ -1057,7 +1054,7 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         break;
     case OS_EXTENDED:
         if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
             break;
         }
         tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
@@ -1071,7 +1068,7 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         /* unimplemented data type on 68040/ColdFire
          * FIXME if needed for another FPU
          */
-        gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
         break;
     default:
         g_assert_not_reached();
@@ -1203,7 +1200,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                 break;
             case OS_EXTENDED:
                 if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-                    gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+                    gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
                     break;
                 }
                 tmp = tcg_const_i32(read_im32(env, s) >> 16);
@@ -1217,7 +1214,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                 /* unimplemented data type on 68040/ColdFire
                  * FIXME if needed for another FPU
                  */
-                gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
+                gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
                 break;
             default:
                 g_assert_not_reached();
@@ -1450,7 +1447,7 @@ static void gen_exit_tb(DisasContext *s)
 {
     update_cc_op(s);
     tcg_gen_movi_i32(QREG_PC, s->pc);
-    s->is_jmp = DISAS_EXIT;
+    s->base.is_jmp = DISAS_EXIT;
 }
 
 #define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
@@ -1474,8 +1471,8 @@ static void gen_exit_tb(DisasContext *s)
 static inline bool use_goto_tb(DisasContext *s, uint32_t dest)
 {
 #ifndef CONFIG_USER_ONLY
-    return (s->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK) ||
-           (s->insn_pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (s->base.pc_first & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK)
+        || (s->base.pc_next & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -1484,17 +1481,17 @@ static inline bool use_goto_tb(DisasContext *s, uint32_t dest)
 /* Generate a jump to an immediate address.  */
 static void gen_jmp_tb(DisasContext *s, int n, uint32_t dest)
 {
-    if (unlikely(s->singlestep_enabled)) {
+    if (unlikely(s->base.singlestep_enabled)) {
         gen_exception(s, dest, EXCP_DEBUG);
     } else if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(QREG_PC, dest);
-        tcg_gen_exit_tb(s->tb, n);
+        tcg_gen_exit_tb(s->base.tb, n);
     } else {
         gen_jmp_im(s, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
-    s->is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 DISAS_INSN(scc)
@@ -1541,12 +1538,12 @@ DISAS_INSN(dbcc)
 
 DISAS_INSN(undef_mac)
 {
-    gen_exception(s, s->insn_pc, EXCP_LINEA);
+    gen_exception(s, s->base.pc_next, EXCP_LINEA);
 }
 
 DISAS_INSN(undef_fpu)
 {
-    gen_exception(s, s->insn_pc, EXCP_LINEF);
+    gen_exception(s, s->base.pc_next, EXCP_LINEF);
 }
 
 DISAS_INSN(undef)
@@ -1555,8 +1552,8 @@ DISAS_INSN(undef)
        for the 680x0 series, as well as those that are implemented
        but actually illegal for CPU32 or pre-68020.  */
     qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
-                  insn, s->insn_pc);
-    gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
+                  insn, s->base.pc_next);
+    gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
 }
 
 DISAS_INSN(mulw)
@@ -1616,7 +1613,7 @@ DISAS_INSN(divl)
 
     if (ext & 0x400) {
         if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
-            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
             return;
         }
 
@@ -2310,7 +2307,7 @@ DISAS_INSN(arith_im)
             break;
         case OS_WORD:
             if (IS_USER(s)) {
-                gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+                gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
                 return;
             }
             src1 = gen_get_sr(s);
@@ -2479,7 +2476,7 @@ DISAS_INSN(cas2w)
                          (REG(ext1, 6) << 3) |
                          (REG(ext2, 0) << 6) |
                          (REG(ext1, 0) << 9));
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_exit_atomic(cpu_env);
     } else {
         gen_helper_cas2w(cpu_env, regs, addr1, addr2);
@@ -2529,7 +2526,7 @@ DISAS_INSN(cas2l)
                          (REG(ext1, 6) << 3) |
                          (REG(ext2, 0) << 6) |
                          (REG(ext1, 0) << 9));
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_cas2l_parallel(cpu_env, regs, addr1, addr2);
     } else {
         gen_helper_cas2l(cpu_env, regs, addr1, addr2);
@@ -2720,7 +2717,7 @@ DISAS_INSN(swap)
 
 DISAS_INSN(bkpt)
 {
-    gen_exception(s, s->insn_pc, EXCP_DEBUG);
+    gen_exception(s, s->base.pc_next, EXCP_DEBUG);
 }
 
 DISAS_INSN(pea)
@@ -2773,7 +2770,7 @@ DISAS_INSN(pulse)
 
 DISAS_INSN(illegal)
 {
-    gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+    gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 }
 
 /* ??? This should be atomic.  */
@@ -2803,7 +2800,7 @@ DISAS_INSN(mull)
 
     if (ext & 0x400) {
         if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
-            gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
+            gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
             return;
         }
 
@@ -2904,7 +2901,7 @@ DISAS_INSN(unlk)
 DISAS_INSN(reset)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4375,7 +4372,7 @@ DISAS_INSN(chk)
         }
         /* fallthru */
     default:
-        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
         return;
     }
     SRC_EA(env, src, opsize, 1, NULL);
@@ -4402,13 +4399,13 @@ DISAS_INSN(chk2)
         opsize = OS_LONG;
         break;
     default:
-        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
         return;
     }
 
     ext = read_im16(env, s);
     if ((ext & 0x0800) == 0) {
-        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
         return;
     }
 
@@ -4468,7 +4465,7 @@ DISAS_INSN(move16_reg)
 
     ext = read_im16(env, s);
     if ((ext & (1 << 15)) == 0) {
-        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
     }
 
     m68k_copy_line(AREG(ext, 12), AREG(insn, 0), index);
@@ -4530,7 +4527,7 @@ DISAS_INSN(move_from_sr)
     TCGv sr;
 
     if (IS_USER(s) && !m68k_feature(env, M68K_FEATURE_M68000)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     sr = gen_get_sr(s);
@@ -4547,7 +4544,7 @@ DISAS_INSN(moves)
     int extend;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4600,7 +4597,7 @@ DISAS_INSN(moves)
 DISAS_INSN(move_to_sr)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     gen_move_to_sr(env, s, insn, false);
@@ -4610,7 +4607,7 @@ DISAS_INSN(move_to_sr)
 DISAS_INSN(move_from_usp)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     tcg_gen_ld_i32(AREG(insn, 0), cpu_env,
@@ -4620,7 +4617,7 @@ DISAS_INSN(move_from_usp)
 DISAS_INSN(move_to_usp)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     tcg_gen_st_i32(AREG(insn, 0), cpu_env,
@@ -4630,7 +4627,7 @@ DISAS_INSN(move_to_usp)
 DISAS_INSN(halt)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4642,7 +4639,7 @@ DISAS_INSN(stop)
     uint16_t ext;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4656,10 +4653,10 @@ DISAS_INSN(stop)
 DISAS_INSN(rte)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-    gen_exception(s, s->insn_pc, EXCP_RTE);
+    gen_exception(s, s->base.pc_next, EXCP_RTE);
 }
 
 DISAS_INSN(cf_movec)
@@ -4668,7 +4665,7 @@ DISAS_INSN(cf_movec)
     TCGv reg;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4689,7 +4686,7 @@ DISAS_INSN(m68k_movec)
     TCGv reg;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4711,7 +4708,7 @@ DISAS_INSN(m68k_movec)
 DISAS_INSN(intouch)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* ICache fetch.  Implement as no-op.  */
@@ -4720,7 +4717,7 @@ DISAS_INSN(intouch)
 DISAS_INSN(cpushl)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* Cache push/invalidate.  Implement as no-op.  */
@@ -4729,7 +4726,7 @@ DISAS_INSN(cpushl)
 DISAS_INSN(cpush)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* Cache push/invalidate.  Implement as no-op.  */
@@ -4738,7 +4735,7 @@ DISAS_INSN(cpush)
 DISAS_INSN(cinv)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* Invalidate cache line.  Implement as no-op.  */
@@ -4750,7 +4747,7 @@ DISAS_INSN(pflush)
     TCGv opmode;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4764,7 +4761,7 @@ DISAS_INSN(ptest)
     TCGv is_read;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     is_read = tcg_const_i32((insn >> 5) & 1);
@@ -4775,7 +4772,7 @@ DISAS_INSN(ptest)
 
 DISAS_INSN(wddata)
 {
-    gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+    gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
 }
 
 DISAS_INSN(wdebug)
@@ -4783,7 +4780,7 @@ DISAS_INSN(wdebug)
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* TODO: Implement wdebug.  */
@@ -4793,7 +4790,7 @@ DISAS_INSN(wdebug)
 
 DISAS_INSN(trap)
 {
-    gen_exception(s, s->insn_pc, EXCP_TRAP0 + (insn & 0xf));
+    gen_exception(s, s->base.pc_next, EXCP_TRAP0 + (insn & 0xf));
 }
 
 static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
@@ -4860,7 +4857,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
     switch (mode) {
     case 0: /* Dn */
         if (mask != M68K_FPIAR && mask != M68K_FPSR && mask != M68K_FPCR) {
-            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
             return;
         }
         if (is_write) {
@@ -4871,7 +4868,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
         return;
     case 1: /* An, only with FPIAR */
         if (mask != M68K_FPIAR) {
-            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
             return;
         }
         if (is_write) {
@@ -5429,7 +5426,7 @@ DISAS_INSN(frestore)
     TCGv addr;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
@@ -5443,7 +5440,7 @@ DISAS_INSN(frestore)
 DISAS_INSN(fsave)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
 
@@ -6075,14 +6072,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     /* generate intermediate code */
     pc_start = tb->pc;
 
-    dc->tb = tb;
+    dc->base.tb = tb;
 
     dc->env = env;
-    dc->is_jmp = DISAS_NEXT;
+    dc->base.is_jmp = DISAS_NEXT;
     dc->pc = pc_start;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_synced = 1;
-    dc->singlestep_enabled = cs->singlestep_enabled;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
     dc->done_mac = 0;
     dc->writeback_mask = 0;
     num_insns = 0;
@@ -6116,9 +6113,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_io_start();
         }
 
-        dc->insn_pc = dc->pc;
+        dc->base.pc_next = dc->pc;
 	disas_m68k_insn(env, dc);
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
              !cs->singlestep_enabled &&
              !singlestep &&
              (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
@@ -6128,13 +6125,13 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         gen_io_end();
     if (unlikely(cs->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
-        if (!dc->is_jmp) {
+        if (!dc->base.is_jmp) {
             update_cc_op(dc);
             tcg_gen_movi_i32(QREG_PC, dc->pc);
         }
         gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
     } else {
-        switch(dc->is_jmp) {
+        switch (dc->base.is_jmp) {
         case DISAS_NEXT:
             update_cc_op(dc);
             gen_jmp_tb(dc, 0, dc->pc);
-- 
2.14.4
