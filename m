Received: from eggs.gnu.org ([209.51.188.92]:45891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDtw-0000Km-A9
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDts-0002VF-Mh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:06 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwDtq-0002SG-St
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:04 -0500
Received: by mail-pf1-x441.google.com with SMTP id j5so6379710pfa.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:29:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:29:49 -0800
Message-Id: <20190219222952.22183-3-richard.henderson@linaro.org>
In-Reply-To: <20190219222952.22183-1-richard.henderson@linaro.org>
References: <20190219222952.22183-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 2/5] target/arm: Implement FMLAL and FMLSL
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
 target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

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
index c56e878787..d3c8eaf089 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10917,9 +10917,29 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
+            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm), cpu_env,
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               data, gen_helper_gvec_fmlal_a64);
+        }
+        return;
+
     default:
         unallocated_encoding(s);
         return;
@@ -12739,6 +12759,17 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
+        /* is_fp, but we pass cpu_env not fp_status.  */
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -12849,6 +12880,22 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
+                               vec_full_reg_offset(s, rm), cpu_env,
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               data, gen_helper_gvec_fmlal_idx_a64);
+        }
+        return;
     }
 
     if (size == 3) {
-- 
2.17.2
