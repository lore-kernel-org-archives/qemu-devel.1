Received: from eggs.gnu.org ([2001:4830:134:3::10]:32880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29p-0004fh-Sh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29o-00015Q-63
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:17 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:40867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29n-00013g-Su
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:16 -0400
Received: by mail-pl0-x233.google.com with SMTP id t6-v6so413524plo.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:24 -0700
Message-Id: <20180627043328.11531-32-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 31/35] target/arm: Implement SVE fp complex
 multiply add (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Enhance the existing helpers to support SVE, which takes the
index from each 128-bit segment.  The change has no effect
for AdvSIMD, since there is only one such segment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 23 ++++++++++++++++++
 target/arm/vec_helper.c    | 50 +++++++++++++++++++++++---------------
 target/arm/sve.decode      |  6 +++++
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7ce3222158..4f2152fb70 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4005,6 +4005,29 @@ static bool trans_FCMLA_zpzzz(DisasContext *s,
     return true;
 }
 
+static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_fcmlah_idx,
+        gen_helper_gvec_fcmlas_idx,
+    };
+
+    tcg_debug_assert(a->esz == 1 || a->esz == 2);
+    tcg_debug_assert(a->rd == a->ra);
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz,
+                           a->index * 4 + a->rot,
+                           fns[a->esz - 1]);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Unary Operations Prediated Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 8f2dc4b989..db5aeb9f24 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -319,22 +319,27 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
-    uintptr_t i;
-    float16 e1 = m[H2(2 * index + flip)];
-    float16 e3 = m[H2(2 * index + 1 - flip)];
+    intptr_t elements = opr_sz / sizeof(float16);
+    intptr_t eltspersegment = 16 / sizeof(float16);
+    intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 15;
     neg_imag <<= 15;
-    e1 ^= neg_real;
-    e3 ^= neg_imag;
 
-    for (i = 0; i < opr_sz / 2; i += 2) {
-        float16 e2 = n[H2(i + flip)];
-        float16 e4 = e2;
+    for (i = 0; i < elements; i += eltspersegment) {
+        float16 mr = m[H2(i + 2 * index + 0)];
+        float16 mi = m[H2(i + 2 * index + 1)];
+        float16 e1 = neg_real ^ (flip ? mi : mr);
+        float16 e3 = neg_imag ^ (flip ? mr : mi);
 
-        d[H2(i)] = float16_muladd(e2, e1, d[H2(i)], 0, fpst);
-        d[H2(i + 1)] = float16_muladd(e4, e3, d[H2(i + 1)], 0, fpst);
+        for (j = i; j < i + eltspersegment; j += 2) {
+            float16 e2 = n[H2(j + flip)];
+            float16 e4 = e2;
+
+            d[H2(j)] = float16_muladd(e2, e1, d[H2(j)], 0, fpst);
+            d[H2(j + 1)] = float16_muladd(e4, e3, d[H2(j + 1)], 0, fpst);
+        }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -380,22 +385,27 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
-    uintptr_t i;
-    float32 e1 = m[H4(2 * index + flip)];
-    float32 e3 = m[H4(2 * index + 1 - flip)];
+    intptr_t elements = opr_sz / sizeof(float32);
+    intptr_t eltspersegment = 16 / sizeof(float32);
+    intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 31;
     neg_imag <<= 31;
-    e1 ^= neg_real;
-    e3 ^= neg_imag;
 
-    for (i = 0; i < opr_sz / 4; i += 2) {
-        float32 e2 = n[H4(i + flip)];
-        float32 e4 = e2;
+    for (i = 0; i < elements; i += eltspersegment) {
+        float32 mr = m[H4(i + 2 * index + 0)];
+        float32 mi = m[H4(i + 2 * index + 1)];
+        float32 e1 = neg_real ^ (flip ? mi : mr);
+        float32 e3 = neg_imag ^ (flip ? mr : mi);
 
-        d[H4(i)] = float32_muladd(e2, e1, d[H4(i)], 0, fpst);
-        d[H4(i + 1)] = float32_muladd(e4, e3, d[H4(i + 1)], 0, fpst);
+        for (j = i; j < i + eltspersegment; j += 2) {
+            float32 e2 = n[H4(j + flip)];
+            float32 e4 = e2;
+
+            d[H4(j)] = float32_muladd(e2, e1, d[H4(j)], 0, fpst);
+            d[H4(j + 1)] = float32_muladd(e4, e3, d[H4(j + 1)], 0, fpst);
+        }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e342cfdf14..62365ed90f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -733,6 +733,12 @@ FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
 FCMLA_zpzzz     01100100 esz:2 0 rm:5 0 rot:2 pg:3 rn:5 rd:5 \
                 ra=%reg_movprfx
 
+# SVE floating-point complex multiply-add (indexed)
+FCMLA_zzxz      01100100 10 1 index:2 rm:3 0001 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx esz=1
+FCMLA_zzxz      01100100 11 1 index:1 rm:4 0001 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx esz=2
+
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
-- 
2.17.1
