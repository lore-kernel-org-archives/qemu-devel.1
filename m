Received: from eggs.gnu.org ([2001:4830:134:3::10]:33654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumd-0007IJ-Tl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumb-00066E-KE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumb-0005dk-8D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumZ-0004XY-F9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:01 +0100
Message-Id: <20180629145347.652-10-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/55] target/arm: Implement SVE Memory
 Contiguous Store Group
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
Message-id: 20180627043328.11531-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  29 +++++
 target/arm/sve_helper.c    | 211 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  65 ++++++++++++
 target/arm/sve.decode      |  38 +++++++
 4 files changed, 343 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 7338abbbcfe..b7681289519 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -794,3 +794,32 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0d22a57a22e..bd874e6fa28 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3120,3 +3120,214 @@ DO_LDNF1(sds_r)
 DO_LDNF1(dd_r)
 
 #undef DO_LDNF1
+
+/*
+ * Store contiguous data, protected by a governing predicate.
+ */
+#define DO_ST1(NAME, FN, TYPEE, TYPEM, H)                  \
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
+            if (pg & 1) {                                  \
+                TYPEM m = *(TYPEE *)(vd + H(i));           \
+                FN(env, addr, m, ra);                      \
+            }                                              \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += sizeof(TYPEM);                         \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_ST1_D(NAME, FN, TYPEM)                          \
+void HELPER(NAME)(CPUARMState *env, void *vg,              \
+                  target_ulong addr, uint32_t desc)        \
+{                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;              \
+    intptr_t ra = GETPC();                                 \
+    unsigned rd = simd_data(desc);                         \
+    uint64_t *d = &env->vfp.zregs[rd].d[0];                \
+    uint8_t *pg = vg;                                      \
+    for (i = 0; i < oprsz; i += 1) {                       \
+        if (pg[H1(i)] & 1) {                               \
+            FN(env, addr, d[i], ra);                       \
+        }                                                  \
+        addr += sizeof(TYPEM);                             \
+    }                                                      \
+}
+
+#define DO_ST2(NAME, FN, TYPEE, TYPEM, H)                  \
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
+            if (pg & 1) {                                  \
+                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
+                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
+                FN(env, addr, m1, ra);                     \
+                FN(env, addr + sizeof(TYPEM), m2, ra);     \
+            }                                              \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 2 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_ST3(NAME, FN, TYPEE, TYPEM, H)                  \
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
+            if (pg & 1) {                                  \
+                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
+                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
+                TYPEM m3 = *(TYPEE *)(d3 + H(i));          \
+                FN(env, addr, m1, ra);                     \
+                FN(env, addr + sizeof(TYPEM), m2, ra);     \
+                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
+            }                                              \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 3 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+#define DO_ST4(NAME, FN, TYPEE, TYPEM, H)                  \
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
+            if (pg & 1) {                                  \
+                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
+                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
+                TYPEM m3 = *(TYPEE *)(d3 + H(i));          \
+                TYPEM m4 = *(TYPEE *)(d4 + H(i));          \
+                FN(env, addr, m1, ra);                     \
+                FN(env, addr + sizeof(TYPEM), m2, ra);     \
+                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
+                FN(env, addr + 3 * sizeof(TYPEM), m4, ra); \
+            }                                              \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
+            addr += 4 * sizeof(TYPEM);                     \
+        } while (i & 15);                                  \
+    }                                                      \
+}
+
+DO_ST1(sve_st1bh_r, cpu_stb_data_ra, uint16_t, uint8_t, H1_2)
+DO_ST1(sve_st1bs_r, cpu_stb_data_ra, uint32_t, uint8_t, H1_4)
+DO_ST1_D(sve_st1bd_r, cpu_stb_data_ra, uint8_t)
+
+DO_ST1(sve_st1hs_r, cpu_stw_data_ra, uint32_t, uint16_t, H1_4)
+DO_ST1_D(sve_st1hd_r, cpu_stw_data_ra, uint16_t)
+
+DO_ST1_D(sve_st1sd_r, cpu_stl_data_ra, uint32_t)
+
+DO_ST1(sve_st1bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
+DO_ST2(sve_st2bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
+DO_ST3(sve_st3bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
+DO_ST4(sve_st4bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
+
+DO_ST1(sve_st1hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
+DO_ST2(sve_st2hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
+DO_ST3(sve_st3hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
+DO_ST4(sve_st4hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
+
+DO_ST1(sve_st1ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
+DO_ST2(sve_st2ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
+DO_ST3(sve_st3ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
+DO_ST4(sve_st4ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
+
+DO_ST1_D(sve_st1dd_r, cpu_stq_data_ra, uint64_t)
+
+void HELPER(sve_st2dd_r)(CPUARMState *env, void *vg,
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
+        if (pg[H1(i)] & 1) {
+            cpu_stq_data_ra(env, addr, d1[i], ra);
+            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
+        }
+        addr += 2 * 8;
+    }
+}
+
+void HELPER(sve_st3dd_r)(CPUARMState *env, void *vg,
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
+        if (pg[H1(i)] & 1) {
+            cpu_stq_data_ra(env, addr, d1[i], ra);
+            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
+            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
+        }
+        addr += 3 * 8;
+    }
+}
+
+void HELPER(sve_st4dd_r)(CPUARMState *env, void *vg,
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
+        if (pg[H1(i)] & 1) {
+            cpu_stq_data_ra(env, addr, d1[i], ra);
+            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
+            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
+            cpu_stq_data_ra(env, addr + 24, d4[i], ra);
+        }
+        addr += 4 * 8;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 09f77b54054..b25fe96b77d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3716,3 +3716,68 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     }
     return true;
 }
+
+static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
+                      int msz, int esz, int nreg)
+{
+    static gen_helper_gvec_mem * const fn_single[4][4] = {
+        { gen_helper_sve_st1bb_r, gen_helper_sve_st1bh_r,
+          gen_helper_sve_st1bs_r, gen_helper_sve_st1bd_r },
+        { NULL,                   gen_helper_sve_st1hh_r,
+          gen_helper_sve_st1hs_r, gen_helper_sve_st1hd_r },
+        { NULL, NULL,
+          gen_helper_sve_st1ss_r, gen_helper_sve_st1sd_r },
+        { NULL, NULL, NULL, gen_helper_sve_st1dd_r },
+    };
+    static gen_helper_gvec_mem * const fn_multiple[3][4] = {
+        { gen_helper_sve_st2bb_r, gen_helper_sve_st2hh_r,
+          gen_helper_sve_st2ss_r, gen_helper_sve_st2dd_r },
+        { gen_helper_sve_st3bb_r, gen_helper_sve_st3hh_r,
+          gen_helper_sve_st3ss_r, gen_helper_sve_st3dd_r },
+        { gen_helper_sve_st4bb_r, gen_helper_sve_st4hh_r,
+          gen_helper_sve_st4ss_r, gen_helper_sve_st4dd_r },
+    };
+    gen_helper_gvec_mem *fn;
+
+    if (nreg == 0) {
+        /* ST1 */
+        fn = fn_single[msz][esz];
+    } else {
+        /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
+        assert(msz == esz);
+        fn = fn_multiple[nreg - 1][msz];
+    }
+    assert(fn != NULL);
+    do_mem_zpa(s, zt, pg, addr, fn);
+}
+
+static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
+{
+    if (a->rm == 31 || a->msz > a->esz) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        TCGv_i64 addr = new_tmp_a64(s);
+        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm), (a->nreg + 1) << a->msz);
+        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+        do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
+    }
+    return true;
+}
+
+static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a, uint32_t insn)
+{
+    if (a->msz > a->esz) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        int vsz = vec_full_reg_size(s);
+        int elements = vsz >> a->esz;
+        TCGv_i64 addr = new_tmp_a64(s);
+
+        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
+                         (a->imm * elements * (a->nreg + 1)) << a->msz);
+        do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
+    }
+    return true;
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index afbed57de1d..6e159faaec6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -27,6 +27,7 @@
 %imm7_22_16     22:2 16:5
 %imm8_16_10     16:5 10:3
 %imm9_16_10     16:s6 10:3
+%size_23        23:2
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz     22:2 5:5 !function=tszimm_esz
@@ -76,6 +77,8 @@
 &incdec2_pred   rd rn pg esz d u
 &rprr_load      rd pg rn rm dtype nreg
 &rpri_load      rd pg rn imm dtype nreg
+&rprr_store     rd pg rn rm msz esz nreg
+&rpri_store     rd pg rn imm msz esz nreg
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -184,6 +187,12 @@
 @rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
                 &rpri_load dtype=%msz_dtype
 
+# Stores; user must fill in ESZ, MSZ, NREG as needed.
+@rprr_store         ....... ..    ..     rm:5 ... pg:3 rn:5 rd:5    &rprr_store
+@rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
+@rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
+                    &rprr_store nreg=0
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -705,3 +714,32 @@ LD_zprr         1010010 .. nreg:2 ..... 110 ... ..... .....     @rprr_load_msz
 # SVE load multiple structures (scalar plus immediate)
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_load_msz
+
+### SVE Memory Store Group
+
+# SVE contiguous store (scalar plus immediate)
+# ST1B, ST1H, ST1W, ST1D; require msz <= esz
+ST_zpri         1110010 .. esz:2  0.... 111 ... ..... ..... \
+                @rpri_store_msz nreg=0
+
+# SVE contiguous store (scalar plus scalar)
+# ST1B, ST1H, ST1W, ST1D; require msz <= esz
+# Enumerate msz lest we conflict with STR_zri.
+ST_zprr         1110010 00 ..     ..... 010 ... ..... ..... \
+                @rprr_store_esz_n0 msz=0
+ST_zprr         1110010 01 ..     ..... 010 ... ..... ..... \
+                @rprr_store_esz_n0 msz=1
+ST_zprr         1110010 10 ..     ..... 010 ... ..... ..... \
+                @rprr_store_esz_n0 msz=2
+ST_zprr         1110010 11 11     ..... 010 ... ..... ..... \
+                @rprr_store msz=3 esz=3 nreg=0
+
+# SVE contiguous non-temporal store (scalar plus immediate)  (nreg == 0)
+# SVE store multiple structures (scalar plus immediate)      (nreg != 0)
+ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
+                @rpri_store_msz esz=%size_23
+
+# SVE contiguous non-temporal store (scalar plus scalar)     (nreg == 0)
+# SVE store multiple structures (scalar plus scalar)         (nreg != 0)
+ST_zprr         1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
+                @rprr_store esz=%size_23
-- 
2.17.1
