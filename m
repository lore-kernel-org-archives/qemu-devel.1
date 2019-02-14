Received: from eggs.gnu.org ([209.51.188.92]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu89f-0006hY-9J
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu7wL-00076A-AI
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:43:59 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu7wK-00070G-Vz
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:43:57 -0500
Received: by mail-pl1-x641.google.com with SMTP id r14so2356114pls.12
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 19:43:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 19:43:43 -0800
Message-Id: <20190214034345.24722-3-richard.henderson@linaro.org>
In-Reply-To: <20190214034345.24722-1-richard.henderson@linaro.org>
References: <20190214034345.24722-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] target/arm: Implement FMLAL and FMLSL for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 ++++
 target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 47238e4245..15085a94ff 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3305,6 +3305,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
 }
 
+static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
+}
+
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e002251ac6..d2ee811489 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10891,9 +10891,26 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         if (!fp_access_check(s)) {
             return;
         }
-
         handle_3same_float(s, size, elements, fpopcode, rd, rn, rm);
         return;
+
+    case 0x1d: /* FMLAL  */
+    case 0x3d: /* FMLSL  */
+    case 0x59: /* FMLAL2 */
+    case 0x79: /* FMLSL2 */
+        if (size & 1 || !dc_isar_feature(aa64_fhm, s)) {
+            unallocated_encoding(s);
+            return;
+        }
+        if (fp_access_check(s)) {
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false,
+                              extract32(insn, 29, 1),
+                              extract32(insn, 23, 1)
+                              ? gen_helper_gvec_fmlsl_h
+                              : gen_helper_gvec_fmlal_h);
+        }
+        return;
+
     default:
         unallocated_encoding(s);
         return;
@@ -12724,6 +12741,17 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         is_fp = 2;
         break;
+    case 0x00: /* FMLAL */
+    case 0x04: /* FMLSL */
+    case 0x18: /* FMLAL2 */
+    case 0x1c: /* FMLSL2 */
+        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_fhm, s)) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = MO_16;
+        is_fp = 3;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -12765,6 +12793,9 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 3: /* other fp, size already set and verified. */
+        break;
+
     default: /* integer */
         switch (size) {
         case MO_8:
@@ -12834,6 +12865,22 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             tcg_temp_free_ptr(fpst);
         }
         return;
+
+    case 0x00: /* FMLAL */
+    case 0x04: /* FMLSL */
+    case 0x18: /* FMLAL2 */
+    case 0x1c: /* FMLSL2 */
+        {
+            int data = (index << 1) | u;
+            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm), fpst,
+                               is_q ? 16 : 8, vec_full_reg_size(s), data,
+                               opcode & 4 ? gen_helper_gvec_fmlsl_idx_h
+                               :  gen_helper_gvec_fmlal_idx_h);
+            tcg_temp_free_ptr(fpst);
+        }
+        return;
     }
 
     if (size == 3) {
-- 
2.17.2
