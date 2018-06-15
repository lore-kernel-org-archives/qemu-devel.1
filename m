Received: from eggs.gnu.org ([2001:4830:134:3::10]:60917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfa-0001is-4v
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfY-0006Ie-Am
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfY-0006G7-1g
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfW-0003k3-No
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:00 +0100
Message-Id: <20180615142521.19143-23-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 22/43] target/arm: Implement SVE Permute -
 Interleaving Group
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
Message-id: 20180613015641.5667-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 15 ++++++++
 target/arm/sve_helper.c    | 72 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 75 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 10 +++++
 4 files changed, 172 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ff958fcebd5..bab20345c62 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -445,6 +445,21 @@ DEF_HELPER_FLAGS_4(sve_trn_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_rev_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_punpk_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_zip_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_zip_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_zip_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_zip_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_uzp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uzp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uzp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uzp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_trn_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_trn_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f4d49d4aff7..f114e9ab635 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1964,3 +1964,75 @@ void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
         }
     }
 }
+
+#define DO_ZIP(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)       \
+{                                                                    \
+    intptr_t oprsz = simd_oprsz(desc);                               \
+    intptr_t i, oprsz_2 = oprsz / 2;                                 \
+    ARMVectorReg tmp_n, tmp_m;                                       \
+    /* We produce output faster than we consume input.               \
+       Therefore we must be mindful of possible overlap.  */         \
+    if (unlikely((vn - vd) < (uintptr_t)oprsz)) {                    \
+        vn = memcpy(&tmp_n, vn, oprsz_2);                            \
+    }                                                                \
+    if (unlikely((vm - vd) < (uintptr_t)oprsz)) {                    \
+        vm = memcpy(&tmp_m, vm, oprsz_2);                            \
+    }                                                                \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                    \
+        *(TYPE *)(vd + H(2 * i + 0)) = *(TYPE *)(vn + H(i));         \
+        *(TYPE *)(vd + H(2 * i + sizeof(TYPE))) = *(TYPE *)(vm + H(i)); \
+    }                                                                \
+}
+
+DO_ZIP(sve_zip_b, uint8_t, H1)
+DO_ZIP(sve_zip_h, uint16_t, H1_2)
+DO_ZIP(sve_zip_s, uint32_t, H1_4)
+DO_ZIP(sve_zip_d, uint64_t, )
+
+#define DO_UZP(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
+{                                                                      \
+    intptr_t oprsz = simd_oprsz(desc);                                 \
+    intptr_t oprsz_2 = oprsz / 2;                                      \
+    intptr_t odd_ofs = simd_data(desc);                                \
+    intptr_t i;                                                        \
+    ARMVectorReg tmp_m;                                                \
+    if (unlikely((vm - vd) < (uintptr_t)oprsz)) {                      \
+        vm = memcpy(&tmp_m, vm, oprsz);                                \
+    }                                                                  \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                      \
+        *(TYPE *)(vd + H(i)) = *(TYPE *)(vn + H(2 * i + odd_ofs));     \
+    }                                                                  \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                      \
+        *(TYPE *)(vd + H(oprsz_2 + i)) = *(TYPE *)(vm + H(2 * i + odd_ofs)); \
+    }                                                                  \
+}
+
+DO_UZP(sve_uzp_b, uint8_t, H1)
+DO_UZP(sve_uzp_h, uint16_t, H1_2)
+DO_UZP(sve_uzp_s, uint32_t, H1_4)
+DO_UZP(sve_uzp_d, uint64_t, )
+
+#define DO_TRN(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
+{                                                                      \
+    intptr_t oprsz = simd_oprsz(desc);                                 \
+    intptr_t odd_ofs = simd_data(desc);                                \
+    intptr_t i;                                                        \
+    for (i = 0; i < oprsz; i += 2 * sizeof(TYPE)) {                    \
+        TYPE ae = *(TYPE *)(vn + H(i + odd_ofs));                      \
+        TYPE be = *(TYPE *)(vm + H(i + odd_ofs));                      \
+        *(TYPE *)(vd + H(i + 0)) = ae;                                 \
+        *(TYPE *)(vd + H(i + sizeof(TYPE))) = be;                      \
+    }                                                                  \
+}
+
+DO_TRN(sve_trn_b, uint8_t, H1)
+DO_TRN(sve_trn_h, uint16_t, H1_2)
+DO_TRN(sve_trn_s, uint32_t, H1_4)
+DO_TRN(sve_trn_d, uint64_t, )
+
+#undef DO_ZIP
+#undef DO_UZP
+#undef DO_TRN
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0160d06915b..21319518d70 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2209,6 +2209,81 @@ static bool trans_PUNPKHI(DisasContext *s, arg_PUNPKHI *a, uint32_t insn)
     return do_perm_pred2(s, a, 1, gen_helper_sve_punpk_p);
 }
 
+/*
+ *** SVE Permute - Interleaving Group
+ */
+
+static bool do_zip(DisasContext *s, arg_rrr_esz *a, bool high)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_zip_b, gen_helper_sve_zip_h,
+        gen_helper_sve_zip_s, gen_helper_sve_zip_d,
+    };
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned high_ofs = high ? vsz / 2 : 0;
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn) + high_ofs,
+                           vec_full_reg_offset(s, a->rm) + high_ofs,
+                           vsz, vsz, 0, fns[a->esz]);
+    }
+    return true;
+}
+
+static bool do_zzz_data_ool(DisasContext *s, arg_rrr_esz *a, int data,
+                            gen_helper_gvec_3 *fn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, data, fn);
+    }
+    return true;
+}
+
+static bool trans_ZIP1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zip(s, a, false);
+}
+
+static bool trans_ZIP2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zip(s, a, true);
+}
+
+static gen_helper_gvec_3 * const uzp_fns[4] = {
+    gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
+    gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
+};
+
+static bool trans_UZP1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zzz_data_ool(s, a, 0, uzp_fns[a->esz]);
+}
+
+static bool trans_UZP2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zzz_data_ool(s, a, 1 << a->esz, uzp_fns[a->esz]);
+}
+
+static gen_helper_gvec_3 * const trn_fns[4] = {
+    gen_helper_sve_trn_b, gen_helper_sve_trn_h,
+    gen_helper_sve_trn_s, gen_helper_sve_trn_d,
+};
+
+static bool trans_TRN1_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zzz_data_ool(s, a, 0, trn_fns[a->esz]);
+}
+
+static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_zzz_data_ool(s, a, 1 << a->esz, trn_fns[a->esz]);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 26fe1608c4a..df2b94dc0a8 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -414,6 +414,16 @@ REV_p           00000101 .. 11 0100 010 000 0 .... 0 ....       @pd_pn
 PUNPKLO         00000101 00 11 0000 010 000 0 .... 0 ....       @pd_pn_e0
 PUNPKHI         00000101 00 11 0001 010 000 0 .... 0 ....       @pd_pn_e0
 
+### SVE Permute - Interleaving Group
+
+# SVE permute vector elements
+ZIP1_z          00000101 .. 1 ..... 011 000 ..... .....         @rd_rn_rm
+ZIP2_z          00000101 .. 1 ..... 011 001 ..... .....         @rd_rn_rm
+UZP1_z          00000101 .. 1 ..... 011 010 ..... .....         @rd_rn_rm
+UZP2_z          00000101 .. 1 ..... 011 011 ..... .....         @rd_rn_rm
+TRN1_z          00000101 .. 1 ..... 011 100 ..... .....         @rd_rn_rm
+TRN2_z          00000101 .. 1 ..... 011 101 ..... .....         @rd_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
