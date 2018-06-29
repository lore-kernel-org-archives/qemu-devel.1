Received: from eggs.gnu.org ([2001:4830:134:3::10]:34143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun0-0007hE-OX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumz-0007MV-H7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumz-0007Hs-7u
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumy-0004k8-3K
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:29 +0100
Message-Id: <20180629145347.652-38-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/55] target/arm: Implement SVE fp complex
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

From: Richard Henderson <richard.henderson@linaro.org>

Enhance the existing helpers to support SVE, which takes the
index from each 128-bit segment.  The change has no effect
for AdvSIMD, since there is only one such segment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180627043328.11531-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 23 ++++++++++++++++++
 target/arm/vec_helper.c    | 50 +++++++++++++++++++++++---------------
 target/arm/sve.decode      |  6 +++++
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c47bcec5349..7912bceb1e0 100644
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
  *** SVE Floating Point Unary Operations Predicated Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 8f2dc4b9893..db5aeb9f24f 100644
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
index e342cfdf146..62365ed90f6 100644
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
