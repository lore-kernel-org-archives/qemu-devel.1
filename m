Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooY-0004zU-43
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooV-0003XO-ON
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:10 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:46309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooV-0003Wt-HZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:07 -0400
Received: by mail-pf0-x234.google.com with SMTP id q1-v6so677329pff.13
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:55:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:56 -1000
Message-Id: <20180621015359.12018-33-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 32/35] target/arm: Implement SVE dot product
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  5 +++
 target/arm/translate-sve.c | 17 ++++++++++
 target/arm/vec_helper.c    | 67 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  3 ++
 4 files changed, 92 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8607077dda..e23ce7ff19 100644
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
index 209a69cd76..aa109208e5 100644
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
index db5aeb9f24..c16a30c3b5 100644
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
index b578d104c4..0b29da9f3a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -721,6 +721,9 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+# SVE integer dot product (unpredicated)
+DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
+
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
                 rn=%reg_movprfx
-- 
2.17.1
