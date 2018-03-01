Received: from eggs.gnu.org ([2001:4830:134:3::10]:33808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-0003j5-FN
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-00087A-QG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJt-00084T-FX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-0000bO-FF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:16 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:38 +0000
Message-Id: <20180301112403.12487-18-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/42] arm/translate-a64: add FP16
 FADD/FABD/FSUB/FMUL/FDIV to simd_three_reg_same_fp16
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

The fprintf is only there for debugging as the skeleton is added to,
it will be removed once the skeleton is complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-10-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  4 ++++
 target/arm/helper-a64.c    |  4 ++++
 target/arm/translate-a64.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index cb2a73124d..bac9469426 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -52,3 +52,7 @@ DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(advsimd_minnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_addh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_subh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_mulh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_divh, f16, f16, f16, ptr)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index fddd5d242b..931a6d3c34 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -586,6 +586,10 @@ float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
     return float16_ ## name(a, b, fpst);    \
 }
 
+ADVSIMD_HALFOP(add)
+ADVSIMD_HALFOP(sub)
+ADVSIMD_HALFOP(mul)
+ADVSIMD_HALFOP(div)
 ADVSIMD_HALFOP(min)
 ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4828457b5b..f8770ee1e9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10283,6 +10283,34 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
         switch (fpopcode) {
+        case 0x0: /* FMAXNM */
+            gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x2: /* FADD */
+            gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x6: /* FMAX */
+            gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x8: /* FMINNM */
+            gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0xa: /* FSUB */
+            gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0xe: /* FMIN */
+            gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x13: /* FMUL */
+            gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x17: /* FDIV */
+            gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x1a: /* FABD */
+            gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+            tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
+            break;
         default:
             fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
                     __func__, insn, fpopcode, s->pc);
-- 
2.16.2
