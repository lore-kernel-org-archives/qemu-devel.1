Received: from eggs.gnu.org ([2001:4830:134:3::10]:34021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK6-0003vJ-7T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK5-0008E6-9T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMK5-0008DQ-1X
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK3-0000fm-TM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:54 +0000
Message-Id: <20180301112403.12487-34-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/42] arm/translate-a64: add FP16 FSQRT to
 simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-26-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  1 +
 target/arm/helper-a64.c    | 13 +++++++++++++
 target/arm/translate-a64.c |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 339323fc3d..ef4ddfe9d8 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -80,3 +80,4 @@ DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
+DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 715dc4333d..1096ff48ac 100644
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
2.16.2
