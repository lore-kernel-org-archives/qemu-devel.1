Received: from eggs.gnu.org ([2001:4830:134:3::10]:40595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A8-0001Kq-4T
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A5-00022D-PJ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:40 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7A5-00021n-H0
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:37 -0500
Received: by mail-pl0-x243.google.com with SMTP id bb3so3441299plb.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:00 -0800
Message-Id: <20180217182323.25885-45-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 44/67] target/arm: Implement SVE Memory
 Contiguous Load Group
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
 target/arm/helper-sve.h    |  35 +++++++
 target/arm/sve_helper.c    | 235 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 130 +++++++++++++++++++++++++
 target/arm/sve.decode      |  44 ++++++++-
 4 files changed, 442 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2e76084992..fcc9ba5f50 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -719,3 +719,38 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4f45f11bff..e542725113 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2788,3 +2788,238 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
 
     return predtest_ones(d, oprsz, esz_mask);
 }
+
+/*
+ * Load contiguous data, protected by a governing predicate.
+ */
+#define DO_LD1(NAME, FN, TYPEE, TYPEM, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                  \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    void *vd = &env->vfp.zregs[rd];                        \
+    for (i = 0; i < oprsz; ) {                             \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
+        do {                                               \
+            TYPEM m = 0;                                   \
+            if (pg & 1) {                                  \
+                m = FN(env, addr, ra);                     \
+            }                                              \
+            *(TYPEE *)(vd + H(i)) = m;                     \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += sizeof(TYPEM);                         \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_LD1_D(NAME, FN, TYPEM)                          \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;              \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    uint64_t *d = &env->vfp.zregs[rd].d[0];                \
+    uint8_t *pg = vg;                                      \
+    for (i = 0; i < oprsz; i += 1) {                       \
+        TYPEM m = 0;                                       \
+        if (pg[H1(i)] & 1) {                               \
+            m = FN(env, addr, ra);                         \
+        }                                                  \
+        d[i] = m;                                          \
+        addr += sizeof(TYPEM);                             \
+    }                                                      \
+}
+
+#define DO_LD2(NAME, FN, TYPEE, TYPEM, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                  \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    void *d1 = &env->vfp.zregs[rd];                        \
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
+    for (i = 0; i < oprsz; ) {                             \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
+        do {                                               \
+            TYPEM m1 = 0, m2 = 0;                          \
+            if (pg & 1) {                                  \
+                m1 = FN(env, addr, ra);                    \
+                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
+            }                                              \
+            *(TYPEE *)(d1 + H(i)) = m1;                    \
+            *(TYPEE *)(d2 + H(i)) = m2;                    \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 2 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_LD3(NAME, FN, TYPEE, TYPEM, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                  \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    void *d1 = &env->vfp.zregs[rd];                        \
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
+    void *d3 = &env->vfp.zregs[(rd + 2) & 31];             \
+    for (i = 0; i < oprsz; ) {                             \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
+        do {                                               \
+            TYPEM m1 = 0, m2 = 0, m3 = 0;                  \
+            if (pg & 1) {                                  \
+                m1 = FN(env, addr, ra);                    \
+                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
+                m3 = FN(env, addr + 2 * sizeof(TYPEM), ra); \
+            }                                              \
+            *(TYPEE *)(d1 + H(i)) = m1;                    \
+            *(TYPEE *)(d2 + H(i)) = m2;                    \
+            *(TYPEE *)(d3 + H(i)) = m3;                    \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 3 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_LD4(NAME, FN, TYPEE, TYPEM, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                  \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    void *d1 = &env->vfp.zregs[rd];                        \
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
+    void *d3 = &env->vfp.zregs[(rd + 2) & 31];             \
+    void *d4 = &env->vfp.zregs[(rd + 3) & 31];             \
+    for (i = 0; i < oprsz; ) {                             \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
+        do {                                               \
+            TYPEM m1 = 0, m2 = 0, m3 = 0, m4 = 0;          \
+            if (pg & 1) {                                  \
+                m1 = FN(env, addr, ra);                    \
+                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
+                m3 = FN(env, addr + 2 * sizeof(TYPEM), ra); \
+                m4 = FN(env, addr + 3 * sizeof(TYPEM), ra); \
+            }                                              \
+            *(TYPEE *)(d1 + H(i)) = m1;                    \
+            *(TYPEE *)(d2 + H(i)) = m2;                    \
+            *(TYPEE *)(d3 + H(i)) = m3;                    \
+            *(TYPEE *)(d4 + H(i)) = m4;                    \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 4 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+DO_LD1(sve_ld1bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
+DO_LD1(sve_ld1bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
+DO_LD1(sve_ld1bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
+DO_LD1(sve_ld1bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
+DO_LD1_D(sve_ld1bdu_r, cpu_ldub_data_ra, uint8_t)
+DO_LD1_D(sve_ld1bds_r, cpu_ldsb_data_ra, int8_t)
+
+DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
+DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
+DO_LD1_D(sve_ld1hdu_r, cpu_lduw_data_ra, uint16_t)
+DO_LD1_D(sve_ld1hds_r, cpu_ldsw_data_ra, int16_t)
+
+DO_LD1_D(sve_ld1sdu_r, cpu_ldl_data_ra, uint32_t)
+DO_LD1_D(sve_ld1sds_r, cpu_ldl_data_ra, int32_t)
+
+DO_LD1(sve_ld1bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
+DO_LD2(sve_ld2bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
+DO_LD3(sve_ld3bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
+DO_LD4(sve_ld4bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
+
+DO_LD1(sve_ld1hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
+DO_LD2(sve_ld2hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
+DO_LD3(sve_ld3hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
+DO_LD4(sve_ld4hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
+
+DO_LD1(sve_ld1ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
+DO_LD2(sve_ld2ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
+DO_LD3(sve_ld3ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
+DO_LD4(sve_ld4ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
+
+DO_LD1_D(sve_ld1dd_r, cpu_ldq_data_ra, uint64_t)
+
+void HELPER(sve_ld2dd_r)(CPUARMState *env, void *vg,
+                         target_ulong addr, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;
+    intptr_t ra = GETPC();
+    unsigned rd = simd_data(desc);
+    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
+    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
+    uint8_t *pg = vg;
+
+    for (i = 0; i < oprsz; i += 1) {
+        uint64_t m1 = 0, m2 = 0;
+        if (pg[H1(i)] & 1) {
+            m1 = cpu_ldq_data_ra(env, addr, ra);
+            m2 = cpu_ldq_data_ra(env, addr + 8, ra);
+        }
+        d1[i] = m1;
+        d2[i] = m2;
+        addr += 2 * 8;
+    }
+}
+
+void HELPER(sve_ld3dd_r)(CPUARMState *env, void *vg,
+                         target_ulong addr, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;
+    intptr_t ra = GETPC();
+    unsigned rd = simd_data(desc);
+    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
+    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
+    uint64_t *d3 = &env->vfp.zregs[(rd + 2) & 31].d[0];
+    uint8_t *pg = vg;
+
+    for (i = 0; i < oprsz; i += 1) {
+        uint64_t m1 = 0, m2 = 0, m3 = 0;
+        if (pg[H1(i)] & 1) {
+            m1 = cpu_ldq_data_ra(env, addr, ra);
+            m2 = cpu_ldq_data_ra(env, addr + 8, ra);
+            m3 = cpu_ldq_data_ra(env, addr + 16, ra);
+        }
+        d1[i] = m1;
+        d2[i] = m2;
+        d3[i] = m3;
+        addr += 3 * 8;
+    }
+}
+
+void HELPER(sve_ld4dd_r)(CPUARMState *env, void *vg,
+                         target_ulong addr, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;
+    intptr_t ra = GETPC();
+    unsigned rd = simd_data(desc);
+    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
+    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
+    uint64_t *d3 = &env->vfp.zregs[(rd + 2) & 31].d[0];
+    uint64_t *d4 = &env->vfp.zregs[(rd + 3) & 31].d[0];
+    uint8_t *pg = vg;
+
+    for (i = 0; i < oprsz; i += 1) {
+        uint64_t m1 = 0, m2 = 0, m3 = 0, m4 = 0;
+        if (pg[H1(i)] & 1) {
+            m1 = cpu_ldq_data_ra(env, addr, ra);
+            m2 = cpu_ldq_data_ra(env, addr + 8, ra);
+            m3 = cpu_ldq_data_ra(env, addr + 16, ra);
+            m4 = cpu_ldq_data_ra(env, addr + 24, ra);
+        }
+        d1[i] = m1;
+        d2[i] = m2;
+        d3[i] = m3;
+        d4[i] = m4;
+        addr += 4 * 8;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f9a3ad1434..aa8bfd2ae7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -46,6 +46,8 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
+typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i32);
+
 /*
  * Helpers for extracting complex instruction fields.
  */
@@ -86,6 +88,15 @@ static inline int expand_imm_sh8u(int x)
     return (uint8_t)x << (x & 0x100 ? 8 : 0);
 }
 
+/* Convert a 2-bit memory size (msz) to a 4-bit data type (dtype)
+ * with unsigned data.  C.f. SVE Memory Contiguous Load Group.
+ */
+static inline int msz_dtype(int msz)
+{
+    static const uint8_t dtype[4] = { 0, 5, 10, 15 };
+    return dtype[msz];
+}
+
 /*
  * Include the generated decoder.
  */
@@ -3268,3 +3279,122 @@ static void trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
     int size = pred_full_reg_size(s);
     do_ldr(s, pred_full_reg_offset(s, a->rd), size, a->rn, a->imm * size);
 }
+
+/*
+ *** SVE Memory - Contiguous Load Group
+ */
+
+/* The memory element size of dtype.  */
+static const TCGMemOp dtype_mop[16] = {
+    MO_UB, MO_UB, MO_UB, MO_UB,
+    MO_SL, MO_UW, MO_UW, MO_UW,
+    MO_SW, MO_SW, MO_UL, MO_UL,
+    MO_SB, MO_SB, MO_SB, MO_Q
+};
+
+#define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
+
+/* The vector element size of dtype.  */
+static const uint8_t dtype_esz[16] = {
+    0, 1, 2, 3,
+    3, 1, 2, 3,
+    3, 2, 2, 3,
+    3, 2, 1, 3
+};
+
+static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
+                       gen_helper_gvec_mem *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr t_pg;
+    TCGv_i32 desc;
+
+    /* For e.g. LD4, there are not enough arguments to pass all 4
+       registers as pointers, so encode the regno into the data field.
+       For consistency, do this even for LD1.  */
+    desc = tcg_const_i32(simd_desc(vsz, vsz, zt));
+    t_pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+    fn(cpu_env, t_pg, addr, desc);
+
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(desc);
+    tcg_temp_free_i64(addr);
+}
+
+static void do_ld_zpa(DisasContext *s, int zt, int pg,
+                      TCGv_i64 addr, int dtype, int nreg)
+{
+    static gen_helper_gvec_mem * const fns[16][4] = {
+        { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+          gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+        { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+
+        { gen_helper_sve_ld1sds_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1hh_r, gen_helper_sve_ld2hh_r,
+          gen_helper_sve_ld3hh_r, gen_helper_sve_ld4hh_r },
+        { gen_helper_sve_ld1hsu_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1hdu_r, NULL, NULL, NULL },
+
+        { gen_helper_sve_ld1hds_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1hss_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1ss_r, gen_helper_sve_ld2ss_r,
+          gen_helper_sve_ld3ss_r, gen_helper_sve_ld4ss_r },
+        { gen_helper_sve_ld1sdu_r, NULL, NULL, NULL },
+
+        { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1dd_r, gen_helper_sve_ld2dd_r,
+          gen_helper_sve_ld3dd_r, gen_helper_sve_ld4dd_r },
+    };
+    gen_helper_gvec_mem *fn = fns[dtype][nreg];
+
+    /* While there are holes in the table, they are not
+       accessible via the instruction encoding.  */
+    assert(fn != NULL);
+    do_mem_zpa(s, zt, pg, addr, fn);
+}
+
+static void trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+{
+    TCGv_i64 addr;
+
+    if (a->rm == 31) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    addr = tcg_temp_new_i64();
+    tcg_gen_muli_i64(addr, cpu_reg(s, a->rm),
+                     (a->nreg + 1) << dtype_msz(a->dtype));
+    tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+    do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
+}
+
+static void trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned elements = vsz >> dtype_esz[a->dtype];
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
+                     (a->imm * elements * (a->nreg + 1))
+                     << dtype_msz(a->dtype));
+    do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
+}
+
+static void trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+{
+    /* FIXME */
+    trans_LD_zprr(s, a, insn);
+}
+
+static void trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    /* FIXME */
+    trans_LD_zpri(s, a, insn);
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 42d14994a1..d2b3869c58 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -42,9 +42,12 @@
 %tszimm16_shl	22:2 16:5 !function=tszimm_shl
 
 # Signed 8-bit immediate, optionally shifted left by 8.
-%sh8_i8s		5:9 !function=expand_imm_sh8s
+%sh8_i8s	5:9 !function=expand_imm_sh8s
 # Unsigned 8-bit immediate, optionally shifted left by 8.
-%sh8_i8u		5:9 !function=expand_imm_sh8u
+%sh8_i8u	5:9 !function=expand_imm_sh8u
+
+# Unsigned load of msz into esz=2, represented as a dtype.
+%msz_dtype	23:2 !function=msz_dtype
 
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
@@ -72,6 +75,8 @@
 &incdec2_cnt	rd rn pat esz imm d u
 &incdec_pred	rd pg esz d u
 &incdec2_pred	rd rn pg esz d u
+&rprr_load	rd pg rn rm dtype nreg
+&rpri_load	rd pg rn imm dtype nreg
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -171,6 +176,15 @@
 @incdec2_pred	........ esz:2 .... .. ..... .. pg:4 rd:5 \
 		&incdec2_pred rn=%reg_movprfx
 
+# Loads; user must fill in NREG.
+@rprr_load_dt	....... dtype:4 rm:5 ... pg:3 rn:5 rd:5		&rprr_load
+@rpri_load_dt	....... dtype:4 . imm:s4 ... pg:3 rn:5 rd:5	&rpri_load
+
+@rprr_load_msz	....... .... rm:5 ... pg:3 rn:5 rd:5 \
+		&rprr_load dtype=%msz_dtype
+@rpri_load_msz	....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
+		&rpri_load dtype=%msz_dtype
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -673,3 +687,29 @@ LDR_pri		10000101 10 ...... 000 ... ..... 0 ....		@pd_rn_i9
 
 # SVE load vector register
 LDR_zri		10000101 10 ...... 010 ... ..... .....		@rd_rn_i9
+
+### SVE Memory Contiguous Load Group
+
+# SVE contiguous load (scalar plus scalar)
+LD_zprr		1010010 .... ..... 010 ... ..... .....    @rprr_load_dt nreg=0
+
+# SVE contiguous first-fault load (scalar plus scalar)
+LDFF1_zprr	1010010 .... ..... 011 ... ..... .....	  @rprr_load_dt nreg=0
+
+# SVE contiguous load (scalar plus immediate)
+LD_zpri		1010010 .... 0.... 101 ... ..... .....    @rpri_load_dt nreg=0
+
+# SVE contiguous non-fault load (scalar plus immediate)
+LDNF1_zpri	1010010 .... 1.... 101 ... ..... .....    @rpri_load_dt nreg=0
+
+# SVE contiguous non-temporal load (scalar plus scalar)
+# LDNT1B, LDNT1H, LDNT1W, LDNT1D
+# SVE load multiple structures (scalar plus scalar)
+# LD2B, LD2H, LD2W, LD2D; etc.
+LD_zprr		1010010 .. nreg:2 ..... 110 ... ..... .....	@rprr_load_msz
+
+# SVE contiguous non-temporal load (scalar plus immediate)
+# LDNT1B, LDNT1H, LDNT1W, LDNT1D
+# SVE load multiple structures (scalar plus immediate)
+# LD2B, LD2H, LD2W, LD2D; etc.
+LD_zpri		1010010 .. nreg:2 0.... 111 ... ..... .....	@rpri_load_msz
-- 
2.14.3
