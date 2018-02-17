Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79U-0000cC-KU
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79T-0001gs-3T
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:00 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79S-0001gM-Rz
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:59 -0500
Received: by mail-pg0-x243.google.com with SMTP id l4so2191244pgp.11
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:35 -0800
Message-Id: <20180217182323.25885-20-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 19/67] target/arm: Implement SVE Bitwise
 Shift - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 12 +++++++
 target/arm/sve_helper.c    | 30 +++++++++++++++++
 target/arm/translate-sve.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 26 +++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2a2dbe98dd..00e3cd48bb 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -368,6 +368,18 @@ DEF_HELPER_FLAGS_4(sve_index_h, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
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
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 950012e70a..4c6e2713fa 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -614,6 +614,36 @@ DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
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
index 4a38020c8a..43e9f1ad08 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -130,6 +130,13 @@ static void do_mov_z(DisasContext *s, int rd, int rn)
     do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
 }
 
+/* Initialize a Zreg with replications of a 64-bit immediate.  */
+static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), vsz, vsz, word);
+}
+
 /* Invoke a vector expander on two Pregs.  */
 static void do_vector2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
                          int esz, int rd, int rn)
@@ -644,6 +651,80 @@ DO_ZPZW(LSL, lsl)
 
 #undef DO_ZPZW
 
+/*
+ *** SVE Bitwise Shift - Unpredicated Group
+ */
+
+static void do_shift_imm(DisasContext *s, arg_rri_esz *a, bool asr,
+                         void (*gvec_fn)(unsigned, uint32_t, uint32_t,
+                                         int64_t, uint32_t, uint32_t))
+{
+    unsigned vsz = vec_full_reg_size(s);
+    if (a->esz < 0) {
+        /* Invalid tsz encoding -- see tszimm_esz. */
+        unallocated_encoding(s);
+        return;
+    }
+    /* Shift by element size is architecturally valid.  For
+       arithmetic right-shift, it's the same as by one less.
+       Otherwise it is a zeroing operation.  */
+    if (a->imm >= 8 << a->esz) {
+        if (asr) {
+            a->imm = (8 << a->esz) - 1;
+        } else {
+            do_dupi_z(s, a->rd, 0);
+            return;
+        }
+    }
+    gvec_fn(a->esz, vec_full_reg_offset(s, a->rd),
+            vec_full_reg_offset(s, a->rn), a->imm, vsz, vsz);
+}
+
+static void trans_ASR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, true, tcg_gen_gvec_sari);
+}
+
+static void trans_LSR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, false, tcg_gen_gvec_shri);
+}
+
+static void trans_LSL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_shift_imm(s, a, false, tcg_gen_gvec_shli);
+}
+
+static void do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
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
+static void trans_##NAME##_zzw(DisasContext *s, arg_rrr_esz *a,           \
+                               uint32_t insn)                             \
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
 /*
  *** SVE Integer Multiply-Add Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0b47869dcd..f71ea1b60d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -33,6 +33,11 @@
 # A combination of tsz:imm3 -- extract (tsz:imm3) - esize
 %tszimm_shl	22:2 5:5 !function=tszimm_shl
 
+# Similarly for the tszh/tszl pair at 22/16 for zzi
+%tszimm16_esz	22:2 16:5 !function=tszimm_esz
+%tszimm16_shr	22:2 16:5 !function=tszimm_shr
+%tszimm16_shl	22:2 16:5 !function=tszimm_shl
+
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx	0:5
@@ -44,6 +49,7 @@
 
 &rr_esz		rd rn esz
 &rri		rd rn imm
+&rri_esz	rd rn imm esz
 &rrr_esz	rd rn rm esz
 &rpr_esz	rd pg rn esz
 &rprr_s		rd pg rn rm s
@@ -94,6 +100,10 @@
 @rdn_pg_tszimm	........ .. ... ... ... pg:3 ..... rd:5 \
 		&rpri_esz rn=%reg_movprfx esz=%tszimm_esz
 
+# Similarly without predicate.
+@rd_rn_tszimm	........ .. ... ... ...... rn:5 rd:5 \
+		&rri_esz esz=%tszimm16_esz
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9	........ ........ ...... rn:5 . rd:4	\
 		&rri imm=%imm9_16_10
@@ -252,6 +262,22 @@ ADDPL		00000100 011 ..... 01010 ...... .....		@rd_rn_i6
 # SVE stack frame size
 RDVL		00000100 101 11111 01010 imm:s6 rd:5
 
+### SVE Bitwise Shift - Unpredicated Group
+
+# SVE bitwise shift by immediate (unpredicated)
+ASR_zzi		00000100 .. 1 ..... 1001 00 ..... ..... \
+		@rd_rn_tszimm imm=%tszimm16_shr
+LSR_zzi		00000100 .. 1 ..... 1001 01 ..... ..... \
+		@rd_rn_tszimm imm=%tszimm16_shr
+LSL_zzi		00000100 .. 1 ..... 1001 11 ..... ..... \
+		@rd_rn_tszimm imm=%tszimm16_shl
+
+# SVE bitwise shift by wide elements (unpredicated)
+# Note esz != 3
+ASR_zzw		00000100 .. 1 ..... 1000 00 ..... .....		@rd_rn_rm
+LSR_zzw		00000100 .. 1 ..... 1000 01 ..... .....		@rd_rn_rm
+LSL_zzw		00000100 .. 1 ..... 1000 11 ..... .....		@rd_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
