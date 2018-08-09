Received: from eggs.gnu.org ([2001:4830:134:3::10]:54160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncTA-000151-HL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT7-0007VA-BG
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncT6-0007UM-W1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id z8-v6so2108090pgu.8
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:05 -0700
Message-Id: <20180809042206.15726-20-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/20] target/arm: Rewrite vector gather
 first-fault loads
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

This implements the feature for softmmu, and moves the
main loop out of a macro and into a function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  84 ++++++++---
 target/arm/sve_helper.c    | 290 +++++++++++++++++++++++++++----------
 target/arm/translate-sve.c |  84 +++++------
 3 files changed, 321 insertions(+), 137 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6b9b93af45..9e79182ab4 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1401,69 +1401,111 @@ DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffssu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffssu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffddu_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffddu_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffddu_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0a4756bff9..6728862326 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5147,91 +5147,233 @@ DO_LD1_ZPZ_D(dd_be, zd)
 
 /* First fault loads with a vector index.  */
 
-#ifdef CONFIG_USER_ONLY
+/* Load one element into VD+REG_OFF from (ENV,VADDR) without faulting.
+ * The controlling predicate is known to be true.  Return true if the
+ * load was successful.
+ */
+typedef bool sve_ld1_nf_fn(CPUARMState *env, void *vd, intptr_t reg_off,
+                           target_ulong vaddr, int mmu_idx);
 
-#define DO_LDFF1_ZPZ(NAME, TYPEE, TYPEI, TYPEM, FN, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    intptr_t i, oprsz = simd_oprsz(desc);                               \
-    unsigned scale = simd_data(desc);                                   \
-    uintptr_t ra = GETPC();                                             \
-    bool first = true;                                                  \
-    mmap_lock();                                                        \
-    for (i = 0; i < oprsz; ) {                                          \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
-        do {                                                            \
-            TYPEM m = 0;                                                \
-            if (pg & 1) {                                               \
-                target_ulong off = *(TYPEI *)(vm + H(i));               \
-                target_ulong addr = base + (off << scale);              \
-                if (!first &&                                           \
-                    page_check_range(addr, sizeof(TYPEM), PAGE_READ)) { \
-                    record_fault(env, i, oprsz);                        \
-                    goto exit;                                          \
-                }                                                       \
-                m = FN(env, addr, ra);                                  \
-                first = false;                                          \
-            }                                                           \
-            *(TYPEE *)(vd + H(i)) = m;                                  \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);                   \
-        } while (i & 15);                                               \
-    }                                                                   \
- exit:                                                                  \
-    mmap_unlock();                                                      \
+#ifdef CONFIG_SOFTMMU
+#define DO_LD_NF(NAME, H, TYPEE, TYPEM, HOST) \
+static bool sve_ld##NAME##_nf(CPUARMState *env, void *vd, intptr_t reg_off, \
+                            target_ulong addr, int mmu_idx)                 \
+{                                                                           \
+    target_ulong next_page = -(addr | TARGET_PAGE_MASK);                    \
+    if (likely(next_page - addr >= sizeof(TYPEM))) {                        \
+        void *host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);  \
+        if (likely(host)) {                                                 \
+            TYPEM val = HOST(host);                                         \
+            *(TYPEE *)(vd + H(reg_off)) = val;                              \
+            return true;                                                    \
+        }                                                                   \
+    }                                                                       \
+    return false;                                                           \
 }
-
 #else
-
-#define DO_LDFF1_ZPZ(NAME, TYPEE, TYPEI, TYPEM, FN, H)                  \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    g_assert_not_reached();                                             \
+#define DO_LD_NF(NAME, H, TYPEE, TYPEM, HOST) \
+static bool sve_ld##NAME##_nf(CPUARMState *env, void *vd, intptr_t reg_off, \
+                            target_ulong addr, int mmu_idx)                 \
+{                                                                           \
+    if (likely(page_check_range(addr, sizeof(TYPEM), PAGE_READ))) {         \
+        TYPEM val = HOST(g2h(addr));                                        \
+        *(TYPEE *)(vd + H(reg_off)) = val;                                  \
+        return true;                                                        \
+    }                                                                       \
+    return false;                                                           \
 }
-
 #endif
 
-#define DO_LDFF1_ZPZ_S(NAME, TYPEI, TYPEM, FN) \
-    DO_LDFF1_ZPZ(NAME, uint32_t, TYPEI, TYPEM, FN, H1_4)
-#define DO_LDFF1_ZPZ_D(NAME, TYPEI, TYPEM, FN) \
-    DO_LDFF1_ZPZ(NAME, uint64_t, TYPEI, TYPEM, FN, )
+DO_LD_NF(bsu, H1_4, uint32_t, uint8_t, ldub_p)
+DO_LD_NF(bss, H1_4, uint32_t,  int8_t, ldsb_p)
+DO_LD_NF(bdu,     , uint64_t, uint8_t, ldub_p)
+DO_LD_NF(bds,     , uint64_t,  int8_t, ldsb_p)
 
-DO_LDFF1_ZPZ_S(sve_ldffbsu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffhsu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffssu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffbss_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffhss_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
+DO_LD_NF(hsu_le, H1_4, uint32_t, uint16_t, lduw_le_p)
+DO_LD_NF(hss_le, H1_4, uint32_t,  int16_t, ldsw_le_p)
+DO_LD_NF(hsu_be, H1_4, uint32_t, uint16_t, lduw_be_p)
+DO_LD_NF(hss_be, H1_4, uint32_t,  int16_t, ldsw_be_p)
+DO_LD_NF(hdu_le,     , uint64_t, uint16_t, lduw_le_p)
+DO_LD_NF(hds_le,     , uint64_t,  int16_t, ldsw_le_p)
+DO_LD_NF(hdu_be,     , uint64_t, uint16_t, lduw_be_p)
+DO_LD_NF(hds_be,     , uint64_t,  int16_t, ldsw_be_p)
 
-DO_LDFF1_ZPZ_S(sve_ldffbsu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffhsu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffssu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffbss_zss, int32_t, int8_t,   cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_S(sve_ldffhss_zss, int32_t, int16_t,  cpu_lduw_data_ra)
+DO_LD_NF(ss_le,  H1_4, uint32_t, uint32_t, ldl_le_p)
+DO_LD_NF(ss_be,  H1_4, uint32_t, uint32_t, ldl_be_p)
+DO_LD_NF(sdu_le,     , uint64_t, uint32_t, ldl_le_p)
+DO_LD_NF(sds_le,     , uint64_t,  int32_t, ldl_le_p)
+DO_LD_NF(sdu_be,     , uint64_t, uint32_t, ldl_be_p)
+DO_LD_NF(sds_be,     , uint64_t,  int32_t, ldl_be_p)
 
-DO_LDFF1_ZPZ_D(sve_ldffbdu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhdu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsdu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffddu_zsu, uint32_t, uint64_t, cpu_ldq_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffbds_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhds_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsds_zsu, uint32_t, int32_t,  cpu_ldl_data_ra)
+DO_LD_NF(dd_le,      , uint64_t, uint64_t, ldq_le_p)
+DO_LD_NF(dd_be,      , uint64_t, uint64_t, ldq_be_p)
 
-DO_LDFF1_ZPZ_D(sve_ldffbdu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhdu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsdu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffddu_zss, int32_t, uint64_t, cpu_ldq_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffbds_zss, int32_t, int8_t,   cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhds_zss, int32_t, int16_t,  cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsds_zss, int32_t, int32_t,  cpu_ldl_data_ra)
+/*
+ * Common helper for all gather first-faulting loads.
+ */
+static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
+                                target_ulong base, uint32_t desc, uintptr_t ra,
+                                zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
+                                sve_ld1_nf_fn *nonfault_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t reg_off, reg_max = simd_oprsz(desc);
+    unsigned scale = simd_data(desc);
+    target_ulong addr;
 
-DO_LDFF1_ZPZ_D(sve_ldffbdu_zd, uint64_t, uint8_t,  cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhdu_zd, uint64_t, uint16_t, cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsdu_zd, uint64_t, uint32_t, cpu_ldl_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffddu_zd, uint64_t, uint64_t, cpu_ldq_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffbds_zd, uint64_t, int8_t,   cpu_ldub_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffhds_zd, uint64_t, int16_t,  cpu_lduw_data_ra)
-DO_LDFF1_ZPZ_D(sve_ldffsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
+    /* Skip to the first true predicate.  */
+    reg_off = find_next_active(vg, 0, reg_max, MO_32);
+    if (likely(reg_off < reg_max)) {
+        /* Perform one normal read, which will fault or not.  */
+        set_helper_retaddr(ra);
+        addr = off_fn(vm, reg_off);
+        addr = base + (addr << scale);
+        tlb_fn(env, vd, reg_off, addr, mmu_idx, ra);
+
+        /* The rest of the reads will be non-faulting.  */
+        set_helper_retaddr(0);
+    }
+
+    /* After any fault, zero the leading predicated false elements.  */
+    swap_memzero(vd, reg_off);
+
+    while (likely((reg_off += 4) < reg_max)) {
+        uint64_t pg = *(uint64_t *)(vg + (reg_off >> 6) * 8);
+        if (likely((pg >> (reg_off & 63)) & 1)) {
+            addr = off_fn(vm, reg_off);
+            addr = base + (addr << scale);
+            if (!nonfault_fn(env, vd, reg_off, addr, mmu_idx)) {
+                record_fault(env, reg_off, reg_max);
+                break;
+            }
+        } else {
+            *(uint32_t *)(vd + H1_4(reg_off)) = 0;
+        }
+    }
+}
+
+static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
+                                target_ulong base, uint32_t desc, uintptr_t ra,
+                                zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
+                                sve_ld1_nf_fn *nonfault_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t reg_off, reg_max = simd_oprsz(desc);
+    unsigned scale = simd_data(desc);
+    target_ulong addr;
+
+    /* Skip to the first true predicate.  */
+    reg_off = find_next_active(vg, 0, reg_max, MO_64);
+    if (likely(reg_off < reg_max)) {
+        /* Perform one normal read, which will fault or not.  */
+        set_helper_retaddr(ra);
+        addr = off_fn(vm, reg_off);
+        addr = base + (addr << scale);
+        tlb_fn(env, vd, reg_off, addr, mmu_idx, ra);
+
+        /* The rest of the reads will be non-faulting.  */
+        set_helper_retaddr(0);
+    }
+
+    /* After any fault, zero the leading predicated false elements.  */
+    swap_memzero(vd, reg_off);
+
+    while (likely((reg_off += 8) < reg_max)) {
+        uint8_t pg = *(uint8_t *)(vg + H1(reg_off >> 3));
+        if (likely(pg & 1)) {
+            addr = off_fn(vm, reg_off);
+            addr = base + (addr << scale);
+            if (!nonfault_fn(env, vd, reg_off, addr, mmu_idx)) {
+                record_fault(env, reg_off, reg_max);
+                break;
+            }
+        } else {
+            *(uint64_t *)(vd + reg_off) = 0;
+        }
+    }
+}
+
+#define DO_LDFF1_ZPZ_S(MEM, OFS) \
+void HELPER(sve_ldff##MEM##_##OFS)                                      \
+    (CPUARMState *env, void *vd, void *vg, void *vm,                    \
+     target_ulong base, uint32_t desc)                                  \
+{                                                                       \
+    sve_ldff1_zs(env, vd, vg, vm, base, desc, GETPC(),                  \
+                 off_##OFS##_s, sve_ld1##MEM##_tlb, sve_ld##MEM##_nf);  \
+}
+
+#define DO_LDFF1_ZPZ_D(MEM, OFS) \
+void HELPER(sve_ldff##MEM##_##OFS)                                      \
+    (CPUARMState *env, void *vd, void *vg, void *vm,                    \
+     target_ulong base, uint32_t desc)                                  \
+{                                                                       \
+    sve_ldff1_zd(env, vd, vg, vm, base, desc, GETPC(),                  \
+                 off_##OFS##_d, sve_ld1##MEM##_tlb, sve_ld##MEM##_nf);  \
+}
+
+DO_LDFF1_ZPZ_S(bsu, zsu)
+DO_LDFF1_ZPZ_S(bsu, zss)
+DO_LDFF1_ZPZ_D(bdu, zsu)
+DO_LDFF1_ZPZ_D(bdu, zss)
+DO_LDFF1_ZPZ_D(bdu, zd)
+
+DO_LDFF1_ZPZ_S(bss, zsu)
+DO_LDFF1_ZPZ_S(bss, zss)
+DO_LDFF1_ZPZ_D(bds, zsu)
+DO_LDFF1_ZPZ_D(bds, zss)
+DO_LDFF1_ZPZ_D(bds, zd)
+
+DO_LDFF1_ZPZ_S(hsu_le, zsu)
+DO_LDFF1_ZPZ_S(hsu_le, zss)
+DO_LDFF1_ZPZ_D(hdu_le, zsu)
+DO_LDFF1_ZPZ_D(hdu_le, zss)
+DO_LDFF1_ZPZ_D(hdu_le, zd)
+
+DO_LDFF1_ZPZ_S(hsu_be, zsu)
+DO_LDFF1_ZPZ_S(hsu_be, zss)
+DO_LDFF1_ZPZ_D(hdu_be, zsu)
+DO_LDFF1_ZPZ_D(hdu_be, zss)
+DO_LDFF1_ZPZ_D(hdu_be, zd)
+
+DO_LDFF1_ZPZ_S(hss_le, zsu)
+DO_LDFF1_ZPZ_S(hss_le, zss)
+DO_LDFF1_ZPZ_D(hds_le, zsu)
+DO_LDFF1_ZPZ_D(hds_le, zss)
+DO_LDFF1_ZPZ_D(hds_le, zd)
+
+DO_LDFF1_ZPZ_S(hss_be, zsu)
+DO_LDFF1_ZPZ_S(hss_be, zss)
+DO_LDFF1_ZPZ_D(hds_be, zsu)
+DO_LDFF1_ZPZ_D(hds_be, zss)
+DO_LDFF1_ZPZ_D(hds_be, zd)
+
+DO_LDFF1_ZPZ_S(ss_le,  zsu)
+DO_LDFF1_ZPZ_S(ss_le,  zss)
+DO_LDFF1_ZPZ_D(sdu_le, zsu)
+DO_LDFF1_ZPZ_D(sdu_le, zss)
+DO_LDFF1_ZPZ_D(sdu_le, zd)
+
+DO_LDFF1_ZPZ_S(ss_be,  zsu)
+DO_LDFF1_ZPZ_S(ss_be,  zss)
+DO_LDFF1_ZPZ_D(sdu_be, zsu)
+DO_LDFF1_ZPZ_D(sdu_be, zss)
+DO_LDFF1_ZPZ_D(sdu_be, zd)
+
+DO_LDFF1_ZPZ_D(sds_le, zsu)
+DO_LDFF1_ZPZ_D(sds_le, zss)
+DO_LDFF1_ZPZ_D(sds_le, zd)
+
+DO_LDFF1_ZPZ_D(sds_be, zsu)
+DO_LDFF1_ZPZ_D(sds_be, zss)
+DO_LDFF1_ZPZ_D(sds_be, zd)
+
+DO_LDFF1_ZPZ_D(dd_le, zsu)
+DO_LDFF1_ZPZ_D(dd_le, zss)
+DO_LDFF1_ZPZ_D(dd_le, zd)
+
+DO_LDFF1_ZPZ_D(dd_be, zsu)
+DO_LDFF1_ZPZ_D(dd_be, zss)
+DO_LDFF1_ZPZ_D(dd_be, zd)
 
 /* Stores with a vector index.  */
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fdd9b9b3a0..20492e9b8b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5095,17 +5095,17 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][2][3] = {
 
       /* First-fault */
       { { { gen_helper_sve_ldffbss_zsu,
-            gen_helper_sve_ldffhss_zsu,
+            gen_helper_sve_ldffhss_le_zsu,
             NULL, },
           { gen_helper_sve_ldffbsu_zsu,
-            gen_helper_sve_ldffhsu_zsu,
-            gen_helper_sve_ldffssu_zsu, } },
+            gen_helper_sve_ldffhsu_le_zsu,
+            gen_helper_sve_ldffss_le_zsu, } },
         { { gen_helper_sve_ldffbss_zss,
-            gen_helper_sve_ldffhss_zss,
+            gen_helper_sve_ldffhss_le_zss,
             NULL, },
           { gen_helper_sve_ldffbsu_zss,
-            gen_helper_sve_ldffhsu_zss,
-            gen_helper_sve_ldffssu_zss, } } } },
+            gen_helper_sve_ldffhsu_le_zss,
+            gen_helper_sve_ldffss_le_zss, } } } },
 
     /* Big-endian */
     { { { { gen_helper_sve_ldbss_zsu,
@@ -5123,17 +5123,17 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][2][3] = {
 
       /* First-fault */
       { { { gen_helper_sve_ldffbss_zsu,
-            gen_helper_sve_ldffhss_zsu,
+            gen_helper_sve_ldffhss_be_zsu,
             NULL, },
           { gen_helper_sve_ldffbsu_zsu,
-            gen_helper_sve_ldffhsu_zsu,
-            gen_helper_sve_ldffssu_zsu, } },
+            gen_helper_sve_ldffhsu_be_zsu,
+            gen_helper_sve_ldffss_be_zsu, } },
         { { gen_helper_sve_ldffbss_zss,
-            gen_helper_sve_ldffhss_zss,
+            gen_helper_sve_ldffhss_be_zss,
             NULL, },
           { gen_helper_sve_ldffbsu_zss,
-            gen_helper_sve_ldffhsu_zss,
-            gen_helper_sve_ldffssu_zss, } } } },
+            gen_helper_sve_ldffhsu_be_zss,
+            gen_helper_sve_ldffss_be_zss, } } } },
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
@@ -5166,29 +5166,29 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][2][3][2][4] = {
 
       /* First-fault */
       { { { gen_helper_sve_ldffbds_zsu,
-            gen_helper_sve_ldffhds_zsu,
-            gen_helper_sve_ldffsds_zsu,
+            gen_helper_sve_ldffhds_le_zsu,
+            gen_helper_sve_ldffsds_le_zsu,
             NULL, },
           { gen_helper_sve_ldffbdu_zsu,
-            gen_helper_sve_ldffhdu_zsu,
-            gen_helper_sve_ldffsdu_zsu,
-            gen_helper_sve_ldffddu_zsu, } },
+            gen_helper_sve_ldffhdu_le_zsu,
+            gen_helper_sve_ldffsdu_le_zsu,
+            gen_helper_sve_ldffdd_le_zsu, } },
         { { gen_helper_sve_ldffbds_zss,
-            gen_helper_sve_ldffhds_zss,
-            gen_helper_sve_ldffsds_zss,
+            gen_helper_sve_ldffhds_le_zss,
+            gen_helper_sve_ldffsds_le_zss,
             NULL, },
           { gen_helper_sve_ldffbdu_zss,
-            gen_helper_sve_ldffhdu_zss,
-            gen_helper_sve_ldffsdu_zss,
-            gen_helper_sve_ldffddu_zss, } },
+            gen_helper_sve_ldffhdu_le_zss,
+            gen_helper_sve_ldffsdu_le_zss,
+            gen_helper_sve_ldffdd_le_zss, } },
         { { gen_helper_sve_ldffbds_zd,
-            gen_helper_sve_ldffhds_zd,
-            gen_helper_sve_ldffsds_zd,
+            gen_helper_sve_ldffhds_le_zd,
+            gen_helper_sve_ldffsds_le_zd,
             NULL, },
           { gen_helper_sve_ldffbdu_zd,
-            gen_helper_sve_ldffhdu_zd,
-            gen_helper_sve_ldffsdu_zd,
-            gen_helper_sve_ldffddu_zd, } } } },
+            gen_helper_sve_ldffhdu_le_zd,
+            gen_helper_sve_ldffsdu_le_zd,
+            gen_helper_sve_ldffdd_le_zd, } } } },
 
     /* Big-endian */
     { { { { gen_helper_sve_ldbds_zsu,
@@ -5218,29 +5218,29 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][2][3][2][4] = {
 
       /* First-fault */
       { { { gen_helper_sve_ldffbds_zsu,
-            gen_helper_sve_ldffhds_zsu,
-            gen_helper_sve_ldffsds_zsu,
+            gen_helper_sve_ldffhds_be_zsu,
+            gen_helper_sve_ldffsds_be_zsu,
             NULL, },
           { gen_helper_sve_ldffbdu_zsu,
-            gen_helper_sve_ldffhdu_zsu,
-            gen_helper_sve_ldffsdu_zsu,
-            gen_helper_sve_ldffddu_zsu, } },
+            gen_helper_sve_ldffhdu_be_zsu,
+            gen_helper_sve_ldffsdu_be_zsu,
+            gen_helper_sve_ldffdd_be_zsu, } },
         { { gen_helper_sve_ldffbds_zss,
-            gen_helper_sve_ldffhds_zss,
-            gen_helper_sve_ldffsds_zss,
+            gen_helper_sve_ldffhds_be_zss,
+            gen_helper_sve_ldffsds_be_zss,
             NULL, },
           { gen_helper_sve_ldffbdu_zss,
-            gen_helper_sve_ldffhdu_zss,
-            gen_helper_sve_ldffsdu_zss,
-            gen_helper_sve_ldffddu_zss, } },
+            gen_helper_sve_ldffhdu_be_zss,
+            gen_helper_sve_ldffsdu_be_zss,
+            gen_helper_sve_ldffdd_be_zss, } },
         { { gen_helper_sve_ldffbds_zd,
-            gen_helper_sve_ldffhds_zd,
-            gen_helper_sve_ldffsds_zd,
+            gen_helper_sve_ldffhds_be_zd,
+            gen_helper_sve_ldffsds_be_zd,
             NULL, },
           { gen_helper_sve_ldffbdu_zd,
-            gen_helper_sve_ldffhdu_zd,
-            gen_helper_sve_ldffsdu_zd,
-            gen_helper_sve_ldffddu_zd, } } } },
+            gen_helper_sve_ldffhdu_be_zd,
+            gen_helper_sve_ldffsdu_be_zd,
+            gen_helper_sve_ldffdd_be_zd, } } } },
 };
 
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
-- 
2.17.1
