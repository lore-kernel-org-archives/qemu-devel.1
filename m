Received: from eggs.gnu.org ([2001:4830:134:3::10]:46722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDA-0007ui-Iy
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD8-0004wx-DM
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:24 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD8-0004wo-8Y
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:22 -0500
Received: by mail-qt0-x243.google.com with SMTP id l7so14117077qtd.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:43 -0800
Message-Id: <20170123021748.13170-22-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 21/26] target-hppa: Implement branches
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
 target/hppa/translate.c | 477 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 477 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2ad651c..1d0976f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -455,6 +455,14 @@ static target_long low_sextract(uint32_t val, int pos, int len)
     return x;
 }
 
+static target_long assemble_12(uint32_t insn)
+{
+    target_ulong x = -(target_ulong)(insn & 1);
+    x = (x <<  1) | extract32(insn, 2, 1);
+    x = (x << 10) | extract32(insn, 3, 10);
+    return x;
+}
+
 static target_long assemble_16(uint32_t insn)
 {
     /* Take the name from PA2.0, which produces a 16-bit number
@@ -463,6 +471,15 @@ static target_long assemble_16(uint32_t insn)
     return low_sextract(insn, 0, 14);
 }
 
+static target_long assemble_17(uint32_t insn)
+{
+    target_ulong x = -(target_ulong)(insn & 1);
+    x = (x <<  5) | extract32(insn, 16, 5);
+    x = (x <<  1) | extract32(insn, 2, 1);
+    x = (x << 10) | extract32(insn, 3, 10);
+    return x << 2;
+}
+
 static target_long assemble_21(uint32_t insn)
 {
     target_ulong x = -(target_ulong)(insn & 1);
@@ -473,6 +490,15 @@ static target_long assemble_21(uint32_t insn)
     return x << 11;
 }
 
+static target_long assemble_22(uint32_t insn)
+{
+    target_ulong x = -(target_ulong)(insn & 1);
+    x = (x << 10) | extract32(insn, 16, 10);
+    x = (x <<  1) | extract32(insn, 2, 1);
+    x = (x << 10) | extract32(insn, 3, 10);
+    return x << 2;
+}
+
 /* The parisc documentation describes only the general interpretation of
    the conditions, without describing their exact implementation.  The
    interpretations do not stand up well when considering ADD,C and SUB,B.
@@ -574,6 +600,24 @@ static DisasCond do_log_cond(unsigned cf, TCGv res)
     return do_cond(cf, res, res, res);
 }
 
+/* Similar, but for shift/extract/deposit conditions.  */
+
+static DisasCond do_sed_cond(unsigned orig, TCGv res)
+{
+    unsigned c, f;
+
+    /* Convert the compressed condition codes to standard.
+       0-2 are the same as logicals (nv,<,<=), while 3 is OD.
+       4-7 are the reverse of 0-3.  */
+    c = orig & 3;
+    if (c == 3) {
+        c = 7;
+    }
+    f = (orig & 4) / 4;
+
+    return do_log_cond(c * 2 + f, res);
+}
+
 /* Similar, but for unit conditions.  */
 
 static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
@@ -897,6 +941,188 @@ static ExitStatus do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
     return NO_EXIT;
 }
 
+/* Emit an unconditional branch to a direct target, which may or may not
+   have already had nullification handled.  */
+static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
+                             unsigned link, bool is_n)
+{
+    if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
+        if (link != 0) {
+            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+        }
+        ctx->iaoq_n = dest;
+        if (is_n) {
+            ctx->null_cond.c = TCG_COND_ALWAYS;
+        }
+        return NO_EXIT;
+    } else {
+        nullify_over(ctx);
+
+        if (link != 0) {
+            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+        }
+
+        if (is_n && use_nullify_skip(ctx)) {
+            nullify_set(ctx, 0);
+            gen_goto_tb(ctx, 0, dest, dest + 4);
+        } else {
+            nullify_set(ctx, is_n);
+            gen_goto_tb(ctx, 0, ctx->iaoq_b, dest);
+        }
+
+        nullify_end(ctx, NO_EXIT);
+
+        nullify_set(ctx, 0);
+        gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
+        return EXIT_GOTO_TB;
+    }
+}
+
+/* Emit a conditional branch to a direct target.  If the branch itself
+   is nullified, we should have already used nullify_over.  */
+static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
+                             DisasCond *cond)
+{
+    target_ulong dest = iaoq_dest(ctx, disp);
+    TCGLabel *taken = NULL;
+    TCGCond c = cond->c;
+    int which = 0;
+    bool n;
+
+    assert(ctx->null_cond.c == TCG_COND_NEVER);
+
+    /* Handle TRUE and NEVER as direct branches.  */
+    if (c == TCG_COND_ALWAYS) {
+        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
+    }
+    if (c == TCG_COND_NEVER) {
+        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+    }
+
+    taken = gen_new_label();
+    cond_prep(cond);
+    tcg_gen_brcond_tl(c, cond->a0, cond->a1, taken);
+    cond_free(cond);
+
+    /* Not taken: Condition not satisfied; nullify on backward branches. */
+    n = is_n && disp < 0;
+    if (n && use_nullify_skip(ctx)) {
+        nullify_set(ctx, 0);
+        gen_goto_tb(ctx, which++, ctx->iaoq_n, ctx->iaoq_n + 4);
+    } else {
+        if (!n && ctx->null_lab) {
+            gen_set_label(ctx->null_lab);
+            ctx->null_lab = NULL;
+        }
+        nullify_set(ctx, n);
+        gen_goto_tb(ctx, which++, ctx->iaoq_b, ctx->iaoq_n);
+    }
+
+    gen_set_label(taken);
+
+    /* Taken: Condition satisfied; nullify on forward branches.  */
+    n = is_n && disp >= 0;
+    if (n && use_nullify_skip(ctx)) {
+        nullify_set(ctx, 0);
+        gen_goto_tb(ctx, which++, dest, dest + 4);
+    } else {
+        nullify_set(ctx, n);
+        gen_goto_tb(ctx, which++, ctx->iaoq_b, dest);
+    }
+
+    /* Not taken: the branch itself was nullified.  */
+    if (ctx->null_lab) {
+        gen_set_label(ctx->null_lab);
+        ctx->null_lab = NULL;
+        if (which < 2) {
+            nullify_set(ctx, 0);
+            gen_goto_tb(ctx, which, ctx->iaoq_b, ctx->iaoq_n);
+            return EXIT_GOTO_TB;
+        } else {
+            return EXIT_IAQ_N_STALE;
+        }
+    } else {
+        return EXIT_GOTO_TB;
+    }
+}
+
+/* Emit an unconditional branch to an indirect target.  This handles
+   nullification of the branch itself.  */
+static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
+                             unsigned link, bool is_n)
+{
+    TCGv a0, a1, next, tmp;
+    TCGCond c;
+
+    assert(ctx->null_lab == NULL);
+
+    if (ctx->null_cond.c == TCG_COND_NEVER) {
+        if (link != 0) {
+            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+        }
+        next = get_temp(ctx);
+        tcg_gen_mov_tl(next, dest);
+        ctx->iaoq_n = -1;
+        ctx->iaoq_n_var = next;
+        if (is_n) {
+            ctx->null_cond.c = TCG_COND_ALWAYS;
+        }
+    } else if (is_n && use_nullify_skip(ctx)) {
+        /* The (conditional) branch, B, nullifies the next insn, N,
+           and we're allowed to skip execution N (no single-step or
+           tracepoint in effect).  Since the exit_tb that we must use
+           for the indirect branch consumes no special resources, we
+           can (conditionally) skip B and continue execution.  */
+        /* The use_nullify_skip test implies we have a known control path.  */
+        tcg_debug_assert(ctx->iaoq_b != -1);
+        tcg_debug_assert(ctx->iaoq_n != -1);
+
+        /* We do have to handle the non-local temporary, DEST, before
+           branching.  Since IOAQ_F is not really live at this point, we
+           can simply store DEST optimistically.  Similarly with IAOQ_B.  */
+        tcg_gen_mov_tl(cpu_iaoq_f, dest);
+        tcg_gen_addi_tl(cpu_iaoq_b, dest, 4);
+
+        nullify_over(ctx);
+        if (link != 0) {
+            tcg_gen_movi_tl(cpu_gr[link], ctx->iaoq_n);
+        }
+        tcg_gen_exit_tb(0);
+        return nullify_end(ctx, NO_EXIT);
+    } else {
+        cond_prep(&ctx->null_cond);
+        c = ctx->null_cond.c;
+        a0 = ctx->null_cond.a0;
+        a1 = ctx->null_cond.a1;
+
+        tmp = tcg_temp_new();
+        next = get_temp(ctx);
+
+        copy_iaoq_entry(tmp, ctx->iaoq_n, ctx->iaoq_n_var);
+        tcg_gen_movcond_tl(c, next, a0, a1, tmp, dest);
+        ctx->iaoq_n = -1;
+        ctx->iaoq_n_var = next;
+
+        if (link != 0) {
+            tcg_gen_movcond_tl(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
+        }
+
+        if (is_n) {
+            /* The branch nullifies the next insn, which means the state of N
+               after the branch is the inverse of the state of N that applied
+               to the branch.  */
+            tcg_gen_setcond_tl(tcg_invert_cond(c), cpu_psw_n, a0, a1);
+            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_n();
+            ctx->psw_n_nonzero = true;
+        } else {
+            cond_free(&ctx->null_cond);
+        }
+    }
+
+    return NO_EXIT;
+}
+
 static ExitStatus trans_nop(DisasContext *ctx, uint32_t insn,
                             const DisasInsn *di)
 {
@@ -1310,6 +1536,224 @@ static ExitStatus trans_ldo(DisasContext *ctx, uint32_t insn)
     return NO_EXIT;
 }
 
+static ExitStatus trans_cmpb(DisasContext *ctx, uint32_t insn,
+                             bool is_true, bool is_imm, bool is_dw)
+{
+    target_long disp = assemble_12(insn) * 4;
+    unsigned n = extract32(insn, 1, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned r = extract32(insn, 21, 5);
+    unsigned cf = c * 2 + !is_true;
+    TCGv dest, in1, in2, sv;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    if (is_imm) {
+        in1 = load_const(ctx, low_sextract(insn, 16, 5));
+    } else {
+        in1 = load_gpr(ctx, extract32(insn, 16, 5));
+    }
+    in2 = load_gpr(ctx, r);
+    dest = get_temp(ctx);
+
+    tcg_gen_sub_tl(dest, in1, in2);
+
+    TCGV_UNUSED(sv);
+    if (c == 6) {
+        sv = do_sub_sv(ctx, dest, in1, in2);
+    }
+
+    cond = do_sub_cond(cf, dest, in1, in2, sv);
+    return do_cbranch(ctx, disp, n, &cond);
+}
+
+static ExitStatus trans_addb(DisasContext *ctx, uint32_t insn,
+                             bool is_true, bool is_imm)
+{
+    target_long disp = assemble_12(insn) * 4;
+    unsigned n = extract32(insn, 1, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned r = extract32(insn, 21, 5);
+    unsigned cf = c * 2 + !is_true;
+    TCGv dest, in1, in2, sv, cb_msb;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    if (is_imm) {
+        in1 = load_const(ctx, low_sextract(insn, 16, 5));
+    } else {
+        in1 = load_gpr(ctx, extract32(insn, 16, 5));
+    }
+    in2 = load_gpr(ctx, r);
+    dest = dest_gpr(ctx, r);
+    TCGV_UNUSED(sv);
+    TCGV_UNUSED(cb_msb);
+
+    switch (c) {
+    default:
+        tcg_gen_add_tl(dest, in1, in2);
+        break;
+    case 4: case 5:
+        cb_msb = get_temp(ctx);
+        tcg_gen_movi_tl(cb_msb, 0);
+        tcg_gen_add2_tl(dest, cb_msb, in1, cb_msb, in2, cb_msb);
+        break;
+    case 6:
+        tcg_gen_add_tl(dest, in1, in2);
+        sv = do_add_sv(ctx, dest, in1, in2);
+        break;
+    }
+
+    cond = do_cond(cf, dest, cb_msb, sv);
+    return do_cbranch(ctx, disp, n, &cond);
+}
+
+static ExitStatus trans_bb(DisasContext *ctx, uint32_t insn)
+{
+    target_long disp = assemble_12(insn) * 4;
+    unsigned n = extract32(insn, 1, 1);
+    unsigned c = extract32(insn, 15, 1);
+    unsigned r = extract32(insn, 16, 5);
+    unsigned p = extract32(insn, 21, 5);
+    unsigned i = extract32(insn, 26, 1);
+    TCGv tmp, tcg_r;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    tmp = tcg_temp_new();
+    tcg_r = load_gpr(ctx, r);
+    if (i) {
+        tcg_gen_shli_tl(tmp, tcg_r, p);
+    } else {
+        tcg_gen_shl_tl(tmp, tcg_r, cpu_sar);
+    }
+
+    cond = cond_make_0(c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    tcg_temp_free(tmp);
+    return do_cbranch(ctx, disp, n, &cond);
+}
+
+static ExitStatus trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
+{
+    target_long disp = assemble_12(insn) * 4;
+    unsigned n = extract32(insn, 1, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned t = extract32(insn, 16, 5);
+    unsigned r = extract32(insn, 21, 5);
+    TCGv dest;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    dest = dest_gpr(ctx, r);
+    if (is_imm) {
+        tcg_gen_movi_tl(dest, low_sextract(t, 0, 5));
+    } else if (t == 0) {
+        tcg_gen_movi_tl(dest, 0);
+    } else {
+        tcg_gen_mov_tl(dest, cpu_gr[t]);
+    }
+
+    cond = do_sed_cond(c, dest);
+    return do_cbranch(ctx, disp, n, &cond);
+}
+
+static ExitStatus trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned b = extract32(insn, 21, 5);
+    target_long disp = assemble_17(insn);
+
+    /* unsigned s = low_uextract(insn, 13, 3); */
+    /* ??? It seems like there should be a good way of using
+       "be disp(sr2, r0)", the canonical gateway entry mechanism
+       to our advantage.  But that appears to be inconvenient to
+       manage along side branch delay slots.  Therefore we handle
+       entry into the gateway page via absolute address.  */
+
+    /* Since we don't implement spaces, just branch.  Do notice the special
+       case of "be disp(*,r0)" using a direct branch to disp, so that we can
+       goto_tb to the TB containing the syscall.  */
+    if (b == 0) {
+        return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
+    } else {
+        TCGv tmp = get_temp(ctx);
+        tcg_gen_addi_tl(tmp, load_gpr(ctx, b), disp);
+        return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+    }
+}
+
+static ExitStatus trans_bl(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned link = extract32(insn, 21, 5);
+    target_long disp = assemble_17(insn);
+
+    return do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
+}
+
+static ExitStatus trans_bl_long(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    target_long disp = assemble_22(insn);
+
+    return do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
+}
+
+static ExitStatus trans_blr(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned link = extract32(insn, 21, 5);
+    TCGv tmp = get_temp(ctx);
+
+    tcg_gen_shli_tl(tmp, load_gpr(ctx, rx), 3);
+    tcg_gen_addi_tl(tmp, tmp, ctx->iaoq_f + 8);
+    return do_ibranch(ctx, tmp, link, n);
+}
+
+static ExitStatus trans_bv(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    TCGv dest;
+
+    if (rx == 0) {
+        dest = load_gpr(ctx, rb);
+    } else {
+        dest = get_temp(ctx);
+        tcg_gen_shli_tl(dest, load_gpr(ctx, rx), 3);
+        tcg_gen_add_tl(dest, dest, load_gpr(ctx, rb));
+    }
+    return do_ibranch(ctx, dest, 0, n);
+}
+
+static ExitStatus trans_bve(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned link = extract32(insn, 13, 1) ? 2 : 0;
+
+    return do_ibranch(ctx, load_gpr(ctx, rb), link, n);
+}
+
+static const DisasInsn table_branch[] = {
+    { 0xe8000000u, 0xfc006000u, trans_bl }, /* B,L and B,L,PUSH */
+    { 0xe800a000u, 0xfc00e000u, trans_bl_long },
+    { 0xe8004000u, 0xfc00fffdu, trans_blr },
+    { 0xe800c000u, 0xfc00fffdu, trans_bv },
+    { 0xe800d000u, 0xfc00dffcu, trans_bve },
+};
+
 static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
                                       const DisasInsn table[], size_t n)
 {
@@ -1338,13 +1782,46 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_addil(ctx, insn);
     case 0x0D:
         return trans_ldo(ctx, insn);
+    case 0x20:
+        return trans_cmpb(ctx, insn, true, false, false);
+    case 0x21:
+        return trans_cmpb(ctx, insn, true, true, false);
+    case 0x22:
+        return trans_cmpb(ctx, insn, false, false, false);
+    case 0x23:
+        return trans_cmpb(ctx, insn, false, true, false);
     case 0x24:
         return trans_cmpiclr(ctx, insn);
     case 0x25:
         return trans_subi(ctx, insn);
+    case 0x27:
+        return trans_cmpb(ctx, insn, true, false, true);
+    case 0x28:
+        return trans_addb(ctx, insn, true, false);
+    case 0x29:
+        return trans_addb(ctx, insn, true, true);
+    case 0x2A:
+        return trans_addb(ctx, insn, false, false);
+    case 0x2B:
+        return trans_addb(ctx, insn, false, true);
     case 0x2C:
     case 0x2D:
         return trans_addi(ctx, insn);
+    case 0x2F:
+        return trans_cmpb(ctx, insn, false, false, true);
+    case 0x30:
+    case 0x31:
+        return trans_bb(ctx, insn);
+    case 0x32:
+        return trans_movb(ctx, insn, false);
+    case 0x33:
+        return trans_movb(ctx, insn, true);
+    case 0x38:
+        return trans_be(ctx, insn, false);
+    case 0x39:
+        return trans_be(ctx, insn, true);
+    case 0x3A:
+        return translate_table(ctx, insn, table_branch);
     default:
         break;
     }
-- 
2.9.3
