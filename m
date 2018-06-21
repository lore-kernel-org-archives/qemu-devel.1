Received: from eggs.gnu.org ([2001:4830:134:3::10]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonu-0004PB-Jm
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonr-000361-8a
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:30 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVonq-00035O-W9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:27 -0400
Received: by mail-pl0-x230.google.com with SMTP id k1-v6so756899plt.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:35 -1000
Message-Id: <20180621015359.12018-12-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 11/35] target/arm: Implement SVE scatter
 stores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 41 +++++++++++++++++++++
 target/arm/sve_helper.c    | 62 ++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 74 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 39 ++++++++++++++++++++
 4 files changed, 216 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index a5d3bb121c..8880128f9c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -958,3 +958,44 @@ DEF_HELPER_FLAGS_4(sve_st1hs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbs_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a9c98bca32..ed4861a292 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3712,3 +3712,65 @@ void HELPER(sve_st4dd_r)(CPUARMState *env, void *vg,
         addr += 4 * 8;
     }
 }
+
+/* Stores with a vector index.  */
+
+#define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
+void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
+                  target_ulong base, uint32_t desc)                     \
+{                                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;                           \
+    unsigned scale = simd_data(desc);                                   \
+    uintptr_t ra = GETPC();                                             \
+    uint32_t *d = vd; TYPEI *m = vm; uint8_t *pg = vg;                  \
+    for (i = 0; i < oprsz; i++) {                                       \
+        uint8_t pp = pg[H1(i)];                                         \
+        if (pp & 0x01) {                                                \
+            target_ulong off = (target_ulong)m[H4(i * 2)] << scale;     \
+            FN(env, base + off, d[H4(i * 2)], ra);                      \
+        }                                                               \
+        if (pp & 0x10) {                                                \
+            target_ulong off = (target_ulong)m[H4(i * 2 + 1)] << scale; \
+            FN(env, base + off, d[H4(i * 2 + 1)], ra);                  \
+        }                                                               \
+    }                                                                   \
+}
+
+#define DO_ST1_ZPZ_D(NAME, TYPEI, FN)                                   \
+void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
+                  target_ulong base, uint32_t desc)                     \
+{                                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;                           \
+    unsigned scale = simd_data(desc);                                   \
+    uintptr_t ra = GETPC();                                             \
+    uint64_t *d = vd, *m = vm; uint8_t *pg = vg;                        \
+    for (i = 0; i < oprsz; i++) {                                       \
+        if (pg[H1(i)] & 1) {                                            \
+            target_ulong off = (target_ulong)(TYPEI)m[i] << scale;      \
+            FN(env, base + off, d[i], ra);                              \
+        }                                                               \
+    }                                                                   \
+}
+
+DO_ST1_ZPZ_S(sve_stbs_zsu, uint32_t, cpu_stb_data_ra)
+DO_ST1_ZPZ_S(sve_sths_zsu, uint32_t, cpu_stw_data_ra)
+DO_ST1_ZPZ_S(sve_stss_zsu, uint32_t, cpu_stl_data_ra)
+
+DO_ST1_ZPZ_S(sve_stbs_zss, int32_t, cpu_stb_data_ra)
+DO_ST1_ZPZ_S(sve_sths_zss, int32_t, cpu_stw_data_ra)
+DO_ST1_ZPZ_S(sve_stss_zss, int32_t, cpu_stl_data_ra)
+
+DO_ST1_ZPZ_D(sve_stbd_zsu, uint32_t, cpu_stb_data_ra)
+DO_ST1_ZPZ_D(sve_sthd_zsu, uint32_t, cpu_stw_data_ra)
+DO_ST1_ZPZ_D(sve_stsd_zsu, uint32_t, cpu_stl_data_ra)
+DO_ST1_ZPZ_D(sve_stdd_zsu, uint32_t, cpu_stq_data_ra)
+
+DO_ST1_ZPZ_D(sve_stbd_zss, int32_t, cpu_stb_data_ra)
+DO_ST1_ZPZ_D(sve_sthd_zss, int32_t, cpu_stw_data_ra)
+DO_ST1_ZPZ_D(sve_stsd_zss, int32_t, cpu_stl_data_ra)
+DO_ST1_ZPZ_D(sve_stdd_zss, int32_t, cpu_stq_data_ra)
+
+DO_ST1_ZPZ_D(sve_stbd_zd, uint64_t, cpu_stb_data_ra)
+DO_ST1_ZPZ_D(sve_sthd_zd, uint64_t, cpu_stw_data_ra)
+DO_ST1_ZPZ_D(sve_stsd_zd, uint64_t, cpu_stl_data_ra)
+DO_ST1_ZPZ_D(sve_stdd_zd, uint64_t, cpu_stq_data_ra)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 50f1ff75ef..6e1907cedd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -43,6 +43,8 @@ typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
 typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i32);
+typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
+                                         TCGv_ptr, TCGv_i64, TCGv_i32);
 
 /*
  * Helpers for extracting complex instruction fields.
@@ -4228,3 +4230,75 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a, uint32_t insn)
     }
     return true;
 }
+
+/*
+ *** SVE gather loads / scatter stores
+ */
+
+static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm, int scale,
+                       TCGv_i64 scalar, gen_helper_gvec_mem_scatter *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_i32 desc = tcg_const_i32(simd_desc(vsz, vsz, scale));
+    TCGv_ptr t_zm = tcg_temp_new_ptr();
+    TCGv_ptr t_pg = tcg_temp_new_ptr();
+    TCGv_ptr t_zt = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+    tcg_gen_addi_ptr(t_zm, cpu_env, vec_full_reg_offset(s, zm));
+    tcg_gen_addi_ptr(t_zt, cpu_env, vec_full_reg_offset(s, zt));
+    fn(cpu_env, t_zt, t_pg, t_zm, scalar, desc);
+
+    tcg_temp_free_ptr(t_zt);
+    tcg_temp_free_ptr(t_zm);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(desc);
+}
+
+static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
+{
+    /* Indexed by [xs][msz].  */
+    static gen_helper_gvec_mem_scatter * const fn32[2][3] = {
+        { gen_helper_sve_stbs_zsu,
+          gen_helper_sve_sths_zsu,
+          gen_helper_sve_stss_zsu, },
+        { gen_helper_sve_stbs_zss,
+          gen_helper_sve_sths_zss,
+          gen_helper_sve_stss_zss, },
+    };
+    static gen_helper_gvec_mem_scatter * const fn64[3][4] = {
+        { gen_helper_sve_stbd_zsu,
+          gen_helper_sve_sthd_zsu,
+          gen_helper_sve_stsd_zsu,
+          gen_helper_sve_stdd_zsu, },
+        { gen_helper_sve_stbd_zss,
+          gen_helper_sve_sthd_zss,
+          gen_helper_sve_stsd_zss,
+          gen_helper_sve_stdd_zss, },
+        { gen_helper_sve_stbd_zd,
+          gen_helper_sve_sthd_zd,
+          gen_helper_sve_stsd_zd,
+          gen_helper_sve_stdd_zd, },
+    };
+    gen_helper_gvec_mem_scatter *fn;
+
+    if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+    switch (a->esz) {
+    case MO_32:
+        fn = fn32[a->xs][a->msz];
+        break;
+    case MO_64:
+        fn = fn64[a->xs][a->msz];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
+               cpu_reg_sp(s, a->rn), fn);
+    return true;
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index c088e51493..2ca0fd85e6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -80,6 +80,7 @@
 &rpri_load      rd pg rn imm dtype nreg
 &rprr_store     rd pg rn rm msz esz nreg
 &rpri_store     rd pg rn imm msz esz nreg
+&rprr_scatter_store     rd pg rn rm esz msz xs scale
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -198,6 +199,8 @@
 @rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
 @rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
                     &rprr_store nreg=0
+@rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
+                    &rprr_scatter_store
 
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
@@ -824,3 +827,39 @@ ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
 # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
 ST_zprr         1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
                 @rprr_store esz=%size_23
+
+# SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
+# Require msz > 0 && msz <= esz.
+ST1_zprz        1110010 .. 11 ..... 100 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=2 scale=1
+ST1_zprz        1110010 .. 11 ..... 110 ... ..... ..... \
+                @rprr_scatter_store xs=1 esz=2 scale=1
+
+# SVE 32-bit scatter store (scalar plus 32-bit unscaled offsets)
+# Require msz <= esz.
+ST1_zprz        1110010 .. 10 ..... 100 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=2 scale=0
+ST1_zprz        1110010 .. 10 ..... 110 ... ..... ..... \
+                @rprr_scatter_store xs=1 esz=2 scale=0
+
+# SVE 64-bit scatter store (scalar plus 64-bit scaled offset)
+# Require msz > 0
+ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
+                @rprr_scatter_store xs=2 esz=3 scale=1
+
+# SVE 64-bit scatter store (scalar plus 64-bit unscaled offset)
+ST1_zprz        1110010 .. 00 ..... 101 ... ..... ..... \
+                @rprr_scatter_store xs=2 esz=3 scale=0
+
+# SVE 64-bit scatter store (scalar plus unpacked 32-bit scaled offset)
+# Require msz > 0
+ST1_zprz        1110010 .. 01 ..... 100 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=3 scale=1
+ST1_zprz        1110010 .. 01 ..... 110 ... ..... ..... \
+                @rprr_scatter_store xs=1 esz=3 scale=1
+
+# SVE 64-bit scatter store (scalar plus unpacked 32-bit unscaled offset)
+ST1_zprz        1110010 .. 00 ..... 100 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=3 scale=0
+ST1_zprz        1110010 .. 00 ..... 110 ... ..... ..... \
+                @rprr_scatter_store xs=1 esz=3 scale=0
-- 
2.17.1
