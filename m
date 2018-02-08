Received: from eggs.gnu.org ([2001:4830:134:3::10]:57600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBb-00037X-Js
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBZ-0000Zp-Nj
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:39 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejqBZ-0000YP-CB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:37 -0500
Received: by mail-wr0-x243.google.com with SMTP id f6so5595206wra.6
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:40:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:41 +0000
Message-Id: <20180208173157.24705-17-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/32] arm/translate-a64: add FP16 x2 ops
 for simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

A bunch of the vectorised bitwise operations just operate on larger
chunks at a time. We can do the same for the new half-precision
operations by introducing some TWOHALFOP helpers which work on each
half of a pair of half-precision operations at once.

Hopefully all this hoop jumping will get simpler once we have
generically vectorised helpers here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch fixes
---
 target/arm/helper-a64.c    | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/helper-a64.h    | 10 ++++++++++
 target/arm/translate-a64.c | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 6358b42472..8f0f59ea31 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -634,8 +634,32 @@ ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
 ADVSIMD_HALFOP(maxnum)
 
+#define ADVSIMD_TWOHALFOP(name)                                         \
+uint32_t ADVSIMD_HELPER(name, 2h)(uint32_t two_a, uint32_t two_b, void *fpstp) \
+{ \
+    float16  a1, a2, b1, b2;                        \
+    uint32_t r1, r2;                                \
+    float_status *fpst = fpstp;                     \
+    a1 = extract32(two_a, 0, 16);                   \
+    a2 = extract32(two_a, 16, 16);                  \
+    b1 = extract32(two_b, 0, 16);                   \
+    b2 = extract32(two_b, 16, 16);                  \
+    r1 = float16_ ## name(a1, b1, fpst);            \
+    r2 = float16_ ## name(a2, b2, fpst);            \
+    return deposit32(r1, 16, 16, r2);               \
+}
+
+ADVSIMD_TWOHALFOP(add)
+ADVSIMD_TWOHALFOP(sub)
+ADVSIMD_TWOHALFOP(mul)
+ADVSIMD_TWOHALFOP(div)
+ADVSIMD_TWOHALFOP(min)
+ADVSIMD_TWOHALFOP(max)
+ADVSIMD_TWOHALFOP(minnum)
+ADVSIMD_TWOHALFOP(maxnum)
+
 /* Data processing - scalar floating-point and advanced SIMD */
-float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
+static float16 float16_mulx(float16 a, float16 b, void *fpstp)
 {
     float_status *fpst = fpstp;
 
@@ -651,6 +675,9 @@ float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
     return float16_mul(a, b, fpst);
 }
 
+ADVSIMD_HALFOP(mulx)
+ADVSIMD_TWOHALFOP(mulx)
+
 /* fused multiply-accumulate */
 float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
 {
@@ -658,6 +685,23 @@ float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
     return float16_muladd(a, b, c, 0, fpst);
 }
 
+uint32_t HELPER(advsimd_muladd2h)(uint32_t two_a, uint32_t two_b,
+                                  uint32_t two_c, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16  a1, a2, b1, b2, c1, c2;
+    uint32_t r1, r2;
+    a1 = extract32(two_a, 0, 16);
+    a2 = extract32(two_a, 16, 16);
+    b1 = extract32(two_b, 0, 16);
+    b2 = extract32(two_b, 16, 16);
+    c1 = extract32(two_c, 0, 16);
+    c2 = extract32(two_c, 16, 16);
+    r1 = float16_muladd(a1, b1, c1, 0, fpst);
+    r2 = float16_muladd(a2, b2, c2, 0, fpst);
+    return deposit32(r1, 16, 16, r2);
+}
+
 /*
  * Floating point comparisons produce an integer result. Softfloat
  * routines return float_relation types which we convert to the 0/-1
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index d347f473d4..d2dd46d07b 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -61,6 +61,16 @@ DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
 DEF_HELPER_4(advsimd_muladdh, f16, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_add2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_sub2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_mul2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_div2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_max2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_min2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_maxnum2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_minnum2h, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, ptr)
+DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, ptr)
 DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 83a1fa3116..f01bab801c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10966,21 +10966,31 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             }
             case 0x5: /* FMLS */
             case 0x1: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, is_scalar ? size : MO_32);
+                read_vec_element_i32(s, tcg_res, rd, pass,
+                                     is_scalar ? size : MO_32);
                 switch (size) {
                 case 1:
                     if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for fused multiply-add */
+                        /* As usual for ARM, separate negation for fused
+                         * multiply-add. */
                         tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
                     }
-                    gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
+                    if (is_scalar) {
+                        gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
+                                                   tcg_res, fpst);
+                    } else {
+                        gen_helper_advsimd_muladd2h(tcg_res, tcg_op, tcg_idx,
+                                                    tcg_res, fpst);
+                    }
                     break;
                 case 2:
                     if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for fused multiply-add */
+                        /* As usual for ARM, separate negation for fused
+                         * multiply-add. */
                         tcg_gen_xori_i32(tcg_op, tcg_op, 0x80000000);
                     }
-                    gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
+                    gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx,
+                                           tcg_res, fpst);
                     break;
                 default:
                     g_assert_not_reached();
@@ -10990,9 +11000,21 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 switch (size) {
                 case 1:
                     if (u) {
-                        gen_helper_advsimd_mulxh(tcg_res, tcg_op, tcg_idx, fpst);
+                        if (is_scalar) {
+                            gen_helper_advsimd_mulxh(tcg_res, tcg_op,
+                                                     tcg_idx, fpst);
+                        } else {
+                            gen_helper_advsimd_mulx2h(tcg_res, tcg_op,
+                                                      tcg_idx, fpst);
+                        }
                     } else {
-                        g_assert_not_reached();
+                        if (is_scalar) {
+                            gen_helper_advsimd_mulh(tcg_res, tcg_op,
+                                                    tcg_idx, fpst);
+                        } else {
+                            gen_helper_advsimd_mul2h(tcg_res, tcg_op,
+                                                     tcg_idx, fpst);
+                        }
                     }
                     break;
                 case 2:
-- 
2.15.1
