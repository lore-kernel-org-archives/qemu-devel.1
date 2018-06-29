Received: from eggs.gnu.org ([2001:4830:134:3::10]:34156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun1-0007iW-Ho
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun0-0007P1-DH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun0-0007Me-3s
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumz-0004kn-3N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:30 +0100
Message-Id: <20180629145347.652-39-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 38/55] target/arm: Implement SVE dot product
 (vectors)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-33-richard.henderson@linaro.org
[PMM: moved 'ra=%reg_movprfx' here from following patch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  5 +++
 target/arm/translate-sve.c | 17 ++++++++++
 target/arm/vec_helper.c    | 67 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  3 ++
 4 files changed, 92 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8607077ddaf..e23ce7ff197 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -583,6 +583,11 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7912bceb1e0..cf9c652e54e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3423,6 +3423,23 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
+static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[2][2] = {
+        { gen_helper_gvec_sdot_b, gen_helper_gvec_sdot_h },
+        { gen_helper_gvec_udot_b, gen_helper_gvec_udot_h }
+    };
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, fns[a->u][a->sz]);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index db5aeb9f24f..c16a30c3b5b 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -194,6 +194,73 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+/* Integer 8 and 16-bit dot-product.
+ *
+ * Note that for the loops herein, host endianness does not matter
+ * with respect to the ordering of data within the 64-bit lanes.
+ * All elements are treated equally, no matter where they are.
+ */
+
+void HELPER(gvec_sdot_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd;
+    int8_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] += n[i * 4 + 0] * m[i * 4 + 0]
+              + n[i * 4 + 1] * m[i * 4 + 1]
+              + n[i * 4 + 2] * m[i * 4 + 2]
+              + n[i * 4 + 3] * m[i * 4 + 3];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd;
+    uint8_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] += n[i * 4 + 0] * m[i * 4 + 0]
+              + n[i * 4 + 1] * m[i * 4 + 1]
+              + n[i * 4 + 2] * m[i * 4 + 2]
+              + n[i * 4 + 3] * m[i * 4 + 3];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sdot_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd;
+    int16_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] += (int64_t)n[i * 4 + 0] * m[i * 4 + 0]
+              + (int64_t)n[i * 4 + 1] * m[i * 4 + 1]
+              + (int64_t)n[i * 4 + 2] * m[i * 4 + 2]
+              + (int64_t)n[i * 4 + 3] * m[i * 4 + 3];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd;
+    uint16_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] += (uint64_t)n[i * 4 + 0] * m[i * 4 + 0]
+              + (uint64_t)n[i * 4 + 1] * m[i * 4 + 1]
+              + (uint64_t)n[i * 4 + 2] * m[i * 4 + 2]
+              + (uint64_t)n[i * 4 + 3] * m[i * 4 + 3];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          void *vfpst, uint32_t desc)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 62365ed90f6..7b7b29ae640 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -725,6 +725,9 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+# SVE integer dot product (unpredicated)
+DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx
+
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
                 rn=%reg_movprfx
-- 
2.17.1
