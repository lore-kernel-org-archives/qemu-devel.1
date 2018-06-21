Received: from eggs.gnu.org ([2001:4830:134:3::10]:39590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooZ-00050I-BD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooX-0003Ya-P6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:11 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:38073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooX-0003Xw-GG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:09 -0400
Received: by mail-pl0-x22f.google.com with SMTP id d10-v6so758077plo.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:55:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:57 -1000
Message-Id: <20180621015359.12018-34-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 33/35] target/arm: Implement SVE dot product
 (indexed)
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
 target/arm/helper.h        |  5 ++
 target/arm/translate-sve.c | 18 +++++++
 target/arm/vec_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 +++-
 4 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e23ce7ff19..59e8c3bd1b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -588,6 +588,11 @@ DEF_HELPER_FLAGS_4(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_sdot_idx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_udot_idx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sdot_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_udot_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index aa109208e5..af2958be10 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3440,6 +3440,24 @@ static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a, uint32_t insn)
     return true;
 }
 
+static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[2][2] = {
+        { gen_helper_gvec_sdot_idx_b, gen_helper_gvec_sdot_idx_h },
+        { gen_helper_gvec_udot_idx_b, gen_helper_gvec_udot_idx_h }
+    };
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, a->index, fns[a->u][a->sz]);
+    }
+    return true;
+}
+
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index c16a30c3b5..3117ee39cd 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -261,6 +261,102 @@ void HELPER(gvec_udot_h)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    uint32_t *d = vd;
+    int8_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz_4; i = j) {
+        int8_t m0 = m[(i + index) * 4 + 0];
+        int8_t m1 = m[(i + index) * 4 + 1];
+        int8_t m2 = m[(i + index) * 4 + 2];
+        int8_t m3 = m[(i + index) * 4 + 3];
+
+        j = i;
+        do {
+            d[j] += n[j * 4 + 0] * m0
+                  + n[j * 4 + 1] * m1
+                  + n[j * 4 + 2] * m2
+                  + n[j * 4 + 3] * m3;
+        } while (++j < MIN(i + 4, opr_sz_4));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    uint32_t *d = vd;
+    uint8_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz_4; i = j) {
+        uint8_t m0 = m[(i + index) * 4 + 0];
+        uint8_t m1 = m[(i + index) * 4 + 1];
+        uint8_t m2 = m[(i + index) * 4 + 2];
+        uint8_t m3 = m[(i + index) * 4 + 3];
+
+        j = i;
+        do {
+            d[j] += n[j * 4 + 0] * m0
+                  + n[j * 4 + 1] * m1
+                  + n[j * 4 + 2] * m2
+                  + n[j * 4 + 3] * m3;
+        } while (++j < MIN(i + 4, opr_sz_4));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
+    intptr_t index = simd_data(desc);
+    uint64_t *d = vd;
+    int16_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz_8; i = j) {
+        int64_t m0 = m[(i + index) * 4 + 0];
+        int64_t m1 = m[(i + index) * 4 + 1];
+        int64_t m2 = m[(i + index) * 4 + 2];
+        int64_t m3 = m[(i + index) * 4 + 3];
+
+        j = i;
+        do {
+            d[j] += n[j * 4 + 0] * m0
+                  + n[j * 4 + 1] * m1
+                  + n[j * 4 + 2] * m2
+                  + n[j * 4 + 3] * m3;
+        } while (++j < MIN(i + 2, opr_sz_8));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
+    intptr_t index = simd_data(desc);
+    uint64_t *d = vd;
+    uint16_t *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz_8; i = j) {
+        uint64_t m0 = m[(i + index) * 4 + 0];
+        uint64_t m1 = m[(i + index) * 4 + 1];
+        uint64_t m2 = m[(i + index) * 4 + 2];
+        uint64_t m3 = m[(i + index) * 4 + 3];
+
+        j = i;
+        do {
+            d[j] += n[j * 4 + 0] * m0
+                  + n[j * 4 + 1] * m1
+                  + n[j * 4 + 2] * m2
+                  + n[j * 4 + 3] * m3;
+        } while (++j < MIN(i + 2, opr_sz_8));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          void *vfpst, uint32_t desc)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0b29da9f3a..f69ff285a1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -722,7 +722,13 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
 # SVE integer dot product (unpredicated)
-DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
+DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx
+
+# SVE integer dot product (indexed)
+DOT_zzx         01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
+                sz=0 ra=%reg_movprfx
+DOT_zzx         01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
+                sz=1 ra=%reg_movprfx
 
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
-- 
2.17.1
