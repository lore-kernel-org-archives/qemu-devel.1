Received: from eggs.gnu.org ([2001:4830:134:3::10]:39524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooT-0004uH-5T
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooS-0003Ut-Bq
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:05 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooS-0003UV-5W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:04 -0400
Received: by mail-pl0-x235.google.com with SMTP id a7-v6so758236plp.3
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:55:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:54 -1000
Message-Id: <20180621015359.12018-31-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 30/35] target/arm: Pass index to AdvSIMD
 FCMLA (indexed)
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

The original commit failed to pass, or use, the index.

Fixes: d17b7cdcf4ea
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 21 ++++++++++++---------
 target/arm/vec_helper.c    | 10 ++++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8d8a4cecb0..038e48278f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12669,15 +12669,18 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
     case 0x17: /* FCMLA #270 */
-        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                           vec_full_reg_offset(s, rn),
-                           vec_reg_offset(s, rm, index, size), fpst,
-                           is_q ? 16 : 8, vec_full_reg_size(s),
-                           extract32(insn, 13, 2), /* rot */
-                           size == MO_64
-                           ? gen_helper_gvec_fcmlas_idx
-                           : gen_helper_gvec_fcmlah_idx);
-        tcg_temp_free_ptr(fpst);
+        {
+            int rot = extract32(insn, 13, 2);
+            int data = index * 4 + rot;
+            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_reg_offset(s, rm, index, size), fpst,
+                               is_q ? 16 : 8, vec_full_reg_size(s), data,
+                               size == MO_64
+                               ? gen_helper_gvec_fcmlas_idx
+                               : gen_helper_gvec_fcmlah_idx);
+            tcg_temp_free_ptr(fpst);
+        }
         return;
     }
 
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 073e5c58e7..8f2dc4b989 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -317,10 +317,11 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     uintptr_t i;
-    float16 e1 = m[H2(flip)];
-    float16 e3 = m[H2(1 - flip)];
+    float16 e1 = m[H2(2 * index + flip)];
+    float16 e3 = m[H2(2 * index + 1 - flip)];
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 15;
@@ -377,10 +378,11 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     uintptr_t i;
-    float32 e1 = m[H4(flip)];
-    float32 e3 = m[H4(1 - flip)];
+    float32 e1 = m[H4(2 * index + flip)];
+    float32 e3 = m[H4(2 * index + 1 - flip)];
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 31;
-- 
2.17.1
