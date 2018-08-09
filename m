Received: from eggs.gnu.org ([2001:4830:134:3::10]:54089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT1-0000xx-Rg
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSz-0007OS-W1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:35957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSz-0007Nq-L7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id h12-v6so2119569pgs.3
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:00 -0700
Message-Id: <20180809042206.15726-15-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/20] target/arm: Rewrite
 helper_sve_st[1234]*_r
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

This fixes the endianness problem for softmmu, and does
move the main loop out of a macro and into an inlined function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 351 ++++++++++++++++++++--------------------
 1 file changed, 172 insertions(+), 179 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 5cc7de5077..4eae6569cc 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3987,6 +3987,7 @@ typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
  */
 typedef void sve_ld1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
                             target_ulong vaddr, int mmu_idx, uintptr_t ra);
+typedef sve_ld1_tlb_fn sve_st1_tlb_fn;
 
 /*
  * Generate the above primitives.
@@ -4772,214 +4773,206 @@ DO_LDFF1_LDNF1_2(dd,  3, 3)
 /*
  * Store contiguous data, protected by a governing predicate.
  */
-#define DO_ST1(NAME, FN, TYPEE, TYPEM, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc);                  \
-    intptr_t ra = GETPC();                                 \
-    unsigned rd = simd_data(desc);                         \
-    void *vd = &env->vfp.zregs[rd];                        \
-    for (i = 0; i < oprsz; ) {                             \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
-        do {                                               \
-            if (pg & 1) {                                  \
-                TYPEM m = *(TYPEE *)(vd + H(i));           \
-                FN(env, addr, m, ra);                      \
-            }                                              \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += sizeof(TYPEM);                         \
-        } while (i & 15);                                  \
-    }                                                      \
+
+#ifdef CONFIG_SOFTMMU
+#define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
+static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
+                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+{                                                                           \
+    TCGMemOpIdx oi = make_memop_idx(ctz32(sizeof(TYPEM)) | MOEND, mmu_idx); \
+    TLB(env, addr, *(TYPEM *)(vd + H(reg_off)), oi, ra);                    \
 }
-
-#define DO_ST1_D(NAME, FN, TYPEM)                          \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;              \
-    intptr_t ra = GETPC();                                 \
-    unsigned rd = simd_data(desc);                         \
-    uint64_t *d = &env->vfp.zregs[rd].d[0];                \
-    uint8_t *pg = vg;                                      \
-    for (i = 0; i < oprsz; i += 1) {                       \
-        if (pg[H1(i)] & 1) {                               \
-            FN(env, addr, d[i], ra);                       \
-        }                                                  \
-        addr += sizeof(TYPEM);                             \
-    }                                                      \
+#else
+#define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
+static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
+                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+{                                                                           \
+    HOST(g2h(addr), *(TYPEM *)(vd + H(reg_off)));                           \
 }
+#endif
 
-#define DO_ST2(NAME, FN, TYPEE, TYPEM, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc);                  \
-    intptr_t ra = GETPC();                                 \
-    unsigned rd = simd_data(desc);                         \
-    void *d1 = &env->vfp.zregs[rd];                        \
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
-    for (i = 0; i < oprsz; ) {                             \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
-        do {                                               \
-            if (pg & 1) {                                  \
-                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
-                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
-                FN(env, addr, m1, ra);                     \
-                FN(env, addr + sizeof(TYPEM), m2, ra);     \
-            }                                              \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 2 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
-}
+DO_ST_TLB(st1bb,   H1,  uint8_t, stb_p, 0, helper_ret_stb_mmu)
+DO_ST_TLB(st1bh, H1_2, uint16_t, stb_p, 0, helper_ret_stb_mmu)
+DO_ST_TLB(st1bs, H1_4, uint32_t, stb_p, 0, helper_ret_stb_mmu)
+DO_ST_TLB(st1bd,     , uint64_t, stb_p, 0, helper_ret_stb_mmu)
 
-#define DO_ST3(NAME, FN, TYPEE, TYPEM, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc);                  \
-    intptr_t ra = GETPC();                                 \
-    unsigned rd = simd_data(desc);                         \
-    void *d1 = &env->vfp.zregs[rd];                        \
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
-    void *d3 = &env->vfp.zregs[(rd + 2) & 31];             \
-    for (i = 0; i < oprsz; ) {                             \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
-        do {                                               \
-            if (pg & 1) {                                  \
-                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
-                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
-                TYPEM m3 = *(TYPEE *)(d3 + H(i));          \
-                FN(env, addr, m1, ra);                     \
-                FN(env, addr + sizeof(TYPEM), m2, ra);     \
-                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
-            }                                              \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 3 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
-}
+DO_ST_TLB(st1hh_le, H1_2, uint16_t, stw_le_p, MO_LE, helper_le_stw_mmu)
+DO_ST_TLB(st1hs_le, H1_4, uint32_t, stw_le_p, MO_LE, helper_le_stw_mmu)
+DO_ST_TLB(st1hd_le,     , uint64_t, stw_le_p, MO_LE, helper_le_stw_mmu)
 
-#define DO_ST4(NAME, FN, TYPEE, TYPEM, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc);                  \
-    intptr_t ra = GETPC();                                 \
-    unsigned rd = simd_data(desc);                         \
-    void *d1 = &env->vfp.zregs[rd];                        \
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];             \
-    void *d3 = &env->vfp.zregs[(rd + 2) & 31];             \
-    void *d4 = &env->vfp.zregs[(rd + 3) & 31];             \
-    for (i = 0; i < oprsz; ) {                             \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
-        do {                                               \
-            if (pg & 1) {                                  \
-                TYPEM m1 = *(TYPEE *)(d1 + H(i));          \
-                TYPEM m2 = *(TYPEE *)(d2 + H(i));          \
-                TYPEM m3 = *(TYPEE *)(d3 + H(i));          \
-                TYPEM m4 = *(TYPEE *)(d4 + H(i));          \
-                FN(env, addr, m1, ra);                     \
-                FN(env, addr + sizeof(TYPEM), m2, ra);     \
-                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
-                FN(env, addr + 3 * sizeof(TYPEM), m4, ra); \
-            }                                              \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 4 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
-}
+DO_ST_TLB(st1ss_le, H1_4, uint32_t, stl_le_p, MO_LE, helper_le_stl_mmu)
+DO_ST_TLB(st1sd_le,     , uint64_t, stl_le_p, MO_LE, helper_le_stl_mmu)
 
-DO_ST1(sve_st1bh_r, cpu_stb_data_ra, uint16_t, uint8_t, H1_2)
-DO_ST1(sve_st1bs_r, cpu_stb_data_ra, uint32_t, uint8_t, H1_4)
-DO_ST1_D(sve_st1bd_r, cpu_stb_data_ra, uint8_t)
+DO_ST_TLB(st1dd_le,     , uint64_t, stq_le_p, MO_LE, helper_le_stq_mmu)
 
-DO_ST1(sve_st1hs_r, cpu_stw_data_ra, uint32_t, uint16_t, H1_4)
-DO_ST1_D(sve_st1hd_r, cpu_stw_data_ra, uint16_t)
+DO_ST_TLB(st1hh_be, H1_2, uint16_t, stw_be_p, MO_BE, helper_be_stw_mmu)
+DO_ST_TLB(st1hs_be, H1_4, uint32_t, stw_be_p, MO_BE, helper_be_stw_mmu)
+DO_ST_TLB(st1hd_be,     , uint64_t, stw_be_p, MO_BE, helper_be_stw_mmu)
 
-DO_ST1_D(sve_st1sd_r, cpu_stl_data_ra, uint32_t)
+DO_ST_TLB(st1ss_be, H1_4, uint32_t, stl_be_p, MO_BE, helper_be_stl_mmu)
+DO_ST_TLB(st1sd_be,     , uint64_t, stl_be_p, MO_BE, helper_be_stl_mmu)
 
-DO_ST1(sve_st1bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
-DO_ST2(sve_st2bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
-DO_ST3(sve_st3bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
-DO_ST4(sve_st4bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
+DO_ST_TLB(st1dd_be,     , uint64_t, stq_be_p, MO_BE, helper_be_stq_mmu)
 
-DO_ST1(sve_st1hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
-DO_ST2(sve_st2hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
-DO_ST3(sve_st3hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
-DO_ST4(sve_st4hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
+#undef DO_ST_TLB
 
-DO_ST1(sve_st1ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
-DO_ST2(sve_st2ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
-DO_ST3(sve_st3ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
-DO_ST4(sve_st4ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
-
-DO_ST1_D(sve_st1dd_r, cpu_stq_data_ra, uint64_t)
-
-void HELPER(sve_st2dd_r)(CPUARMState *env, void *vg,
-                         target_ulong addr, uint32_t desc)
+/*
+ * Common helpers for all contiguous 1,2,3,4-register predicated stores.
+ */
+static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, const uintptr_t ra,
+                      const int esize, const int msize,
+                      sve_st1_tlb_fn *tlb_fn)
 {
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    intptr_t ra = GETPC();
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
     unsigned rd = simd_data(desc);
-    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
-    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
-    uint8_t *pg = vg;
+    void *vd = &env->vfp.zregs[rd];
 
-    for (i = 0; i < oprsz; i += 1) {
-        if (pg[H1(i)] & 1) {
-            cpu_stq_data_ra(env, addr, d1[i], ra);
-            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
-        }
-        addr += 2 * 8;
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, vd, i, addr, mmu_idx, ra);
+            }
+            i += esize, pg >>= esize;
+            addr += msize;
+        } while (i & 15);
     }
+    set_helper_retaddr(0);
 }
 
-void HELPER(sve_st3dd_r)(CPUARMState *env, void *vg,
-                         target_ulong addr, uint32_t desc)
+static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, const uintptr_t ra,
+                      const int esize, const int msize,
+                      sve_st1_tlb_fn *tlb_fn)
 {
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    intptr_t ra = GETPC();
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
     unsigned rd = simd_data(desc);
-    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
-    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
-    uint64_t *d3 = &env->vfp.zregs[(rd + 2) & 31].d[0];
-    uint8_t *pg = vg;
+    void *d1 = &env->vfp.zregs[rd];
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
 
-    for (i = 0; i < oprsz; i += 1) {
-        if (pg[H1(i)] & 1) {
-            cpu_stq_data_ra(env, addr, d1[i], ra);
-            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
-            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
-        }
-        addr += 3 * 8;
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, d1, i, addr, mmu_idx, ra);
+                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
+            }
+            i += esize, pg >>= esize;
+            addr += 2 * msize;
+        } while (i & 15);
     }
+    set_helper_retaddr(0);
 }
 
-void HELPER(sve_st4dd_r)(CPUARMState *env, void *vg,
-                         target_ulong addr, uint32_t desc)
+static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, const uintptr_t ra,
+                      const int esize, const int msize,
+                      sve_st1_tlb_fn *tlb_fn)
 {
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    intptr_t ra = GETPC();
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
     unsigned rd = simd_data(desc);
-    uint64_t *d1 = &env->vfp.zregs[rd].d[0];
-    uint64_t *d2 = &env->vfp.zregs[(rd + 1) & 31].d[0];
-    uint64_t *d3 = &env->vfp.zregs[(rd + 2) & 31].d[0];
-    uint64_t *d4 = &env->vfp.zregs[(rd + 3) & 31].d[0];
-    uint8_t *pg = vg;
+    void *d1 = &env->vfp.zregs[rd];
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
+    void *d3 = &env->vfp.zregs[(rd + 2) & 31];
 
-    for (i = 0; i < oprsz; i += 1) {
-        if (pg[H1(i)] & 1) {
-            cpu_stq_data_ra(env, addr, d1[i], ra);
-            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
-            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
-            cpu_stq_data_ra(env, addr + 24, d4[i], ra);
-        }
-        addr += 4 * 8;
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, d1, i, addr, mmu_idx, ra);
+                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, mmu_idx, ra);
+            }
+            i += esize, pg >>= esize;
+            addr += 3 * msize;
+        } while (i & 15);
     }
+    set_helper_retaddr(0);
 }
 
+static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, const uintptr_t ra,
+                      const int esize, const int msize,
+                      sve_st1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned rd = simd_data(desc);
+    void *d1 = &env->vfp.zregs[rd];
+    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
+    void *d3 = &env->vfp.zregs[(rd + 2) & 31];
+    void *d4 = &env->vfp.zregs[(rd + 3) & 31];
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, d1, i, addr, mmu_idx, ra);
+                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, mmu_idx, ra);
+                tlb_fn(env, d4, i, addr + 3 * msize, mmu_idx, ra);
+            }
+            i += esize, pg >>= esize;
+            addr += 4 * msize;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
+}
+
+#define DO_STN_1(N, NAME, ESIZE) \
+void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)           \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
+{                                                                   \
+    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, 1,           \
+                  sve_st1##NAME##_tlb);                             \
+}
+
+#define DO_STN_2(N, NAME, ESIZE, MSIZE) \
+void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)             \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+{                                                                     \
+    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
+                  arm_cpu_data_is_big_endian(env)                     \
+                  ? sve_st1##NAME##_be_tlb : sve_st1##NAME##_le_tlb); \
+}
+
+DO_STN_1(1, bb, 1)
+DO_STN_1(1, bh, 2)
+DO_STN_1(1, bs, 4)
+DO_STN_1(1, bd, 8)
+DO_STN_1(2, bb, 1)
+DO_STN_1(3, bb, 1)
+DO_STN_1(4, bb, 1)
+
+DO_STN_2(1, hh, 2, 2)
+DO_STN_2(1, hs, 4, 2)
+DO_STN_2(1, hd, 8, 2)
+DO_STN_2(2, hh, 2, 2)
+DO_STN_2(3, hh, 2, 2)
+DO_STN_2(4, hh, 2, 2)
+
+DO_STN_2(1, ss, 4, 4)
+DO_STN_2(1, sd, 8, 4)
+DO_STN_2(2, ss, 4, 4)
+DO_STN_2(3, ss, 4, 4)
+DO_STN_2(4, ss, 4, 4)
+
+DO_STN_2(1, dd, 8, 8)
+DO_STN_2(2, dd, 8, 8)
+DO_STN_2(3, dd, 8, 8)
+DO_STN_2(4, dd, 8, 8)
+
+#undef DO_STN_1
+#undef DO_STN_2
+
 /* Loads with a vector index.  */
 
 #define DO_LD1_ZPZ_S(NAME, TYPEI, TYPEM, FN)                            \
-- 
2.17.1
