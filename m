Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e332C-0000U6-VC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e3329-0001hB-2Q
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:42:05 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:54073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e3328-0001gI-S5
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:42:01 -0400
Received: by mail-wr0-x229.google.com with SMTP id y44so1456830wry.10
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:42:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:24 +0100
Message-Id: <20171013162438.32458-17-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 16/30] target/arm/translate-a64.c: add FP16
 FADD/FMUL/FDIV to AdvSIMD 3 Same (!sub)
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

The fprintf is only there for debugging as the skeleton is added to,
it will be removed once the skeleton is complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.c    |  4 ++++
 target/arm/helper-a64.h    |  4 ++++
 target/arm/translate-a64.c | 12 +++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index a0c20faabc..8ef15c4c45 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -551,6 +551,10 @@ float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
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
index b774431f1f..a4ce87970e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -44,6 +44,10 @@ DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_le, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+DEF_HELPER_3(advsimd_addh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_subh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_mulh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_divh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5e531b3ae4..f687bab214 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9806,8 +9806,18 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
         switch (fpopcode) {
+        case 0x2: /* FADD */
+            gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x23: /* FMUL */
+            gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x27: /* FDIV */
+            gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         default:
-            fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpopcode);
+            fprintf(stderr,"%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
+                    __func__, insn, fpopcode, s->pc);
             g_assert_not_reached();
         }
 
-- 
2.14.1
