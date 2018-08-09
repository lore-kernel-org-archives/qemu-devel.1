Received: from eggs.gnu.org ([2001:4830:134:3::10]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT7-000128-N2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT4-0007Su-ON
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:34670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncT4-0007Rl-DS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:34 -0400
Received: by mail-pf1-x432.google.com with SMTP id k19-v6so2208678pfi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:03 -0700
Message-Id: <20180809042206.15726-18-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/20] target/arm: Rewrite vector gather loads
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
 target/arm/helper-sve.h    |  84 +++++++++----
 target/arm/sve_helper.c    | 218 +++++++++++++++++++++++----------
 target/arm/translate-sve.c | 244 +++++++++++++++++++++++++------------
 3 files changed, 380 insertions(+), 166 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 1ad043101a..49d1c09e30 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1292,69 +1292,111 @@ DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldssu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldbss_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldssu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldbss_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhss_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldddu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldbds_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldddu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldbds_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldddu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldbds_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 92c0e961a9..76d3f021e4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4984,80 +4984,166 @@ DO_STN_2(4, dd, 8, 8)
 
 /* Loads with a vector index.  */
 
-#define DO_LD1_ZPZ_S(NAME, TYPEI, TYPEM, FN)                            \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    intptr_t i, oprsz = simd_oprsz(desc);                               \
-    unsigned scale = simd_data(desc);                                   \
-    uintptr_t ra = GETPC();                                             \
-    for (i = 0; i < oprsz; ) {                                          \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
-        do {                                                            \
-            TYPEM m = 0;                                                \
-            if (pg & 1) {                                               \
-                target_ulong off = *(TYPEI *)(vm + H1_4(i));            \
-                m = FN(env, base + (off << scale), ra);                 \
-            }                                                           \
-            *(uint32_t *)(vd + H1_4(i)) = m;                            \
-            i += 4, pg >>= 4;                                           \
-        } while (i & 15);                                               \
-    }                                                                   \
+typedef target_ulong zreg_off_fn(void *reg, intptr_t reg_ofs);
+
+static target_ulong off_zsu_s(void *reg, intptr_t reg_ofs)
+{
+    return *(uint32_t *)(reg + H1_4(reg_ofs));
 }
 
-#define DO_LD1_ZPZ_D(NAME, TYPEI, TYPEM, FN)                            \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;                           \
-    unsigned scale = simd_data(desc);                                   \
-    uintptr_t ra = GETPC();                                             \
-    uint64_t *d = vd, *m = vm; uint8_t *pg = vg;                        \
-    for (i = 0; i < oprsz; i++) {                                       \
-        TYPEM mm = 0;                                                   \
-        if (pg[H1(i)] & 1) {                                            \
-            target_ulong off = (TYPEI)m[i];                             \
-            mm = FN(env, base + (off << scale), ra);                    \
-        }                                                               \
-        d[i] = mm;                                                      \
-    }                                                                   \
+static target_ulong off_zss_s(void *reg, intptr_t reg_ofs)
+{
+    return *(int32_t *)(reg + H1_4(reg_ofs));
 }
 
-DO_LD1_ZPZ_S(sve_ldbsu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LD1_ZPZ_S(sve_ldhsu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
-DO_LD1_ZPZ_S(sve_ldssu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
-DO_LD1_ZPZ_S(sve_ldbss_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
-DO_LD1_ZPZ_S(sve_ldhss_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
+static target_ulong off_zsu_d(void *reg, intptr_t reg_ofs)
+{
+    return (uint32_t)*(uint64_t *)(reg + reg_ofs);
+}
 
-DO_LD1_ZPZ_S(sve_ldbsu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LD1_ZPZ_S(sve_ldhsu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
-DO_LD1_ZPZ_S(sve_ldssu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
-DO_LD1_ZPZ_S(sve_ldbss_zss, int32_t, int8_t,   cpu_ldub_data_ra)
-DO_LD1_ZPZ_S(sve_ldhss_zss, int32_t, int16_t,  cpu_lduw_data_ra)
+static target_ulong off_zss_d(void *reg, intptr_t reg_ofs)
+{
+    return (int32_t)*(uint64_t *)(reg + reg_ofs);
+}
 
-DO_LD1_ZPZ_D(sve_ldbdu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhdu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsdu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
-DO_LD1_ZPZ_D(sve_ldddu_zsu, uint32_t, uint64_t, cpu_ldq_data_ra)
-DO_LD1_ZPZ_D(sve_ldbds_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhds_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsds_zsu, uint32_t, int32_t,  cpu_ldl_data_ra)
+static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
+{
+    return *(uint64_t *)(reg + reg_ofs);
+}
 
-DO_LD1_ZPZ_D(sve_ldbdu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhdu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsdu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
-DO_LD1_ZPZ_D(sve_ldddu_zss, int32_t, uint64_t, cpu_ldq_data_ra)
-DO_LD1_ZPZ_D(sve_ldbds_zss, int32_t, int8_t,   cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhds_zss, int32_t, int16_t,  cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsds_zss, int32_t, int32_t,  cpu_ldl_data_ra)
+static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
+                       target_ulong base, uint32_t desc, uintptr_t ra,
+                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned scale = simd_data(desc);
+    ARMVectorReg scratch = { };
 
-DO_LD1_ZPZ_D(sve_ldbdu_zd, uint64_t, uint8_t,  cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhdu_zd, uint64_t, uint16_t, cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsdu_zd, uint64_t, uint32_t, cpu_ldl_data_ra)
-DO_LD1_ZPZ_D(sve_ldddu_zd, uint64_t, uint64_t, cpu_ldq_data_ra)
-DO_LD1_ZPZ_D(sve_ldbds_zd, uint64_t, int8_t,   cpu_ldub_data_ra)
-DO_LD1_ZPZ_D(sve_ldhds_zd, uint64_t, int16_t,  cpu_lduw_data_ra)
-DO_LD1_ZPZ_D(sve_ldsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                target_ulong off = off_fn(vm, i);
+                tlb_fn(env, &scratch, i, base + (off << scale), mmu_idx, ra);
+            }
+            i += 4, pg >>= 4;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
+
+    /* Wait until all exceptions have been raised to write back.  */
+    memcpy(vd, &scratch, oprsz);
+}
+
+static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
+                       target_ulong base, uint32_t desc, uintptr_t ra,
+                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;
+    unsigned scale = simd_data(desc);
+    ARMVectorReg scratch = { };
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; i++) {
+        uint8_t pg = *(uint8_t *)(vg + H1(i));
+        if (pg & 1) {
+            target_ulong off = off_fn(vm, i * 8);
+            tlb_fn(env, &scratch, i * 8, base + (off << scale), mmu_idx, ra);
+        }
+    }
+    set_helper_retaddr(0);
+
+    /* Wait until all exceptions have been raised to write back.  */
+    memcpy(vd, &scratch, oprsz * 8);
+}
+
+#define DO_LD1_ZPZ_S(MEM, OFS) \
+void __attribute__((flatten)) HELPER(sve_ld##MEM##_##OFS)    \
+    (CPUARMState *env, void *vd, void *vg, void *vm,         \
+     target_ulong base, uint32_t desc)                       \
+{                                                            \
+    sve_ld1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
+              off_##OFS##_s, sve_ld1##MEM##_tlb);            \
+}
+
+#define DO_LD1_ZPZ_D(MEM, OFS) \
+void __attribute__((flatten)) HELPER(sve_ld##MEM##_##OFS)    \
+    (CPUARMState *env, void *vd, void *vg, void *vm,         \
+     target_ulong base, uint32_t desc)                       \
+{                                                            \
+    sve_ld1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
+               off_##OFS##_d, sve_ld1##MEM##_tlb);           \
+}
+
+DO_LD1_ZPZ_S(bsu, zsu)
+DO_LD1_ZPZ_S(bsu, zss)
+DO_LD1_ZPZ_D(bdu, zsu)
+DO_LD1_ZPZ_D(bdu, zss)
+DO_LD1_ZPZ_D(bdu, zd)
+
+DO_LD1_ZPZ_S(bss, zsu)
+DO_LD1_ZPZ_S(bss, zss)
+DO_LD1_ZPZ_D(bds, zsu)
+DO_LD1_ZPZ_D(bds, zss)
+DO_LD1_ZPZ_D(bds, zd)
+
+DO_LD1_ZPZ_S(hsu_le, zsu)
+DO_LD1_ZPZ_S(hsu_le, zss)
+DO_LD1_ZPZ_D(hdu_le, zsu)
+DO_LD1_ZPZ_D(hdu_le, zss)
+DO_LD1_ZPZ_D(hdu_le, zd)
+
+DO_LD1_ZPZ_S(hsu_be, zsu)
+DO_LD1_ZPZ_S(hsu_be, zss)
+DO_LD1_ZPZ_D(hdu_be, zsu)
+DO_LD1_ZPZ_D(hdu_be, zss)
+DO_LD1_ZPZ_D(hdu_be, zd)
+
+DO_LD1_ZPZ_S(hss_le, zsu)
+DO_LD1_ZPZ_S(hss_le, zss)
+DO_LD1_ZPZ_D(hds_le, zsu)
+DO_LD1_ZPZ_D(hds_le, zss)
+DO_LD1_ZPZ_D(hds_le, zd)
+
+DO_LD1_ZPZ_S(hss_be, zsu)
+DO_LD1_ZPZ_S(hss_be, zss)
+DO_LD1_ZPZ_D(hds_be, zsu)
+DO_LD1_ZPZ_D(hds_be, zss)
+DO_LD1_ZPZ_D(hds_be, zd)
+
+DO_LD1_ZPZ_S(ss_le, zsu)
+DO_LD1_ZPZ_S(ss_le, zss)
+DO_LD1_ZPZ_D(sdu_le, zsu)
+DO_LD1_ZPZ_D(sdu_le, zss)
+DO_LD1_ZPZ_D(sdu_le, zd)
+
+DO_LD1_ZPZ_S(ss_be, zsu)
+DO_LD1_ZPZ_S(ss_be, zss)
+DO_LD1_ZPZ_D(sdu_be, zsu)
+DO_LD1_ZPZ_D(sdu_be, zss)
+DO_LD1_ZPZ_D(sdu_be, zd)
+
+DO_LD1_ZPZ_D(sds_le, zsu)
+DO_LD1_ZPZ_D(sds_le, zss)
+DO_LD1_ZPZ_D(sds_le, zd)
+
+DO_LD1_ZPZ_D(sds_be, zsu)
+DO_LD1_ZPZ_D(sds_be, zss)
+DO_LD1_ZPZ_D(sds_be, zd)
+
+DO_LD1_ZPZ_D(dd_le, zsu)
+DO_LD1_ZPZ_D(dd_le, zss)
+DO_LD1_ZPZ_D(dd_le, zd)
+
+DO_LD1_ZPZ_D(dd_be, zsu)
+DO_LD1_ZPZ_D(dd_be, zss)
+DO_LD1_ZPZ_D(dd_be, zd)
+
+#undef DO_LD1_ZPZ_S
+#undef DO_LD1_ZPZ_D
 
 /* First fault loads with a vector index.  */
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index acb85731f8..d4d7e9d3ae 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5077,91 +5077,176 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm, int scale,
     tcg_temp_free_i32(desc);
 }
 
-/* Indexed by [ff][xs][u][msz].  */
-static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][3] = {
-    { { { gen_helper_sve_ldbss_zsu,
-          gen_helper_sve_ldhss_zsu,
-          NULL, },
-        { gen_helper_sve_ldbsu_zsu,
-          gen_helper_sve_ldhsu_zsu,
-          gen_helper_sve_ldssu_zsu, } },
-      { { gen_helper_sve_ldbss_zss,
-          gen_helper_sve_ldhss_zss,
-          NULL, },
-        { gen_helper_sve_ldbsu_zss,
-          gen_helper_sve_ldhsu_zss,
-          gen_helper_sve_ldssu_zss, } } },
+/* Indexed by [be][ff][xs][u][msz].  */
+static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][2][3] = {
+    /* Little-endian */
+    { { { { gen_helper_sve_ldbss_zsu,
+            gen_helper_sve_ldhss_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldbsu_zsu,
+            gen_helper_sve_ldhsu_le_zsu,
+            gen_helper_sve_ldss_le_zsu, } },
+        { { gen_helper_sve_ldbss_zss,
+            gen_helper_sve_ldhss_le_zss,
+            NULL, },
+          { gen_helper_sve_ldbsu_zss,
+            gen_helper_sve_ldhsu_le_zss,
+            gen_helper_sve_ldss_le_zss, } } },
 
-    { { { gen_helper_sve_ldffbss_zsu,
-          gen_helper_sve_ldffhss_zsu,
-          NULL, },
-        { gen_helper_sve_ldffbsu_zsu,
-          gen_helper_sve_ldffhsu_zsu,
-          gen_helper_sve_ldffssu_zsu, } },
-      { { gen_helper_sve_ldffbss_zss,
-          gen_helper_sve_ldffhss_zss,
-          NULL, },
-        { gen_helper_sve_ldffbsu_zss,
-          gen_helper_sve_ldffhsu_zss,
-          gen_helper_sve_ldffssu_zss, } } }
+      /* First-fault */
+      { { { gen_helper_sve_ldffbss_zsu,
+            gen_helper_sve_ldffhss_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zsu,
+            gen_helper_sve_ldffhsu_zsu,
+            gen_helper_sve_ldffssu_zsu, } },
+        { { gen_helper_sve_ldffbss_zss,
+            gen_helper_sve_ldffhss_zss,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zss,
+            gen_helper_sve_ldffhsu_zss,
+            gen_helper_sve_ldffssu_zss, } } } },
+
+    /* Big-endian */
+    { { { { gen_helper_sve_ldbss_zsu,
+            gen_helper_sve_ldhss_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldbsu_zsu,
+            gen_helper_sve_ldhsu_be_zsu,
+            gen_helper_sve_ldss_be_zsu, } },
+        { { gen_helper_sve_ldbss_zss,
+            gen_helper_sve_ldhss_be_zss,
+            NULL, },
+          { gen_helper_sve_ldbsu_zss,
+            gen_helper_sve_ldhsu_be_zss,
+            gen_helper_sve_ldss_be_zss, } } },
+
+      /* First-fault */
+      { { { gen_helper_sve_ldffbss_zsu,
+            gen_helper_sve_ldffhss_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zsu,
+            gen_helper_sve_ldffhsu_zsu,
+            gen_helper_sve_ldffssu_zsu, } },
+        { { gen_helper_sve_ldffbss_zss,
+            gen_helper_sve_ldffhss_zss,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zss,
+            gen_helper_sve_ldffhsu_zss,
+            gen_helper_sve_ldffssu_zss, } } } },
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
-static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][3][2][4] = {
-    { { { gen_helper_sve_ldbds_zsu,
-          gen_helper_sve_ldhds_zsu,
-          gen_helper_sve_ldsds_zsu,
-          NULL, },
-        { gen_helper_sve_ldbdu_zsu,
-          gen_helper_sve_ldhdu_zsu,
-          gen_helper_sve_ldsdu_zsu,
-          gen_helper_sve_ldddu_zsu, } },
-      { { gen_helper_sve_ldbds_zss,
-          gen_helper_sve_ldhds_zss,
-          gen_helper_sve_ldsds_zss,
-          NULL, },
-        { gen_helper_sve_ldbdu_zss,
-          gen_helper_sve_ldhdu_zss,
-          gen_helper_sve_ldsdu_zss,
-          gen_helper_sve_ldddu_zss, } },
-      { { gen_helper_sve_ldbds_zd,
-          gen_helper_sve_ldhds_zd,
-          gen_helper_sve_ldsds_zd,
-          NULL, },
-        { gen_helper_sve_ldbdu_zd,
-          gen_helper_sve_ldhdu_zd,
-          gen_helper_sve_ldsdu_zd,
-          gen_helper_sve_ldddu_zd, } } },
+static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][2][3][2][4] = {
+    /* Little-endian */
+    { { { { gen_helper_sve_ldbds_zsu,
+            gen_helper_sve_ldhds_le_zsu,
+            gen_helper_sve_ldsds_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldbdu_zsu,
+            gen_helper_sve_ldhdu_le_zsu,
+            gen_helper_sve_ldsdu_le_zsu,
+            gen_helper_sve_lddd_le_zsu, } },
+        { { gen_helper_sve_ldbds_zss,
+            gen_helper_sve_ldhds_le_zss,
+            gen_helper_sve_ldsds_le_zss,
+            NULL, },
+          { gen_helper_sve_ldbdu_zss,
+            gen_helper_sve_ldhdu_le_zss,
+            gen_helper_sve_ldsdu_le_zss,
+            gen_helper_sve_lddd_le_zss, } },
+        { { gen_helper_sve_ldbds_zd,
+            gen_helper_sve_ldhds_le_zd,
+            gen_helper_sve_ldsds_le_zd,
+            NULL, },
+          { gen_helper_sve_ldbdu_zd,
+            gen_helper_sve_ldhdu_le_zd,
+            gen_helper_sve_ldsdu_le_zd,
+            gen_helper_sve_lddd_le_zd, } } },
 
-    { { { gen_helper_sve_ldffbds_zsu,
-          gen_helper_sve_ldffhds_zsu,
-          gen_helper_sve_ldffsds_zsu,
-          NULL, },
-        { gen_helper_sve_ldffbdu_zsu,
-          gen_helper_sve_ldffhdu_zsu,
-          gen_helper_sve_ldffsdu_zsu,
-          gen_helper_sve_ldffddu_zsu, } },
-      { { gen_helper_sve_ldffbds_zss,
-          gen_helper_sve_ldffhds_zss,
-          gen_helper_sve_ldffsds_zss,
-          NULL, },
-        { gen_helper_sve_ldffbdu_zss,
-          gen_helper_sve_ldffhdu_zss,
-          gen_helper_sve_ldffsdu_zss,
-          gen_helper_sve_ldffddu_zss, } },
-      { { gen_helper_sve_ldffbds_zd,
-          gen_helper_sve_ldffhds_zd,
-          gen_helper_sve_ldffsds_zd,
-          NULL, },
-        { gen_helper_sve_ldffbdu_zd,
-          gen_helper_sve_ldffhdu_zd,
-          gen_helper_sve_ldffsdu_zd,
-          gen_helper_sve_ldffddu_zd, } } }
+      /* First-fault */
+      { { { gen_helper_sve_ldffbds_zsu,
+            gen_helper_sve_ldffhds_zsu,
+            gen_helper_sve_ldffsds_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zsu,
+            gen_helper_sve_ldffhdu_zsu,
+            gen_helper_sve_ldffsdu_zsu,
+            gen_helper_sve_ldffddu_zsu, } },
+        { { gen_helper_sve_ldffbds_zss,
+            gen_helper_sve_ldffhds_zss,
+            gen_helper_sve_ldffsds_zss,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zss,
+            gen_helper_sve_ldffhdu_zss,
+            gen_helper_sve_ldffsdu_zss,
+            gen_helper_sve_ldffddu_zss, } },
+        { { gen_helper_sve_ldffbds_zd,
+            gen_helper_sve_ldffhds_zd,
+            gen_helper_sve_ldffsds_zd,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zd,
+            gen_helper_sve_ldffhdu_zd,
+            gen_helper_sve_ldffsdu_zd,
+            gen_helper_sve_ldffddu_zd, } } } },
+
+    /* Big-endian */
+    { { { { gen_helper_sve_ldbds_zsu,
+            gen_helper_sve_ldhds_be_zsu,
+            gen_helper_sve_ldsds_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldbdu_zsu,
+            gen_helper_sve_ldhdu_be_zsu,
+            gen_helper_sve_ldsdu_be_zsu,
+            gen_helper_sve_lddd_be_zsu, } },
+        { { gen_helper_sve_ldbds_zss,
+            gen_helper_sve_ldhds_be_zss,
+            gen_helper_sve_ldsds_be_zss,
+            NULL, },
+          { gen_helper_sve_ldbdu_zss,
+            gen_helper_sve_ldhdu_be_zss,
+            gen_helper_sve_ldsdu_be_zss,
+            gen_helper_sve_lddd_be_zss, } },
+        { { gen_helper_sve_ldbds_zd,
+            gen_helper_sve_ldhds_be_zd,
+            gen_helper_sve_ldsds_be_zd,
+            NULL, },
+          { gen_helper_sve_ldbdu_zd,
+            gen_helper_sve_ldhdu_be_zd,
+            gen_helper_sve_ldsdu_be_zd,
+            gen_helper_sve_lddd_be_zd, } } },
+
+      /* First-fault */
+      { { { gen_helper_sve_ldffbds_zsu,
+            gen_helper_sve_ldffhds_zsu,
+            gen_helper_sve_ldffsds_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zsu,
+            gen_helper_sve_ldffhdu_zsu,
+            gen_helper_sve_ldffsdu_zsu,
+            gen_helper_sve_ldffddu_zsu, } },
+        { { gen_helper_sve_ldffbds_zss,
+            gen_helper_sve_ldffhds_zss,
+            gen_helper_sve_ldffsds_zss,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zss,
+            gen_helper_sve_ldffhdu_zss,
+            gen_helper_sve_ldffsdu_zss,
+            gen_helper_sve_ldffddu_zss, } },
+        { { gen_helper_sve_ldffbds_zd,
+            gen_helper_sve_ldffhds_zd,
+            gen_helper_sve_ldffsds_zd,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zd,
+            gen_helper_sve_ldffhdu_zd,
+            gen_helper_sve_ldffsdu_zd,
+            gen_helper_sve_ldffddu_zd, } } } },
 };
 
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
+    int be = s->be_data == MO_BE;
 
     if (!sve_access_check(s)) {
         return true;
@@ -5169,10 +5254,10 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn32[be][a->ff][a->xs][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn64[be][a->ff][a->xs][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5185,6 +5270,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
 static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
+    int be = s->be_data == MO_BE;
     TCGv_i64 imm;
 
     if (a->esz < a->msz || (a->esz == a->msz && !a->u)) {
@@ -5196,10 +5282,10 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[a->ff][0][a->u][a->msz];
+        fn = gather_load_fn32[be][a->ff][0][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[a->ff][2][a->u][a->msz];
+        fn = gather_load_fn64[be][a->ff][2][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
-- 
2.17.1
