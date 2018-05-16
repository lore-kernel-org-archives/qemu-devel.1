Received: from eggs.gnu.org ([2001:4830:134:3::10]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wT-0007sr-Lk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wQ-0007bx-Dh
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:41 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:38195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wQ-0007bN-0F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:38 -0400
Received: by mail-pf0-x22e.google.com with SMTP id o76-v6so1055271pfi.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:59 -0700
Message-Id: <20180516223007.10256-20-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 19/27] target/arm: Implement SVE Compute
 Vector Address Group
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 36 ++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 12 ++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 00e3cd48bb..5280d375f9 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -380,6 +380,11 @@ DEF_HELPER_FLAGS_4(sve_lsl_zzw_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_lsl_zzw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_lsl_zzw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_adr_p32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_p64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_s32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_adr_u32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f43640c1eb..7fa8394aec 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1062,3 +1062,43 @@ void HELPER(sve_index_d)(void *vd, uint64_t start,
         d[i] = start + i * incr;
     }
 }
+
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
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2c2218bc31..8924848463 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -893,6 +893,42 @@ static bool trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Compute Vector Address Group
+ */
+
+static bool do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, a->imm, fn);
+    }
+    return true;
+}
+
+static bool trans_ADR_p32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    return do_adr(s, a, gen_helper_sve_adr_p32);
+}
+
+static bool trans_ADR_p64(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    return do_adr(s, a, gen_helper_sve_adr_p64);
+}
+
+static bool trans_ADR_s32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    return do_adr(s, a, gen_helper_sve_adr_s32);
+}
+
+static bool trans_ADR_u32(DisasContext *s, arg_rrri *a, uint32_t insn)
+{
+    return do_adr(s, a, gen_helper_sve_adr_u32);
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b24f6b2f1b..691876de4e 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -48,6 +48,7 @@
 
 &rr_esz         rd rn esz
 &rri            rd rn imm
+&rrri           rd rn rm imm
 &rri_esz        rd rn imm esz
 &rrr_esz        rd rn rm esz
 &rpr_esz        rd pg rn esz
@@ -75,6 +76,9 @@
 # Three operand, vector element size
 @rd_rn_rm       ........ esz:2 . rm:5 ... ... rn:5 rd:5         &rrr_esz
 
+# Three operand with "memory" size, aka immediate left shift
+@rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
+
 # Two register operand, with governing predicate, vector element size
 @rdn_pg_rm      ........ esz:2 ... ... ... pg:3 rm:5 rd:5 \
                 &rprr_esz rn=%reg_movprfx
@@ -276,6 +280,14 @@ ASR_zzw         00000100 .. 1 ..... 1000 00 ..... .....         @rd_rn_rm
 LSR_zzw         00000100 .. 1 ..... 1000 01 ..... .....         @rd_rn_rm
 LSL_zzw         00000100 .. 1 ..... 1000 11 ..... .....         @rd_rn_rm
 
+### SVE Compute Vector Address Group
+
+# SVE vector address generation
+ADR_s32         00000100 00 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
+ADR_u32         00000100 01 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
+ADR_p32         00000100 10 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
+ADR_p64         00000100 11 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.0
