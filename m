Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFs-00032v-G4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFn-0002OW-DB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyDFn-0002N9-25
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Mar 2018 10:08:12 +0100
Message-Id: <20180320090813.852-2-laurent@vivier.eu>
In-Reply-To: <20180320090813.852-1-laurent@vivier.eu>
References: <20180320090813.852-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] target/m68k: add DisasContext parameter to
 gen_extend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

This parameter will be needed to manage automatic release
of temporary allocated TCG variables.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180319113544.704-2-laurent@vivier.eu>
---
 target/m68k/translate.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index cef6f663ad..1c2ff56305 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -617,7 +617,7 @@ static void gen_flush_flags(DisasContext *s)
     s->cc_op = CC_OP_FLAGS;
 }
 
-static inline TCGv gen_extend(TCGv val, int opsize, int sign)
+static inline TCGv gen_extend(DisasContext *s, TCGv val, int opsize, int sign)
 {
     TCGv tmp;
 
@@ -811,7 +811,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             gen_partset_reg(opsize, reg, val);
             return store_dummy;
         } else {
-            return gen_extend(reg, opsize, what == EA_LOADS);
+            return gen_extend(s, reg, opsize, what == EA_LOADS);
         }
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
@@ -819,7 +819,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             tcg_gen_mov_i32(reg, val);
             return store_dummy;
         } else {
-            return gen_extend(reg, opsize, what == EA_LOADS);
+            return gen_extend(s, reg, opsize, what == EA_LOADS);
         }
     case 2: /* Indirect register */
         reg = get_areg(s, reg0);
@@ -1759,8 +1759,8 @@ DISAS_INSN(abcd_reg)
 
     gen_flush_flags(s); /* !Z is sticky */
 
-    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
-    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+    src = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(s, DREG(insn, 9), OS_BYTE, 0);
     bcd_add(dest, src);
     gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
 
@@ -1794,8 +1794,8 @@ DISAS_INSN(sbcd_reg)
 
     gen_flush_flags(s); /* !Z is sticky */
 
-    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
-    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+    src = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(s, DREG(insn, 9), OS_BYTE, 0);
 
     bcd_sub(dest, src);
 
@@ -1856,7 +1856,7 @@ DISAS_INSN(addsub)
 
     add = (insn & 0x4000) != 0;
     opsize = insn_opsize(insn);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
     dest = tcg_temp_new();
     if (insn & 0x100) {
         SRC_EA(env, tmp, opsize, 1, &addr);
@@ -2386,7 +2386,7 @@ DISAS_INSN(cas)
         return;
     }
 
-    cmp = gen_extend(DREG(ext, 0), opsize, 1);
+    cmp = gen_extend(s, DREG(ext, 0), opsize, 1);
 
     /* if  <EA> == Dc then
      *     <EA> = Du
@@ -3055,7 +3055,7 @@ DISAS_INSN(or)
     int opsize;
 
     opsize = insn_opsize(insn);
-    reg = gen_extend(DREG(insn, 9), opsize, 0);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 0);
     dest = tcg_temp_new();
     if (insn & 0x100) {
         SRC_EA(env, src, opsize, 0, &addr);
@@ -3120,8 +3120,8 @@ DISAS_INSN(subx_reg)
 
     opsize = insn_opsize(insn);
 
-    src = gen_extend(DREG(insn, 0), opsize, 1);
-    dest = gen_extend(DREG(insn, 9), opsize, 1);
+    src = gen_extend(s, DREG(insn, 0), opsize, 1);
+    dest = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_subx(s, src, dest, opsize);
 
@@ -3176,7 +3176,7 @@ DISAS_INSN(cmp)
 
     opsize = insn_opsize(insn);
     SRC_EA(env, src, opsize, 1, NULL);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
     gen_update_cc_cmp(s, reg, src, opsize);
 }
 
@@ -3329,8 +3329,8 @@ DISAS_INSN(addx_reg)
 
     opsize = insn_opsize(insn);
 
-    dest = gen_extend(DREG(insn, 9), opsize, 1);
-    src = gen_extend(DREG(insn, 0), opsize, 1);
+    dest = gen_extend(s, DREG(insn, 9), opsize, 1);
+    src = gen_extend(s, DREG(insn, 0), opsize, 1);
 
     gen_addx(s, src, dest, opsize);
 
@@ -3369,7 +3369,7 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
     int logical = insn & 8;
     int left = insn & 0x100;
     int bits = opsize_bytes(opsize) * 8;
-    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+    TCGv reg = gen_extend(s, DREG(insn, 0), opsize, !logical);
 
     if (count == 0) {
         count = 8;
@@ -3419,7 +3419,7 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
     int logical = insn & 8;
     int left = insn & 0x100;
     int bits = opsize_bytes(opsize) * 8;
-    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+    TCGv reg = gen_extend(s, DREG(insn, 0), opsize, !logical);
     TCGv s32;
     TCGv_i64 t64, s64;
 
@@ -3556,7 +3556,7 @@ DISAS_INSN(shift_mem)
            while M68000 sets if the most significant bit is changed at
            any time during the shift operation */
         if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
-            src = gen_extend(src, OS_WORD, 1);
+            src = gen_extend(s, src, OS_WORD, 1);
             tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, src);
         }
     } else {
@@ -3789,7 +3789,7 @@ DISAS_INSN(rotate8_im)
     TCGv shift;
     int tmp;
 
-    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
 
     tmp = (insn >> 9) & 7;
     if (tmp == 0) {
@@ -3816,7 +3816,7 @@ DISAS_INSN(rotate16_im)
     TCGv shift;
     int tmp;
 
-    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_WORD, 0);
     tmp = (insn >> 9) & 7;
     if (tmp == 0) {
         tmp = 8;
@@ -3876,7 +3876,7 @@ DISAS_INSN(rotate8_reg)
     TCGv t0, t1;
     int left = (insn & 0x100);
 
-    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_BYTE, 0);
     src = DREG(insn, 9);
     /* shift in [0..63] */
     t0 = tcg_temp_new_i32();
@@ -3911,7 +3911,7 @@ DISAS_INSN(rotate16_reg)
     TCGv t0, t1;
     int left = (insn & 0x100);
 
-    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    reg = gen_extend(s, DREG(insn, 0), OS_WORD, 0);
     src = DREG(insn, 9);
     /* shift in [0..63] */
     t0 = tcg_temp_new_i32();
@@ -4353,7 +4353,7 @@ DISAS_INSN(chk)
         return;
     }
     SRC_EA(env, src, opsize, 1, NULL);
-    reg = gen_extend(DREG(insn, 9), opsize, 1);
+    reg = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_flush_flags(s);
     gen_helper_chk(cpu_env, reg, src);
-- 
2.14.3
