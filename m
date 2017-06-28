Received: from eggs.gnu.org ([2001:4830:134:3::10]:39734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJnv-0005Sp-HH
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJns-0003Sq-E0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:43:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQJns-0003SE-25
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:43:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 28 Jun 2017 22:42:35 +0200
Message-Id: <20170628204241.32106-2-laurent@vivier.eu>
In-Reply-To: <20170628204241.32106-1-laurent@vivier.eu>
References: <20170628204241.32106-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 1/7] target/m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

use DisasCompare with FPU conditions in fscc and fbcc.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 210 ++++++++++++++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 79 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 7aa0fdc..5f4bedc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4633,142 +4633,193 @@ undef:
     disas_undef_fpu(env, s, insn);
 }
 
-DISAS_INSN(fbcc)
+static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
 {
-    uint32_t offset;
-    uint32_t addr;
-    TCGLabel *l1;
-    TCGv tmp, fpsr;
-
-    addr = s->pc;
-    offset = cpu_ldsw_code(env, s->pc);
-    s->pc += 2;
-    if (insn & (1 << 6)) {
-        offset = (offset << 16) | read_im16(env, s);
-    }
+    TCGv fpsr;
 
+    c->g1 = 1;
+    c->v2 = tcg_const_i32(0);
+    c->g2 = 0;
+    /* TODO: Raise BSUN exception.  */
     fpsr = tcg_temp_new();
     gen_load_fcr(s, fpsr, M68K_FPSR);
-    l1 = gen_new_label();
-    /* TODO: Raise BSUN exception.  */
-    /* Jump to l1 if condition is true.  */
-    switch (insn & 0x3f)  {
+    switch (cond) {
     case 0:  /* False */
     case 16: /* Signaling False */
+        c->v1 = c->v2;
+        c->tcond = TCG_COND_NEVER;
         break;
     case 1:  /* EQual Z */
     case 17: /* Signaling EQual Z */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
+        c->tcond = TCG_COND_NE;
         break;
     case 2:  /* Ordered Greater Than !(A || Z || N) */
     case 18: /* Greater Than !(A || Z || N) */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr,
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr,
                          FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
+        c->tcond = TCG_COND_EQ;
         break;
     case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
     case 19: /* Greater than or Equal Z || !(A || N) */
-        assert(FPSR_CC_A == (FPSR_CC_N >> 3));
-        tmp = tcg_temp_new();
-        tcg_gen_shli_i32(tmp, fpsr, 3);
-        tcg_gen_or_i32(tmp, tmp, fpsr);
-        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
-        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
+        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
+        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z | FPSR_CC_N);
+        tcg_gen_or_i32(c->v1, c->v1, fpsr);
+        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 4:  /* Ordered Less Than !(!N || A || Z); */
     case 20: /* Less Than !(!N || A || Z); */
-        tmp = tcg_temp_new();
-        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_N);
-        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_N);
+        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z);
+        c->tcond = TCG_COND_EQ;
         break;
     case 5:  /* Ordered Less than or Equal Z || (N && !A) */
     case 21: /* Less than or Equal Z || (N && !A) */
-        assert(FPSR_CC_A == (FPSR_CC_N >> 3));
-        tmp = tcg_temp_new();
-        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_A);
-        tcg_gen_shli_i32(tmp, tmp, 3);
-        tcg_gen_ori_i32(tmp, tmp, FPSR_CC_Z);
-        tcg_gen_and_i32(tmp, tmp, fpsr);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
+        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
+        tcg_gen_andc_i32(c->v1, fpsr, c->v1);
+        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 6:  /* Ordered Greater or Less than !(A || Z) */
     case 22: /* Greater or Less than !(A || Z) */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
+        c->tcond = TCG_COND_EQ;
         break;
     case 7:  /* Ordered !A */
     case 23: /* Greater, Less or Equal !A */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
+        c->tcond = TCG_COND_EQ;
         break;
     case 8:  /* Unordered A */
     case 24: /* Not Greater, Less or Equal A */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
+        c->tcond = TCG_COND_NE;
         break;
     case 9:  /* Unordered or Equal A || Z */
     case 25: /* Not Greater or Less then A || Z */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
+        c->tcond = TCG_COND_NE;
         break;
     case 10: /* Unordered or Greater Than A || !(N || Z)) */
     case 26: /* Not Less or Equal A || !(N || Z)) */
-        assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
-        tmp = tcg_temp_new();
-        tcg_gen_shli_i32(tmp, fpsr, 1);
-        tcg_gen_or_i32(tmp, tmp, fpsr);
-        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
-        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_A);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
+        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
+        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_A | FPSR_CC_N);
+        tcg_gen_or_i32(c->v1, c->v1, fpsr);
+        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 11: /* Unordered or Greater or Equal A || Z || !N */
     case 27: /* Not Less Than A || Z || !N */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
+        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 12: /* Unordered or Less Than A || (N && !Z) */
     case 28: /* Not Greater than or Equal A || (N && !Z) */
-        assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
-        tmp = tcg_temp_new();
-        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_Z);
-        tcg_gen_shli_i32(tmp, tmp, 1);
-        tcg_gen_ori_i32(tmp, tmp, FPSR_CC_A);
-        tcg_gen_and_i32(tmp, tmp, fpsr);
-        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_A | FPSR_CC_N);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
+        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
+        tcg_gen_andc_i32(c->v1, fpsr, c->v1);
+        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 13: /* Unordered or Less or Equal A || Z || N */
     case 29: /* Not Greater Than A || Z || N */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
+        c->tcond = TCG_COND_NE;
         break;
     case 14: /* Not Equal !Z */
     case 30: /* Signaling Not Equal !Z */
-        tmp = tcg_temp_new();
-        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
+        c->v1 = tcg_temp_new();
+        c->g1 = 0;
+        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
+        c->tcond = TCG_COND_EQ;
         break;
     case 15: /* True */
     case 31: /* Signaling True */
-        tcg_gen_br(l1);
+        c->v1 = c->v2;
+        c->tcond = TCG_COND_ALWAYS;
         break;
     }
     tcg_temp_free(fpsr);
+}
+
+static void gen_fjmpcc(DisasContext *s, int cond, TCGLabel *l1)
+{
+    DisasCompare c;
+
+    gen_fcc_cond(&c, s, cond);
+    tcg_gen_brcond_i32(c.tcond, c.v1, c.v2, l1);
+    free_cond(&c);
+}
+
+DISAS_INSN(fbcc)
+{
+    uint32_t offset;
+    uint32_t base;
+    TCGLabel *l1;
+
+    base = s->pc;
+    offset = (int16_t)read_im16(env, s);
+    if (insn & (1 << 6)) {
+        offset = (offset << 16) | read_im16(env, s);
+    }
+
+    l1 = gen_new_label();
+    update_cc_op(s);
+    gen_fjmpcc(s, insn & 0x3f, l1);
     gen_jmp_tb(s, 0, s->pc);
     gen_set_label(l1);
-    gen_jmp_tb(s, 1, addr + offset);
+    gen_jmp_tb(s, 1, base + offset);
+}
+
+DISAS_INSN(fscc)
+{
+    DisasCompare c;
+    int cond;
+    TCGv tmp;
+    uint16_t ext;
+
+    ext = read_im16(env, s);
+    cond = ext & 0x3f;
+    gen_fcc_cond(&c, s, cond);
+
+    tmp = tcg_temp_new();
+    tcg_gen_setcond_i32(c.tcond, tmp, c.v1, c.v2);
+    free_cond(&c);
+
+    tcg_gen_neg_i32(tmp, tmp);
+    DEST_EA(env, insn, OS_BYTE, tmp, NULL);
+    tcg_temp_free(tmp);
 }
 
 DISAS_INSN(frestore)
@@ -5349,6 +5400,7 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(frestore,  f340, ffc0, CF_FPU);
     INSN(fsave,     f300, ffc0, CF_FPU);
     INSN(fpu,       f200, ffc0, FPU);
+    INSN(fscc,      f240, ffc0, FPU);
     INSN(fbcc,      f280, ff80, FPU);
     INSN(frestore,  f340, ffc0, FPU);
     INSN(fsave,     f300, ffc0, FPU);
-- 
2.9.4
