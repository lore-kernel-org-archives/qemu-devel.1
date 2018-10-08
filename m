Received: from eggs.gnu.org ([2001:4830:134:3::10]:46002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5L-00012n-BB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5B-0006xl-6l
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W57-0006uy-OT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W56-0003gb-48
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:43 +0100
Message-Id: <20181008140004.12612-13-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/33] target/arm: Rewrite helper_sve_ld[234]*_r
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

Use the same *_tlb primitives as we use for ld1.

For linux-user, this hoists the set of helper_retaddr.  For softmmu,
hoists the computation of the current mmu_idx outside the loop,
fixes the endianness problem, and moves the main loop out of a
macro and into an inlined function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 210 ++++++++++++++++++++++------------------
 1 file changed, 117 insertions(+), 93 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d628978431c..f712b382f8b 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4285,109 +4285,133 @@ DO_LD1_2(ld1dd,  3, 3)
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
2.19.0
