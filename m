Received: from eggs.gnu.org ([2001:4830:134:3::10]:41893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en998-0008Rr-1A
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en996-0000kj-LP
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:46 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en996-0000kT-CQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:44 -0500
Received: by mail-pf0-x242.google.com with SMTP id c63so659218pfa.10
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:44 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:17 -0800
Message-Id: <20180217203132.31780-5-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/19] target/hppa: Convert remainder of system
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 92 ++++++++++++++++++++++--------------------------
 target/hppa/insns.decode | 12 +++++++
 2 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9b2de2fa2a..ae5969be0b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -290,6 +290,18 @@ typedef struct DisasContext {
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
 
@@ -2007,7 +2019,7 @@ static void trans_break(DisasContext *ctx, arg_break *a, uint32_t insn)
     nullify_end(ctx);
 }
 
-static void trans_sync(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_sync(DisasContext *ctx, arg_sync *a, uint32_t insn)
 {
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
@@ -2187,20 +2199,18 @@ static void trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a, uint32_t insn)
     cond_free(&ctx->null_cond);
 }
 
-static void trans_ldsid(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_ldsid(DisasContext *ctx, arg_ldsid *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
+    unsigned rt = a->t;
     TCGv_reg dest = dest_gpr(ctx, rt);
 
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
 
@@ -2211,28 +2221,14 @@ static void trans_ldsid(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     cond_free(&ctx->null_cond);
 }
 
+static void trans_rsm(DisasContext *ctx, arg_rsm *a, uint32_t insn)
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
-static void trans_rsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    target_ureg sm = extract_sm_imm(insn);
+    unsigned rt = a->t;
+    target_ureg sm = a->i;
     TCGv_reg tmp;
 
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
     tmp = get_temp(ctx);
@@ -2244,15 +2240,17 @@ static void trans_rsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     /* Exit the TB to recognize new interrupts, e.g. PSW_M.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     nullify_end(ctx);
+#endif
 }
 
-static void trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_ssm(DisasContext *ctx, arg_ssm *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    target_ureg sm = extract_sm_imm(insn);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    unsigned rt = a->t;
+    target_ureg sm = a->i;
     TCGv_reg tmp;
 
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
     tmp = get_temp(ctx);
@@ -2264,8 +2262,8 @@ static void trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     /* Exit the TB to recognize new interrupts, e.g. PSW_I.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     nullify_end(ctx);
+#endif
 }
-#endif /* !CONFIG_USER_ONLY */
 
 static void trans_mtsm(DisasContext *ctx, arg_mtsm *a, uint32_t insn)
 {
@@ -2284,15 +2282,13 @@ static void trans_mtsm(DisasContext *ctx, arg_mtsm *a, uint32_t insn)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-static void trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void do_rfi(DisasContext *ctx, bool rfi_r)
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
@@ -2306,8 +2302,20 @@ static void trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     ctx->base.is_jmp = DISAS_NORETURN;
 
     nullify_end(ctx);
+#endif
 }
 
+static void trans_rfi(DisasContext *ctx, arg_rfi *a, uint32_t insn)
+{
+    do_rfi(ctx, false);
+}
+
+static void trans_rfi_r(DisasContext *ctx, arg_rfi_r *a, uint32_t insn)
+{
+    do_rfi(ctx, true);
+}
+
+#ifndef CONFIG_USER_ONLY
 static void gen_hlt(DisasContext *ctx, int reset)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
@@ -2322,17 +2330,6 @@ static void gen_hlt(DisasContext *ctx, int reset)
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
 static void trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
                                const DisasInsn *di)
 {
@@ -4512,9 +4509,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x00: /* system op */
-        translate_table(ctx, insn, table_system);
-        return;
     case 0x01:
         translate_table(ctx, insn, table_mem_mgmt);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 01b8a52ca5..b2131a269b 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -23,6 +23,8 @@
 
 %assemble_sr3	13:1 14:2
 
+%sm_imm		16:10 !function=expand_sm_imm
+
 ####
 # System
 ####
@@ -37,3 +39,13 @@ mtsm		000000 00000 r:5   000 11000011 00000
 mfia		000000 ----- 00000 ---   10100101 t:5
 mfsp		000000 ----- 00000 ...   00100101 t:5	sp=%assemble_sr3
 mfctl		000000 r:5   00000- e:1 -01000101 t:5
+
+sync		000000 ----- ----- 000 00100000 00000	# sync, syncdma
+
+ldsid		000000 b:5   ----- sp:2 0 10000101 t:5
+
+rsm		000000 ..........  000 01110011 t:5	i=%sm_imm
+ssm		000000 ..........  000 01101011 t:5	i=%sm_imm
+
+rfi		000000 ----- ----- --- 01100000 00000
+rfi_r		000000 ----- ----- --- 01100101 00000
-- 
2.14.3
