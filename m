Received: from eggs.gnu.org ([2001:4830:134:3::10]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUb-0008Kt-3p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUZ-0002Ao-Mc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:21 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUZ-0002AB-F3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:19 -0500
Received: by mail-pg0-x243.google.com with SMTP id y6so9433270pgp.4
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:44 -0800
Message-Id: <20171218174552.18871-16-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/23] target/arm: Implement SVE Integer
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 18 ++++++++++++++
 target/arm/sve_helper.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 27 +++++++++++++++++++++
 target/arm/sve.def         | 15 ++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index e9382de300..abed625123 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -339,6 +339,24 @@ DEF_HELPER_FLAGS_4(sve_neg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 481b3bdefe..8235784a82 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -855,6 +855,64 @@ DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
 #undef DO_SHL
 #undef DO_ASRD
 
+/* Fully general four-operand expander, controlled by a predicate.
+ */
+#define DO_ZPZZZ(NAME, TYPE, H, OP)                           \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,     \
+                  void *vg, uint32_t desc)                    \
+{                                                             \
+    intptr_t iv = 0, ib = 0, opr_sz = simd_oprsz(desc);       \
+    for (iv = ib = 0; iv < opr_sz; iv += 16, ib += 2) {       \
+        uint16_t pg = *(uint16_t *)(vg + H2(ib));             \
+        intptr_t i = 0;                                       \
+        do {                                                  \
+            if (pg & 1) {                                     \
+                TYPE nn = *(TYPE *)(vn + iv + H(i));          \
+                TYPE mm = *(TYPE *)(vm + iv + H(i));          \
+                TYPE aa = *(TYPE *)(va + iv + H(i));          \
+                *(TYPE *)(vd + iv + H(i)) = OP(aa, nn, mm);   \
+            }                                                 \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);           \
+        } while (pg);                                         \
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
+
 void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
 {
     intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7dbc43fb6e..83793ab169 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -520,6 +520,33 @@ void trans_ASRD(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     }
 }
 
+static void do_zpzzz_ool(DisasContext *s, arg_rprrr_esz *a,
+                         gen_helper_gvec_5 *fn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    tcg_gen_gvec_5_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->ra),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       pred_full_reg_offset(s, a->pg),
+                       vsz, vsz, 0, fn);
+}
+
+#define DO_ZPZZZ(NAME, name) \
+void trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn)  \
+{                                                                    \
+    static gen_helper_gvec_5 * const fns[4] = {                      \
+        gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,        \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,        \
+    };                                                               \
+    do_zpzzz_ool(s, a, fns[a->esz]);                                 \
+}
+
+DO_ZPZZZ(MLA, mla)
+DO_ZPZZZ(MLS, mls)
+
+#undef DO_ZPZZZ
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 955a0275a1..3ae871394c 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -45,6 +45,7 @@
 &rrr_esz		rd rn rm esz
 &rpr_esz		rd pg rn esz
 &rprr_esz		rd pg rn rm esz
+&rprrr_esz		rd pg rn rm ra esz
 &rpri_esz		rd pg rn imm esz
 &pred_set		rd pat esz i s
 
@@ -62,6 +63,10 @@
 @rdn_pg_rm_esz		........ esz:2 ... ... ... pg:3 rm:5 rd:5	&rprr_esz rn=%reg_movprfx
 @rdm_pg_rn_esz		........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rprr_esz rm=%reg_movprfx
 
+# Three register operand, with governing predicate, vector element size
+@rda_pg_rn_rm_esz	........ esz:2 . rm:5  ... pg:3 rn:5 rd:5	&rprrr_esz ra=%reg_movprfx
+@rdn_pg_ra_rm_esz	........ esz:2 . rm:5  ... pg:3 ra:5 rd:5	&rprrr_esz rn=%reg_movprfx
+
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn_esz		........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
 
@@ -168,6 +173,16 @@ UXTH			00000100 .. 010 011 101 ... ..... .....		@rd_pg_rn_esz # Note size > 1
 SXTW			00000100 .. 010 100 101 ... ..... .....		@rd_pg_rn_esz # Note size == 3
 UXTW			00000100 .. 010 101 101 ... ..... .....		@rd_pg_rn_esz # Note size == 3
 
+### SVE Integer Multiply-Add Group
+
+# SVE integer multiply-add writing addend (predicated)
+MLA			00000100 .. 0 ..... 010 ... ..... .....		@rda_pg_rn_rm_esz
+MLS			00000100 .. 0 ..... 011 ... ..... .....		@rda_pg_rn_rm_esz
+
+# SVE integer multiply-add writing multiplicand (predicated)
+MLA			00000100 .. 0 ..... 110 ... ..... .....		@rdn_pg_ra_rm_esz # MAD
+MLS			00000100 .. 0 ..... 111 ... ..... .....		@rdn_pg_ra_rm_esz # MSB
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3
