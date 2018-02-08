Received: from eggs.gnu.org ([2001:4830:134:3::10]:54308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3R-0003OL-9z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3P-0006ms-UD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:13 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3P-0006k9-Ns
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:11 -0500
Received: by mail-wr0-x242.google.com with SMTP id 41so5553179wrc.9
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:35 +0000
Message-Id: <20180208173157.24705-11-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/32] arm/translate-a64: add FP16
 FADD/FABD/FSUB/FMUL/FDIV to simd_three_reg_same_fp16
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

The fprintf is only there for debugging as the skeleton is added to,
it will be removed once the skeleton is complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
 - add absh helper
 - fix checkpatch violation
---
 target/arm/helper-a64.c    |  9 +++++++++
 target/arm/helper-a64.h    |  5 +++++
 target/arm/translate-a64.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index fddd5d242b..25e45121af 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -579,6 +579,11 @@ uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
 
 #define ADVSIMD_HELPER(name, suffix) HELPER(glue(glue(advsimd_, name), suffix))
 
+float16 ADVSIMD_HELPER(abs, h) (float16 a)
+{
+    return float16_abs(a);
+}
+
 #define ADVSIMD_HALFOP(name) \
 float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
 { \
@@ -586,6 +591,10 @@ float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
     return float16_ ## name(a, b, fpst);    \
 }
 
+ADVSIMD_HALFOP(add)
+ADVSIMD_HALFOP(sub)
+ADVSIMD_HALFOP(mul)
+ADVSIMD_HALFOP(div)
 ADVSIMD_HALFOP(min)
 ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index b69a557241..5cbabcc27a 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -48,6 +48,11 @@ DEF_HELPER_FLAGS_4(paired_cmpxchg64_le_parallel, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be_parallel, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64)
+DEF_HELPER_1(advsimd_absh, f16, f16)
+DEF_HELPER_3(advsimd_addh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_subh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_mulh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_divh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5392f83794..93d71d8b2c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9849,6 +9849,34 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
+            gen_helper_advsimd_absh(tcg_res, tcg_res);
+            break;
         default:
             fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
                     __func__, insn, fpopcode, s->pc);
-- 
2.15.1
