Received: from eggs.gnu.org ([2001:4830:134:3::10]:56023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUh-0008SR-1e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUf-0002GB-IW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:27 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUf-0002Fc-An
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:25 -0500
Received: by mail-pg0-x244.google.com with SMTP id f12so9433645pgo.5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:48 -0800
Message-Id: <20171218174552.18871-20-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/23] target/arm: Implement SVE Bitwise Shift
 - Unpredicated Group
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
 target/arm/helper-sve.h    | 12 +++++++++++
 target/arm/sve_helper.c    | 30 ++++++++++++++++++++++++++
 target/arm/translate-sve.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.def         | 21 ++++++++++++++++++
 4 files changed, 116 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c8eae5eb62..c0e23e7a83 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -362,6 +362,18 @@ DEF_HELPER_FLAGS_4(sve_index_h, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
 DEF_HELPER_FLAGS_4(sve_index_s, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
 DEF_HELPER_FLAGS_4(sve_index_d, TCG_CALL_NO_RWG, void, ptr, i64, i64, i32)
 
+DEF_HELPER_FLAGS_4(sve_asr_zzw_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asr_zzw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asr_zzw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_lsr_zzw_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsr_zzw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsr_zzw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_lsl_zzw_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsl_zzw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsl_zzw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d8684b9457..b6aca18d22 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -669,6 +669,36 @@ DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
 DO_ZPZ(sve_neg_s, uint32_t, H1_4, DO_NEG)
 DO_ZPZ_D(sve_neg_d, uint64_t, DO_NEG)
 
+/* Three-operand expander, unpredicated, in which the third operand is "wide".
+ */
+#define DO_ZZW(NAME, TYPE, TYPEW, H, OP)                       \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    for (i = 0; i < opr_sz; ) {                                \
+        TYPEW mm = *(TYPEW *)(vm + i);                         \
+        do {                                                   \
+            TYPE nn = *(TYPE *)(vn + H(i));                    \
+            *(TYPE *)(vd + H(i)) = OP(nn, mm);                 \
+            i += sizeof(TYPE);                                 \
+        } while (i & 7);                                       \
+    }                                                          \
+}
+
+DO_ZZW(sve_asr_zzw_b, int8_t, uint64_t, H1, DO_ASR)
+DO_ZZW(sve_lsr_zzw_b, uint8_t, uint64_t, H1, DO_LSR)
+DO_ZZW(sve_lsl_zzw_b, uint8_t, uint64_t, H1, DO_LSL)
+
+DO_ZZW(sve_asr_zzw_h, int16_t, uint64_t, H1_2, DO_ASR)
+DO_ZZW(sve_lsr_zzw_h, uint16_t, uint64_t, H1_2, DO_LSR)
+DO_ZZW(sve_lsl_zzw_h, uint16_t, uint64_t, H1_2, DO_LSL)
+
+DO_ZZW(sve_asr_zzw_s, int32_t, uint64_t, H1_4, DO_ASR)
+DO_ZZW(sve_lsr_zzw_s, uint32_t, uint64_t, H1_4, DO_LSR)
+DO_ZZW(sve_lsl_zzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
+
+#undef DO_ZZW
+
 #undef DO_CLS_B
 #undef DO_CLS_H
 #undef DO_CLZ_B
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 026af7a162..d8e7cc7570 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -657,6 +657,59 @@ void trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
     tcg_gen_movi_i64(reg, a->imm * vec_full_reg_size(s));
 }
 
+static void do_shift_imm(DisasContext *s, arg_rri_esz *a,
+                         void (*gvec_fn)(unsigned, uint32_t, uint32_t,
+                                         uint32_t, uint32_t, unsigned))
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    gvec_fn(a->esz, vec_full_reg_offset(s, a->rd),
+            vec_full_reg_offset(s, a->rn), vsz, vsz, a->imm);
+}
+
+void trans_ASR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, tcg_gen_gvec_sari);
+}
+
+void trans_LSR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, tcg_gen_gvec_shri);
+}
+
+void trans_LSL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, tcg_gen_gvec_shli);
+}
+
+static void do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    if (fn == NULL) {
+        unallocated_encoding(s);
+        return;
+    }
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       vsz, vsz, 0, fn);
+}
+
+#define DO_ZZW(NAME, name) \
+void trans_##NAME##_zzw(DisasContext *s, arg_rrr_esz *a, uint32_t insn)   \
+{                                                                         \
+    static gen_helper_gvec_3 * const fns[4] = {                           \
+        gen_helper_sve_##name##_zzw_b, gen_helper_sve_##name##_zzw_h,     \
+        gen_helper_sve_##name##_zzw_s, NULL                               \
+    };                                                                    \
+    do_zzw_ool(s, a, fns[a->esz]);                                        \
+}
+
+DO_ZZW(ASR, asr)
+DO_ZZW(LSR, lsr)
+DO_ZZW(LSL, lsl)
+
+#undef DO_ZZW
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 7428ebc5cd..9caed8fc66 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -32,6 +32,11 @@
 # A combination of tsz:imm3 -- extract (tsz:imm3) - esize
 %tszimm_shl		22:2 5:5 !function=tszimm_shl
 
+# Similarly for the tszh/tszl pair at 22/16 for zzi
+%tszimm16_esz		22:2 16:5 !function=tszimm_esz
+%tszimm16_shr		22:2 16:5 !function=tszimm_shr
+%tszimm16_shl		22:2 16:5 !function=tszimm_shl
+
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx		0:5
@@ -42,6 +47,7 @@
 # instruction patterns.
 
 &rri			rd rn imm
+&rri_esz		rd rn imm esz
 &rrr_esz		rd rn rm esz
 &rpr_esz		rd pg rn esz
 &rprr_esz		rd pg rn rm esz
@@ -80,6 +86,9 @@
 # User must fill in imm.
 @rdn_pg_tszimm		........ .. ... ... ... pg:3 ..... rd:5		&rpri_esz rn=%reg_movprfx esz=%tszimm_esz
 
+# Similarly without predicate.
+@rd_rn_tszimm		........ .. ... ... ...... rn:5 rd:5		&rri_esz esz=%tszimm16_esz
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9		........ ........ ...... rn:5 . rd:4		&rri imm=%imm9_16_10
 @rd_rn_i9		........ ........ ...... rn:5 rd:5		&rri imm=%imm9_16_10
@@ -230,6 +239,18 @@ ADDPL			00000100 011 ..... 01010 ...... .....		@rd_rn_i6
 # SVE stack frame size
 RDVL			00000100 101 11111 01010 imm:s6 rd:5
 
+### SVE Bitwise Shift - Unpredicated Group
+
+# SVE bitwise shift by immediate (unpredicated)
+ASR_zzi			00000100 .. 1 ..... 1001 00 ..... .....		@rd_rn_tszimm imm=%tszimm16_shr
+LSR_zzi			00000100 .. 1 ..... 1001 01 ..... .....		@rd_rn_tszimm imm=%tszimm16_shr
+LSL_zzi			00000100 .. 1 ..... 1001 11 ..... .....		@rd_rn_tszimm imm=%tszimm16_shl
+
+# SVE bitwise shift by wide elements (unpredicated)
+ASR_zzw			00000100 .. 1 ..... 1000 00 ..... .....		@rd_rn_rm_esz # Note size != 3
+LSR_zzw			00000100 .. 1 ..... 1000 01 ..... .....		@rd_rn_rm_esz # Note size != 3
+LSL_zzw			00000100 .. 1 ..... 1000 11 ..... .....		@rd_rn_rm_esz # Note size != 3
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3
