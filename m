Received: from eggs.gnu.org ([2001:4830:134:3::10]:49435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFeG-0000w3-B9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFeF-0006Ae-Eb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:52:36 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFeF-0006AB-7U
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:52:35 -0500
Received: by mail-wr0-x241.google.com with SMTP id u49so14554578wrc.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:52:35 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:30 +0000
Message-Id: <20180223153636.29809-26-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 25/31] arm/translate-a64: add FP16 FSQRT to
 simd_two_reg_misc_fp16
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  remove superfluous helpers
---
 target/arm/helper-a64.c    | 13 +++++++++++++
 target/arm/helper-a64.h    |  1 +
 target/arm/translate-a64.c |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 92a0d55a9c..afb25ad20c 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -828,3 +828,16 @@ uint32_t HELPER(advsimd_f16touinth)(float16 a, void *fpstp)
     }
     return float16_to_uint16(a, fpst);
 }
+
+/*
+ * Square Root and Reciprocal square root
+ */
+
+float16 HELPER(sqrt_f16)(float16 a, void *fpstp)
+{
+    float_status *s = fpstp;
+
+    return float16_sqrt(a, s);
+}
+
+
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 339323fc3d..ef4ddfe9d8 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -80,3 +80,4 @@ DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
+DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a7e99e2a2f..ba3926262e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11388,6 +11388,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x6f: /* FNEG */
         need_fpst = false;
         break;
+    case 0x7f: /* FSQRT (vector) */
+        break;
     default:
         fprintf(stderr, "%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
         g_assert_not_reached();
@@ -11502,6 +11504,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x6f: /* FNEG */
                 tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
                 break;
+            case 0x7f: /* FSQRT */
+                gen_helper_sqrt_f16(tcg_res, tcg_op, tcg_fpstatus);
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
2.15.1
