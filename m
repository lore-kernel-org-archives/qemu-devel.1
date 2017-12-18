Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUd-0008OJ-P2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUc-0002DS-IO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:23 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUc-0002Cn-Af
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:22 -0500
Received: by mail-pg0-x241.google.com with SMTP id j4so9441910pgp.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:46 -0800
Message-Id: <20171218174552.18871-18-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/23] target/arm: Implement SVE Index
 Generation Group
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
 target/arm/helper-sve.h    |  5 ++++
 target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.def         | 14 +++++++++++
 4 files changed, 121 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index abed625123..c8eae5eb62 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -357,6 +357,11 @@ DEF_HELPER_FLAGS_6(sve_mls_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_mls_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_index_b, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
+DEF_HELPER_FLAGS_4(sve_index_h, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
+DEF_HELPER_FLAGS_4(sve_index_s, TCG_CALL_NO_RWG, void, ptr, i32, i32, i32)
+DEF_HELPER_FLAGS_4(sve_index_d, TCG_CALL_NO_RWG, void, ptr, i64, i64, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8235784a82..d8684b9457 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -913,6 +913,46 @@ DO_ZPZZZ_D(sve_mls_d, uint64_t, DO_MLS)
 #undef DO_ZPZZZ
 #undef DO_ZPZZZ_D
 
+void HELPER(sve_index_b)(void *vd, uint32_t start,
+                         uint32_t incr, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[H1(i)] = start + i * incr;
+    }
+}
+
+void HELPER(sve_index_h)(void *vd, uint32_t start,
+                         uint32_t incr, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    uint16_t *d = vd;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[H2(i)] = start + i * incr;
+    }
+}
+
+void HELPER(sve_index_s)(void *vd, uint32_t start,
+                         uint32_t incr, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t *d = vd;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[H4(i)] = start + i * incr;
+    }
+}
+
+void HELPER(sve_index_d)(void *vd, uint64_t start,
+                         uint64_t incr, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = start + i * incr;
+    }
+}
+
 void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
 {
     intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7edec8ba96..7e1bf7d623 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -577,6 +577,68 @@ DO_ZPZZZ(MLS, mls)
 
 #undef DO_ZPZZZ
 
+static void do_index(DisasContext *s, int esz, int rd,
+                     TCGv_i64 start, TCGv_i64 incr)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    TCGv_i32 desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+    TCGv_ptr t_zd = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_zd, cpu_env, vec_full_reg_offset(s, rd));
+    if (esz == 3) {
+        gen_helper_sve_index_d(t_zd, start, incr, desc);
+    } else {
+        static void (*fns[3])(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32) = {
+            gen_helper_sve_index_b,
+            gen_helper_sve_index_h,
+            gen_helper_sve_index_s,
+        };
+        TCGv_i32 s32 = tcg_temp_new_i32();
+        TCGv_i32 i32 = tcg_temp_new_i32();
+
+        tcg_gen_extrl_i64_i32(s32, start);
+        tcg_gen_extrl_i64_i32(i32, incr);
+        fns[esz](t_zd, s32, i32, desc);
+
+        tcg_temp_free_i32(s32);
+        tcg_temp_free_i32(i32);
+    }
+    tcg_temp_free_ptr(t_zd);
+    tcg_temp_free_i32(desc);
+}
+
+void trans_INDEX_ii(DisasContext *s, arg_INDEX_ii *a, uint32_t insn)
+{
+    TCGv_i64 start = tcg_const_i64(a->imm1);
+    TCGv_i64 incr = tcg_const_i64(a->imm2);
+    do_index(s, a->esz, a->rd, start, incr);
+    tcg_temp_free_i64(start);
+    tcg_temp_free_i64(incr);
+}
+
+void trans_INDEX_ir(DisasContext *s, arg_INDEX_ir *a, uint32_t insn)
+{
+    TCGv_i64 start = tcg_const_i64(a->imm);
+    TCGv_i64 incr = cpu_reg(s, a->rm);
+    do_index(s, a->esz, a->rd, start, incr);
+    tcg_temp_free_i64(start);
+}
+
+void trans_INDEX_ri(DisasContext *s, arg_INDEX_ri *a, uint32_t insn)
+{
+    TCGv_i64 start = cpu_reg(s, a->rn);
+    TCGv_i64 incr = tcg_const_i64(a->imm);
+    do_index(s, a->esz, a->rd, start, incr);
+    tcg_temp_free_i64(incr);
+}
+
+void trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
+{
+    TCGv_i64 start = cpu_reg(s, a->rn);
+    TCGv_i64 incr = cpu_reg(s, a->rm);
+    do_index(s, a->esz, a->rd, start, incr);
+}
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index a33fec4f33..0cac3a974f 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -204,6 +204,20 @@ ORR_zzz			00000100 01 1 ..... 001 100 ..... .....		@rd_rn_rm
 EOR_zzz			00000100 10 1 ..... 001 100 ..... .....		@rd_rn_rm
 BIC_zzz			00000100 11 1 ..... 001 100 ..... .....		@rd_rn_rm
 
+### SVE Index Generation Group
+
+# SVE index generation (immediate start, immediate increment)
+INDEX_ii		00000100 esz:2 1 imm2:s5 010000 imm1:s5 rd:5
+
+# SVE index generation (immediate start, register increment)
+INDEX_ir		00000100 esz:2 1 rm:5 010010 imm:s5 rd:5
+
+# SVE index generation (register start, immediate increment)
+INDEX_ri		00000100 esz:2 1 imm:s5 010001 rn:5 rd:5
+
+# SVE index generation (register start, register increment)
+INDEX_rr		00000100 .. 1 ..... 010011 ..... .....		@rd_rn_rm_esz
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3
