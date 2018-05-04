Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSd-00006G-Vx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSc-0004uK-3W
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:52 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSb-0004ta-Ra
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:50 -0400
Received: by mail-pf0-x244.google.com with SMTP id v63so16566361pfk.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:29 -0700
Message-Id: <20180504054030.24527-13-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/13] target/openrisc: Convert dec_float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 359 +++++++++++++++----------------------------
 target/openrisc/insns.decode |  21 +++
 2 files changed, 149 insertions(+), 231 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index f02d04cbce..66e493220e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1241,246 +1241,143 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
     return true;
 }
 
-static void dec_float(DisasContext *dc, uint32_t insn)
+static void do_fp2(DisasContext *dc, arg_da *a,
+                   void (*fn)(TCGv, TCGv_env, TCGv))
 {
-    uint32_t op0;
-    uint32_t ra, rb, rd;
-    op0 = extract32(insn, 0, 8);
-    ra = extract32(insn, 16, 5);
-    rb = extract32(insn, 11, 5);
-    rd = extract32(insn, 21, 5);
+    check_r0_write(a->d);
+    fn(cpu_R[a->d], cpu_env, cpu_R[a->a]);
+    gen_helper_update_fpcsr(cpu_env);
+}
 
-    switch (op0) {
-    case 0x00: /* lf.add.s */
-        LOG_DIS("lf.add.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_add_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
+static void do_fp3(DisasContext *dc, arg_dab *a,
+                   void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
+{
+    check_r0_write(a->d);
+    fn(cpu_R[a->d], cpu_env, cpu_R[a->a], cpu_R[a->b]);
+    gen_helper_update_fpcsr(cpu_env);
+}
 
-    case 0x01: /* lf.sub.s */
-        LOG_DIS("lf.sub.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_sub_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x02:    /* lf.mul.s */
-        LOG_DIS("lf.mul.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_mul_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x03: /* lf.div.s */
-        LOG_DIS("lf.div.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_div_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x04: /* lf.itof.s */
-        LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
-        check_r0_write(rd);
-        gen_helper_itofs(cpu_R[rd], cpu_env, cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x05: /* lf.ftoi.s */
-        LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
-        check_r0_write(rd);
-        gen_helper_ftois(cpu_R[rd], cpu_env, cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x06: /* lf.rem.s */
-        LOG_DIS("lf.rem.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_rem_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x07: /* lf.madd.s */
-        LOG_DIS("lf.madd.s r%d, r%d, r%d\n", rd, ra, rb);
-        check_r0_write(rd);
-        gen_helper_float_madd_s(cpu_R[rd], cpu_env, cpu_R[rd],
-                                cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x08: /* lf.sfeq.s */
-        LOG_DIS("lf.sfeq.s r%d, r%d\n", ra, rb);
-        gen_helper_float_eq_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x09: /* lf.sfne.s */
-        LOG_DIS("lf.sfne.s r%d, r%d\n", ra, rb);
-        gen_helper_float_eq_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x0a: /* lf.sfgt.s */
-        LOG_DIS("lf.sfgt.s r%d, r%d\n", ra, rb);
-        gen_helper_float_lt_s(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x0b: /* lf.sfge.s */
-        LOG_DIS("lf.sfge.s r%d, r%d\n", ra, rb);
-        gen_helper_float_le_s(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x0c: /* lf.sflt.s */
-        LOG_DIS("lf.sflt.s r%d, r%d\n", ra, rb);
-        gen_helper_float_lt_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x0d: /* lf.sfle.s */
-        LOG_DIS("lf.sfle.s r%d, r%d\n", ra, rb);
-        gen_helper_float_le_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-#ifdef TARGET_OPENRISC64
-    case 0x10: /* lf.add.d */
-        LOG_DIS("lf.add.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_add_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x11: /* lf.sub.d */
-        LOG_DIS("lf.sub.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_sub_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x12: /* lf.mul.d */
-        LOG_DIS("lf.mul.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_mul_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x13: /* lf.div.d */
-        LOG_DIS("lf.div.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_div_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x14: /* lf.itof.d */
-        LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_itofd(cpu_R[rd], cpu_env, cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x15: /* lf.ftoi.d */
-        LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_ftoid(cpu_R[rd], cpu_env, cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x16: /* lf.rem.d */
-        LOG_DIS("lf.rem.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_rem_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x17: /* lf.madd.d */
-        LOG_DIS("lf.madd.d r%d, r%d, r%d\n", rd, ra, rb);
-        check_of64s(dc);
-        check_r0_write(rd);
-        gen_helper_float_madd_d(cpu_R[rd], cpu_env, cpu_R[rd],
-                                cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x18: /* lf.sfeq.d */
-        LOG_DIS("lf.sfeq.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_eq_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x1a: /* lf.sfgt.d */
-        LOG_DIS("lf.sfgt.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_lt_d(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x1b: /* lf.sfge.d */
-        LOG_DIS("lf.sfge.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_le_d(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x19: /* lf.sfne.d */
-        LOG_DIS("lf.sfne.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_eq_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x1c: /* lf.sflt.d */
-        LOG_DIS("lf.sflt.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_lt_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-
-    case 0x1d: /* lf.sfle.d */
-        LOG_DIS("lf.sfle.d r%d, r%d\n", ra, rb);
-        check_of64s(dc);
-        gen_helper_float_le_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
-        gen_helper_update_fpcsr(cpu_env);
-        break;
-#endif
-
-    default:
-        gen_illegal_exception(dc);
-        break;
+static void do_fpcmp(DisasContext *dc, arg_ab *a,
+                     void (*fn)(TCGv, TCGv_env, TCGv, TCGv),
+                     bool inv, bool swap)
+{
+    if (swap) {
+        fn(cpu_sr_f, cpu_env, cpu_R[a->b], cpu_R[a->a]);
+    } else {
+        fn(cpu_sr_f, cpu_env, cpu_R[a->a], cpu_R[a->b]);
     }
+    if (inv) {
+        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+    }
+    gen_helper_update_fpcsr(cpu_env);
+}
+
+static bool trans_lf_add_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.add.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    do_fp3(dc, a, gen_helper_float_add_s);
+    return true;
+}
+
+static bool trans_lf_sub_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sub.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    do_fp3(dc, a, gen_helper_float_sub_s);
+    return true;
+}
+
+static bool trans_lf_mul_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.mul.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    do_fp3(dc, a, gen_helper_float_mul_s);
+    return true;
+}
+
+static bool trans_lf_div_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.div.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    do_fp3(dc, a, gen_helper_float_div_s);
+    return true;
+}
+
+static bool trans_lf_rem_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.rem.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    do_fp3(dc, a, gen_helper_float_rem_s);
+    return true;
+}
+
+static bool trans_lf_itof_s(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("lf.itof.s r%d, r%d\n", a->d, a->a);
+    do_fp2(dc, a, gen_helper_itofs);
+    return true;
+}
+
+static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("lf.ftoi.s r%d, r%d\n", a->d, a->a);
+    do_fp2(dc, a, gen_helper_ftois);
+    return true;
+}
+
+static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("lf.madd.s r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    gen_helper_float_madd_s(cpu_R[a->d], cpu_env, cpu_R[a->d],
+                            cpu_R[a->a], cpu_R[a->b]);
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool trans_lf_sfeq_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sfeq.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_eq_s, false, false);
+    return true;
+}
+
+static bool trans_lf_sfne_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sfne.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_eq_s, true, false);
+    return true;
+}
+
+static bool trans_lf_sfgt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sfgt.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_lt_s, false, true);
+    return true;
+}
+
+static bool trans_lf_sfge_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sfge.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_le_s, false, true);
+    return true;
+}
+
+static bool trans_lf_sflt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sflt.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_lt_s, false, false);
+    return true;
+}
+
+static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("lf.sfle.s r%d, r%d\n", a->a, a->b);
+    do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
+    return true;
 }
 
 static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
 {
-    uint32_t op0;
-    uint32_t insn;
-    insn = cpu_ldl_code(&cpu->env, dc->pc);
-
-    /* Transition to the auto-generated decoder.  */
-    if (decode(dc, insn)) {
-        return;
-    }
-
-    op0 = extract32(insn, 26, 6);
-    switch (op0) {
-    case 0x32:
-        dec_float(dc, insn);
-        break;
-
-    default:
+    uint32_t insn = cpu_ldl_code(&cpu->env, dc->pc);
+    if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-        break;
     }
 }
 
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 4ec0e2de3a..dad68c8422 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -166,3 +166,24 @@ l_sfgtsi        101111 01010 a:5 i:s16
 l_sfgesi        101111 01011 a:5 i:s16
 l_sfltsi        101111 01100 a:5 i:s16
 l_sflesi        101111 01101 a:5 i:s16
+
+####
+# FP Instructions
+####
+
+lf_add_s        110010 d:5 a:5 b:5   --- 00000000
+lf_sub_s        110010 d:5 a:5 b:5   --- 00000001
+lf_mul_s        110010 d:5 a:5 b:5   --- 00000010
+lf_div_s        110010 d:5 a:5 b:5   --- 00000011
+lf_rem_s        110010 d:5 a:5 b:5   --- 00000110
+lf_madd_s       110010 d:5 a:5 b:5   --- 00000111
+
+lf_itof_s       110010 d:5 a:5 00000 --- 00000100
+lf_ftoi_s       110010 d:5 a:5 00000 --- 00000101
+
+lf_sfeq_s       110010 ----- a:5 b:5 --- 00001000
+lf_sfne_s       110010 ----- a:5 b:5 --- 00001001
+lf_sfgt_s       110010 ----- a:5 b:5 --- 00001010
+lf_sfge_s       110010 ----- a:5 b:5 --- 00001011
+lf_sflt_s       110010 ----- a:5 b:5 --- 00001100
+lf_sfle_s       110010 ----- a:5 b:5 --- 00001101
-- 
2.14.3
