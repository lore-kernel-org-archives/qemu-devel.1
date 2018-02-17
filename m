Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AK-0001YK-6W
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AH-000292-3g
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:52 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AG-00028c-SX
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:49 -0500
Received: by mail-pl0-x241.google.com with SMTP id k8so3439026pli.8
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:07 -0800
Message-Id: <20180217182323.25885-52-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 51/67] target/arm: Implement SVE load and
 broadcast element
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
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve_helper.c    | 43 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/sve.decode      |  5 +++++
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c4502256d5..6c640a92ff 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -274,6 +274,11 @@ DEF_HELPER_FLAGS_3(sve_clr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_clr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_clr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_clri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0e2b3091b0..a7dc6f6164 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -994,6 +994,49 @@ void HELPER(sve_clr_d)(void *vd, void *vg, uint32_t desc)
     }
 }
 
+/* Store zero into every inactive element of Zd.  */
+void HELPER(sve_clri_b)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= expand_pred_b(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clri_h)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= expand_pred_h(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clri_s)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= expand_pred_s(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clri_d)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        if (!(pg[H1(i)] & 1)) {
+            d[i] = 0;
+        }
+    }
+}
+
 /* Three-operand expander, immediate operand, controlled by a predicate.
  */
 #define DO_ZPZI(NAME, TYPE, H, OP)                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 32f0340738..b000a2482e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -584,6 +584,19 @@ static void do_clr_zp(DisasContext *s, int rd, int pg, int esz)
                        vsz, vsz, 0, fns[esz]);
 }
 
+/* Store zero into every inactive element of Zd.  */
+static void do_clr_inactive_zp(DisasContext *s, int rd, int pg, int esz)
+{
+    static gen_helper_gvec_2 * const fns[4] = {
+        gen_helper_sve_clri_b, gen_helper_sve_clri_h,
+        gen_helper_sve_clri_s, gen_helper_sve_clri_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, 0, fns[esz]);
+}
+
 static void do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
                         gen_helper_gvec_3 *fn)
 {
@@ -3506,7 +3519,7 @@ static void trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
  *** SVE Memory - Contiguous Load Group
  */
 
-/* The memory element size of dtype.  */
+/* The memory mode of the dtype.  */
 static const TCGMemOp dtype_mop[16] = {
     MO_UB, MO_UB, MO_UB, MO_UB,
     MO_SL, MO_UW, MO_UW, MO_UW,
@@ -3671,6 +3684,46 @@ static void trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     do_ldrq(s, a->rd, a->pg, addr, dtype_msz(a->dtype));
 }
 
+/* Load and broadcast element.  */
+static void trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned psz = pred_full_reg_size(s);
+    unsigned esz = dtype_esz[a->dtype];
+    TCGLabel *over = gen_new_label();
+    TCGv_i64 temp;
+
+    /* If the guarding predicate has no bits set, no load occurs.  */
+    if (psz <= 8) {
+        temp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(temp, cpu_env, pred_full_reg_offset(s, a->pg));
+        tcg_gen_andi_i64(temp, temp,
+                         deposit64(0, 0, psz * 8, pred_esz_masks[esz]));
+        tcg_gen_brcondi_i64(TCG_COND_EQ, temp, 0, over);
+        tcg_temp_free_i64(temp);
+    } else {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        find_last_active(s, t32, esz, a->pg);
+        tcg_gen_brcondi_i32(TCG_COND_LT, t32, 0, over);
+        tcg_temp_free_i32(t32);
+    }
+
+    /* Load the data.  */
+    temp = tcg_temp_new_i64();
+    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm);
+    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
+                        s->be_data | dtype_mop[a->dtype]);
+
+    /* Broadcast to *all* elements.  */
+    tcg_gen_gvec_dup_i64(esz, vec_full_reg_offset(s, a->rd),
+                         vsz, vsz, temp);
+    tcg_temp_free_i64(temp);
+
+    /* Zero the inactive elements.  */
+    gen_set_label(over);
+    do_clr_inactive_zp(s, a->rd, a->pg, esz);
+}
+
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95a290aed0..3e30985a09 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10	16:s6 10:3
 %preg4_5	5:4
 %size_23	23:2
+%dtype_23_13	23:2 13:2
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz	22:2 5:5 !function=tszimm_esz
@@ -758,6 +759,10 @@ LDR_pri		10000101 10 ...... 000 ... ..... 0 ....		@pd_rn_i9
 # SVE load vector register
 LDR_zri		10000101 10 ...... 010 ... ..... .....		@rd_rn_i9
 
+# SVE load and broadcast element
+LD1R_zpri	1000010 .. 1 imm:6 1.. pg:3 rn:5 rd:5 \
+		&rpri_load dtype=%dtype_23_13 nreg=0
+
 ### SVE Memory Contiguous Load Group
 
 # SVE contiguous load (scalar plus scalar)
-- 
2.14.3
