Received: from eggs.gnu.org ([209.51.188.92]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8q-0002aR-Us
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8m-0001pl-BF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:56 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:33119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001U5-8J
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pl1-x634.google.com with SMTP id y10so705464plp.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:00 -0800
Message-Id: <20190212045721.28041-4-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/24] target/hppa: Convert move to/from system
 registers
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
 target/hppa/translate.c  | 61 +++++++++++++++++-----------------------
 target/hppa/insns.decode | 15 ++++++++++
 2 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f50ec7b9c2..72cb7b477e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -838,7 +838,7 @@ static unsigned assemble_rc64(uint32_t insn)
     return r2 * 32 + r1 * 4 + r0;
 }
 
-static unsigned assemble_sr3(uint32_t insn)
+static inline unsigned assemble_sr3(uint32_t insn)
 {
     unsigned s2 = extract32(insn, 13, 1);
     unsigned s0 = extract32(insn, 14, 2);
@@ -2005,9 +2005,9 @@ static bool trans_sync(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return true;
 }
 
-static bool trans_mfia(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
+    unsigned rt = a->t;
     TCGv_reg tmp = dest_gpr(ctx, rt);
     tcg_gen_movi_reg(tmp, ctx->iaoq_f);
     save_gpr(ctx, rt, tmp);
@@ -2016,10 +2016,10 @@ static bool trans_mfia(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return true;
 }
 
-static bool trans_mfsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned rs = assemble_sr3(insn);
+    unsigned rt = a->t;
+    unsigned rs = a->sp;
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_reg t1 = tcg_temp_new();
 
@@ -2035,16 +2035,16 @@ static bool trans_mfsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return true;
 }
 
-static bool trans_mfctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ctl = extract32(insn, 21, 5);
+    unsigned rt = a->t;
+    unsigned ctl = a->r;
     TCGv_reg tmp;
 
     switch (ctl) {
     case CR_SAR:
 #ifdef TARGET_HPPA64
-        if (extract32(insn, 14, 1) == 0) {
+        if (a->e == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
             tcg_gen_andi_reg(tmp, cpu_sar, 31);
@@ -2086,10 +2086,10 @@ static bool trans_mfctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return true;
 }
 
-static bool trans_mtsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mtsp(DisasContext *ctx, arg_mtsp *a)
 {
-    unsigned rr = extract32(insn, 16, 5);
-    unsigned rs = assemble_sr3(insn);
+    unsigned rr = a->r;
+    unsigned rs = a->sp;
     TCGv_i64 t64;
 
     if (rs >= 5) {
@@ -2112,11 +2112,10 @@ static bool trans_mtsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return nullify_end(ctx);
 }
 
-static bool trans_mtctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 {
-    unsigned rin = extract32(insn, 16, 5);
-    unsigned ctl = extract32(insn, 21, 5);
-    TCGv_reg reg = load_gpr(ctx, rin);
+    unsigned ctl = a->t;
+    TCGv_reg reg = load_gpr(ctx, a->r);
     TCGv_reg tmp;
 
     if (ctl == CR_SAR) {
@@ -2132,9 +2131,7 @@ static bool trans_mtctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     /* All other control registers are privileged or read-only.  */
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
 
-#ifdef CONFIG_USER_ONLY
-    g_assert_not_reached();
-#else
+#ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
     switch (ctl) {
     case CR_IT:
@@ -2168,12 +2165,11 @@ static bool trans_mtctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 #endif
 }
 
-static bool trans_mtsarcm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
 {
-    unsigned rin = extract32(insn, 16, 5);
     TCGv_reg tmp = tcg_temp_new();
 
-    tcg_gen_not_reg(tmp, load_gpr(ctx, rin));
+    tcg_gen_not_reg(tmp, load_gpr(ctx, a->r));
     tcg_gen_andi_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
     save_or_nullify(ctx, cpu_sar, tmp);
     tcg_temp_free(tmp);
@@ -2261,24 +2257,26 @@ static bool trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
 }
+#endif /* !CONFIG_USER_ONLY */
 
-static bool trans_mtsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 {
-    unsigned rr = extract32(insn, 16, 5);
-    TCGv_reg tmp, reg;
-
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    TCGv_reg tmp, reg;
     nullify_over(ctx);
 
-    reg = load_gpr(ctx, rr);
+    reg = load_gpr(ctx, a->r);
     tmp = get_temp(ctx);
     gen_helper_swap_system_mask(tmp, cpu_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
+#endif
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned comp = extract32(insn, 5, 4);
@@ -2317,19 +2315,12 @@ static bool gen_hlt(DisasContext *ctx, int reset)
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
-    { 0x00001820u, 0xffe01fffu, trans_mtsp },
-    { 0x00001840u, 0xfc00ffffu, trans_mtctl },
-    { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
-    { 0x000014a0u, 0xffffffe0u, trans_mfia },
-    { 0x000004a0u, 0xffff1fe0u, trans_mfsp },
-    { 0x000008a0u, 0xfc1fbfe0u, trans_mfctl },
     { 0x00000400u, 0xffffffffu, trans_sync },  /* sync */
     { 0x00100400u, 0xffffffffu, trans_sync },  /* syncdma */
     { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
 #ifndef CONFIG_USER_ONLY
     { 0x00000e60u, 0xfc00ffe0u, trans_rsm },
     { 0x00000d60u, 0xfc00ffe0u, trans_ssm },
-    { 0x00001860u, 0xffe0ffffu, trans_mtsm },
     { 0x00000c00u, 0xfffffe1fu, trans_rfi },
 #endif
 };
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 2822fbc58b..047a9d01ec 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -17,8 +17,23 @@
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
 
+####
+# Field definitions
+####
+
+%assemble_sr3   13:1 14:2
+
 ####
 # System
 ####
 
 break           000000 ----- ----- --- 00000000 -----
+
+mtsp            000000 ----- r:5   ... 11000001 00000   sp=%assemble_sr3
+mtctl           000000 t:5   r:5   --- 11000010 00000
+mtsarcm         000000 01011 r:5   --- 11000110 00000
+mtsm            000000 00000 r:5   000 11000011 00000
+
+mfia            000000 ----- 00000 ---   10100101 t:5
+mfsp            000000 ----- 00000 ...   00100101 t:5   sp=%assemble_sr3
+mfctl           000000 r:5   00000- e:1 -01000101 t:5
-- 
2.17.2
