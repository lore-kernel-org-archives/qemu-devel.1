Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT1-0000xw-KT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSy-0007N7-BM
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSy-0007MW-28
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:28 -0400
Received: by mail-pg1-x52f.google.com with SMTP id z8-v6so2107922pgu.8
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:59 -0700
Message-Id: <20180809042206.15726-14-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/20] target/arm: Rewrite helper_sve_ld[234]*_r
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

Use the same *_tlb primitives as we use for ld1.  This is not
a significant change, but does (for linux-user) hoist the set
of helper_retaddr, and (for softmmu) hoist the computation of
the current mmu_idx outside the loop.

This does fix the endianness problem for softmmu, and does
move the main loop out of a macro and into an inlined function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 210 ++++++++++++++++++++++------------------
 1 file changed, 117 insertions(+), 93 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4ca9412e20..5cc7de5077 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4398,109 +4398,133 @@ DO_LD1_2(ld1dd,  3, 3)
 #undef DO_LD1_1
 #undef DO_LD1_2
 
-#define DO_LD2(NAME, FN, TYPEE, TYPEM, H)                  \
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
-            TYPEM m1 = 0, m2 = 0;                          \
-            if (pg & 1) {                                  \
-                m1 = FN(env, addr, ra);                    \
-                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
-            }                                              \
-            *(TYPEE *)(d1 + H(i)) = m1;                    \
-            *(TYPEE *)(d2 + H(i)) = m2;                    \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 2 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
+/*
+ * Common helpers for all contiguous 2,3,4-register predicated loads.
+ */
+static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, int size, uintptr_t ra,
+                      sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned rd = simd_data(desc);
+    ARMVectorReg scratch[2] = { };
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
+            }
+            i += size, pg >>= size;
+            addr += 2 * size;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
+
+    /* Wait until all exceptions have been raised to write back.  */
+    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
 }
 
-#define DO_LD3(NAME, FN, TYPEE, TYPEM, H)                  \
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
-            TYPEM m1 = 0, m2 = 0, m3 = 0;                  \
-            if (pg & 1) {                                  \
-                m1 = FN(env, addr, ra);                    \
-                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
-                m3 = FN(env, addr + 2 * sizeof(TYPEM), ra); \
-            }                                              \
-            *(TYPEE *)(d1 + H(i)) = m1;                    \
-            *(TYPEE *)(d2 + H(i)) = m2;                    \
-            *(TYPEE *)(d3 + H(i)) = m3;                    \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 3 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
+static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, int size, uintptr_t ra,
+                      sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned rd = simd_data(desc);
+    ARMVectorReg scratch[3] = { };
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, mmu_idx, ra);
+            }
+            i += size, pg >>= size;
+            addr += 3 * size;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
+
+    /* Wait until all exceptions have been raised to write back.  */
+    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
 }
 
-#define DO_LD4(NAME, FN, TYPEE, TYPEM, H)                  \
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
-            TYPEM m1 = 0, m2 = 0, m3 = 0, m4 = 0;          \
-            if (pg & 1) {                                  \
-                m1 = FN(env, addr, ra);                    \
-                m2 = FN(env, addr + sizeof(TYPEM), ra);    \
-                m3 = FN(env, addr + 2 * sizeof(TYPEM), ra); \
-                m4 = FN(env, addr + 3 * sizeof(TYPEM), ra); \
-            }                                              \
-            *(TYPEE *)(d1 + H(i)) = m1;                    \
-            *(TYPEE *)(d2 + H(i)) = m2;                    \
-            *(TYPEE *)(d3 + H(i)) = m3;                    \
-            *(TYPEE *)(d4 + H(i)) = m4;                    \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += 4 * sizeof(TYPEM);                     \
-        } while (i & 15);                                  \
-    }                                                      \
+static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
+                      uint32_t desc, int size, uintptr_t ra,
+                      sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned rd = simd_data(desc);
+    ARMVectorReg scratch[4] = { };
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, mmu_idx, ra);
+                tlb_fn(env, &scratch[3], i, addr + 3 * size, mmu_idx, ra);
+            }
+            i += size, pg >>= size;
+            addr += 4 * size;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
+
+    /* Wait until all exceptions have been raised to write back.  */
+    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
+    memcpy(&env->vfp.zregs[(rd + 3) & 31], &scratch[3], oprsz);
 }
 
-DO_LD2(sve_ld2bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
-DO_LD3(sve_ld3bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
-DO_LD4(sve_ld4bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
+#define DO_LDN_1(N) \
+void __attribute__((flatten)) HELPER(sve_ld##N##bb_r)               \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
+{                                                                   \
+    sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
+}
 
-DO_LD2(sve_ld2hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
-DO_LD3(sve_ld3hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
-DO_LD4(sve_ld4hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
+#define DO_LDN_2(N, SUFF, SIZE)                                       \
+void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_r)             \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+{                                                                     \
+    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
+                  arm_cpu_data_is_big_endian(env)                     \
+                  ? sve_ld1##SUFF##_be_tlb : sve_ld1##SUFF##_le_tlb); \
+}
 
-DO_LD2(sve_ld2ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
-DO_LD3(sve_ld3ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
-DO_LD4(sve_ld4ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
+DO_LDN_1(2)
+DO_LDN_1(3)
+DO_LDN_1(4)
 
-DO_LD2(sve_ld2dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
-DO_LD3(sve_ld3dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
-DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
+DO_LDN_2(2, hh, 2)
+DO_LDN_2(3, hh, 2)
+DO_LDN_2(4, hh, 2)
 
-#undef DO_LD2
-#undef DO_LD3
-#undef DO_LD4
+DO_LDN_2(2, ss, 4)
+DO_LDN_2(3, ss, 4)
+DO_LDN_2(4, ss, 4)
+
+DO_LDN_2(2, dd, 8)
+DO_LDN_2(3, dd, 8)
+DO_LDN_2(4, dd, 8)
+
+#undef DO_LDN_1
+#undef DO_LDN_2
 
 /*
  * Load contiguous data, first-fault and no-fault.
-- 
2.17.1
