Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2371C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF042078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF042078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67UG-0005I3-Rz
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k67Rk-0001uU-Vf
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:14:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k67Rh-0007eV-Uu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:14:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06614426|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0232365-0.000612012-0.976151;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.IGxBKGW_1597302868; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IGxBKGW_1597302868)
 by smtp.aliyun-inc.com(10.147.41.143);
 Thu, 13 Aug 2020 15:14:29 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] fpu/softfloat: Define operations for bfloat16
Date: Thu, 13 Aug 2020 15:14:19 +0800
Message-Id: <20200813071421.2509-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
References: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:14:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, aurelien@aurel32.net,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements operations for bfloat16 except conversion and some misc
operations. We also add FloatFmt and pack/unpack interfaces for bfloat16.
As they are both static fields, we can't make a sperate patch for them.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c               | 168 ++++++++++++++++++++++++++++++++++
 include/fpu/softfloat-types.h |   5 +
 include/fpu/softfloat.h       |  44 +++++++++
 3 files changed, 217 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 79be4f5840..d4205f92d5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -554,6 +554,10 @@ static const FloatFmt float16_params_ahp = {
     .arm_althp = true
 };
 
+static const FloatFmt bfloat16_params = {
+    FLOAT_PARAMS(8, 7)
+};
+
 static const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
@@ -580,6 +584,11 @@ static inline FloatParts float16_unpack_raw(float16 f)
     return unpack_raw(float16_params, f);
 }
 
+static inline FloatParts bfloat16_unpack_raw(bfloat16 f)
+{
+    return unpack_raw(bfloat16_params, f);
+}
+
 static inline FloatParts float32_unpack_raw(float32 f)
 {
     return unpack_raw(float32_params, f);
@@ -603,6 +612,11 @@ static inline float16 float16_pack_raw(FloatParts p)
     return make_float16(pack_raw(float16_params, p));
 }
 
+static inline bfloat16 bfloat16_pack_raw(FloatParts p)
+{
+    return pack_raw(bfloat16_params, p);
+}
+
 static inline float32 float32_pack_raw(FloatParts p)
 {
     return make_float32(pack_raw(float32_params, p));
@@ -820,6 +834,11 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
+static FloatParts bfloat16_unpack_canonical(bfloat16 f, float_status *s)
+{
+    return sf_canonicalize(bfloat16_unpack_raw(f), &bfloat16_params, s);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts p, float_status *s,
                                              const FloatFmt *params)
 {
@@ -831,6 +850,11 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
     return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
+static bfloat16 bfloat16_round_pack_canonical(FloatParts p, float_status *s)
+{
+    return bfloat16_pack_raw(round_canonical(p, s, &bfloat16_params));
+}
+
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
     return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
@@ -1158,6 +1182,28 @@ float64_sub(float64 a, float64 b, float_status *s)
     return float64_addsub(a, b, s, hard_f64_sub, soft_f64_sub);
 }
 
+/*
+ * Returns the result of adding or subtracting the bfloat16
+ * values `a' and `b'.
+ */
+bfloat16 QEMU_FLATTEN bfloat16_add(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, false, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
+bfloat16 QEMU_FLATTEN bfloat16_sub(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b'. The operation is performed according to the IEC/IEEE Standard
@@ -1260,6 +1306,20 @@ float64_mul(float64 a, float64 b, float_status *s)
                         f64_is_zon2, f64_addsubmul_post);
 }
 
+/*
+ * Returns the result of multiplying the bfloat16
+ * values `a' and `b'.
+ */
+
+bfloat16 QEMU_FLATTEN bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = mul_floats(pa, pb, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b' then adding 'c', with no intermediate rounding step after the
@@ -1642,6 +1702,23 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     return soft_f64_muladd(ua.s, ub.s, uc.s, flags, s);
 }
 
+/*
+ * Returns the result of multiplying the bfloat16 values `a'
+ * and `b' then adding 'c', with no intermediate rounding step after the
+ * multiplication.
+ */
+
+bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
+                                      int flags, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pc = bfloat16_unpack_canonical(c, status);
+    FloatParts pr = muladd_floats(pa, pb, pc, flags, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
@@ -1808,6 +1885,20 @@ float64_div(float64 a, float64 b, float_status *s)
                         f64_div_pre, f64_div_post);
 }
 
+/*
+ * Returns the result of dividing the bfloat16
+ * value `a' by the corresponding value `b'.
+ */
+
+bfloat16 bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = div_floats(pa, pb, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Float to Float conversions
  *
@@ -2847,6 +2938,25 @@ MINMAX(64, maxnummag, false, true, true)
 
 #undef MINMAX
 
+#define BF16_MINMAX(name, ismin, isiee, ismag)                          \
+bfloat16 bfloat16_ ## name(bfloat16 a, bfloat16 b, float_status *s)     \
+{                                                                       \
+    FloatParts pa = bfloat16_unpack_canonical(a, s);                    \
+    FloatParts pb = bfloat16_unpack_canonical(b, s);                    \
+    FloatParts pr = minmax_floats(pa, pb, ismin, isiee, ismag, s);      \
+                                                                        \
+    return bfloat16_round_pack_canonical(pr, s);                        \
+}
+
+BF16_MINMAX(min, true, false, false)
+BF16_MINMAX(minnum, true, true, false)
+BF16_MINMAX(minnummag, true, true, true)
+BF16_MINMAX(max, false, false, false)
+BF16_MINMAX(maxnum, false, true, false)
+BF16_MINMAX(maxnummag, false, true, true)
+
+#undef BF16_MINMAX
+
 /* Floating point compare */
 static FloatRelation compare_floats(FloatParts a, FloatParts b, bool is_quiet,
                                     float_status *s)
@@ -3008,6 +3118,24 @@ FloatRelation float64_compare_quiet(float64 a, float64 b, float_status *s)
     return f64_compare(a, b, true, s);
 }
 
+static int QEMU_FLATTEN
+soft_bf16_compare(bfloat16 a, bfloat16 b, bool is_quiet, float_status *s)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, s);
+    FloatParts pb = bfloat16_unpack_canonical(b, s);
+    return compare_floats(pa, pb, is_quiet, s);
+}
+
+int bfloat16_compare(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return soft_bf16_compare(a, b, false, s);
+}
+
+int bfloat16_compare_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return soft_bf16_compare(a, b, true, s);
+}
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
@@ -3047,6 +3175,13 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pr = scalbn_decomposed(pa, n, status);
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Square Root
  *
@@ -3197,6 +3332,13 @@ float64 QEMU_FLATTEN float64_sqrt(float64 xa, float_status *s)
     return soft_f64_sqrt(ua.s, s);
 }
 
+bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pr = sqrt_float(pa, status, &bfloat16_params);
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated NaN.
 *----------------------------------------------------------------------------*/
@@ -3239,6 +3381,13 @@ float128 float128_default_nan(float_status *status)
     return r;
 }
 
+bfloat16 bfloat16_default_nan(float_status *status)
+{
+    FloatParts p = parts_default_nan(status);
+    p.frac >>= bfloat16_params.frac_shift;
+    return bfloat16_pack_raw(p);
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN from a signalling NaN for the floating point value `a'.
 *----------------------------------------------------------------------------*/
@@ -3270,6 +3419,14 @@ float64 float64_silence_nan(float64 a, float_status *status)
     return float64_pack_raw(p);
 }
 
+bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
+{
+    FloatParts p = bfloat16_unpack_raw(a);
+    p.frac <<= bfloat16_params.frac_shift;
+    p = parts_silence_nan(p, status);
+    p.frac >>= bfloat16_params.frac_shift;
+    return bfloat16_pack_raw(p);
+}
 
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
@@ -3319,6 +3476,17 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
     return a;
 }
 
+bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = bfloat16_unpack_raw(a);
+        if (parts_squash_denormal(p, status)) {
+            return bfloat16_set_sign(bfloat16_zero, p.sign);
+        }
+    }
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 7680193ebc..3a3bf55631 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -112,6 +112,11 @@ typedef struct {
 #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
 #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
 
+/*
+ * Software neural-network floating-point types.
+ */
+typedef uint16_t bfloat16;
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 659218b5c7..198f954e4d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -239,6 +239,37 @@ bool float16_is_quiet_nan(float16, float_status *status);
 bool float16_is_signaling_nan(float16, float_status *status);
 float16 float16_silence_nan(float16, float_status *status);
 
+/*----------------------------------------------------------------------------
+| Software bfloat16 operations.
+*----------------------------------------------------------------------------*/
+
+bfloat16 bfloat16_add(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_sub(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_mul(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_div(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_muladd(bfloat16, bfloat16, bfloat16, int,
+                         float_status *status);
+float16 bfloat16_scalbn(bfloat16, int, float_status *status);
+bfloat16 bfloat16_min(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_max(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_minnum(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_maxnum(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_minnummag(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_maxnummag(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_sqrt(bfloat16, float_status *status);
+int bfloat16_compare(bfloat16, bfloat16, float_status *status);
+int bfloat16_compare_quiet(bfloat16, bfloat16, float_status *status);
+int bfloat16_unordered_quiet(bfloat16, bfloat16, float_status *status);
+int bfloat16_le(bfloat16, bfloat16, float_status *status);
+int bfloat16_lt(bfloat16, bfloat16, float_status *status);
+int bfloat16_eq_quiet(bfloat16, bfloat16, float_status *status);
+
+int bfloat16_is_quiet_nan(bfloat16, float_status *status);
+int bfloat16_is_signaling_nan(bfloat16, float_status *status);
+bfloat16 bfloat16_silence_nan(bfloat16, float_status *status);
+bfloat16 bfloat16_default_nan(float_status *status);
+bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
+
 static inline bool float16_is_any_nan(float16 a)
 {
     return ((float16_val(a) & ~0x8000) > 0x7c00);
@@ -293,6 +324,19 @@ static inline float16 float16_set_sign(float16 a, int sign)
 #define float16_three make_float16(0x4200)
 #define float16_infinity make_float16(0x7c00)
 
+static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
+{
+    return (a & 0x7fff) | (sign << 15);
+}
+
+#define bfloat16_zero 0
+#define bfloat16_half 0x3f00
+#define bfloat16_one 0x3f80
+#define bfloat16_one_point_five 0x3fc0
+#define bfloat16_two 0x4000
+#define bfloat16_three 0x4040
+#define bfloat16_infinity 0x7f80
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.23.0


