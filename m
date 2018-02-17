Received: from eggs.gnu.org ([2001:4830:134:3::10]:39643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79D-0000HY-BV
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79B-0001Xk-7o
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:43 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79B-0001XR-08
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:41 -0500
Received: by mail-pg0-x244.google.com with SMTP id l4so2191070pgp.11
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:24 -0800
Message-Id: <20180217182323.25885-9-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/67] target/arm: Implement SVE Predicate
 Misc Group
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
 target/arm/cpu.h           |   3 +
 target/arm/helper-sve.h    |   3 +
 target/arm/sve_helper.c    |  86 +++++++++++++++++++++++-
 target/arm/translate-sve.c | 163 ++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/sve.decode      |  41 ++++++++++++
 5 files changed, 293 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8befe43a01..27f395183b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2915,4 +2915,7 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
     return &env->vfp.zregs[regno].d[0];
 }
 
+/* Shared between translate-sve.c and sve_helper.c.  */
+extern const uint64_t pred_esz_masks[4];
+
 #endif
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 57adc4d912..0c04afff8c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -20,6 +20,9 @@
 DEF_HELPER_FLAGS_2(sve_predtest1, TCG_CALL_NO_WG, i32, i64, i64)
 DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_pfirst, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_pnext, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b63e7cc90e..cee7d9bcf6 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -39,7 +39,7 @@
 
 static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
 {
-    if (g) {
+    if (likely(g)) {
         /* Compute N from first D & G.
            Use bit 2 to signal first G bit seen.  */
         if (!(flags & 4)) {
@@ -114,3 +114,87 @@ LOGICAL_PPPP(sve_nand_pppp, DO_NAND)
 #undef DO_NAND
 #undef DO_SEL
 #undef LOGICAL_PPPP
+
+/* Similar to the ARM LastActiveElement pseudocode function, except the
+   result is multiplied by the element size.  This includes the not found
+   indication; e.g. not found for esz=3 is -8.  */
+static intptr_t last_active_element(uint64_t *g, intptr_t words, intptr_t esz)
+{
+    uint64_t mask = pred_esz_masks[esz];
+    intptr_t i = words;
+
+    do {
+        uint64_t this_g = g[--i] & mask;
+        if (this_g) {
+            return i * 64 + (63 - clz64(this_g));
+        }
+    } while (i > 0);
+    return (intptr_t)-1 << esz;
+}
+
+uint32_t HELPER(sve_pfirst)(void *vd, void *vg, uint32_t words)
+{
+    uint32_t flags = PREDTEST_INIT;
+    uint64_t *d = vd, *g = vg;
+    intptr_t i = 0;
+
+    do {
+        uint64_t this_d = d[i];
+        uint64_t this_g = g[i];
+
+        if (this_g) {
+            if (!(flags & 4)) {
+                /* Set in D the first bit of G.  */
+                this_d |= this_g & -this_g;
+                d[i] = this_d;
+            }
+            flags = iter_predtest_fwd(this_d, this_g, flags);
+        }
+    } while (++i < words);
+
+    return flags;
+}
+
+uint32_t HELPER(sve_pnext)(void *vd, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = extract32(pred_desc, 0, SIMD_OPRSZ_BITS);
+    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    uint32_t flags = PREDTEST_INIT;
+    uint64_t *d = vd, *g = vg, esz_mask;
+    intptr_t i, next;
+
+    next = last_active_element(vd, words, esz) + (1 << esz);
+    esz_mask = pred_esz_masks[esz];
+
+    /* Similar to the pseudocode for pnext, but scaled by ESZ
+       so that we find the correct bit.  */
+    if (next < words * 64) {
+        uint64_t mask = -1;
+
+        if (next & 63) {
+            mask = ~((1ull << (next & 63)) - 1);
+            next &= -64;
+        }
+        do {
+            uint64_t this_g = g[next / 64] & esz_mask & mask;
+            if (this_g != 0) {
+                next = (next & -64) + ctz64(this_g);
+                break;
+            }
+            next += 64;
+            mask = -1;
+        } while (next < words * 64);
+    }
+
+    i = 0;
+    do {
+        uint64_t this_d = 0;
+        if (i == next / 64) {
+            this_d = 1ull << (next & 63);
+        }
+        d[i] = this_d;
+        flags = iter_predtest_fwd(this_d, g[i] & esz_mask, flags);
+    } while (++i < words);
+
+    return flags;
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 405f9397a1..a9b6ae046d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "tcg-op-gvec.h"
+#include "tcg-gvec-desc.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "translate.h"
@@ -67,9 +68,8 @@ static inline int pred_full_reg_size(DisasContext *s)
  * Note that this is not needed for the vector registers as they
  * are always properly sized for tcg vectors.
  */
-static int pred_gvec_reg_size(DisasContext *s)
+static int size_for_gvec(int size)
 {
-    int size = pred_full_reg_size(s);
     if (size <= 8) {
         return 8;
     } else {
@@ -77,6 +77,11 @@ static int pred_gvec_reg_size(DisasContext *s)
     }
 }
 
+static int pred_gvec_reg_size(DisasContext *s)
+{
+    return size_for_gvec(pred_full_reg_size(s));
+}
+
 /* Invoke a vector expander on two Zregs.  */
 static void do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
                          int esz, int rd, int rn)
@@ -172,6 +177,12 @@ static void do_predtest(DisasContext *s, int dofs, int gofs, int words)
     tcg_temp_free_i32(t);
 }
 
+/* For each element size, the bits within a predicate word that are active.  */
+const uint64_t pred_esz_masks[4] = {
+    0xffffffffffffffffull, 0x5555555555555555ull,
+    0x1111111111111111ull, 0x0101010101010101ull
+};
+
 /*
  *** SVE Logical - Unpredicated Group
  */
@@ -509,6 +520,154 @@ static void trans_PTEST(DisasContext *s, arg_PTEST *a, uint32_t insn)
     }
 }
 
+/* See the ARM pseudocode DecodePredCount.  */
+static unsigned decode_pred_count(unsigned fullsz, int pattern, int esz)
+{
+    unsigned elements = fullsz >> esz;
+    unsigned bound;
+
+    switch (pattern) {
+    case 0x0: /* POW2 */
+        return pow2floor(elements);
+    case 0x1: /* VL1 */
+    case 0x2: /* VL2 */
+    case 0x3: /* VL3 */
+    case 0x4: /* VL4 */
+    case 0x5: /* VL5 */
+    case 0x6: /* VL6 */
+    case 0x7: /* VL7 */
+    case 0x8: /* VL8 */
+        bound = pattern;
+        break;
+    case 0x9: /* VL16 */
+    case 0xa: /* VL32 */
+    case 0xb: /* VL64 */
+    case 0xc: /* VL128 */
+    case 0xd: /* VL256 */
+        bound = 16 << (pattern - 9);
+        break;
+    case 0x1d: /* MUL4 */
+        return elements - elements % 4;
+    case 0x1e: /* MUL3 */
+        return elements - elements % 3;
+    case 0x1f: /* ALL */
+        return elements;
+    default:   /* #uimm5 */
+        return 0;
+    }
+    return elements >= bound ? bound : 0;
+}
+
+static void trans_PTRUE(DisasContext *s, arg_PTRUE *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned ofs = pred_full_reg_offset(s, a->rd);
+    unsigned numelem, setsz, i;
+    uint64_t word, lastword;
+    TCGv_i64 t;
+
+    numelem = decode_pred_count(fullsz, a->pat, a->esz);
+
+    /* Determine what we must store into each bit, and how many.  */
+    if (numelem == 0) {
+        lastword = word = 0;
+        setsz = fullsz;
+    } else {
+        setsz = numelem << a->esz;
+        lastword = word = pred_esz_masks[a->esz];
+        if (setsz % 64) {
+            lastword &= ~(-1ull << (setsz % 64));
+        }
+    }
+
+    t = tcg_temp_new_i64();
+    if (fullsz <= 64) {
+        tcg_gen_movi_i64(t, lastword);
+        tcg_gen_st_i64(t, cpu_env, ofs);
+        goto done;
+    }
+
+    if (word == lastword) {
+        unsigned maxsz = size_for_gvec(fullsz / 8);
+        unsigned oprsz = size_for_gvec(setsz / 8);
+
+        if (oprsz * 8 == setsz) {
+            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
+            goto done;
+        }
+        if (oprsz * 8 == setsz + 8) {
+            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
+            tcg_gen_movi_i64(t, 0);
+            tcg_gen_st_i64(t, cpu_env, ofs + oprsz - 8);
+            goto done;
+        }
+    }
+
+    setsz /= 8;
+    fullsz /= 8;
+
+    tcg_gen_movi_i64(t, word);
+    for (i = 0; i < setsz; i += 8) {
+        tcg_gen_st_i64(t, cpu_env, ofs + i);
+    }
+    if (lastword != word) {
+        tcg_gen_movi_i64(t, lastword);
+        tcg_gen_st_i64(t, cpu_env, ofs + i);
+        i += 8;
+    }
+    if (i < fullsz) {
+        tcg_gen_movi_i64(t, 0);
+        for (; i < fullsz; i += 8) {
+            tcg_gen_st_i64(t, cpu_env, ofs + i);
+        }
+    }
+
+ done:
+    tcg_temp_free_i64(t);
+
+    /* PTRUES */
+    if (a->s) {
+        tcg_gen_movi_i32(cpu_NF, -(word != 0));
+        tcg_gen_movi_i32(cpu_CF, word == 0);
+        tcg_gen_movi_i32(cpu_VF, 0);
+        tcg_gen_mov_i32(cpu_ZF, cpu_NF);
+    }
+}
+
+static void do_pfirst_pnext(DisasContext *s, arg_rr_esz *a,
+                            void (*gen_fn)(TCGv_i32, TCGv_ptr,
+                                           TCGv_ptr, TCGv_i32))
+{
+    TCGv_ptr t_pd = tcg_temp_new_ptr();
+    TCGv_ptr t_pg = tcg_temp_new_ptr();
+    TCGv_i32 t;
+    unsigned desc;
+
+    desc = DIV_ROUND_UP(pred_full_reg_size(s), 8);
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
+
+    tcg_gen_addi_ptr(t_pd, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->rn));
+    t = tcg_const_i32(desc);
+
+    gen_fn(t, t_pd, t_pg, t);
+    tcg_temp_free_ptr(t_pd);
+    tcg_temp_free_ptr(t_pg);
+
+    do_pred_flags(t);
+    tcg_temp_free_i32(t);
+}
+
+static void trans_PFIRST(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    do_pfirst_pnext(s, a, gen_helper_sve_pfirst);
+}
+
+static void trans_PNEXT(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    do_pfirst_pnext(s, a, gen_helper_sve_pnext);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index d92886127a..2e27ef41cd 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -23,20 +23,30 @@
 # Named fields.  These are primarily for disjoint fields.
 
 %imm9_16_10	16:s6 10:3
+%preg4_5	5:4
 
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
 # instruction patterns.
 
+&rr_esz		rd rn esz
 &rri		rd rn imm
 &rrr_esz	rd rn rm esz
 &rprr_s		rd pg rn rm s
 
+&ptrue		rd esz pat s
+
 ###########################################################################
 # Named instruction formats.  These are generally used to
 # reduce the amount of duplication between instruction patterns.
 
+# Two operand with unused vector element size
+@pd_pn_e0	........ ........ ....... rn:4 . rd:4		&rr_esz esz=0
+
+# Two operand
+@pd_pn		........ esz:2 .. .... ....... rn:4 . rd:4	&rr_esz
+
 # Three operand with unused vector element size
 @rd_rn_rm_e0	........ ... rm:5 ... ... rn:5 rd:5		&rrr_esz esz=0
 
@@ -77,6 +87,37 @@ NAND_pppp	00100101 1. 00 .... 01 .... 1 .... 1 ....	@pd_pg_pn_pm_s
 # SVE predicate test
 PTEST		00100101 01010000 11 pg:4 0 rn:4 00000
 
+# SVE predicate initialize
+PTRUE		00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4	&ptrue
+
+# SVE initialize FFR (SETFFR)
+PTRUE		00100101 0010 1100 1001 0000 0000 0000 \
+		&ptrue rd=16 esz=0 pat=31 s=0
+
+# SVE zero predicate register (PFALSE)
+# Note that pat=32 is outside of the natural 0..31, and will
+# always hit the default #uimm5 case of decode_pred_count.
+PTRUE		00100101 0001 1000 1110 0100 0000 rd:4 \
+		&ptrue esz=0 pat=32 s=0
+
+# SVE predicate read from FFR (predicated) (RDFFR)
+ORR_pppp	00100101 0 s:1 0110001111000 pg:4 0 rd:4 \
+		&rprr_s rn=16 rm=16
+
+# SVE predicate read from FFR (unpredicated) (RDFFR)
+ORR_pppp	00100101 0001 1001 1111 0000 0000 rd:4 \
+		&rprr_s rn=16 rm=16 pg=16 s=0
+
+# SVE FFR write from predicate (WRFFR)
+ORR_pppp	00100101 0010 1000 1001 000 rn:4 00000 \
+		&rprr_s rd=16 rm=%preg4_5 pg=%preg4_5 s=0
+
+# SVE predicate first active
+PFIRST		00100101 01 011 000 11000 00 .... 0 ....	@pd_pn_e0
+
+# SVE predicate next active
+PNEXT		00100101 .. 011 001 11000 10 .... 0 ....	@pd_pn
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.14.3
