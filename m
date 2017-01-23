Received: from eggs.gnu.org ([2001:4830:134:3::10]:46816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDI-00082o-JH
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDE-0004yr-Sg
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:32 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUDE-0004yh-Mb
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:28 -0500
Received: by mail-qt0-x244.google.com with SMTP id l7so14117436qtd.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:48 -0800
Message-Id: <20170123021748.13170-27-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 26/26] target-hppa: Implement floating-point
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/helper.h    |  55 ++++
 target/hppa/op_helper.c | 394 ++++++++++++++++++++++++++
 target/hppa/translate.c | 728 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1177 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index d51cf6d..789f07f 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -9,3 +9,58 @@ DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tl, tl)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_FLAGS_2(fsqrt_s, TCG_CALL_NO_RWG, f32, env, f32)
+DEF_HELPER_FLAGS_2(frnd_s, TCG_CALL_NO_RWG, f32, env, f32)
+DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fsub_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fmpy_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdiv_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
+
+DEF_HELPER_FLAGS_2(fsqrt_d, TCG_CALL_NO_RWG, f64, env, f64)
+DEF_HELPER_FLAGS_2(frnd_d, TCG_CALL_NO_RWG, f64, env, f64)
+DEF_HELPER_FLAGS_3(fadd_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fsub_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fmpy_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
+
+DEF_HELPER_FLAGS_2(fcnv_s_d, TCG_CALL_NO_RWG, f64, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_d_s, TCG_CALL_NO_RWG, f32, env, f64)
+
+DEF_HELPER_FLAGS_2(fcnv_w_s, TCG_CALL_NO_RWG, f32, env, s32)
+DEF_HELPER_FLAGS_2(fcnv_dw_s, TCG_CALL_NO_RWG, f32, env, s64)
+DEF_HELPER_FLAGS_2(fcnv_w_d, TCG_CALL_NO_RWG, f64, env, s32)
+DEF_HELPER_FLAGS_2(fcnv_dw_d, TCG_CALL_NO_RWG, f64, env, s64)
+
+DEF_HELPER_FLAGS_2(fcnv_s_w, TCG_CALL_NO_RWG, s32, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_d_w, TCG_CALL_NO_RWG, s32, env, f64)
+DEF_HELPER_FLAGS_2(fcnv_s_dw, TCG_CALL_NO_RWG, s64, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_d_dw, TCG_CALL_NO_RWG, s64, env, f64)
+
+DEF_HELPER_FLAGS_2(fcnv_t_s_w, TCG_CALL_NO_RWG, s32, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_t_d_w, TCG_CALL_NO_RWG, s32, env, f64)
+DEF_HELPER_FLAGS_2(fcnv_t_s_dw, TCG_CALL_NO_RWG, s64, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_t_d_dw, TCG_CALL_NO_RWG, s64, env, f64)
+
+DEF_HELPER_FLAGS_2(fcnv_uw_s, TCG_CALL_NO_RWG, f32, env, i32)
+DEF_HELPER_FLAGS_2(fcnv_udw_s, TCG_CALL_NO_RWG, f32, env, i64)
+DEF_HELPER_FLAGS_2(fcnv_uw_d, TCG_CALL_NO_RWG, f64, env, i32)
+DEF_HELPER_FLAGS_2(fcnv_udw_d, TCG_CALL_NO_RWG, f64, env, i64)
+
+DEF_HELPER_FLAGS_2(fcnv_s_uw, TCG_CALL_NO_RWG, i32, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_d_uw, TCG_CALL_NO_RWG, i32, env, f64)
+DEF_HELPER_FLAGS_2(fcnv_s_udw, TCG_CALL_NO_RWG, i64, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_d_udw, TCG_CALL_NO_RWG, i64, env, f64)
+
+DEF_HELPER_FLAGS_2(fcnv_t_s_uw, TCG_CALL_NO_RWG, i32, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_t_d_uw, TCG_CALL_NO_RWG, i32, env, f64)
+DEF_HELPER_FLAGS_2(fcnv_t_s_udw, TCG_CALL_NO_RWG, i64, env, f32)
+DEF_HELPER_FLAGS_2(fcnv_t_d_udw, TCG_CALL_NO_RWG, i64, env, f64)
+
+DEF_HELPER_FLAGS_5(fcmp_s, TCG_CALL_NO_RWG, void, env, f32, f32, i32, i32)
+DEF_HELPER_FLAGS_5(fcmp_d, TCG_CALL_NO_RWG, void, env, f64, f64, i32, i32)
+
+DEF_HELPER_FLAGS_4(fmpyfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(fmpynfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(fmpyfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 670e600..c05c0d5 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -174,3 +174,397 @@ void cpu_hppa_loaded_fr0(CPUHPPAState *env)
 {
     helper_loaded_fr0(env);
 }
+
+#define CONVERT_BIT(X, SRC, DST)        \
+    ((SRC) > (DST)                      \
+     ? (X) / ((SRC) / (DST)) & (DST)    \
+     : ((X) & (SRC)) * ((DST) / (SRC)))
+
+static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
+{
+    uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
+    uint32_t hard_exp = 0;
+    uint32_t shadow = env->fr0_shadow;
+
+    if (likely(soft_exp == 0)) {
+        env->fr[0] = (uint64_t)shadow << 32;
+        return;
+    }
+    set_float_exception_flags(0, &env->fp_status);
+
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_inexact,   1u << 0);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_underflow, 1u << 1);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_overflow,  1u << 2);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_divbyzero, 1u << 3);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_invalid,   1u << 4);
+    shadow |= hard_exp << (32 - 5);
+    env->fr0_shadow = shadow;
+    env->fr[0] = (uint64_t)shadow << 32;
+
+    if (hard_exp & shadow) {
+        dynexcp(env, EXCP_SIGFPE, ra);
+    }
+}
+
+float32 HELPER(fsqrt_s)(CPUHPPAState *env, float32 arg)
+{
+    float32 ret = float32_sqrt(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(frnd_s)(CPUHPPAState *env, float32 arg)
+{
+    float32 ret = float32_round_to_int(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fadd_s)(CPUHPPAState *env, float32 a, float32 b)
+{
+    float32 ret = float32_add(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fsub_s)(CPUHPPAState *env, float32 a, float32 b)
+{
+    float32 ret = float32_sub(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fmpy_s)(CPUHPPAState *env, float32 a, float32 b)
+{
+    float32 ret = float32_mul(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fdiv_s)(CPUHPPAState *env, float32 a, float32 b)
+{
+    float32 ret = float32_div(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fsqrt_d)(CPUHPPAState *env, float64 arg)
+{
+    float64 ret = float64_sqrt(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(frnd_d)(CPUHPPAState *env, float64 arg)
+{
+    float64 ret = float64_round_to_int(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fadd_d)(CPUHPPAState *env, float64 a, float64 b)
+{
+    float64 ret = float64_add(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fsub_d)(CPUHPPAState *env, float64 a, float64 b)
+{
+    float64 ret = float64_sub(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fmpy_d)(CPUHPPAState *env, float64 a, float64 b)
+{
+    float64 ret = float64_mul(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fdiv_d)(CPUHPPAState *env, float64 a, float64 b)
+{
+    float64 ret = float64_div(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
+{
+    float64 ret = float32_to_float64(arg, &env->fp_status);
+    ret = float64_maybe_silence_nan(ret, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fcnv_d_s)(CPUHPPAState *env, float64 arg)
+{
+    float32 ret = float64_to_float32(arg, &env->fp_status);
+    ret = float32_maybe_silence_nan(ret, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fcnv_w_s)(CPUHPPAState *env, int32_t arg)
+{
+    float32 ret = int32_to_float32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fcnv_dw_s)(CPUHPPAState *env, int64_t arg)
+{
+    float32 ret = int64_to_float32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fcnv_w_d)(CPUHPPAState *env, int32_t arg)
+{
+    float64 ret = int32_to_float64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fcnv_dw_d)(CPUHPPAState *env, int64_t arg)
+{
+    float64 ret = int64_to_float64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int32_t HELPER(fcnv_s_w)(CPUHPPAState *env, float32 arg)
+{
+    int32_t ret = float32_to_int32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int32_t HELPER(fcnv_d_w)(CPUHPPAState *env, float64 arg)
+{
+    int32_t ret = float64_to_int32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int64_t HELPER(fcnv_s_dw)(CPUHPPAState *env, float32 arg)
+{
+    int64_t ret = float32_to_int64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int64_t HELPER(fcnv_d_dw)(CPUHPPAState *env, float64 arg)
+{
+    int64_t ret = float64_to_int64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int32_t HELPER(fcnv_t_s_w)(CPUHPPAState *env, float32 arg)
+{
+    int32_t ret = float32_to_int32_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int32_t HELPER(fcnv_t_d_w)(CPUHPPAState *env, float64 arg)
+{
+    int32_t ret = float64_to_int32_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int64_t HELPER(fcnv_t_s_dw)(CPUHPPAState *env, float32 arg)
+{
+    int64_t ret = float32_to_int64_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+int64_t HELPER(fcnv_t_d_dw)(CPUHPPAState *env, float64 arg)
+{
+    int64_t ret = float64_to_int64_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fcnv_uw_s)(CPUHPPAState *env, uint32_t arg)
+{
+    float32 ret = uint32_to_float32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fcnv_udw_s)(CPUHPPAState *env, uint64_t arg)
+{
+    float32 ret = uint64_to_float32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fcnv_uw_d)(CPUHPPAState *env, uint32_t arg)
+{
+    float64 ret = uint32_to_float64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fcnv_udw_d)(CPUHPPAState *env, uint64_t arg)
+{
+    float64 ret = uint64_to_float64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint32_t HELPER(fcnv_s_uw)(CPUHPPAState *env, float32 arg)
+{
+    uint32_t ret = float32_to_uint32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint32_t HELPER(fcnv_d_uw)(CPUHPPAState *env, float64 arg)
+{
+    uint32_t ret = float64_to_uint32(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint64_t HELPER(fcnv_s_udw)(CPUHPPAState *env, float32 arg)
+{
+    uint64_t ret = float32_to_uint64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint64_t HELPER(fcnv_d_udw)(CPUHPPAState *env, float64 arg)
+{
+    uint64_t ret = float64_to_uint64(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint32_t HELPER(fcnv_t_s_uw)(CPUHPPAState *env, float32 arg)
+{
+    uint32_t ret = float32_to_uint32_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint32_t HELPER(fcnv_t_d_uw)(CPUHPPAState *env, float64 arg)
+{
+    uint32_t ret = float64_to_uint32_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint64_t HELPER(fcnv_t_s_udw)(CPUHPPAState *env, float32 arg)
+{
+    uint64_t ret = float32_to_uint64_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+uint64_t HELPER(fcnv_t_d_udw)(CPUHPPAState *env, float64 arg)
+{
+    uint64_t ret = float64_to_uint64_round_to_zero(arg, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+static void update_fr0_cmp(CPUHPPAState *env, uint32_t y, uint32_t c, int r)
+{
+    uint32_t shadow = env->fr0_shadow;
+
+    switch (r) {
+    case float_relation_greater:
+        c = extract32(c, 4, 1);
+        break;
+    case float_relation_less:
+        c = extract32(c, 3, 1);
+        break;
+    case float_relation_equal:
+        c = extract32(c, 2, 1);
+        break;
+    case float_relation_unordered:
+        c = extract32(c, 1, 1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (y) {
+        /* targeted comparison */
+        /* set fpsr[ca[y - 1]] to current compare */
+        shadow = deposit32(shadow, 21 - (y - 1), 1, c);
+    } else {
+        /* queued comparison */
+        /* shift cq right by one place */
+        shadow = deposit32(shadow, 11, 10, extract32(shadow, 12, 10));
+        /* move fpsr[c] to fpsr[cq[0]] */
+        shadow = deposit32(shadow, 21, 1, extract32(shadow, 26, 1));
+        /* set fpsr[c] to current compare */
+        shadow = deposit32(shadow, 26, 1, c);
+    }
+
+    env->fr0_shadow = shadow;
+    env->fr[0] = (uint64_t)shadow << 32;
+}
+
+void HELPER(fcmp_s)(CPUHPPAState *env, float32 a, float32 b,
+                    uint32_t y, uint32_t c)
+{
+    int r;
+    if (c & 1) {
+        r = float32_compare(a, b, &env->fp_status);
+    } else {
+        r = float32_compare_quiet(a, b, &env->fp_status);
+    }
+    update_fr0_op(env, GETPC());
+    update_fr0_cmp(env, y, c, r);
+}
+
+void HELPER(fcmp_d)(CPUHPPAState *env, float64 a, float64 b,
+                    uint32_t y, uint32_t c)
+{
+    int r;
+    if (c & 1) {
+        r = float64_compare(a, b, &env->fp_status);
+    } else {
+        r = float64_compare_quiet(a, b, &env->fp_status);
+    }
+    update_fr0_op(env, GETPC());
+    update_fr0_cmp(env, y, c, r);
+}
+
+float32 HELPER(fmpyfadd_s)(CPUHPPAState *env, float32 a, float32 b, float32 c)
+{
+    float32 ret = float32_muladd(a, b, c, 0, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float32 HELPER(fmpynfadd_s)(CPUHPPAState *env, float32 a, float32 b, float32 c)
+{
+    float32 ret = float32_muladd(a, b, c, float_muladd_negate_product,
+                                 &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fmpyfadd_d)(CPUHPPAState *env, float64 a, float64 b, float64 c)
+{
+    float64 ret = float64_muladd(a, b, c, 0, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
+float64 HELPER(fmpynfadd_d)(CPUHPPAState *env, float64 a, float64 b, float64 c)
+{
+    float64 ret = float64_muladd(a, b, c, float_muladd_negate_product,
+                                 &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cfdb9ee..4d243f7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -85,6 +85,12 @@ typedef struct DisasInsn {
                         const struct DisasInsn *f);
     union {
         void (*f_ttt)(TCGv, TCGv, TCGv);
+        void (*f_weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
+        void (*f_dedd)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64);
+        void (*f_wew)(TCGv_i32, TCGv_env, TCGv_i32);
+        void (*f_ded)(TCGv_i64, TCGv_env, TCGv_i64);
+        void (*f_wed)(TCGv_i32, TCGv_env, TCGv_i64);
+        void (*f_dew)(TCGv_i64, TCGv_env, TCGv_i32);
     };
 } DisasInsn;
 
@@ -295,6 +301,28 @@ static TCGv_i32 load_frw_i32(unsigned rt)
     return ret;
 }
 
+static TCGv_i32 load_frw0_i32(unsigned rt)
+{
+    if (rt == 0) {
+        return tcg_const_i32(0);
+    } else {
+        return load_frw_i32(rt);
+    }
+}
+
+static TCGv_i64 load_frw0_i64(unsigned rt)
+{
+    if (rt == 0) {
+        return tcg_const_i64(0);
+    } else {
+        TCGv_i64 ret = tcg_temp_new_i64();
+        tcg_gen_ld32u_i64(ret, cpu_env,
+                          offsetof(CPUHPPAState, fr[rt & 31])
+                          + (rt & 32 ? LO_OFS : HI_OFS));
+        return ret;
+    }
+}
+
 static void save_frw_i32(unsigned rt, TCGv_i32 val)
 {
     tcg_gen_st_i32(val, cpu_env,
@@ -312,6 +340,15 @@ static TCGv_i64 load_frd(unsigned rt)
     return ret;
 }
 
+static TCGv_i64 load_frd0(unsigned rt)
+{
+    if (rt == 0) {
+        return tcg_const_i64(0);
+    } else {
+        return load_frd(rt);
+    }
+}
+
 static void save_frd(unsigned rt, TCGv_i64 val)
 {
     tcg_gen_st_i64(val, cpu_env, offsetof(CPUHPPAState, fr[rt]));
@@ -494,6 +531,35 @@ static target_long low_sextract(uint32_t val, int pos, int len)
     return x;
 }
 
+static unsigned assemble_rt64(uint32_t insn)
+{
+    unsigned r1 = extract32(insn, 6, 1);
+    unsigned r0 = extract32(insn, 0, 5);
+    return r1 * 32 + r0;
+}
+
+static unsigned assemble_ra64(uint32_t insn)
+{
+    unsigned r1 = extract32(insn, 7, 1);
+    unsigned r0 = extract32(insn, 21, 5);
+    return r1 * 32 + r0;
+}
+
+static unsigned assemble_rb64(uint32_t insn)
+{
+    unsigned r1 = extract32(insn, 12, 1);
+    unsigned r0 = extract32(insn, 16, 5);
+    return r1 * 32 + r0;
+}
+
+static unsigned assemble_rc64(uint32_t insn)
+{
+    unsigned r2 = extract32(insn, 8, 1);
+    unsigned r1 = extract32(insn, 13, 3);
+    unsigned r0 = extract32(insn, 9, 2);
+    return r2 * 32 + r1 * 4 + r0;
+}
+
 static target_long assemble_12(uint32_t insn)
 {
     target_ulong x = -(target_ulong)(insn & 1);
@@ -1218,6 +1284,110 @@ static ExitStatus do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     return nullify_end(ctx, NO_EXIT);
 }
 
+static ExitStatus do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
+                             void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    nullify_over(ctx);
+    tmp = load_frw0_i32(ra);
+
+    func(tmp, cpu_env, tmp);
+
+    save_frw_i32(rt, tmp);
+    tcg_temp_free_i32(tmp);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
+                             void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    nullify_over(ctx);
+    src = load_frd(ra);
+    dst = tcg_temp_new_i32();
+
+    func(dst, cpu_env, src);
+
+    tcg_temp_free_i64(src);
+    save_frw_i32(rt, dst);
+    tcg_temp_free_i32(dst);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
+                             void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+{
+    TCGv_i64 tmp;
+
+    nullify_over(ctx);
+    tmp = load_frd0(ra);
+
+    func(tmp, cpu_env, tmp);
+
+    save_frd(rt, tmp);
+    tcg_temp_free_i64(tmp);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
+                             void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 src;
+    TCGv_i64 dst;
+
+    nullify_over(ctx);
+    src = load_frw0_i32(ra);
+    dst = tcg_temp_new_i64();
+
+    func(dst, cpu_env, src);
+
+    tcg_temp_free_i32(src);
+    save_frd(rt, dst);
+    tcg_temp_free_i64(dst);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fop_weww(DisasContext *ctx, unsigned rt,
+                              unsigned ra, unsigned rb,
+                              void (*func)(TCGv_i32, TCGv_env,
+                                           TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 a, b;
+
+    nullify_over(ctx);
+    a = load_frw0_i32(ra);
+    b = load_frw0_i32(rb);
+
+    func(a, cpu_env, a, b);
+
+    tcg_temp_free_i32(b);
+    save_frw_i32(rt, a);
+    tcg_temp_free_i32(a);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fop_dedd(DisasContext *ctx, unsigned rt,
+                              unsigned ra, unsigned rb,
+                              void (*func)(TCGv_i64, TCGv_env,
+                                           TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 a, b;
+
+    nullify_over(ctx);
+    a = load_frd0(ra);
+    b = load_frd0(rb);
+
+    func(a, cpu_env, a, b);
+
+    tcg_temp_free_i64(b);
+    save_frd(rt, a);
+    tcg_temp_free_i64(a);
+    return nullify_end(ctx, NO_EXIT);
+}
+
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
 static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
@@ -2893,6 +3063,554 @@ static const DisasInsn table_branch[] = {
     { 0xe800d000u, 0xfc00dffcu, trans_bve },
 };
 
+static ExitStatus trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_wew(ctx, rt, ra, di->f_wew);
+}
+
+static ExitStatus trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = assemble_rt64(insn);
+    unsigned ra = assemble_ra64(insn);
+    return do_fop_wew(ctx, rt, ra, di->f_wew);
+}
+
+static ExitStatus trans_fop_ded(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_ded(ctx, rt, ra, di->f_ded);
+}
+
+static ExitStatus trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_wed(ctx, rt, ra, di->f_wed);
+}
+
+static ExitStatus trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = assemble_rt64(insn);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_wed(ctx, rt, ra, di->f_wed);
+}
+
+static ExitStatus trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_dew(ctx, rt, ra, di->f_dew);
+}
+
+static ExitStatus trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned ra = assemble_ra64(insn);
+    return do_fop_dew(ctx, rt, ra, di->f_dew);
+}
+
+static ExitStatus trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned rb = extract32(insn, 16, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_weww(ctx, rt, ra, rb, di->f_weww);
+}
+
+static ExitStatus trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
+{
+    unsigned rt = assemble_rt64(insn);
+    unsigned rb = assemble_rb64(insn);
+    unsigned ra = assemble_ra64(insn);
+    return do_fop_weww(ctx, rt, ra, rb, di->f_weww);
+}
+
+static ExitStatus trans_fop_dedd(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned rb = extract32(insn, 16, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fop_dedd(ctx, rt, ra, rb, di->f_dedd);
+}
+
+static void gen_fcpy_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+{
+    tcg_gen_mov_i32(dst, src);
+}
+
+static void gen_fcpy_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
+{
+    tcg_gen_mov_i64(dst, src);
+}
+
+static void gen_fabs_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+{
+    tcg_gen_andi_i32(dst, src, INT32_MAX);
+}
+
+static void gen_fabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
+{
+    tcg_gen_andi_i64(dst, src, INT64_MAX);
+}
+
+static void gen_fneg_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+{
+    tcg_gen_xori_i32(dst, src, INT32_MIN);
+}
+
+static void gen_fneg_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
+{
+    tcg_gen_xori_i64(dst, src, INT64_MIN);
+}
+
+static void gen_fnegabs_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+{
+    tcg_gen_ori_i32(dst, src, INT32_MIN);
+}
+
+static void gen_fnegabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
+{
+    tcg_gen_ori_i64(dst, src, INT64_MIN);
+}
+
+static ExitStatus do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
+                            unsigned y, unsigned c)
+{
+    TCGv_i32 ta, tb, tc, ty;
+
+    nullify_over(ctx);
+
+    ta = load_frw0_i32(ra);
+    tb = load_frw0_i32(rb);
+    ty = tcg_const_i32(y);
+    tc = tcg_const_i32(c);
+
+    gen_helper_fcmp_s(cpu_env, ta, tb, ty, tc);
+
+    tcg_temp_free_i32(ta);
+    tcg_temp_free_i32(tb);
+    tcg_temp_free_i32(ty);
+    tcg_temp_free_i32(tc);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned c = extract32(insn, 0, 5);
+    unsigned y = extract32(insn, 13, 3);
+    unsigned rb = extract32(insn, 16, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    return do_fcmp_s(ctx, ra, rb, y, c);
+}
+
+static ExitStatus trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned c = extract32(insn, 0, 5);
+    unsigned y = extract32(insn, 13, 3);
+    unsigned rb = assemble_rb64(insn);
+    unsigned ra = assemble_ra64(insn);
+    return do_fcmp_s(ctx, ra, rb, y, c);
+}
+
+static ExitStatus trans_fcmp_d(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned c = extract32(insn, 0, 5);
+    unsigned y = extract32(insn, 13, 3);
+    unsigned rb = extract32(insn, 16, 5);
+    unsigned ra = extract32(insn, 21, 5);
+    TCGv_i64 ta, tb;
+    TCGv_i32 tc, ty;
+
+    nullify_over(ctx);
+
+    ta = load_frd0(ra);
+    tb = load_frd0(rb);
+    ty = tcg_const_i32(y);
+    tc = tcg_const_i32(c);
+
+    gen_helper_fcmp_d(cpu_env, ta, tb, ty, tc);
+
+    tcg_temp_free_i64(ta);
+    tcg_temp_free_i64(tb);
+    tcg_temp_free_i32(ty);
+    tcg_temp_free_i32(tc);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_ftest_t(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned y = extract32(insn, 13, 3);
+    unsigned cbit = (y ^ 1) - 1;
+    TCGv t;
+
+    nullify_over(ctx);
+
+    t = tcg_temp_new();
+    tcg_gen_ld32u_tl(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
+    tcg_gen_extract_tl(t, t, 21 - cbit, 1);
+    ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+    tcg_temp_free(t);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_ftest_q(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
+{
+    unsigned c = extract32(insn, 0, 5);
+    int mask;
+    bool inv = false;
+    TCGv t;
+
+    nullify_over(ctx);
+
+    t = tcg_temp_new();
+    tcg_gen_ld32u_tl(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
+
+    switch (c) {
+    case 0: /* simple */
+        tcg_gen_andi_tl(t, t, 0x4000000);
+        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+        goto done;
+    case 2: /* rej */
+        inv = true;
+        /* fallthru */
+    case 1: /* acc */
+        mask = 0x43ff800;
+        break;
+    case 6: /* rej8 */
+        inv = true;
+        /* fallthru */
+    case 5: /* acc8 */
+        mask = 0x43f8000;
+        break;
+    case 9: /* acc6 */
+        mask = 0x43e0000;
+        break;
+    case 13: /* acc4 */
+        mask = 0x4380000;
+        break;
+    case 17: /* acc2 */
+        mask = 0x4200000;
+        break;
+    default:
+        return gen_illegal(ctx);
+    }
+    if (inv) {
+        TCGv c = load_const(ctx, mask);
+        tcg_gen_or_tl(t, t, c);
+        ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+    } else {
+        tcg_gen_andi_tl(t, t, mask);
+        ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+    }
+ done:
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_xmpyu(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned rb = assemble_rb64(insn);
+    unsigned ra = assemble_ra64(insn);
+    TCGv_i64 a, b;
+
+    nullify_over(ctx);
+
+    a = load_frw0_i64(ra);
+    b = load_frw0_i64(rb);
+    tcg_gen_mul_i64(a, a, b);
+    save_frd(rt, a);
+    tcg_temp_free_i64(a);
+    tcg_temp_free_i64(b);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+#define FOP_DED  trans_fop_ded, .f_ded
+#define FOP_DEDD trans_fop_dedd, .f_dedd
+
+#define FOP_WEW  trans_fop_wew_0c, .f_wew
+#define FOP_DEW  trans_fop_dew_0c, .f_dew
+#define FOP_WED  trans_fop_wed_0c, .f_wed
+#define FOP_WEWW trans_fop_weww_0c, .f_weww
+
+static const DisasInsn table_float_0c[] = {
+    /* floating point class zero */
+    { 0x30004000, 0xfc1fffe0, FOP_WEW = gen_fcpy_s },
+    { 0x30006000, 0xfc1fffe0, FOP_WEW = gen_fabs_s },
+    { 0x30008000, 0xfc1fffe0, FOP_WEW = gen_helper_fsqrt_s },
+    { 0x3000a000, 0xfc1fffe0, FOP_WEW = gen_helper_frnd_s },
+    { 0x3000c000, 0xfc1fffe0, FOP_WEW = gen_fneg_s },
+    { 0x3000e000, 0xfc1fffe0, FOP_WEW = gen_fnegabs_s },
+
+    { 0x30004800, 0xfc1fffe0, FOP_DED = gen_fcpy_d },
+    { 0x30006800, 0xfc1fffe0, FOP_DED = gen_fabs_d },
+    { 0x30008800, 0xfc1fffe0, FOP_DED = gen_helper_fsqrt_d },
+    { 0x3000a800, 0xfc1fffe0, FOP_DED = gen_helper_frnd_d },
+    { 0x3000c800, 0xfc1fffe0, FOP_DED = gen_fneg_d },
+    { 0x3000e800, 0xfc1fffe0, FOP_DED = gen_fnegabs_d },
+
+    /* floating point class three */
+    { 0x30000600, 0xfc00ffe0, FOP_WEWW = gen_helper_fadd_s },
+    { 0x30002600, 0xfc00ffe0, FOP_WEWW = gen_helper_fsub_s },
+    { 0x30004600, 0xfc00ffe0, FOP_WEWW = gen_helper_fmpy_s },
+    { 0x30006600, 0xfc00ffe0, FOP_WEWW = gen_helper_fdiv_s },
+
+    { 0x30000e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fadd_d },
+    { 0x30002e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fsub_d },
+    { 0x30004e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fmpy_d },
+    { 0x30006e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fdiv_d },
+
+    /* floating point class one */
+    /* float/float */
+    { 0x30000a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_s },
+    { 0x30002200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_d },
+    /* int/float */
+    { 0x30008200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_w_s },
+    { 0x30008a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_dw_s },
+    { 0x3000a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_w_d },
+    { 0x3000aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_dw_d },
+    /* float/int */
+    { 0x30010200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_s_w },
+    { 0x30010a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_w },
+    { 0x30012200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_dw },
+    { 0x30012a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_dw },
+    /* float/int truncate */
+    { 0x30018200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_t_s_w },
+    { 0x30018a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_t_d_w },
+    { 0x3001a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_t_s_dw },
+    { 0x3001aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_dw },
+    /* uint/float */
+    { 0x30028200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_uw_s },
+    { 0x30028a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_udw_s },
+    { 0x3002a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_uw_d },
+    { 0x3002aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_udw_d },
+    /* float/uint */
+    { 0x30030200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_s_uw },
+    { 0x30030a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_uw },
+    { 0x30032200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_udw },
+    { 0x30032a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_udw },
+    /* float/uint truncate */
+    { 0x30038200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_t_s_uw },
+    { 0x30038a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_t_d_uw },
+    { 0x3003a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_t_s_udw },
+    { 0x3003aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_udw },
+
+    /* floating point class two */
+    { 0x30000400, 0xfc001fe0, trans_fcmp_s_0c },
+    { 0x30000c00, 0xfc001fe0, trans_fcmp_d },
+    { 0x30002420, 0xffffffe0, trans_ftest_q },
+    { 0x30000420, 0xffff1fff, trans_ftest_t },
+
+    /* FID.  Note that ra == rt == 0, which via fcpy puts 0 into fr0.
+       This is machine/revision == 0, which is reserved for simulator.  */
+    { 0x30000000, 0xffffffff, FOP_WEW = gen_fcpy_s },
+};
+
+#undef FOP_WEW
+#undef FOP_DEW
+#undef FOP_WED
+#undef FOP_WEWW
+#define FOP_WEW  trans_fop_wew_0e, .f_wew
+#define FOP_DEW  trans_fop_dew_0e, .f_dew
+#define FOP_WED  trans_fop_wed_0e, .f_wed
+#define FOP_WEWW trans_fop_weww_0e, .f_weww
+
+static const DisasInsn table_float_0e[] = {
+    /* floating point class zero */
+    { 0x38004000, 0xfc1fff20, FOP_WEW = gen_fcpy_s },
+    { 0x38006000, 0xfc1fff20, FOP_WEW = gen_fabs_s },
+    { 0x38008000, 0xfc1fff20, FOP_WEW = gen_helper_fsqrt_s },
+    { 0x3800a000, 0xfc1fff20, FOP_WEW = gen_helper_frnd_s },
+    { 0x3800c000, 0xfc1fff20, FOP_WEW = gen_fneg_s },
+    { 0x3800e000, 0xfc1fff20, FOP_WEW = gen_fnegabs_s },
+
+    { 0x38004800, 0xfc1fffe0, FOP_DED = gen_fcpy_d },
+    { 0x38006800, 0xfc1fffe0, FOP_DED = gen_fabs_d },
+    { 0x38008800, 0xfc1fffe0, FOP_DED = gen_helper_fsqrt_d },
+    { 0x3800a800, 0xfc1fffe0, FOP_DED = gen_helper_frnd_d },
+    { 0x3800c800, 0xfc1fffe0, FOP_DED = gen_fneg_d },
+    { 0x3800e800, 0xfc1fffe0, FOP_DED = gen_fnegabs_d },
+
+    /* floating point class three */
+    { 0x38000600, 0xfc00ef20, FOP_WEWW = gen_helper_fadd_s },
+    { 0x38002600, 0xfc00ef20, FOP_WEWW = gen_helper_fsub_s },
+    { 0x38004600, 0xfc00ef20, FOP_WEWW = gen_helper_fmpy_s },
+    { 0x38006600, 0xfc00ef20, FOP_WEWW = gen_helper_fdiv_s },
+
+    { 0x38000e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fadd_d },
+    { 0x38002e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fsub_d },
+    { 0x38004e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fmpy_d },
+    { 0x38006e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fdiv_d },
+
+    { 0x38004700, 0xfc00ef60, trans_xmpyu },
+
+    /* floating point class one */
+    /* float/float */
+    { 0x38000a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_s },
+    { 0x38002200, 0xfc1fffc0, FOP_DEW = gen_helper_fcnv_s_d },
+    /* int/float */
+    { 0x38008200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_w_s },
+    { 0x38008a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_dw_s },
+    { 0x3800a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_w_d },
+    { 0x3800aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_dw_d },
+    /* float/int */
+    { 0x38010200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_s_w },
+    { 0x38010a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_w },
+    { 0x38012200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_dw },
+    { 0x38012a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_dw },
+    /* float/int truncate */
+    { 0x38018200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_t_s_w },
+    { 0x38018a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_w },
+    { 0x3801a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_dw },
+    { 0x3801aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_dw },
+    /* uint/float */
+    { 0x38028200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_uw_s },
+    { 0x38028a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_udw_s },
+    { 0x3802a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_uw_d },
+    { 0x3802aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_udw_d },
+    /* float/uint */
+    { 0x38030200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_s_uw },
+    { 0x38030a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_uw },
+    { 0x38032200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_udw },
+    { 0x38032a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_udw },
+    /* float/uint truncate */
+    { 0x38038200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_t_s_uw },
+    { 0x38038a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_uw },
+    { 0x3803a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_udw },
+    { 0x3803aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_udw },
+
+    /* floating point class two */
+    { 0x38000400, 0xfc000f60, trans_fcmp_s_0e },
+    { 0x38000c00, 0xfc001fe0, trans_fcmp_d },
+};
+
+#undef FOP_WEW
+#undef FOP_DEW
+#undef FOP_WED
+#undef FOP_WEWW
+#undef FOP_DED
+#undef FOP_DEDD
+
+/* Convert the fmpyadd single-precision register encodings to standard.  */
+static inline int fmpyadd_s_reg(unsigned r)
+{
+    return (r & 16) * 2 + 16 + (r & 15);
+}
+
+static ExitStatus trans_fmpyadd(DisasContext *ctx, uint32_t insn, bool is_sub)
+{
+    unsigned tm = extract32(insn, 0, 5);
+    unsigned f = extract32(insn, 5, 1);
+    unsigned ra = extract32(insn, 6, 5);
+    unsigned ta = extract32(insn, 11, 5);
+    unsigned rm2 = extract32(insn, 16, 5);
+    unsigned rm1 = extract32(insn, 21, 5);
+
+    nullify_over(ctx);
+
+    /* Independent multiply & add/sub, with undefined behaviour
+       if outputs overlap inputs.  */
+    if (f == 0) {
+        tm = fmpyadd_s_reg(tm);
+        ra = fmpyadd_s_reg(ra);
+        ta = fmpyadd_s_reg(ta);
+        rm2 = fmpyadd_s_reg(rm2);
+        rm1 = fmpyadd_s_reg(rm1);
+        do_fop_weww(ctx, tm, rm1, rm2, gen_helper_fmpy_s);
+        do_fop_weww(ctx, ta, ta, ra,
+                    is_sub ? gen_helper_fsub_s : gen_helper_fadd_s);
+    } else {
+        do_fop_dedd(ctx, tm, rm1, rm2, gen_helper_fmpy_d);
+        do_fop_dedd(ctx, ta, ta, ra,
+                    is_sub ? gen_helper_fsub_d : gen_helper_fadd_d);
+    }
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = assemble_rt64(insn);
+    unsigned neg = extract32(insn, 5, 1);
+    unsigned rm1 = assemble_ra64(insn);
+    unsigned rm2 = assemble_rb64(insn);
+    unsigned ra3 = assemble_rc64(insn);
+    TCGv_i32 a, b, c;
+
+    nullify_over(ctx);
+    a = load_frw0_i32(rm1);
+    b = load_frw0_i32(rm2);
+    c = load_frw0_i32(ra3);
+
+    if (neg) {
+        gen_helper_fmpynfadd_s(a, cpu_env, a, b, c);
+    } else {
+        gen_helper_fmpyfadd_s(a, cpu_env, a, b, c);
+    }
+
+    tcg_temp_free_i32(b);
+    tcg_temp_free_i32(c);
+    save_frw_i32(rt, a);
+    tcg_temp_free_i32(a);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned neg = extract32(insn, 5, 1);
+    unsigned rm1 = extract32(insn, 21, 5);
+    unsigned rm2 = extract32(insn, 16, 5);
+    unsigned ra3 = assemble_rc64(insn);
+    TCGv_i64 a, b, c;
+
+    nullify_over(ctx);
+    a = load_frd0(rm1);
+    b = load_frd0(rm2);
+    c = load_frd0(ra3);
+
+    if (neg) {
+        gen_helper_fmpynfadd_d(a, cpu_env, a, b, c);
+    } else {
+        gen_helper_fmpyfadd_d(a, cpu_env, a, b, c);
+    }
+
+    tcg_temp_free_i64(b);
+    tcg_temp_free_i64(c);
+    save_frd(rt, a);
+    tcg_temp_free_i64(a);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_fp_fused[] = {
+    { 0xb8000000u, 0xfc000800u, trans_fmpyfadd_s },
+    { 0xb8000800u, 0xfc0019c0u, trans_fmpyfadd_d }
+};
+
 static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
                                       const DisasInsn table[], size_t n)
 {
@@ -2921,6 +3639,8 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return translate_table(ctx, insn, table_arith_log);
     case 0x03:
         return translate_table(ctx, insn, table_index_mem);
+    case 0x06:
+        return trans_fmpyadd(ctx, insn, false);
     case 0x08:
         return trans_ldil(ctx, insn);
     case 0x09:
@@ -2929,8 +3649,12 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_addil(ctx, insn);
     case 0x0B:
         return trans_copr_dw(ctx, insn);
+    case 0x0C:
+        return translate_table(ctx, insn, table_float_0c);
     case 0x0D:
         return trans_ldo(ctx, insn);
+    case 0x0E:
+        return translate_table(ctx, insn, table_float_0e);
 
     case 0x10:
         return trans_load(ctx, insn, false, MO_UB);
@@ -2969,6 +3693,8 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_cmpiclr(ctx, insn);
     case 0x25:
         return trans_subi(ctx, insn);
+    case 0x26:
+        return trans_fmpyadd(ctx, insn, true);
     case 0x27:
         return trans_cmpb(ctx, insn, true, false, true);
     case 0x28:
@@ -2982,6 +3708,8 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     case 0x2C:
     case 0x2D:
         return trans_addi(ctx, insn);
+    case 0x2E:
+        return translate_table(ctx, insn, table_fp_fused);
     case 0x2F:
         return trans_cmpb(ctx, insn, false, false, true);
 
-- 
2.9.3
