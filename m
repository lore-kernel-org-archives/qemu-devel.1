Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun2-0007jf-Kw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun1-0007RX-CK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun1-0007Me-2X
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumz-0004lD-RC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:31 +0100
Message-Id: <20180629145347.652-40-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/55] target/arm: Implement SVE dot product
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180627043328.11531-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |   5 ++
 target/arm/translate-sve.c |  18 ++++++
 target/arm/vec_helper.c    | 124 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |   6 ++
 4 files changed, 153 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e23ce7ff197..59e8c3bd1b9 100644
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
index cf9c652e54e..c080345b9c7 100644
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
index c16a30c3b5b..37f338732e3 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -261,6 +261,130 @@ void HELPER(gvec_udot_h)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    uint32_t *d = vd;
+    int8_t *n = vn;
+    int8_t *m_indexed = (int8_t *)vm + index * 4;
+
+    /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
+     * Otherwise opr_sz is a multiple of 16.
+     */
+    segend = MIN(4, opr_sz_4);
+    i = 0;
+    do {
+        int8_t m0 = m_indexed[i * 4 + 0];
+        int8_t m1 = m_indexed[i * 4 + 1];
+        int8_t m2 = m_indexed[i * 4 + 2];
+        int8_t m3 = m_indexed[i * 4 + 3];
+
+        do {
+            d[i] += n[i * 4 + 0] * m0
+                  + n[i * 4 + 1] * m1
+                  + n[i * 4 + 2] * m2
+                  + n[i * 4 + 3] * m3;
+        } while (++i < segend);
+        segend = i + 4;
+    } while (i < opr_sz_4);
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    uint32_t *d = vd;
+    uint8_t *n = vn;
+    uint8_t *m_indexed = (uint8_t *)vm + index * 4;
+
+    /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
+     * Otherwise opr_sz is a multiple of 16.
+     */
+    segend = MIN(4, opr_sz_4);
+    i = 0;
+    do {
+        uint8_t m0 = m_indexed[i * 4 + 0];
+        uint8_t m1 = m_indexed[i * 4 + 1];
+        uint8_t m2 = m_indexed[i * 4 + 2];
+        uint8_t m3 = m_indexed[i * 4 + 3];
+
+        do {
+            d[i] += n[i * 4 + 0] * m0
+                  + n[i * 4 + 1] * m1
+                  + n[i * 4 + 2] * m2
+                  + n[i * 4 + 3] * m3;
+        } while (++i < segend);
+        segend = i + 4;
+    } while (i < opr_sz_4);
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
+    intptr_t index = simd_data(desc);
+    uint64_t *d = vd;
+    int16_t *n = vn;
+    int16_t *m_indexed = (int16_t *)vm + index * 4;
+
+    /* This is supported by SVE only, so opr_sz is always a multiple of 16.
+     * Process the entire segment all at once, writing back the results
+     * only after we've consumed all of the inputs.
+     */
+    for (i = 0; i < opr_sz_8 ; i += 2) {
+        uint64_t d0, d1;
+
+        d0  = n[i * 4 + 0] * (int64_t)m_indexed[i * 4 + 0];
+        d0 += n[i * 4 + 1] * (int64_t)m_indexed[i * 4 + 1];
+        d0 += n[i * 4 + 2] * (int64_t)m_indexed[i * 4 + 2];
+        d0 += n[i * 4 + 3] * (int64_t)m_indexed[i * 4 + 3];
+        d1  = n[i * 4 + 4] * (int64_t)m_indexed[i * 4 + 0];
+        d1 += n[i * 4 + 5] * (int64_t)m_indexed[i * 4 + 1];
+        d1 += n[i * 4 + 6] * (int64_t)m_indexed[i * 4 + 2];
+        d1 += n[i * 4 + 7] * (int64_t)m_indexed[i * 4 + 3];
+
+        d[i + 0] += d0;
+        d[i + 1] += d1;
+    }
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
+    intptr_t index = simd_data(desc);
+    uint64_t *d = vd;
+    uint16_t *n = vn;
+    uint16_t *m_indexed = (uint16_t *)vm + index * 4;
+
+    /* This is supported by SVE only, so opr_sz is always a multiple of 16.
+     * Process the entire segment all at once, writing back the results
+     * only after we've consumed all of the inputs.
+     */
+    for (i = 0; i < opr_sz_8 ; i += 2) {
+        uint64_t d0, d1;
+
+        d0  = n[i * 4 + 0] * (uint64_t)m_indexed[i * 4 + 0];
+        d0 += n[i * 4 + 1] * (uint64_t)m_indexed[i * 4 + 1];
+        d0 += n[i * 4 + 2] * (uint64_t)m_indexed[i * 4 + 2];
+        d0 += n[i * 4 + 3] * (uint64_t)m_indexed[i * 4 + 3];
+        d1  = n[i * 4 + 4] * (uint64_t)m_indexed[i * 4 + 0];
+        d1 += n[i * 4 + 5] * (uint64_t)m_indexed[i * 4 + 1];
+        d1 += n[i * 4 + 6] * (uint64_t)m_indexed[i * 4 + 2];
+        d1 += n[i * 4 + 7] * (uint64_t)m_indexed[i * 4 + 3];
+
+        d[i + 0] += d0;
+        d[i + 1] += d1;
+    }
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          void *vfpst, uint32_t desc)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7b7b29ae640..e10b689454e 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -728,6 +728,12 @@ MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 # SVE integer dot product (unpredicated)
 DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx
 
+# SVE integer dot product (indexed)
+DOT_zzx         01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
+                sz=0 ra=%reg_movprfx
+DOT_zzx         01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
+                sz=1 ra=%reg_movprfx
+
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
                 rn=%reg_movprfx
-- 
2.17.1
