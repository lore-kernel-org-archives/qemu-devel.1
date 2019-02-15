Received: from eggs.gnu.org ([209.51.188.92]:33354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4t-0005O9-4E
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4s-0003Is-90
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:15 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guj4s-0003GJ-2c
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:14 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so5410696plb.5
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:23:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Feb 2019 11:23:00 -0800
Message-Id: <20190215192302.27855-7-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-1-richard.henderson@linaro.org>
References: <20190215192302.27855-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 6/8] target/arm: Implement FMLAL and FMLSL
 for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 ++++
 target/arm/translate-a64.c | 50 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1eea1a408b..69589573e4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3356,6 +3356,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
 }
 
+static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c56e878787..9a4c561982 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10917,9 +10917,26 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
+            int is_s = extract32(insn, 23, 1);
+            int is_2 = extract32(insn, 29, 1);
+            int data = (is_2 << 1) | is_s;
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, data,
+                              gen_helper_gvec_fmlal_h);
+        }
+        return;
+
     default:
         unallocated_encoding(s);
         return;
@@ -12739,6 +12756,17 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
@@ -12780,6 +12808,9 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 3: /* other fp, size already set and verified. */
+        break;
+
     default: /* integer */
         switch (size) {
         case MO_8:
@@ -12849,6 +12880,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             tcg_temp_free_ptr(fpst);
         }
         return;
+
+    case 0x00: /* FMLAL */
+    case 0x04: /* FMLSL */
+    case 0x18: /* FMLAL2 */
+    case 0x1c: /* FMLSL2 */
+        {
+            int is_s = extract32(opcode, 2, 1);
+            int is_2 = u;
+            int data = (index << 2) | (is_2 << 1) | is_s;
+            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm), fpst,
+                               is_q ? 16 : 8, vec_full_reg_size(s), data,
+                               gen_helper_gvec_fmlal_idx_h);
+            tcg_temp_free_ptr(fpst);
+        }
+        return;
     }
 
     if (size == 3) {
-- 
2.17.2
