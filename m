Received: from eggs.gnu.org ([209.51.188.92]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZE-0001dL-Ox
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZA-0004Kv-VG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJZ7-0004DL-9G
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:25 -0500
Received: by mail-wm1-x336.google.com with SMTP id y15so8529936wma.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:32 +0000
Message-Id: <20190228110835.16159-14-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/16] target/arm: Implement FMLAL and FMLSL for
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219222952.22183-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  5 ++++
 target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3e545a2b146..8f52914649d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3404,6 +3404,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
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
index c56e878787c..d3c8eaf0893 100644
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
2.20.1
