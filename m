Received: from eggs.gnu.org ([2001:4830:134:3::10]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32le-0002e9-Sw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32ld-0006ed-8b
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:58 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:49855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lc-0006e3-Vf
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:57 -0400
Received: by mail-wm0-x22d.google.com with SMTP id b189so22390434wmd.4
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:25 +0100
Message-Id: <20171013162438.32458-18-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 17/30] target/arm/translate-a64.c: add FP16
 FMULX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.c    | 18 ++++++++++++++++++
 target/arm/helper-a64.h    |  1 +
 target/arm/translate-a64.c | 45 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 8ef15c4c45..dd26675d5c 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -559,3 +559,21 @@ ADVSIMD_HALFOP(min)
 ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
 ADVSIMD_HALFOP(maxnum)
+
+/* Data processing - scalar floating-point and advanced SIMD */
+
+float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float16_squash_input_denormal(a, fpst);
+    b = float16_squash_input_denormal(b, fpst);
+
+    if ((float16_is_zero(a) && float16_is_infinity(b)) ||
+        (float16_is_infinity(a) && float16_is_zero(b))) {
+        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
+        return make_float16((1U << 14) |
+                            ((float16_val(a) ^ float16_val(b)) & (1U << 15)));
+    }
+    return float16_mul(a, b, fpst);
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a4ce87970e..0f97eb607f 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -52,3 +52,4 @@ DEF_HELPER_3(advsimd_maxh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f687bab214..d12106695f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10648,7 +10648,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x9: /* FMUL, FMULX */
-        if (!extract32(size, 1, 1)) {
+        if (!extract32(size, 1, 1) && !arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
             unallocated_encoding(s);
             return;
         }
@@ -10660,18 +10660,30 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        /* low bit of size indicates single/double */
-        size = extract32(size, 0, 1) ? 3 : 2;
-        if (size == 2) {
+        /* convert insn encoded size to TCGMemOp size */
+        switch (size) {
+        case 0: /* half-precision */
+            size = MO_16;
+            index = h << 2 | l << 1 | m;
+            break;
+        case 2: /* single precision */
+            size = MO_32;
             index = h << 1 | l;
-        } else {
+            rm |= (m << 4);
+            break;
+        case 3: /* double precision */
+            size = MO_64;
             if (l || !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             index = h;
+            rm |= (m << 4);
+            break;
+        default:
+            g_assert_not_reached();
+            break;
         }
-        rm |= (m << 4);
     } else {
         switch (size) {
         case 1:
@@ -10805,10 +10817,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
                 break;
             case 0x9: /* FMUL, FMULX */
-                if (u) {
-                    gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
-                } else {
-                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
+                switch (size) {
+                case 1:
+                    if (u) {
+                        gen_helper_advsimd_mulxh(tcg_res, tcg_op, tcg_idx, fpst);
+                    } else {
+                        g_assert_not_reached();
+                    }
+                    break;
+                case 2:
+                    if (u) {
+                        gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
+                    } else {
+                        gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
+                    }
+                    break;
+                default:
+                    g_assert_not_reached();
                 }
                 break;
             case 0xc: /* SQDMULH */
-- 
2.14.1
