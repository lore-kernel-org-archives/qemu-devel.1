Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29M-00049p-6R
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29J-0000Ke-Ml
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:48 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:46870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29J-0000IM-94
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:45 -0400
Received: by mail-pf0-x22f.google.com with SMTP id q1-v6so379241pff.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:33:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:02 -0700
Message-Id: <20180627043328.11531-10-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 09/35] target/arm: Implement SVE load and
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v6: Fix typo in comment.
---
 target/arm/helper-sve.h    |  5 +++
 target/arm/sve_helper.c    | 41 +++++++++++++++++++++++++
 target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  5 +++
 4 files changed, 113 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 68e55a8d03..a5d3bb121c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -274,6 +274,11 @@ DEF_HELPER_FLAGS_3(sve_clr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_clr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_clr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_movz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_movz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_movz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_movz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 2d08b7dcd3..93f2942590 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -995,6 +995,47 @@ void HELPER(sve_clr_d)(void *vd, void *vg, uint32_t desc)
     }
 }
 
+/* Copy Zn into Zd, and store zero into inactive elements.  */
+void HELPER(sve_movz_b)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] & expand_pred_b(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_movz_h)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] & expand_pred_h(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_movz_s)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[i] & expand_pred_s(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = n[1] & -(uint64_t)(pg[H1(i)] & 1);
+    }
+}
+
 /* Three-operand expander, immediate operand, controlled by a predicate.
  */
 #define DO_ZPZI(NAME, TYPE, H, OP)                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 483ad33179..954d6653d3 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -606,6 +606,20 @@ static bool do_clr_zp(DisasContext *s, int rd, int pg, int esz)
     return true;
 }
 
+/* Copy Zn into Zd, storing zeros into inactive elements.  */
+static void do_movz_zpz(DisasContext *s, int rd, int rn, int pg, int esz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_movz_b, gen_helper_sve_movz_h,
+        gen_helper_sve_movz_s, gen_helper_sve_movz_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, 0, fns[esz]);
+}
+
 static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
                         gen_helper_gvec_3 *fn)
 {
@@ -3999,6 +4013,54 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     return true;
 }
 
+/* Load and broadcast element.  */
+static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned psz = pred_full_reg_size(s);
+    unsigned esz = dtype_esz[a->dtype];
+    TCGLabel *over = gen_new_label();
+    TCGv_i64 temp;
+
+    /* If the guarding predicate has no bits set, no load occurs.  */
+    if (psz <= 8) {
+        /* Reduce the pred_esz_masks value simply to reduce the
+         * size of the code generated here.
+         */
+        uint64_t psz_mask = MAKE_64BIT_MASK(0, psz * 8);
+        temp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(temp, cpu_env, pred_full_reg_offset(s, a->pg));
+        tcg_gen_andi_i64(temp, temp, pred_esz_masks[esz] & psz_mask);
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
+    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << esz);
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
+    do_movz_zpz(s, a->rd, a->rd, a->pg, esz);
+    return true;
+}
+
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 675b81aaa0..765e7e479b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -28,6 +28,7 @@
 %imm8_16_10     16:5 10:3
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
+%dtype_23_13    23:2 13:2
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz     22:2 5:5 !function=tszimm_esz
@@ -751,6 +752,10 @@ LDR_pri         10000101 10 ...... 000 ... ..... 0 ....         @pd_rn_i9
 # SVE load vector register
 LDR_zri         10000101 10 ...... 010 ... ..... .....          @rd_rn_i9
 
+# SVE load and broadcast element
+LD1R_zpri       1000010 .. 1 imm:6 1.. pg:3 rn:5 rd:5 \
+                &rpri_load dtype=%dtype_23_13 nreg=0
+
 ### SVE Memory Contiguous Load Group
 
 # SVE contiguous load (scalar plus scalar)
-- 
2.17.1
