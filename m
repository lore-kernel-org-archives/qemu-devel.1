Received: from eggs.gnu.org ([2001:4830:134:3::10]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8i-0004sx-S7
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8h-0001T6-2A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8g-0001Sr-Tc
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:27 -0500
Received: by mail-qt0-x241.google.com with SMTP id h53so15006212qth.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:26 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:25 +1100
Message-Id: <20170213212536.31871-14-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 13/24] target/openrisc: Keep SR_CY and SR_OV in
 a separate variables
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

This significantly streamlines carry and overflow production.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h              |  13 +++-
 target/openrisc/exception_helper.c |  31 ++++++++--
 target/openrisc/helper.h           |   4 +-
 target/openrisc/translate.c        | 119 +++++++++++++------------------------
 4 files changed, 78 insertions(+), 89 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index bb5d363..e693461 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -287,7 +287,9 @@ typedef struct CPUOpenRISCState {
     target_ulong eear;        /* Exception EA register */
 
     target_ulong sr_f;        /* the SR_F bit, values 0, 1.  */
-    uint32_t sr;              /* Supervisor register, without SR_F */
+    target_ulong sr_cy;       /* the SR_CY bit, values 0, 1.  */
+    target_long  sr_ov;       /* the SR_OV bit (in the sign bit only) */
+    uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
     uint32_t vr;              /* Version register */
     uint32_t upr;             /* Unit presence register */
     uint32_t cpucfgr;         /* CPU configure register */
@@ -414,13 +416,18 @@ static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
 
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
-    return env->sr + env->sr_f * SR_F;
+    return (env->sr
+            + env->sr_f * SR_F
+            + env->sr_cy * SR_CY
+            + (env->sr_ov < 0) * SR_OV);
 }
 
 static inline void cpu_set_sr(CPUOpenRISCState *env, uint32_t val)
 {
     env->sr_f = (val & SR_F) != 0;
-    env->sr = (val & ~SR_F) | SR_FO;
+    env->sr_cy = (val & SR_CY) != 0;
+    env->sr_ov = (val & SR_OV ? -1 : 0);
+    env->sr = (val & ~(SR_F | SR_CY | SR_OV)) | SR_FO;
 }
 
 #define CPU_INTERRUPT_TIMER   CPU_INTERRUPT_TGT_INT_0
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 5147da6..1536053 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -30,13 +30,32 @@ void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
     raise_exception(cpu, excp);
 }
 
-void HELPER(ove)(CPUOpenRISCState *env, target_ulong test)
+static void QEMU_NORETURN do_range(CPUOpenRISCState *env, uintptr_t pc)
 {
-    if (unlikely(test)) {
-        OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-        CPUState *cs = CPU(cpu);
+    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    cs->exception_index = EXCP_RANGE;
+    cpu_loop_exit_restore(cs, pc);
+}
+
+void HELPER(ove_cy)(CPUOpenRISCState *env)
+{
+    if (env->sr_cy) {
+        do_range(env, GETPC());
+    }
+}
+
+void HELPER(ove_ov)(CPUOpenRISCState *env)
+{
+    if (env->sr_ov < 0) {
+        do_range(env, GETPC());
+    }
+}
 
-        cs->exception_index = EXCP_RANGE;
-        cpu_loop_exit_restore(cs, GETPC());
+void HELPER(ove_cyov)(CPUOpenRISCState *env)
+{
+    if (env->sr_cy || env->sr_ov < 0) {
+        do_range(env, GETPC());
     }
 }
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index c2c8098..f4d97a2 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -19,7 +19,9 @@
 
 /* exception */
 DEF_HELPER_FLAGS_2(exception, 0, void, env, i32)
-DEF_HELPER_FLAGS_2(ove, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_1(ove_cy, TCG_CALL_NO_WG, void, env)
+DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
+DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
 
 /* float */
 DEF_HELPER_FLAGS_2(itofd, 0, i64, env, i64)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 405a1a0..6c745d3 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -55,6 +55,8 @@ static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_npc;
 static TCGv cpu_ppc;
 static TCGv cpu_sr_f;           /* bf/bnf, F flag taken */
+static TCGv cpu_sr_cy;          /* carry (unsigned overflow) */
+static TCGv cpu_sr_ov;          /* signed overflow */
 static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
@@ -90,6 +92,10 @@ void openrisc_translate_init(void)
                                 offsetof(CPUOpenRISCState, jmp_pc), "jmp_pc");
     cpu_sr_f = tcg_global_mem_new(cpu_env,
                                   offsetof(CPUOpenRISCState, sr_f), "sr_f");
+    cpu_sr_cy = tcg_global_mem_new(cpu_env,
+                                   offsetof(CPUOpenRISCState, sr_cy), "sr_cy");
+    cpu_sr_ov = tcg_global_mem_new(cpu_env,
+                                   offsetof(CPUOpenRISCState, sr_ov), "sr_ov");
     cpu_lock_addr = tcg_global_mem_new(cpu_env,
                                        offsetof(CPUOpenRISCState, lock_addr),
                                        "lock_addr");
@@ -233,27 +239,24 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     gen_sync_flags(dc);
 }
 
-static void gen_ove_cy(DisasContext *dc, TCGv cy)
+static void gen_ove_cy(DisasContext *dc)
 {
     if (dc->tb_flags & SR_OVE) {
-        gen_helper_ove(cpu_env, cy);
+        gen_helper_ove_cy(cpu_env);
     }
 }
 
-static void gen_ove_ov(DisasContext *dc, TCGv ov)
+static void gen_ove_ov(DisasContext *dc)
 {
     if (dc->tb_flags & SR_OVE) {
-        gen_helper_ove(cpu_env, ov);
+        gen_helper_ove_ov(cpu_env);
     }
 }
 
-static void gen_ove_cyov(DisasContext *dc, TCGv cy, TCGv ov)
+static void gen_ove_cyov(DisasContext *dc)
 {
     if (dc->tb_flags & SR_OVE) {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_or_tl(t0, cy, ov);
-        gen_helper_ove(cpu_env, t0);
-        tcg_temp_free(t0);
+        gen_helper_ove_cyov(cpu_env);
     }
 }
 
@@ -261,143 +264,101 @@ static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
     TCGv t0 = tcg_const_tl(0);
     TCGv res = tcg_temp_new();
-    TCGv sr_cy = tcg_temp_new();
-    TCGv sr_ov = tcg_temp_new();
 
-    tcg_gen_add2_tl(res, sr_cy, srca, t0, srcb, t0);
-    tcg_gen_xor_tl(sr_ov, srca, srcb);
+    tcg_gen_add2_tl(res, cpu_sr_cy, srca, t0, srcb, t0);
+    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
     tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(sr_ov, t0, sr_ov);
+    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
     tcg_temp_free(t0);
 
     tcg_gen_mov_tl(dest, res);
     tcg_temp_free(res);
 
-    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
-
-    gen_ove_cyov(dc, sr_ov, sr_cy);
-    tcg_temp_free(sr_ov);
-    tcg_temp_free(sr_cy);
+    gen_ove_cyov(dc);
 }
 
 static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
     TCGv t0 = tcg_const_tl(0);
     TCGv res = tcg_temp_new();
-    TCGv sr_cy = tcg_temp_new();
-    TCGv sr_ov = tcg_temp_new();
-
-    tcg_gen_shri_tl(sr_cy, cpu_sr, ctz32(SR_CY));
-    tcg_gen_andi_tl(sr_cy, sr_cy, 1);
 
-    tcg_gen_add2_tl(res, sr_cy, srca, t0, sr_cy, t0);
-    tcg_gen_add2_tl(res, sr_cy, res, sr_cy, srcb, t0);
-    tcg_gen_xor_tl(sr_ov, srca, srcb);
+    tcg_gen_add2_tl(res, cpu_sr_cy, srca, t0, cpu_sr_cy, t0);
+    tcg_gen_add2_tl(res, cpu_sr_cy, res, cpu_sr_cy, srcb, t0);
+    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
     tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(sr_ov, t0, sr_ov);
+    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
     tcg_temp_free(t0);
 
     tcg_gen_mov_tl(dest, res);
     tcg_temp_free(res);
 
-    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
-
-    gen_ove_cyov(dc, sr_ov, sr_cy);
-    tcg_temp_free(sr_ov);
-    tcg_temp_free(sr_cy);
+    gen_ove_cyov(dc);
 }
 
 static void gen_sub(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
     TCGv res = tcg_temp_new();
-    TCGv sr_cy = tcg_temp_new();
-    TCGv sr_ov = tcg_temp_new();
 
     tcg_gen_sub_tl(res, srca, srcb);
-    tcg_gen_xor_tl(sr_cy, srca, srcb);
-    tcg_gen_xor_tl(sr_ov, res, srcb);
-    tcg_gen_and_tl(sr_ov, sr_ov, sr_cy);
-    tcg_gen_setcond_tl(TCG_COND_LTU, sr_cy, srca, srcb);
+    tcg_gen_xor_tl(cpu_sr_cy, srca, srcb);
+    tcg_gen_xor_tl(cpu_sr_ov, res, srcb);
+    tcg_gen_and_tl(cpu_sr_ov, cpu_sr_ov, cpu_sr_cy);
+    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_cy, srca, srcb);
 
     tcg_gen_mov_tl(dest, res);
     tcg_temp_free(res);
 
-    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
-
-    gen_ove_cyov(dc, sr_ov, sr_cy);
-    tcg_temp_free(sr_ov);
-    tcg_temp_free(sr_cy);
+    gen_ove_cyov(dc);
 }
 
 static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
-    TCGv sr_ov = tcg_temp_new();
     TCGv t0 = tcg_temp_new();
 
-    tcg_gen_muls2_tl(dest, sr_ov, srca, srcb);
+    tcg_gen_muls2_tl(dest, cpu_sr_ov, srca, srcb);
     tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
-    tcg_gen_setcond_tl(TCG_COND_NE, sr_ov, sr_ov, t0);
+    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
     tcg_temp_free(t0);
 
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
-
-    gen_ove_ov(dc, sr_ov);
-    tcg_temp_free(sr_ov);
+    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
+    gen_ove_ov(dc);
 }
 
 static void gen_mulu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
-    TCGv sr_cy = tcg_temp_new();
-
-    tcg_gen_muls2_tl(dest, sr_cy, srca, srcb);
-    tcg_gen_setcondi_tl(TCG_COND_NE, sr_cy, sr_cy, 0);
-
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+    tcg_gen_muls2_tl(dest, cpu_sr_cy, srca, srcb);
+    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
 
-    gen_ove_cy(dc, sr_cy);
-    tcg_temp_free(sr_cy);
+    gen_ove_cy(dc);
 }
 
 static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
-    TCGv sr_ov = tcg_temp_new();
     TCGv t0 = tcg_temp_new();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, sr_ov, srcb, 0);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Supress the host-side exception by dividing by 1.  */
-    tcg_gen_or_tl(t0, srcb, sr_ov);
+    tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
     tcg_gen_div_tl(dest, srca, t0);
     tcg_temp_free(t0);
 
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
-
-    gen_ove_ov(dc, sr_ov);
-    tcg_temp_free(sr_ov);
+    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
+    gen_ove_ov(dc);
 }
 
 static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 {
-    TCGv sr_cy = tcg_temp_new();
     TCGv t0 = tcg_temp_new();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, sr_cy, srcb, 0);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Supress the host-side exception by dividing by 1.  */
-    tcg_gen_or_tl(t0, srcb, sr_cy);
+    tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
     tcg_gen_divu_tl(dest, srca, t0);
     tcg_temp_free(t0);
 
-    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
-
-    gen_ove_cy(dc, sr_cy);
-    tcg_temp_free(sr_cy);
+    gen_ove_cy(dc);
 }
 
 static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
-- 
2.9.3
