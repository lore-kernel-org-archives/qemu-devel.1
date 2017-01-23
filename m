Received: from eggs.gnu.org ([2001:4830:134:3::10]:46774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDE-0007y3-ES
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDD-0004yL-67
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:28 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUDD-0004yE-10
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:27 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so14088128qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:27 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:47 -0800
Message-Id: <20170123021748.13170-26-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 25/26] target-hppa: Implement system and
 memory-management insns
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
 target/hppa/helper.h    |   3 +
 target/hppa/op_helper.c |  10 +++
 target/hppa/translate.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 88db719..d51cf6d 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -5,4 +5,7 @@ DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
 
+DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tl, tl)
+
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 0aa5fb9..670e600 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -132,6 +132,16 @@ void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
     }
 }
 
+target_ulong HELPER(probe_r)(target_ulong addr)
+{
+    return page_check_range(addr, 1, PAGE_READ);
+}
+
+target_ulong HELPER(probe_w)(target_ulong addr)
+{
+    return page_check_range(addr, 1, PAGE_WRITE);
+}
+
 void HELPER(loaded_fr0)(CPUHPPAState *env)
 {
     uint32_t shadow = env->fr[0] >> 32;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1973777..cfdb9ee 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1465,6 +1465,208 @@ static ExitStatus trans_nop(DisasContext *ctx, uint32_t insn,
     return NO_EXIT;
 }
 
+static ExitStatus trans_break(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    nullify_over(ctx);
+    return nullify_end(ctx, gen_excp(ctx, EXCP_DEBUG));
+}
+
+static ExitStatus trans_sync(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    /* No point in nullifying the memory barrier.  */
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_mfia(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    TCGv tmp = dest_gpr(ctx, rt);
+    tcg_gen_movi_tl(tmp, ctx->iaoq_f);
+    save_gpr(ctx, rt, tmp);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_mfsp(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    TCGv tmp = dest_gpr(ctx, rt);
+
+    /* ??? We don't implement space registers.  */
+    tcg_gen_movi_tl(tmp, 0);
+    save_gpr(ctx, rt, tmp);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_mfctl(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ctl = extract32(insn, 21, 5);
+    TCGv tmp;
+
+    switch (ctl) {
+    case 11: /* SAR */
+#ifdef TARGET_HPPA64
+        if (extract32(insn, 14, 1) == 0) {
+            /* MFSAR without ,W masks low 5 bits.  */
+            tmp = dest_gpr(ctx, rt);
+            tcg_gen_andi_tl(tmp, cpu_sar, 31);
+            save_gpr(ctx, rt, tmp);
+            break;
+        }
+#endif
+        save_gpr(ctx, rt, cpu_sar);
+        break;
+    case 16: /* Interval Timer */
+        tmp = dest_gpr(ctx, rt);
+        tcg_gen_movi_tl(tmp, 0); /* FIXME */
+        save_gpr(ctx, rt, tmp);
+        break;
+    case 26:
+        save_gpr(ctx, rt, cpu_cr26);
+        break;
+    case 27:
+        save_gpr(ctx, rt, cpu_cr27);
+        break;
+    default:
+        /* All other control registers are privileged.  */
+        return gen_illegal(ctx);
+    }
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_mtctl(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    unsigned rin = extract32(insn, 16, 5);
+    unsigned ctl = extract32(insn, 21, 5);
+    TCGv tmp;
+
+    if (ctl == 11) { /* SAR */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_tl(tmp, load_gpr(ctx, rin), TARGET_LONG_BITS - 1);
+        save_or_nullify(ctx, cpu_sar, tmp);
+        tcg_temp_free(tmp);
+    } else {
+        /* All other control registers are privileged or read-only.  */
+        return gen_illegal(ctx);
+    }
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_mtsarcm(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned rin = extract32(insn, 16, 5);
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_not_tl(tmp, load_gpr(ctx, rin));
+    tcg_gen_andi_tl(tmp, tmp, TARGET_LONG_BITS - 1);
+    save_or_nullify(ctx, cpu_sar, tmp);
+    tcg_temp_free(tmp);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_ldsid(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    TCGv dest = dest_gpr(ctx, rt);
+
+    /* Since we don't implement space registers, this returns zero.  */
+    tcg_gen_movi_tl(dest, 0);
+    save_gpr(ctx, rt, dest);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static const DisasInsn table_system[] = {
+    { 0x00000000u, 0xfc001fe0u, trans_break },
+    /* We don't implement space register, so MTSP is a nop.  */
+    { 0x00001820u, 0xffe01fffu, trans_nop },
+    { 0x00001840u, 0xfc00ffffu, trans_mtctl },
+    { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
+    { 0x000014a0u, 0xffffffe0u, trans_mfia },
+    { 0x000004a0u, 0xffff1fe0u, trans_mfsp },
+    { 0x000008a0u, 0xfc1fffe0u, trans_mfctl },
+    { 0x00000400u, 0xffffffffu, trans_sync },
+    { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
+};
+
+static ExitStatus trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rx = extract32(insn, 16, 5);
+    TCGv dest = dest_gpr(ctx, rb);
+    TCGv src1 = load_gpr(ctx, rb);
+    TCGv src2 = load_gpr(ctx, rx);
+
+    /* The only thing we need to do is the base register modification.  */
+    tcg_gen_add_tl(dest, src1, src2);
+    save_gpr(ctx, rb, dest);
+
+    cond_free(&ctx->null_cond);
+    return NO_EXIT;
+}
+
+static ExitStatus trans_probe(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned is_write = extract32(insn, 6, 1);
+    TCGv dest;
+
+    nullify_over(ctx);
+
+    /* ??? Do something with priv level operand.  */
+    dest = dest_gpr(ctx, rt);
+    if (is_write) {
+        gen_helper_probe_w(dest, load_gpr(ctx, rb));
+    } else {
+        gen_helper_probe_r(dest, load_gpr(ctx, rb));
+    }
+    save_gpr(ctx, rt, dest);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_mem_mgmt[] = {
+    { 0x04003280u, 0xfc003fffu, trans_nop },          /* fdc, disp */
+    { 0x04001280u, 0xfc003fffu, trans_nop },          /* fdc, index */
+    { 0x040012a0u, 0xfc003fffu, trans_base_idx_mod }, /* fdc, index, base mod */
+    { 0x040012c0u, 0xfc003fffu, trans_nop },          /* fdce */
+    { 0x040012e0u, 0xfc003fffu, trans_base_idx_mod }, /* fdce, base mod */
+    { 0x04000280u, 0xfc001fffu, trans_nop },          /* fic 0a */
+    { 0x040002a0u, 0xfc001fffu, trans_base_idx_mod }, /* fic 0a, base mod */
+    { 0x040013c0u, 0xfc003fffu, trans_nop },          /* fic 4f */
+    { 0x040013e0u, 0xfc003fffu, trans_base_idx_mod }, /* fic 4f, base mod */
+    { 0x040002c0u, 0xfc001fffu, trans_nop },          /* fice */
+    { 0x040002e0u, 0xfc001fffu, trans_base_idx_mod }, /* fice, base mod */
+    { 0x04002700u, 0xfc003fffu, trans_nop },          /* pdc */
+    { 0x04002720u, 0xfc003fffu, trans_base_idx_mod }, /* pdc, base mod */
+    { 0x04001180u, 0xfc003fa0u, trans_probe },        /* probe */
+    { 0x04003180u, 0xfc003fa0u, trans_probe },        /* probei */
+};
+
 static ExitStatus trans_add(DisasContext *ctx, uint32_t insn,
                             const DisasInsn *di)
 {
@@ -2711,6 +2913,10 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     uint32_t opc = extract32(insn, 26, 6);
 
     switch (opc) {
+    case 0x00: /* system op */
+        return translate_table(ctx, insn, table_system);
+    case 0x01:
+        return translate_table(ctx, insn, table_mem_mgmt);
     case 0x02:
         return translate_table(ctx, insn, table_arith_log);
     case 0x03:
-- 
2.9.3
