Received: from eggs.gnu.org ([2001:4830:134:3::10]:36114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3N-0000nt-6E
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3L-0007bR-Hg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3K-0007Z3-DT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3J-0004t0-Fd
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:58 +0100
Message-Id: <20180518172009.14416-22-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/32] target/arm: Implement SVE Integer
 Multiply-Add Group
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
Message-id: 20180516223007.10256-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 18 ++++++++++++
 target/arm/sve_helper.c    | 57 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 34 +++++++++++++++++++++++
 target/arm/sve.decode      | 17 ++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 11644125d1..b31d497f31 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -345,6 +345,24 @@ DEF_HELPER_FLAGS_4(sve_neg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_neg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_neg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sve_mla_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mla_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mla_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mla_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_mls_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mls_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mls_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_mls_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 236d21e771..56a4eb71d5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -935,3 +935,60 @@ DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
 #undef DO_ASRD
 #undef DO_ZPZI
 #undef DO_ZPZI_D
+
+/* Fully general four-operand expander, controlled by a predicate.
+ */
+#define DO_ZPZZZ(NAME, TYPE, H, OP)                           \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,     \
+                  void *vg, uint32_t desc)                    \
+{                                                             \
+    intptr_t i, opr_sz = simd_oprsz(desc);                    \
+    for (i = 0; i < opr_sz; ) {                               \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));       \
+        do {                                                  \
+            if (pg & 1) {                                     \
+                TYPE nn = *(TYPE *)(vn + H(i));               \
+                TYPE mm = *(TYPE *)(vm + H(i));               \
+                TYPE aa = *(TYPE *)(va + H(i));               \
+                *(TYPE *)(vd + H(i)) = OP(aa, nn, mm);        \
+            }                                                 \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);           \
+        } while (i & 15);                                     \
+    }                                                         \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZZZ_D(NAME, TYPE, OP)                            \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,     \
+                  void *vg, uint32_t desc)                    \
+{                                                             \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                \
+    TYPE *d = vd, *a = va, *n = vn, *m = vm;                  \
+    uint8_t *pg = vg;                                         \
+    for (i = 0; i < opr_sz; i += 1) {                         \
+        if (pg[H1(i)] & 1) {                                  \
+            TYPE aa = a[i], nn = n[i], mm = m[i];             \
+            d[i] = OP(aa, nn, mm);                            \
+        }                                                     \
+    }                                                         \
+}
+
+#define DO_MLA(A, N, M)  (A + N * M)
+#define DO_MLS(A, N, M)  (A - N * M)
+
+DO_ZPZZZ(sve_mla_b, uint8_t, H1, DO_MLA)
+DO_ZPZZZ(sve_mls_b, uint8_t, H1, DO_MLS)
+
+DO_ZPZZZ(sve_mla_h, uint16_t, H1_2, DO_MLA)
+DO_ZPZZZ(sve_mls_h, uint16_t, H1_2, DO_MLS)
+
+DO_ZPZZZ(sve_mla_s, uint32_t, H1_4, DO_MLA)
+DO_ZPZZZ(sve_mls_s, uint32_t, H1_4, DO_MLS)
+
+DO_ZPZZZ_D(sve_mla_d, uint64_t, DO_MLA)
+DO_ZPZZZ_D(sve_mls_d, uint64_t, DO_MLS)
+
+#undef DO_MLA
+#undef DO_MLS
+#undef DO_ZPZZZ
+#undef DO_ZPZZZ_D
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 52f1b4dbf5..f14bb2196a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -634,6 +634,40 @@ DO_ZPZW(LSL, lsl)
 
 #undef DO_ZPZW
 
+/*
+ *** SVE Integer Multiply-Add Group
+ */
+
+static bool do_zpzzz_ool(DisasContext *s, arg_rprrr_esz *a,
+                         gen_helper_gvec_5 *fn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_5_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->ra),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           pred_full_reg_offset(s, a->pg),
+                           vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+#define DO_ZPZZZ(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn) \
+{                                                                    \
+    static gen_helper_gvec_5 * const fns[4] = {                      \
+        gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,        \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,        \
+    };                                                               \
+    return do_zpzzz_ool(s, a, fns[a->esz]);                          \
+}
+
+DO_ZPZZZ(MLA, mla)
+DO_ZPZZZ(MLS, mls)
+
+#undef DO_ZPZZZ
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0ddc1e96be..5e4335b2ae 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -47,6 +47,7 @@
 &rpr_esz        rd pg rn esz
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
+&rprrr_esz      rd pg rn rm ra esz
 &rpri_esz       rd pg rn imm esz
 
 ###########################################################################
@@ -71,6 +72,12 @@
 @rdm_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
                 &rprr_esz rm=%reg_movprfx
 
+# Three register operand, with governing predicate, vector element size
+@rda_pg_rn_rm   ........ esz:2 . rm:5  ... pg:3 rn:5 rd:5 \
+                &rprrr_esz ra=%reg_movprfx
+@rdn_pg_ra_rm   ........ esz:2 . rm:5  ... pg:3 ra:5 rd:5 \
+                &rprrr_esz rn=%reg_movprfx
+
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
 
@@ -186,6 +193,16 @@ UXTH            00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
 SXTW            00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
 UXTW            00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
 
+### SVE Integer Multiply-Add Group
+
+# SVE integer multiply-add writing addend (predicated)
+MLA             00000100 .. 0 ..... 010 ... ..... .....   @rda_pg_rn_rm
+MLS             00000100 .. 0 ..... 011 ... ..... .....   @rda_pg_rn_rm
+
+# SVE integer multiply-add writing multiplicand (predicated)
+MLA             00000100 .. 0 ..... 110 ... ..... .....   @rdn_pg_ra_rm # MAD
+MLS             00000100 .. 0 ..... 111 ... ..... .....   @rdn_pg_ra_rm # MSB
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0
