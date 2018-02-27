Received: from eggs.gnu.org ([2001:4830:134:3::10]:56014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPT-0003mm-Ez
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPS-00084l-2Z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:15 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPR-000845-Ns
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:13 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so15916780wmt.5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:39:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:36 +0000
Message-Id: <20180227143852.11175-16-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/31] arm/translate-a64: add FP16 x2 ops
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
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

A bunch of the vectorised bitwise operations just operate on larger
chunks at a time. We can do the same for the new half-precision
operations by introducing some TWOHALFOP helpers which work on each
half of a pair of half-precision operations at once.

Hopefully all this hoop jumping will get simpler once we have
generically vectorised helpers here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - checkpatch fixes
---
 target/arm/helper-a64.c    | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/helper-a64.h    | 10 ++++++++++
 target/arm/translate-a64.c | 26 +++++++++++++++++++++-----
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 8fdbe034f3..4d5ae96d8f 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -629,8 +629,32 @@ ADVSIMD_HALFOP(max)
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
 
@@ -646,6 +670,9 @@ float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
     return float16_mul(a, b, fpst);
 }
 
+ADVSIMD_HALFOP(mulx)
+ADVSIMD_TWOHALFOP(mulx)
+
 /* fused multiply-accumulate */
 float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
 {
@@ -653,6 +680,23 @@ float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
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
index 79012eee9d..003ffa582f 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -65,3 +65,13 @@ DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, ptr)
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6a264bc134..3487c0430f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11417,8 +11417,13 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                          * multiply-add */
                         tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
                     }
-                    gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
-                                               tcg_res, fpst);
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
@@ -11437,10 +11442,21 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 switch (size) {
                 case 1:
                     if (u) {
-                        gen_helper_advsimd_mulxh(tcg_res, tcg_op, tcg_idx,
-                                                 fpst);
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
