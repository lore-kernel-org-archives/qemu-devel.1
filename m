Received: from eggs.gnu.org ([2001:4830:134:3::10]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD9-0007ug-T4
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD7-0004wY-0z
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:23 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD6-0004wS-Qm
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:20 -0500
Received: by mail-qt0-x243.google.com with SMTP id f4so14077850qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:42 -0800
Message-Id: <20170123021748.13170-21-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 20/26] target-hppa: Implement basic arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/helper.h    |   2 +
 target/hppa/op_helper.c |  23 ++
 target/hppa/translate.c | 882 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 907 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 9c94dac..ecff17c 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,3 +1,5 @@
 DEF_HELPER_2(excp, noreturn, env, int)
+DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 4dd0119..f36ce74 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -31,6 +31,29 @@ void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
     cpu_loop_exit(cs);
 }
 
+static void QEMU_NORETURN dynexcp(CPUHPPAState *env, int excp, uintptr_t ra)
+{
+    HPPACPU *cpu = hppa_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    cs->exception_index = excp;
+    cpu_loop_exit_restore(cs, ra);
+}
+
+void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
+{
+    if (unlikely((target_long)cond < 0)) {
+        dynexcp(env, EXCP_SIGFPE, GETPC());
+    }
+}
+
+void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
+{
+    if (unlikely(cond)) {
+        dynexcp(env, EXCP_SIGFPE, GETPC());
+    }
+}
+
 void HELPER(loaded_fr0)(CPUHPPAState *env)
 {
     uint32_t shadow = env->fr[0] >> 32;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 22dfb73..2ad651c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -83,6 +83,9 @@ typedef struct DisasInsn {
     uint32_t insn, mask;
     ExitStatus (*trans)(DisasContext *ctx, uint32_t insn,
                         const struct DisasInsn *f);
+    union {
+        void (*f_ttt)(TCGv, TCGv, TCGv);
+    };
 } DisasInsn;
 
 /* global register indexes */
@@ -443,6 +446,870 @@ static void gen_goto_tb(DisasContext *ctx, int which,
     }
 }
 
+/* PA has a habit of taking the LSB of a field and using that as the sign,
+   with the rest of the field becoming the least significant bits.  */
+static target_long low_sextract(uint32_t val, int pos, int len)
+{
+    target_ulong x = -(target_ulong)extract32(val, pos, 1);
+    x = (x << (len - 1)) | extract32(val, pos + 1, len - 1);
+    return x;
+}
+
+static target_long assemble_16(uint32_t insn)
+{
+    /* Take the name from PA2.0, which produces a 16-bit number
+       only with wide mode; otherwise a 14-bit number.  Since we don't
+       implement wide mode, this is always the 14-bit number.  */
+    return low_sextract(insn, 0, 14);
+}
+
+static target_long assemble_21(uint32_t insn)
+{
+    target_ulong x = -(target_ulong)(insn & 1);
+    x = (x << 11) | extract32(insn, 1, 11);
+    x = (x <<  2) | extract32(insn, 14, 2);
+    x = (x <<  5) | extract32(insn, 16, 5);
+    x = (x <<  2) | extract32(insn, 12, 2);
+    return x << 11;
+}
+
+/* The parisc documentation describes only the general interpretation of
+   the conditions, without describing their exact implementation.  The
+   interpretations do not stand up well when considering ADD,C and SUB,B.
+   However, considering the Addition, Subtraction and Logical conditions
+   as a whole it would appear that these relations are similar to what
+   a traditional NZCV set of flags would produce.  */
+
+static DisasCond do_cond(unsigned cf, TCGv res, TCGv cb_msb, TCGv sv)
+{
+    DisasCond cond;
+    TCGv tmp;
+
+    switch (cf >> 1) {
+    case 0: /* Never / TR */
+        cond = cond_make_f();
+        break;
+    case 1: /* = / <>        (Z / !Z) */
+        cond = cond_make_0(TCG_COND_EQ, res);
+        break;
+    case 2: /* < / >=        (N / !N) */
+        cond = cond_make_0(TCG_COND_LT, res);
+        break;
+    case 3: /* <= / >        (N | Z / !N & !Z) */
+        cond = cond_make_0(TCG_COND_LE, res);
+        break;
+    case 4: /* NUV / UV      (!C / C) */
+        cond = cond_make_0(TCG_COND_EQ, cb_msb);
+        break;
+    case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
+        tmp = tcg_temp_new();
+        tcg_gen_neg_tl(tmp, cb_msb);
+        tcg_gen_and_tl(tmp, tmp, res);
+        cond = cond_make_0(TCG_COND_EQ, tmp);
+        tcg_temp_free(tmp);
+        break;
+    case 6: /* SV / NSV      (V / !V) */
+        cond = cond_make_0(TCG_COND_LT, sv);
+        break;
+    case 7: /* OD / EV */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_tl(tmp, res, 1);
+        cond = cond_make_0(TCG_COND_NE, tmp);
+        tcg_temp_free(tmp);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (cf & 1) {
+        cond.c = tcg_invert_cond(cond.c);
+    }
+
+    return cond;
+}
+
+/* Similar, but for the special case of subtraction without borrow, we
+   can use the inputs directly.  This can allow other computation to be
+   deleted as unused.  */
+
+static DisasCond do_sub_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2, TCGv sv)
+{
+    DisasCond cond;
+
+    switch (cf >> 1) {
+    case 1: /* = / <> */
+        cond = cond_make(TCG_COND_EQ, in1, in2);
+        break;
+    case 2: /* < / >= */
+        cond = cond_make(TCG_COND_LT, in1, in2);
+        break;
+    case 3: /* <= / > */
+        cond = cond_make(TCG_COND_LE, in1, in2);
+        break;
+    case 4: /* << / >>= */
+        cond = cond_make(TCG_COND_LTU, in1, in2);
+        break;
+    case 5: /* <<= / >> */
+        cond = cond_make(TCG_COND_LEU, in1, in2);
+        break;
+    default:
+        return do_cond(cf, res, sv, sv);
+    }
+    if (cf & 1) {
+        cond.c = tcg_invert_cond(cond.c);
+    }
+
+    return cond;
+}
+
+/* Similar, but for logicals, where the carry and overflow bits are not
+   computed, and use of them is undefined.  */
+
+static DisasCond do_log_cond(unsigned cf, TCGv res)
+{
+    switch (cf >> 1) {
+    case 4: case 5: case 6:
+        cf &= 1;
+        break;
+    }
+    return do_cond(cf, res, res, res);
+}
+
+/* Similar, but for unit conditions.  */
+
+static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
+{
+    DisasCond cond;
+    TCGv tmp, cb;
+
+    TCGV_UNUSED(cb);
+    if (cf & 8) {
+        /* Since we want to test lots of carry-out bits all at once, do not
+         * do our normal thing and compute carry-in of bit B+1 since that
+         * leaves us with carry bits spread across two words.
+         */
+        cb = tcg_temp_new();
+        tmp = tcg_temp_new();
+        tcg_gen_or_tl(cb, in1, in2);
+        tcg_gen_and_tl(tmp, in1, in2);
+        tcg_gen_andc_tl(cb, cb, res);
+        tcg_gen_or_tl(cb, cb, tmp);
+        tcg_temp_free(tmp);
+    }
+
+    switch (cf >> 1) {
+    case 0: /* never / TR */
+    case 1: /* undefined */
+    case 5: /* undefined */
+        cond = cond_make_f();
+        break;
+
+    case 2: /* SBZ / NBZ */
+        /* See hasless(v,1) from
+         * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
+         */
+        tmp = tcg_temp_new();
+        tcg_gen_subi_tl(tmp, res, 0x01010101u);
+        tcg_gen_andc_tl(tmp, tmp, res);
+        tcg_gen_andi_tl(tmp, tmp, 0x80808080u);
+        cond = cond_make_0(TCG_COND_NE, tmp);
+        tcg_temp_free(tmp);
+        break;
+
+    case 3: /* SHZ / NHZ */
+        tmp = tcg_temp_new();
+        tcg_gen_subi_tl(tmp, res, 0x00010001u);
+        tcg_gen_andc_tl(tmp, tmp, res);
+        tcg_gen_andi_tl(tmp, tmp, 0x80008000u);
+        cond = cond_make_0(TCG_COND_NE, tmp);
+        tcg_temp_free(tmp);
+        break;
+
+    case 4: /* SDC / NDC */
+        tcg_gen_andi_tl(cb, cb, 0x88888888u);
+        cond = cond_make_0(TCG_COND_NE, cb);
+        break;
+
+    case 6: /* SBC / NBC */
+        tcg_gen_andi_tl(cb, cb, 0x80808080u);
+        cond = cond_make_0(TCG_COND_NE, cb);
+        break;
+
+    case 7: /* SHC / NHC */
+        tcg_gen_andi_tl(cb, cb, 0x80008000u);
+        cond = cond_make_0(TCG_COND_NE, cb);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+    if (cf & 8) {
+        tcg_temp_free(cb);
+    }
+    if (cf & 1) {
+        cond.c = tcg_invert_cond(cond.c);
+    }
+
+    return cond;
+}
+
+/* Compute signed overflow for addition.  */
+static TCGv do_add_sv(DisasContext *ctx, TCGv res, TCGv in1, TCGv in2)
+{
+    TCGv sv = get_temp(ctx);
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_xor_tl(sv, res, in1);
+    tcg_gen_xor_tl(tmp, in1, in2);
+    tcg_gen_andc_tl(sv, sv, tmp);
+    tcg_temp_free(tmp);
+
+    return sv;
+}
+
+/* Compute signed overflow for subtraction.  */
+static TCGv do_sub_sv(DisasContext *ctx, TCGv res, TCGv in1, TCGv in2)
+{
+    TCGv sv = get_temp(ctx);
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_xor_tl(sv, res, in1);
+    tcg_gen_xor_tl(tmp, in1, in2);
+    tcg_gen_and_tl(sv, sv, tmp);
+    tcg_temp_free(tmp);
+
+    return sv;
+}
+
+static ExitStatus do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                         unsigned shift, bool is_l, bool is_tsv, bool is_tc,
+                         bool is_c, unsigned cf)
+{
+    TCGv dest, cb, cb_msb, sv, tmp;
+    unsigned c = cf >> 1;
+    DisasCond cond;
+
+    dest = tcg_temp_new();
+    TCGV_UNUSED(cb);
+    TCGV_UNUSED(cb_msb);
+
+    if (shift) {
+        tmp = get_temp(ctx);
+        tcg_gen_shli_tl(tmp, in1, shift);
+        in1 = tmp;
+    }
+
+    if (!is_l || c == 4 || c == 5) {
+        TCGv zero = tcg_const_tl(0);
+        cb_msb = get_temp(ctx);
+        tcg_gen_add2_tl(dest, cb_msb, in1, zero, in2, zero);
+        if (is_c) {
+            tcg_gen_add2_tl(dest, cb_msb, dest, cb_msb, cpu_psw_cb_msb, zero);
+        }
+        tcg_temp_free(zero);
+        if (!is_l) {
+            cb = get_temp(ctx);
+            tcg_gen_xor_tl(cb, in1, in2);
+            tcg_gen_xor_tl(cb, cb, dest);
+        }
+    } else {
+        tcg_gen_add_tl(dest, in1, in2);
+        if (is_c) {
+            tcg_gen_add_tl(dest, dest, cpu_psw_cb_msb);
+        }
+    }
+
+    /* Compute signed overflow if required.  */
+    TCGV_UNUSED(sv);
+    if (is_tsv || c == 6) {
+        sv = do_add_sv(ctx, dest, in1, in2);
+        if (is_tsv) {
+            /* ??? Need to include overflow from shift.  */
+            gen_helper_tsv(cpu_env, sv);
+        }
+    }
+
+    /* Emit any conditional trap before any writeback.  */
+    cond = do_cond(cf, dest, cb_msb, sv);
+    if (is_tc) {
+        cond_prep(&cond);
+        tmp = tcg_temp_new();
+        tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+        gen_helper_tcond(cpu_env, tmp);
+        tcg_temp_free(tmp);
+    }
+
+    /* Write back the result.  */
+    if (!is_l) {
+        save_or_nullify(ctx, cpu_psw_cb, cb);
+        save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
+    }
+    save_gpr(ctx, rt, dest);
+    tcg_temp_free(dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond;
+    return NO_EXIT;
+}
+
+static ExitStatus do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                         bool is_tsv, bool is_b, bool is_tc, unsigned cf)
+{
+    TCGv dest, sv, cb, cb_msb, zero, tmp;
+    unsigned c = cf >> 1;
+    DisasCond cond;
+
+    dest = tcg_temp_new();
+    cb = tcg_temp_new();
+    cb_msb = tcg_temp_new();
+
+    zero = tcg_const_tl(0);
+    if (is_b) {
+        /* DEST,C = IN1 + ~IN2 + C.  */
+        tcg_gen_not_tl(cb, in2);
+        tcg_gen_add2_tl(dest, cb_msb, in1, zero, cpu_psw_cb_msb, zero);
+        tcg_gen_add2_tl(dest, cb_msb, dest, cb_msb, cb, zero);
+        tcg_gen_xor_tl(cb, cb, in1);
+        tcg_gen_xor_tl(cb, cb, dest);
+    } else {
+        /* DEST,C = IN1 + ~IN2 + 1.  We can produce the same result in fewer
+           operations by seeding the high word with 1 and subtracting.  */
+        tcg_gen_movi_tl(cb_msb, 1);
+        tcg_gen_sub2_tl(dest, cb_msb, in1, cb_msb, in2, zero);
+        tcg_gen_eqv_tl(cb, in1, in2);
+        tcg_gen_xor_tl(cb, cb, dest);
+    }
+    tcg_temp_free(zero);
+
+    /* Compute signed overflow if required.  */
+    TCGV_UNUSED(sv);
+    if (is_tsv || c == 6) {
+        sv = do_sub_sv(ctx, dest, in1, in2);
+        if (is_tsv) {
+            gen_helper_tsv(cpu_env, sv);
+        }
+    }
+
+    /* Compute the condition.  We cannot use the special case for borrow.  */
+    if (!is_b) {
+        cond = do_sub_cond(cf, dest, in1, in2, sv);
+    } else {
+        cond = do_cond(cf, dest, cb_msb, sv);
+    }
+
+    /* Emit any conditional trap before any writeback.  */
+    if (is_tc) {
+        cond_prep(&cond);
+        tmp = tcg_temp_new();
+        tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+        gen_helper_tcond(cpu_env, tmp);
+        tcg_temp_free(tmp);
+    }
+
+    /* Write back the result.  */
+    save_or_nullify(ctx, cpu_psw_cb, cb);
+    save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
+    save_gpr(ctx, rt, dest);
+    tcg_temp_free(dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond;
+    return NO_EXIT;
+}
+
+static ExitStatus do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
+                            TCGv in2, unsigned cf)
+{
+    TCGv dest, sv;
+    DisasCond cond;
+
+    dest = tcg_temp_new();
+    tcg_gen_sub_tl(dest, in1, in2);
+
+    /* Compute signed overflow if required.  */
+    TCGV_UNUSED(sv);
+    if ((cf >> 1) == 6) {
+        sv = do_sub_sv(ctx, dest, in1, in2);
+    }
+
+    /* Form the condition for the compare.  */
+    cond = do_sub_cond(cf, dest, in1, in2, sv);
+
+    /* Clear.  */
+    tcg_gen_movi_tl(dest, 0);
+    save_gpr(ctx, rt, dest);
+    tcg_temp_free(dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond;
+    return NO_EXIT;
+}
+
+static ExitStatus do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                         unsigned cf, void (*fn)(TCGv, TCGv, TCGv))
+{
+    TCGv dest = dest_gpr(ctx, rt);
+
+    /* Perform the operation, and writeback.  */
+    fn(dest, in1, in2);
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (cf) {
+        ctx->null_cond = do_log_cond(cf, dest);
+    }
+    return NO_EXIT;
+}
+
+static ExitStatus do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
+                          TCGv in2, unsigned cf, bool is_tc,
+                          void (*fn)(TCGv, TCGv, TCGv))
+{
+    TCGv dest;
+    DisasCond cond;
+
+    if (cf == 0) {
+        dest = dest_gpr(ctx, rt);
+        fn(dest, in1, in2);
+        save_gpr(ctx, rt, dest);
+        cond_free(&ctx->null_cond);
+    } else {
+        dest = tcg_temp_new();
+        fn(dest, in1, in2);
+
+        cond = do_unit_cond(cf, dest, in1, in2);
+
+        if (is_tc) {
+            TCGv tmp = tcg_temp_new();
+            cond_prep(&cond);
+            tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+            gen_helper_tcond(cpu_env, tmp);
+            tcg_temp_free(tmp);
+        }
+        save_gpr(ctx, rt, dest);
+
+        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond;
+    }
+    return NO_EXIT;
+}
+
+static ExitStatus trans_nop(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_add(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned ext = extract32(insn, 8, 4);
+    unsigned shift = extract32(insn, 6, 2);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2;
+    bool is_c = false;
+    bool is_l = false;
+    bool is_tc = false;
+    bool is_tsv = false;
+    ExitStatus ret;
+
+    switch (ext) {
+    case 0x6: /* ADD, SHLADD */
+        break;
+    case 0xa: /* ADD,L, SHLADD,L */
+        is_l = true;
+        break;
+    case 0xe: /* ADD,TSV, SHLADD,TSV (1) */
+        is_tsv = true;
+        break;
+    case 0x7: /* ADD,C */
+        is_c = true;
+        break;
+    case 0xf: /* ADD,C,TSV */
+        is_c = is_tsv = true;
+        break;
+    default:
+        return gen_illegal(ctx);
+    }
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_add(ctx, rt, tcg_r1, tcg_r2, shift, is_l, is_tsv, is_tc, is_c, cf);
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_sub(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned ext = extract32(insn, 6, 6);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2;
+    bool is_b = false;
+    bool is_tc = false;
+    bool is_tsv = false;
+    ExitStatus ret;
+
+    switch (ext) {
+    case 0x10: /* SUB */
+        break;
+    case 0x30: /* SUB,TSV */
+        is_tsv = true;
+        break;
+    case 0x14: /* SUB,B */
+        is_b = true;
+        break;
+    case 0x34: /* SUB,B,TSV */
+        is_b = is_tsv = true;
+        break;
+    case 0x13: /* SUB,TC */
+        is_tc = true;
+        break;
+    case 0x33: /* SUB,TSV,TC */
+        is_tc = is_tsv = true;
+        break;
+    default:
+        return gen_illegal(ctx);
+    }
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_sub(ctx, rt, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, cf);
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_log(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f_ttt);
+    return nullify_end(ctx, ret);
+}
+
+/* OR r,0,t -> COPY (according to gas) */
+static ExitStatus trans_copy(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned rt = extract32(insn,  0, 5);
+
+    if (r1 == 0) {
+        TCGv dest = dest_gpr(ctx, rt);
+        tcg_gen_movi_tl(dest, 0);
+        save_gpr(ctx, rt, dest);
+    } else {
+        save_gpr(ctx, rt, cpu_gr[r1]);
+    }
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_cmpclr(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_cmpclr(ctx, rt, tcg_r1, tcg_r2, cf);
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_uxor(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_tl);
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_uaddcm(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned is_tc = extract32(insn, 6, 1);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tcg_r1, tcg_r2, tmp;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    tmp = get_temp(ctx);
+    tcg_gen_not_tl(tmp, tcg_r2);
+    ret = do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_tl);
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_dcor(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned is_i = extract32(insn, 6, 1);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv tmp;
+    ExitStatus ret;
+
+    nullify_over(ctx);
+
+    tmp = get_temp(ctx);
+    tcg_gen_shri_tl(tmp, cpu_psw_cb, 3);
+    if (!is_i) {
+        tcg_gen_not_tl(tmp, tmp);
+    }
+    tcg_gen_andi_tl(tmp, tmp, 0x11111111);
+    tcg_gen_muli_tl(tmp, tmp, 6);
+    ret = do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
+                  is_i ? tcg_gen_add_tl : tcg_gen_sub_tl);
+
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_ds(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
+{
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn,  0, 5);
+    TCGv dest, add1, add2, addc, zero, in1, in2;
+
+    nullify_over(ctx);
+
+    in1 = load_gpr(ctx, r1);
+    in2 = load_gpr(ctx, r2);
+
+    add1 = tcg_temp_new();
+    add2 = tcg_temp_new();
+    addc = tcg_temp_new();
+    dest = tcg_temp_new();
+    zero = tcg_const_tl(0);
+
+    /* Form R1 << 1 | PSW[CB]{8}.  */
+    tcg_gen_add_tl(add1, in1, in1);
+    tcg_gen_add_tl(add1, add1, cpu_psw_cb_msb);
+
+    /* Add or subtract R2, depending on PSW[V].  Proper computation of
+       carry{8} requires that we subtract via + ~R2 + 1, as described in
+       the manual.  By extracting and masking V, we can produce the
+       proper inputs to the addition without movcond.  */
+    tcg_gen_sari_tl(addc, cpu_psw_v, TARGET_LONG_BITS - 1);
+    tcg_gen_xor_tl(add2, in2, addc);
+    tcg_gen_andi_tl(addc, addc, 1);
+    /* ??? This is only correct for 32-bit.  */
+    tcg_gen_add2_i32(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
+    tcg_gen_add2_i32(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
+
+    tcg_temp_free(addc);
+    tcg_temp_free(zero);
+
+    /* Write back the result register.  */
+    save_gpr(ctx, rt, dest);
+
+    /* Write back PSW[CB].  */
+    tcg_gen_xor_tl(cpu_psw_cb, add1, add2);
+    tcg_gen_xor_tl(cpu_psw_cb, cpu_psw_cb, dest);
+
+    /* Write back PSW[V] for the division step.  */
+    tcg_gen_neg_tl(cpu_psw_v, cpu_psw_cb_msb);
+    tcg_gen_xor_tl(cpu_psw_v, cpu_psw_v, in2);
+
+    /* Install the new nullification.  */
+    if (cf) {
+        TCGv sv;
+        TCGV_UNUSED(sv);
+        if (cf >> 1 == 6) {
+            /* ??? The lshift is supposed to contribute to overflow.  */
+            sv = do_add_sv(ctx, dest, add1, add2);
+        }
+        ctx->null_cond = do_cond(cf, dest, cpu_psw_cb_msb, sv);
+    }
+
+    tcg_temp_free(add1);
+    tcg_temp_free(add2);
+    tcg_temp_free(dest);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_arith_log[] = {
+    { 0x08000240u, 0xfc00ffffu, trans_nop },  /* or x,y,0 */
+    { 0x08000240u, 0xffe0ffe0u, trans_copy }, /* or x,0,t */
+    { 0x08000000u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_andc_tl },
+    { 0x08000200u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_and_tl },
+    { 0x08000240u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_or_tl },
+    { 0x08000280u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_xor_tl },
+    { 0x08000880u, 0xfc000fe0u, trans_cmpclr },
+    { 0x08000380u, 0xfc000fe0u, trans_uxor },
+    { 0x08000980u, 0xfc000fa0u, trans_uaddcm },
+    { 0x08000b80u, 0xfc1f0fa0u, trans_dcor },
+    { 0x08000440u, 0xfc000fe0u, trans_ds },
+    { 0x08000700u, 0xfc0007e0u, trans_add }, /* add */
+    { 0x08000400u, 0xfc0006e0u, trans_sub }, /* sub; sub,b; sub,tsv */
+    { 0x080004c0u, 0xfc0007e0u, trans_sub }, /* sub,tc; sub,tsv,tc */
+    { 0x08000200u, 0xfc000320u, trans_add }, /* shladd */
+};
+
+static ExitStatus trans_addi(DisasContext *ctx, uint32_t insn)
+{
+    target_long im = low_sextract(insn, 0, 11);
+    unsigned e1 = extract32(insn, 11, 1);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned o1 = extract32(insn, 26, 1);
+    TCGv tcg_im, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+
+    tcg_im = load_const(ctx, im);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_add(ctx, rt, tcg_im, tcg_r2, 0, false, e1, !o1, false, cf);
+
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_subi(DisasContext *ctx, uint32_t insn)
+{
+    target_long im = low_sextract(insn, 0, 11);
+    unsigned e1 = extract32(insn, 11, 1);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned r2 = extract32(insn, 21, 5);
+    TCGv tcg_im, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+
+    tcg_im = load_const(ctx, im);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_sub(ctx, rt, tcg_im, tcg_r2, e1, false, false, cf);
+
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_cmpiclr(DisasContext *ctx, uint32_t insn)
+{
+    target_long im = low_sextract(insn, 0, 11);
+    unsigned cf = extract32(insn, 12, 4);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned r2 = extract32(insn, 21, 5);
+    TCGv tcg_im, tcg_r2;
+    ExitStatus ret;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+
+    tcg_im = load_const(ctx, im);
+    tcg_r2 = load_gpr(ctx, r2);
+    ret = do_cmpclr(ctx, rt, tcg_im, tcg_r2, cf);
+
+    return nullify_end(ctx, ret);
+}
+
+static ExitStatus trans_ldil(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rt = extract32(insn, 21, 5);
+    target_long i = assemble_21(insn);
+    TCGv tcg_rt = dest_gpr(ctx, rt);
+
+    tcg_gen_movi_tl(tcg_rt, i);
+    save_gpr(ctx, rt, tcg_rt);
+    cond_free(&ctx->null_cond);
+
+    return NO_EXIT;
+}
+
+static ExitStatus trans_addil(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rt = extract32(insn, 21, 5);
+    target_long i = assemble_21(insn);
+    TCGv tcg_rt = load_gpr(ctx, rt);
+    TCGv tcg_r1 = dest_gpr(ctx, 1);
+
+    tcg_gen_addi_tl(tcg_r1, tcg_rt, i);
+    save_gpr(ctx, 1, tcg_r1);
+    cond_free(&ctx->null_cond);
+
+    return NO_EXIT;
+}
+
+static ExitStatus trans_ldo(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = extract32(insn, 16, 5);
+    target_long i = assemble_16(insn);
+    TCGv tcg_rt = dest_gpr(ctx, rt);
+
+    /* Special case rb == 0, for the LDI pseudo-op.
+       The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
+    if (rb == 0) {
+        tcg_gen_movi_tl(tcg_rt, i);
+    } else {
+        tcg_gen_addi_tl(tcg_rt, cpu_gr[rb], i);
+    }
+    save_gpr(ctx, rt, tcg_rt);
+    cond_free(&ctx->null_cond);
+
+    return NO_EXIT;
+}
+
 static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
                                       const DisasInsn table[], size_t n)
 {
@@ -463,6 +1330,21 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     uint32_t opc = extract32(insn, 26, 6);
 
     switch (opc) {
+    case 0x02:
+        return translate_table(ctx, insn, table_arith_log);
+    case 0x08:
+        return trans_ldil(ctx, insn);
+    case 0x0A:
+        return trans_addil(ctx, insn);
+    case 0x0D:
+        return trans_ldo(ctx, insn);
+    case 0x24:
+        return trans_cmpiclr(ctx, insn);
+    case 0x25:
+        return trans_subi(ctx, insn);
+    case 0x2C:
+    case 0x2D:
+        return trans_addi(ctx, insn);
     default:
         break;
     }
-- 
2.9.3
