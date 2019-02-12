Received: from eggs.gnu.org ([209.51.188.92]:49497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8q-0002a2-Ep
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8m-0001pV-7Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:35487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001UO-Hf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pl1-x633.google.com with SMTP id p8so699473plo.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:01 -0800
Message-Id: <20190212045721.28041-5-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/24] target/hppa: Convert remainder of system
 insns
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

Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 99 ++++++++++++++++++----------------------
 target/hppa/insns.decode | 12 +++++
 2 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 72cb7b477e..2ca0f5da10 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,6 +278,18 @@ typedef struct DisasContext {
     bool psw_n_nonzero;
 } DisasContext;
 
+/* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
+static int expand_sm_imm(int val)
+{
+    if (val & PSW_SM_E) {
+        val = (val & ~PSW_SM_E) | PSW_E;
+    }
+    if (val & PSW_SM_W) {
+        val = (val & ~PSW_SM_W) | PSW_W;
+    }
+    return val;
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
@@ -1996,7 +2008,7 @@ static bool trans_break(DisasContext *ctx, arg_break *a)
     return gen_excp_iir(ctx, EXCP_BREAK);
 }
 
-static bool trans_sync(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_sync(DisasContext *ctx, arg_sync *a)
 {
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
@@ -2178,86 +2190,67 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     return true;
 }
 
-static bool trans_ldsid(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    TCGv_reg dest = dest_gpr(ctx, rt);
+    TCGv_reg dest = dest_gpr(ctx, a->t);
 
 #ifdef CONFIG_USER_ONLY
     /* We don't implement space registers in user mode. */
     tcg_gen_movi_reg(dest, 0);
 #else
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned sp = extract32(insn, 14, 2);
     TCGv_i64 t0 = tcg_temp_new_i64();
 
-    tcg_gen_mov_i64(t0, space_select(ctx, sp, load_gpr(ctx, rb)));
+    tcg_gen_mov_i64(t0, space_select(ctx, a->sp, load_gpr(ctx, a->b)));
     tcg_gen_shri_i64(t0, t0, 32);
     tcg_gen_trunc_i64_reg(dest, t0);
 
     tcg_temp_free_i64(t0);
 #endif
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     cond_free(&ctx->null_cond);
     return true;
 }
 
+static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-/* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
-static target_ureg extract_sm_imm(uint32_t insn)
-{
-    target_ureg val = extract32(insn, 16, 10);
-
-    if (val & PSW_SM_E) {
-        val = (val & ~PSW_SM_E) | PSW_E;
-    }
-    if (val & PSW_SM_W) {
-        val = (val & ~PSW_SM_W) | PSW_W;
-    }
-    return val;
-}
-
-static bool trans_rsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    target_ureg sm = extract_sm_imm(insn);
     TCGv_reg tmp;
 
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
     tmp = get_temp(ctx);
     tcg_gen_ld_reg(tmp, cpu_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_andi_reg(tmp, tmp, ~sm);
+    tcg_gen_andi_reg(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, cpu_env, tmp);
-    save_gpr(ctx, rt, tmp);
+    save_gpr(ctx, a->t, tmp);
 
     /* Exit the TB to recognize new interrupts, e.g. PSW_M.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
+#endif
 }
 
-static bool trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    target_ureg sm = extract_sm_imm(insn);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     TCGv_reg tmp;
 
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
     tmp = get_temp(ctx);
     tcg_gen_ld_reg(tmp, cpu_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_ori_reg(tmp, tmp, sm);
+    tcg_gen_ori_reg(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, cpu_env, tmp);
-    save_gpr(ctx, rt, tmp);
+    save_gpr(ctx, a->t, tmp);
 
     /* Exit the TB to recognize new interrupts, e.g. PSW_I.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
+#endif
 }
-#endif /* !CONFIG_USER_ONLY */
 
 static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 {
@@ -2276,15 +2269,13 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-static bool trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool do_rfi(DisasContext *ctx, bool rfi_r)
 {
-    unsigned comp = extract32(insn, 5, 4);
-
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
 
-    if (comp == 5) {
+    if (rfi_r) {
         gen_helper_rfi_r(cpu_env);
     } else {
         gen_helper_rfi(cpu_env);
@@ -2298,8 +2289,20 @@ static bool trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     ctx->base.is_jmp = DISAS_NORETURN;
 
     return nullify_end(ctx);
+#endif
 }
 
+static bool trans_rfi(DisasContext *ctx, arg_rfi *a)
+{
+    return do_rfi(ctx, false);
+}
+
+static bool trans_rfi_r(DisasContext *ctx, arg_rfi_r *a)
+{
+    return do_rfi(ctx, true);
+}
+
+#ifndef CONFIG_USER_ONLY
 static bool gen_hlt(DisasContext *ctx, int reset)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
@@ -2314,17 +2317,6 @@ static bool gen_hlt(DisasContext *ctx, int reset)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static const DisasInsn table_system[] = {
-    { 0x00000400u, 0xffffffffu, trans_sync },  /* sync */
-    { 0x00100400u, 0xffffffffu, trans_sync },  /* syncdma */
-    { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
-#ifndef CONFIG_USER_ONLY
-    { 0x00000e60u, 0xfc00ffe0u, trans_rsm },
-    { 0x00000d60u, 0xfc00ffe0u, trans_ssm },
-    { 0x00000c00u, 0xfffffe1fu, trans_rfi },
-#endif
-};
-
 static bool trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
                                const DisasInsn *di)
 {
@@ -4542,9 +4534,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x00: /* system op */
-        translate_table(ctx, insn, table_system);
-        return;
     case 0x01:
         translate_table(ctx, insn, table_mem_mgmt);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 047a9d01ec..16ea5e1b46 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -23,6 +23,8 @@
 
 %assemble_sr3   13:1 14:2
 
+%sm_imm         16:10 !function=expand_sm_imm
+
 ####
 # System
 ####
@@ -37,3 +39,13 @@ mtsm            000000 00000 r:5   000 11000011 00000
 mfia            000000 ----- 00000 ---   10100101 t:5
 mfsp            000000 ----- 00000 ...   00100101 t:5   sp=%assemble_sr3
 mfctl           000000 r:5   00000- e:1 -01000101 t:5
+
+sync            000000 ----- ----- 000 00100000 00000   # sync, syncdma
+
+ldsid           000000 b:5   ----- sp:2 0 10000101 t:5
+
+rsm             000000 ..........  000 01110011 t:5     i=%sm_imm
+ssm             000000 ..........  000 01101011 t:5     i=%sm_imm
+
+rfi             000000 ----- ----- --- 01100000 00000
+rfi_r           000000 ----- ----- --- 01100101 00000
-- 
2.17.2
