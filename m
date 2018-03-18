Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1exavc-0007uJ-3I
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1exavX-0000Xq-1j
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 12:13:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1exavW-0000Uo-Kx
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 12:12:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 18 Mar 2018 17:12:28 +0100
Message-Id: <20180318161228.21307-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: add a mechanism to automatically
 free TCGv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

SRC_EA() and gen_extend() can return either a temporary
TCGv or a memory allocated one. Mark them when they are
allocated, and free them automatically at end of the
instruction translation.

We want to free locally allocated TCGv to avoid
overflow in sequence like:

  0xc00ae406:  movel %fp@(-132),%fp@(-268)
  0xc00ae40c:  movel %fp@(-128),%fp@(-264)
  0xc00ae412:  movel %fp@(-20),%fp@(-212)
  0xc00ae418:  movel %fp@(-16),%fp@(-208)
  0xc00ae41e:  movel %fp@(-60),%fp@(-220)
  0xc00ae424:  movel %fp@(-56),%fp@(-216)
  0xc00ae42a:  movel %fp@(-124),%fp@(-252)
  0xc00ae430:  movel %fp@(-120),%fp@(-248)
  0xc00ae436:  movel %fp@(-12),%fp@(-260)
  0xc00ae43c:  movel %fp@(-8),%fp@(-256)
  0xc00ae442:  movel %fp@(-52),%fp@(-276)
  0xc00ae448:  movel %fp@(-48),%fp@(-272)
  ...

That can fill a lot of TCGv entries in a sequence,
especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")
we have no limit to fill the TCGOps cache and we can fill
the entire TCG variables array and overflow it.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 100 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index cef6f663ad..a660388054 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -123,8 +123,34 @@ typedef struct DisasContext {
     int done_mac;
     int writeback_mask;
     TCGv writeback[8];
+#define MAX_TO_RELEASE 8
+    int release_count;
+    TCGv release[MAX_TO_RELEASE];
 } DisasContext;
 
+static void init_release_array(DisasContext *s)
+{
+#ifdef CONFIG_DEBUG_TCG
+    memset(s->release, 0, sizeof(s->release));
+#endif
+    s->release_count = 0;
+}
+
+static void do_release(DisasContext *s)
+{
+    int i;
+    for (i = 0; i < s->release_count; i++) {
+        tcg_temp_free(s->release[i]);
+    }
+    init_release_array(s);
+}
+
+static TCGv mark_to_release(DisasContext *s, TCGv tmp)
+{
+    g_assert(s->release_count < MAX_TO_RELEASE);
+    return s->release[s->release_count++] = tmp;
+}
+
 static TCGv get_areg(DisasContext *s, unsigned regno)
 {
     if (s->writeback_mask & (1 << regno)) {
@@ -347,7 +373,8 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
         gen_store(s, opsize, addr, val, index);
         return store_dummy;
     } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS, index);
+        return mark_to_release(s, gen_load(s, opsize, addr,
+                                           what == EA_LOADS, index));
     }
 }
 
@@ -439,7 +466,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         } else {
             bd = 0;
         }
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         if ((ext & 0x44) == 0) {
             /* pre-index */
             add = gen_addr_index(s, ext, tmp);
@@ -449,7 +476,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         if ((ext & 0x80) == 0) {
             /* base not suppressed */
             if (IS_NULL_QREG(base)) {
-                base = tcg_const_i32(offset + bd);
+                base = mark_to_release(s, tcg_const_i32(offset + bd));
                 bd = 0;
             }
             if (!IS_NULL_QREG(add)) {
@@ -465,7 +492,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
                 add = tmp;
             }
         } else {
-            add = tcg_const_i32(bd);
+            add = mark_to_release(s, tcg_const_i32(bd));
         }
         if ((ext & 3) != 0) {
             /* memory indirect */
@@ -494,7 +521,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         }
     } else {
         /* brief extension word format */
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         add = gen_addr_index(s, ext, tmp);
         if (!IS_NULL_QREG(base)) {
             tcg_gen_add_i32(tmp, add, base);
@@ -617,14 +644,14 @@ static void gen_flush_flags(DisasContext *s)
     s->cc_op = CC_OP_FLAGS;
 }
 
-static inline TCGv gen_extend(TCGv val, int opsize, int sign)
+static inline TCGv gen_extend(DisasContext *s, TCGv val, int opsize, int sign)
 {
     TCGv tmp;
 
     if (opsize == OS_LONG) {
         tmp = val;
     } else {
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         gen_ext(tmp, val, opsize, sign);
     }
 
@@ -746,7 +773,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
             return NULL_QREG;
         }
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         if (reg0 == 7 && opsize == OS_BYTE &&
             m68k_feature(s->env, M68K_FEATURE_M68000)) {
             tcg_gen_subi_i32(tmp, reg, 2);
@@ -756,7 +783,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         return tmp;
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         ext = read_im16(env, s);
         tcg_gen_addi_i32(tmp, reg, (int16_t)ext);
         return tmp;
@@ -767,14 +794,14 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 1: /* Absolute long.  */
             offset = read_im32(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 2: /* pc displacement  */
             offset = s->pc;
             offset += (int16_t)read_im16(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(env, s, NULL_QREG);
         case 4: /* Immediate.  */
@@ -811,7 +838,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             gen_partset_reg(opsize, reg, val);
             return store_dummy;
         } else {
-            return gen_extend(reg, opsize, what == EA_LOADS);
+            return gen_extend(s, reg, opsize, what == EA_LOADS);
         }
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
@@ -819,7 +846,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             tcg_gen_mov_i32(reg, val);
             return store_dummy;
         } else {
-            return gen_extend(reg, opsize, what == EA_LOADS);
+            return gen_extend(s, reg, opsize, what == EA_LOADS);
         }
     case 2: /* Indirect register */
         reg = get_areg(s, reg0);
@@ -900,7 +927,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             default:
                 g_assert_not_reached();
             }
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         default:
             return NULL_QREG;
         }
@@ -1759,8 +1786,8 @@ DISAS_INSN(abcd_reg)
 
     gen_flush_flags(s); /* !Z is sticky */
 
-    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
-    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+    src = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(s, DREG(insn, 9), OS_BYTE, 0);
     bcd_add(dest, src);
     gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
 
@@ -1794,8 +1821,8 @@ DISAS_INSN(sbcd_reg)
 
     gen_flush_flags(s); /* !Z is sticky */
 
-    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
-    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+    src = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(s, DREG(insn, 9), OS_BYTE, 0);
 
     bcd_sub(dest, src);
 
@@ -1856,7 +1883,7 @@ DISAS_INSN(addsub)
 
     add = (insn & 0x4000) != 0;
     opsize = insn_opsize(insn);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
     dest = tcg_temp_new();
     if (insn & 0x100) {
         SRC_EA(env, tmp, opsize, 1, &addr);
@@ -2386,7 +2413,7 @@ DISAS_INSN(cas)
         return;
     }
 
-    cmp = gen_extend(DREG(ext, 0), opsize, 1);
+    cmp = gen_extend(s, DREG(ext, 0), opsize, 1);
 
     /* if  <EA> == Dc then
      *     <EA> = Du
@@ -3055,7 +3082,7 @@ DISAS_INSN(or)
     int opsize;
 
     opsize = insn_opsize(insn);
-    reg = gen_extend(DREG(insn, 9), opsize, 0);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 0);
     dest = tcg_temp_new();
     if (insn & 0x100) {
         SRC_EA(env, src, opsize, 0, &addr);
@@ -3120,8 +3147,8 @@ DISAS_INSN(subx_reg)
 
     opsize = insn_opsize(insn);
 
-    src = gen_extend(DREG(insn, 0), opsize, 1);
-    dest = gen_extend(DREG(insn, 9), opsize, 1);
+    src = gen_extend(s, DREG(insn, 0), opsize, 1);
+    dest = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_subx(s, src, dest, opsize);
 
@@ -3176,7 +3203,7 @@ DISAS_INSN(cmp)
 
     opsize = insn_opsize(insn);
     SRC_EA(env, src, opsize, 1, NULL);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
     gen_update_cc_cmp(s, reg, src, opsize);
 }
 
@@ -3329,8 +3356,8 @@ DISAS_INSN(addx_reg)
 
     opsize = insn_opsize(insn);
 
-    dest = gen_extend(DREG(insn, 9), opsize, 1);
-    src = gen_extend(DREG(insn, 0), opsize, 1);
+    dest = gen_extend(s, DREG(insn, 9), opsize, 1);
+    src = gen_extend(s, DREG(insn, 0), opsize, 1);
 
     gen_addx(s, src, dest, opsize);
 
@@ -3369,7 +3396,7 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
     int logical = insn & 8;
     int left = insn & 0x100;
     int bits = opsize_bytes(opsize) * 8;
-    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+    TCGv reg = gen_extend(s, DREG(insn, 0), opsize, !logical);
 
     if (count == 0) {
         count = 8;
@@ -3419,7 +3446,7 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
     int logical = insn & 8;
     int left = insn & 0x100;
     int bits = opsize_bytes(opsize) * 8;
-    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+    TCGv reg = gen_extend(s, DREG(insn, 0), opsize, !logical);
     TCGv s32;
     TCGv_i64 t64, s64;
 
@@ -3556,7 +3583,7 @@ DISAS_INSN(shift_mem)
            while M68000 sets if the most significant bit is changed at
            any time during the shift operation */
         if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
-            src = gen_extend(src, OS_WORD, 1);
+            src = gen_extend(s, src, OS_WORD, 1);
             tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, src);
         }
     } else {
@@ -3789,7 +3816,7 @@ DISAS_INSN(rotate8_im)
     TCGv shift;
     int tmp;
 
-    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
 
     tmp = (insn >> 9) & 7;
     if (tmp == 0) {
@@ -3816,7 +3843,7 @@ DISAS_INSN(rotate16_im)
     TCGv shift;
     int tmp;
 
-    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_WORD, 0);
     tmp = (insn >> 9) & 7;
     if (tmp == 0) {
         tmp = 8;
@@ -3876,7 +3903,7 @@ DISAS_INSN(rotate8_reg)
     TCGv t0, t1;
     int left = (insn & 0x100);
 
-    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
     src = DREG(insn, 9);
     /* shift in [0..63] */
     t0 = tcg_temp_new_i32();
@@ -3911,7 +3938,7 @@ DISAS_INSN(rotate16_reg)
     TCGv t0, t1;
     int left = (insn & 0x100);
 
-    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_WORD, 0);
     src = DREG(insn, 9);
     /* shift in [0..63] */
     t0 = tcg_temp_new_i32();
@@ -4353,7 +4380,7 @@ DISAS_INSN(chk)
         return;
     }
     SRC_EA(env, src, opsize, 1, NULL);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_flush_flags(s);
     gen_helper_chk(cpu_env, reg, src);
@@ -6033,6 +6060,7 @@ static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
     uint16_t insn = read_im16(env, s);
     opcode_table[insn](env, s, insn);
     do_writebacks(s);
+    do_release(s);
 }
 
 /* generate intermediate code for basic block 'tb'.  */
@@ -6067,6 +6095,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
+    init_release_array(dc);
+
     gen_tb_start(tb);
     do {
         pc_offset = dc->pc - pc_start;
-- 
2.14.3
