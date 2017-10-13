Received: from eggs.gnu.org ([2001:4830:134:3::10]:43956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sW-0000Wq-55
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sU-0002Dh-SS
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:04 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:47265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sU-0002D9-LO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:02 -0400
Received: by mail-wm0-x236.google.com with SMTP id t69so22577268wmt.2
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:30 +0100
Message-Id: <20171013162438.32458-23-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 22/30] target/arm/translate-a64.c: add FP16
 FAGCT to AdvSIMD 3 Same
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
 target/arm/helper-a64.c    | 14 +++++++-------
 target/arm/helper-a64.h    |  1 -
 target/arm/translate-a64.c |  3 +++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index b62d77aec4..137866732d 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -609,10 +609,10 @@ uint32_t HELPER(advsimd_acge_f16)(float16 a, float16 b, void *fpstp)
     return -float16_le(f1, f0, fpst);
 }
 
-/* uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp) */
-/* { */
-/*     float_status *fpst = fpstp; */
-/*     float16 f0 = float16_abs(a); */
-/*     float16 f1 = float16_abs(b); */
-/*     return -float16_lt(f1, f0, fpst); */
-/* } */
+uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16 f0 = float16_abs(a);
+    float16 f1 = float16_abs(b);
+    return -float16_lt(f1, f0, fpst);
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 952869f43e..66c4062ea5 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -53,7 +53,6 @@ DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
-
 DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 623b0b3fab..4ad470d9e8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9819,6 +9819,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x27: /* FDIV */
             gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x35: /* FACGT */
+            gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         default:
             fprintf(stderr,"%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
                     __func__, insn, fpopcode, s->pc);
-- 
2.14.1
