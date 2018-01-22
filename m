Received: from eggs.gnu.org ([2001:4830:134:3::10]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0I-0005OL-5e
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0D-000663-4n
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:38 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0C-00064k-Tw
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:33 -0500
Received: by mail-pg0-x242.google.com with SMTP id q67so6080028pga.9
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:42 -0800
Message-Id: <20180122034217.19593-9-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/43] target/hppa: Add space registers
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

Not used where they should be yet, but we can copy them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  1 +
 target/hppa/helper.c    | 14 ++++++----
 target/hppa/translate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 805c93db9c..24c728c0d2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -140,6 +140,7 @@ typedef int64_t  target_sreg;
 struct CPUHPPAState {
     target_ureg gr[32];
     uint64_t fr[32];
+    uint64_t sr[8];          /* stored shifted into place for gva */
 
     target_ureg sar;
     target_ureg cr26;
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index b6521f61fc..48ac80cb2d 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -168,12 +168,16 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
                 psw, psw_cb, psw_c);
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "GR%02d " TREG_FMT_lx " ", i, env->gr[i]);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
-        }
+        cpu_fprintf(f, "GR%02d " TREG_FMT_lx "%c", i, env->gr[i],
+                    (i & 3) == 3 ? '\n' : ' ');
+    }
+#ifndef CONFIG_USER_ONLY
+    for (i = 0; i < 8; i++) {
+        cpu_fprintf(f, "SR%02d %08x%c", i, (uint32_t)(env->sr[i] >> 32),
+                    (i & 3) == 3 ? '\n' : ' ');
     }
-    cpu_fprintf(f, "\n");
+#endif
+     cpu_fprintf(f, "\n");
 
     /* ??? FR */
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0c6d7898a2..1b03573292 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -316,6 +316,7 @@ typedef struct DisasInsn {
 
 /* global register indexes */
 static TCGv_reg cpu_gr[32];
+static TCGv_i64 cpu_sr[4];
 static TCGv_reg cpu_iaoq_f;
 static TCGv_reg cpu_iaoq_b;
 static TCGv_reg cpu_sar;
@@ -354,6 +355,10 @@ void hppa_translate_init(void)
         "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
         "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
     };
+    /* SR[4-7] are not global registers so that we can index them.  */
+    static const char sr_names[4][4] = {
+        "sr0", "sr1", "sr2", "sr3"
+    };
 
     int i;
 
@@ -363,6 +368,11 @@ void hppa_translate_init(void)
                                        offsetof(CPUHPPAState, gr[i]),
                                        gr_names[i]);
     }
+    for (i = 0; i < 4; i++) {
+        cpu_sr[i] = tcg_global_mem_new_i64(cpu_env,
+                                           offsetof(CPUHPPAState, sr[i]),
+                                           sr_names[i]);
+    }
 
     for (i = 0; i < ARRAY_SIZE(vars); ++i) {
         const GlobalVar *v = &vars[i];
@@ -567,6 +577,19 @@ static void save_frd(unsigned rt, TCGv_i64 val)
     tcg_gen_st_i64(val, cpu_env, offsetof(CPUHPPAState, fr[rt]));
 }
 
+static void load_spr(DisasContext *ctx, TCGv_i64 dest, unsigned reg)
+{
+#ifdef CONFIG_USER_ONLY
+    tcg_gen_movi_i64(dest, 0);
+#else
+    if (reg < 4) {
+        tcg_gen_mov_i64(dest, cpu_sr[reg]);
+    } else {
+        tcg_gen_ld_i64(dest, cpu_env, offsetof(CPUHPPAState, sr[reg]));
+    }
+#endif
+}
+
 /* Skip over the implementation of an insn that has been nullified.
    Use this when the insn is too complex for a conditional move.  */
 static void nullify_over(DisasContext *ctx)
@@ -781,6 +804,13 @@ static unsigned assemble_rc64(uint32_t insn)
     return r2 * 32 + r1 * 4 + r0;
 }
 
+static unsigned assemble_sr3(uint32_t insn)
+{
+    unsigned s2 = extract32(insn, 13, 1);
+    unsigned s0 = extract32(insn, 14, 2);
+    return s2 * 4 + s0;
+}
+
 static target_sreg assemble_12(uint32_t insn)
 {
     target_ureg x = -(target_ureg)(insn & 1);
@@ -1883,11 +1913,17 @@ static DisasJumpType trans_mfsp(DisasContext *ctx, uint32_t insn,
                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
-    TCGv_reg tmp = dest_gpr(ctx, rt);
+    unsigned rs = assemble_sr3(insn);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_reg t1 = tcg_temp_new();
 
-    /* ??? We don't implement space registers.  */
-    tcg_gen_movi_reg(tmp, 0);
-    save_gpr(ctx, rt, tmp);
+    load_spr(ctx, t0, rs);
+    tcg_gen_shri_i64(t0, t0, 32);
+    tcg_gen_trunc_i64_reg(t1, t0);
+
+    save_gpr(ctx, rt, t1);
+    tcg_temp_free(t1);
+    tcg_temp_free_i64(t0);
 
     cond_free(&ctx->null_cond);
     return DISAS_NEXT;
@@ -1933,6 +1969,32 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
     return DISAS_NEXT;
 }
 
+static DisasJumpType trans_mtsp(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned rr = extract32(insn, 16, 5);
+    unsigned rs = assemble_sr3(insn);
+    TCGv_i64 t64;
+
+    if (rs >= 5) {
+        CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
+    }
+    nullify_over(ctx);
+
+    t64 = tcg_temp_new_i64();
+    tcg_gen_extu_reg_i64(t64, load_gpr(ctx, rr));
+    tcg_gen_shli_i64(t64, t64, 32);
+
+    if (rs >= 4) {
+        tcg_gen_st_i64(t64, cpu_env, offsetof(CPUHPPAState, sr[rs]));
+    } else {
+        tcg_gen_mov_i64(cpu_sr[rs], t64);
+    }
+    tcg_temp_free_i64(t64);
+
+    return nullify_end(ctx, DISAS_NEXT);
+}
+
 static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
                                  const DisasInsn *di)
 {
@@ -2058,8 +2120,7 @@ static DisasJumpType trans_mtsm(DisasContext *ctx, uint32_t insn,
 
 static const DisasInsn table_system[] = {
     { 0x00000000u, 0xfc001fe0u, trans_break },
-    /* We don't implement space register, so MTSP is a nop.  */
-    { 0x00001820u, 0xffe01fffu, trans_nop },
+    { 0x00001820u, 0xffe01fffu, trans_mtsp },
     { 0x00001840u, 0xfc00ffffu, trans_mtctl },
     { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
     { 0x000014a0u, 0xffffffe0u, trans_mfia },
-- 
2.14.3
