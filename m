Received: from eggs.gnu.org ([2001:4830:134:3::10]:56045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUi-0008TN-1k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUg-0002Hi-VZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUg-0002H3-Nb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:26 -0500
Received: by mail-pg0-x241.google.com with SMTP id b18so9423314pgv.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:49 -0800
Message-Id: <20171218174552.18871-21-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/23] target/arm: Implement SVE Compute Vector
 Address Group
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
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 +++++++++++++++++++++++++++++
 target/arm/sve.def         | 12 ++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c0e23e7a83..a9fcf25b95 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -374,6 +374,11 @@ DEF_HELPER_FLAGS_4(sve_lsl_zzw_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_lsl_zzw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_lsl_zzw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_adr_p32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_p64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_s32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_u32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b6aca18d22..33b3c3432d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -983,6 +983,46 @@ void HELPER(sve_index_d)(void *vd, uint64_t start,
     }
 }
 
+void HELPER(sve_adr_p32)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t sh = simd_data(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] + (m[i] << sh);
+    }
+}
+
+void HELPER(sve_adr_p64)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t sh = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] + (m[i] << sh);
+    }
+}
+
+void HELPER(sve_adr_s32)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t sh = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] + ((uint64_t)(int32_t)m[i] << sh);
+    }
+}
+
+void HELPER(sve_adr_u32)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t sh = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] + ((uint64_t)(uint32_t)m[i] << sh);
+    }
+}
+
 void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
 {
     intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d8e7cc7570..fcb5c4929e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -710,6 +710,35 @@ DO_ZZW(LSL, lsl)
 
 #undef DO_ZZW
 
+static void do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       vsz, vsz, a->imm, fn);
+}
+
+void trans_ADR_p32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    do_adr(s, a, gen_helper_sve_adr_p32);
+}
+
+void trans_ADR_p64(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    do_adr(s, a, gen_helper_sve_adr_p64);
+}
+
+void trans_ADR_s32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    do_adr(s, a, gen_helper_sve_adr_s32);
+}
+
+void trans_ADR_u32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    do_adr(s, a, gen_helper_sve_adr_u32);
+}
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 9caed8fc66..66a88f59bc 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -47,6 +47,7 @@
 # instruction patterns.
 
 &rri			rd rn imm
+&rrri			rd rn rm imm
 &rri_esz		rd rn imm esz
 &rrr_esz		rd rn rm esz
 &rpr_esz		rd pg rn esz
@@ -65,6 +66,9 @@
 # Three operand with unused vector element size
 @rd_rn_rm		........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=0
 
+# Three operand with "memory" size, aka immediate left shift
+@rd_rn_msz_rm		........ ... rm:5 .... imm:2 rn:5 rd:5		&rrri
+
 # Three prediate operand, with governing predicate, unused vector element size
 @pd_pg_pn_pm		........ .... rm:4 .. pg:4 . rn:4 . rd:4	&rprr_esz esz=0
 
@@ -251,6 +255,14 @@ ASR_zzw			00000100 .. 1 ..... 1000 00 ..... .....		@rd_rn_rm_esz # Note size !=
 LSR_zzw			00000100 .. 1 ..... 1000 01 ..... .....		@rd_rn_rm_esz # Note size != 3
 LSL_zzw			00000100 .. 1 ..... 1000 11 ..... .....		@rd_rn_rm_esz # Note size != 3
 
+### SVE Compute Vector Address Group
+
+# SVE vector address generation
+ADR_s32			00000100 00 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
+ADR_u32			00000100 01 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
+ADR_p32			00000100 10 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
+ADR_p64			00000100 11 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3
