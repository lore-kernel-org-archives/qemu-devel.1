Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5G-0000yJ-Q5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5B-0006xf-6O
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W57-0006iu-NX
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W55-0003gN-5o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:42 +0100
Message-Id: <20181008140004.12612-12-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/33] target/arm: Rewrite helper_sve_ld1*_r
 using pages
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

Uses tlb_vaddr_to_host for correct operation with softmmu.
Optimize for accesses within a single page or pair of pages.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 731 +++++++++++++++++++++++++++++++---------
 1 file changed, 569 insertions(+), 162 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0f980972535..d628978431c 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1688,6 +1688,47 @@ static void swap_memmove(void *vd, void *vs, size_t n)
     }
 }
 
+/* Similarly for memset of 0.  */
+static void swap_memzero(void *vd, size_t n)
+{
+    uintptr_t d = (uintptr_t)vd;
+    uintptr_t o = (d | n) & 7;
+    size_t i;
+
+    /* Usually, the first bit of a predicate is set, so N is 0.  */
+    if (likely(n == 0)) {
+        return;
+    }
+
+#ifndef HOST_WORDS_BIGENDIAN
+    o = 0;
+#endif
+    switch (o) {
+    case 0:
+        memset(vd, 0, n);
+        break;
+
+    case 4:
+        for (i = 0; i < n; i += 4) {
+            *(uint32_t *)H1_4(d + i) = 0;
+        }
+        break;
+
+    case 2:
+    case 6:
+        for (i = 0; i < n; i += 2) {
+            *(uint16_t *)H1_2(d + i) = 0;
+        }
+        break;
+
+    default:
+        for (i = 0; i < n; i++) {
+            *(uint8_t *)H1(d + i) = 0;
+        }
+        break;
+    }
+}
+
 void HELPER(sve_ext)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t opr_sz = simd_oprsz(desc);
@@ -3927,32 +3968,323 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
 /*
  * Load contiguous data, protected by a governing predicate.
  */
-#define DO_LD1(NAME, FN, TYPEE, TYPEM, H)                  \
-static void do_##NAME(CPUARMState *env, void *vd, void *vg, \
-                      target_ulong addr, intptr_t oprsz,   \
-                      uintptr_t ra)                        \
-{                                                          \
-    intptr_t i = 0;                                        \
-    do {                                                   \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
-        do {                                               \
-            TYPEM m = 0;                                   \
-            if (pg & 1) {                                  \
-                m = FN(env, addr, ra);                     \
-            }                                              \
-            *(TYPEE *)(vd + H(i)) = m;                     \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
-            addr += sizeof(TYPEM);                         \
-        } while (i & 15);                                  \
-    } while (i < oprsz);                                   \
-}                                                          \
-void HELPER(NAME)(CPUARMState *env, void *vg,              \
-                  target_ulong addr, uint32_t desc)        \
-{                                                          \
-    do_##NAME(env, &env->vfp.zregs[simd_data(desc)], vg,   \
-              addr, simd_oprsz(desc), GETPC());            \
+
+/*
+ * Load elements into @vd, controlled by @vg, from @host + @mem_ofs.
+ * Memory is valid through @host + @mem_max.  The register element
+ * indicies are inferred from @mem_ofs, as modified by the types for
+ * which the helper is built.  Return the @mem_ofs of the first element
+ * not loaded (which is @mem_max if they are all loaded).
+ *
+ * For softmmu, we have fully validated the guest page.  For user-only,
+ * we cannot fully validate without taking the mmap lock, but since we
+ * know the access is within one host page, if any access is valid they
+ * all must be valid.  However, when @vg is all false, it may be that
+ * no access is valid.
+ */
+typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
+                                 intptr_t mem_ofs, intptr_t mem_max);
+
+/*
+ * Load one element into @vd + @reg_off from (@env, @vaddr, @ra).
+ * The controlling predicate is known to be true.
+ */
+typedef void sve_ld1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
+                            target_ulong vaddr, int mmu_idx, uintptr_t ra);
+
+/*
+ * Generate the above primitives.
+ */
+
+#define DO_LD_HOST(NAME, H, TYPEE, TYPEM, HOST) \
+static intptr_t sve_##NAME##_host(void *vd, void *vg, void *host,           \
+                                  intptr_t mem_off, const intptr_t mem_max) \
+{                                                                           \
+    intptr_t reg_off = mem_off * (sizeof(TYPEE) / sizeof(TYPEM));           \
+    uint64_t *pg = vg;                                                      \
+    while (mem_off + sizeof(TYPEM) <= mem_max) {                            \
+        TYPEM val = 0;                                                      \
+        if (likely((pg[reg_off >> 6] >> (reg_off & 63)) & 1)) {             \
+            val = HOST(host + mem_off);                                     \
+        }                                                                   \
+        *(TYPEE *)(vd + H(reg_off)) = val;                                  \
+        mem_off += sizeof(TYPEM), reg_off += sizeof(TYPEE);                 \
+    }                                                                       \
+    return mem_off;                                                         \
 }
 
+#ifdef CONFIG_SOFTMMU
+#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB) \
+static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
+                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+{                                                                           \
+    TCGMemOpIdx oi = make_memop_idx(ctz32(sizeof(TYPEM)) | MOEND, mmu_idx); \
+    TYPEM val = TLB(env, addr, oi, ra);                                     \
+    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
+}
+#else
+#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB)                  \
+static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
+                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+{                                                                           \
+    TYPEM val = HOST(g2h(addr));                                            \
+    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
+}
+#endif
+
+#define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
+    DO_LD_HOST(NAME, H, TE, TM, ldub_p)                 \
+    DO_LD_TLB(NAME, H, TE, TM, ldub_p, 0, helper_ret_ldub_mmu)
+
+DO_LD_PRIM_1(ld1bb,  H1,   uint8_t,  uint8_t)
+DO_LD_PRIM_1(ld1bhu, H1_2, uint16_t, uint8_t)
+DO_LD_PRIM_1(ld1bhs, H1_2, uint16_t,  int8_t)
+DO_LD_PRIM_1(ld1bsu, H1_4, uint32_t, uint8_t)
+DO_LD_PRIM_1(ld1bss, H1_4, uint32_t,  int8_t)
+DO_LD_PRIM_1(ld1bdu,     , uint64_t, uint8_t)
+DO_LD_PRIM_1(ld1bds,     , uint64_t,  int8_t)
+
+#define DO_LD_PRIM_2(NAME, end, MOEND, H, TE, TM, PH, PT)  \
+    DO_LD_HOST(NAME##_##end, H, TE, TM, PH##_##end##_p)    \
+    DO_LD_TLB(NAME##_##end, H, TE, TM, PH##_##end##_p,     \
+              MOEND, helper_##end##_##PT##_mmu)
+
+DO_LD_PRIM_2(ld1hh,  le, MO_LE, H1_2, uint16_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hsu, le, MO_LE, H1_4, uint32_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hss, le, MO_LE, H1_4, uint32_t,  int16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hdu, le, MO_LE,     , uint64_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hds, le, MO_LE,     , uint64_t,  int16_t, lduw, lduw)
+
+DO_LD_PRIM_2(ld1ss,  le, MO_LE, H1_4, uint32_t, uint32_t, ldl, ldul)
+DO_LD_PRIM_2(ld1sdu, le, MO_LE,     , uint64_t, uint32_t, ldl, ldul)
+DO_LD_PRIM_2(ld1sds, le, MO_LE,     , uint64_t,  int32_t, ldl, ldul)
+
+DO_LD_PRIM_2(ld1dd,  le, MO_LE,     , uint64_t, uint64_t, ldq, ldq)
+
+DO_LD_PRIM_2(ld1hh,  be, MO_BE, H1_2, uint16_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hsu, be, MO_BE, H1_4, uint32_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hss, be, MO_BE, H1_4, uint32_t,  int16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hdu, be, MO_BE,     , uint64_t, uint16_t, lduw, lduw)
+DO_LD_PRIM_2(ld1hds, be, MO_BE,     , uint64_t,  int16_t, lduw, lduw)
+
+DO_LD_PRIM_2(ld1ss,  be, MO_BE, H1_4, uint32_t, uint32_t, ldl, ldul)
+DO_LD_PRIM_2(ld1sdu, be, MO_BE,     , uint64_t, uint32_t, ldl, ldul)
+DO_LD_PRIM_2(ld1sds, be, MO_BE,     , uint64_t,  int32_t, ldl, ldul)
+
+DO_LD_PRIM_2(ld1dd,  be, MO_BE,     , uint64_t, uint64_t, ldq, ldq)
+
+#undef DO_LD_TLB
+#undef DO_LD_HOST
+#undef DO_LD_PRIM_1
+#undef DO_LD_PRIM_2
+
+/*
+ * Skip through a sequence of inactive elements in the guarding predicate @vg,
+ * beginning at @reg_off bounded by @reg_max.  Return the offset of the active
+ * element >= @reg_off, or @reg_max if there were no active elements at all.
+ */
+static intptr_t find_next_active(uint64_t *vg, intptr_t reg_off,
+                                 intptr_t reg_max, int esz)
+{
+    uint64_t pg_mask = pred_esz_masks[esz];
+    uint64_t pg = (vg[reg_off >> 6] & pg_mask) >> (reg_off & 63);
+
+    /* In normal usage, the first element is active.  */
+    if (likely(pg & 1)) {
+        return reg_off;
+    }
+
+    if (pg == 0) {
+        reg_off &= -64;
+        do {
+            reg_off += 64;
+            if (unlikely(reg_off >= reg_max)) {
+                /* The entire predicate was false.  */
+                return reg_max;
+            }
+            pg = vg[reg_off >> 6] & pg_mask;
+        } while (pg == 0);
+    }
+    reg_off += ctz64(pg);
+
+    /* We should never see an out of range predicate bit set.  */
+    tcg_debug_assert(reg_off < reg_max);
+    return reg_off;
+}
+
+/*
+ * Return the maximum offset <= @mem_max which is still within the page
+ * referenced by @base + @mem_off.
+ */
+static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
+                             intptr_t mem_max)
+{
+    target_ulong addr = base + mem_off;
+    intptr_t split = -(intptr_t)(addr | TARGET_PAGE_MASK);
+    return MIN(split, mem_max - mem_off) + mem_off;
+}
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    helper_retaddr = ra;
+#endif
+}
+
+/*
+ * The result of tlb_vaddr_to_host for user-only is just g2h(x),
+ * which is always non-null.  Elide the useless test.
+ */
+static inline bool test_host_page(void *host)
+{
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
+    return likely(host != NULL);
+#endif
+}
+
+/*
+ * Common helper for all contiguous one-register predicated loads.
+ */
+static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
+                      uint32_t desc, const uintptr_t retaddr,
+                      const int esz, const int msz,
+                      sve_ld1_host_fn *host_fn,
+                      sve_ld1_tlb_fn *tlb_fn)
+{
+    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const int diffsz = esz - msz;
+    const intptr_t reg_max = simd_oprsz(desc);
+    const intptr_t mem_max = reg_max >> diffsz;
+    const int mmu_idx = cpu_mmu_index(env, false);
+    ARMVectorReg scratch;
+    void *host;
+    intptr_t split, reg_off, mem_off;
+
+    /* Find the first active element.  */
+    reg_off = find_next_active(vg, 0, reg_max, esz);
+    if (unlikely(reg_off == reg_max)) {
+        /* The entire predicate was false; no load occurs.  */
+        memset(vd, 0, reg_max);
+        return;
+    }
+    mem_off = reg_off >> diffsz;
+    set_helper_retaddr(retaddr);
+
+    /*
+     * If the (remaining) load is entirely within a single page, then:
+     * For softmmu, and the tlb hits, then no faults will occur;
+     * For user-only, either the first load will fault or none will.
+     * We can thus perform the load directly to the destination and
+     * Vd will be unmodified on any exception path.
+     */
+    split = max_for_page(addr, mem_off, mem_max);
+    if (likely(split == mem_max)) {
+        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
+        if (test_host_page(host)) {
+            mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
+            tcg_debug_assert(mem_off == mem_max);
+            set_helper_retaddr(0);
+            /* After having taken any fault, zero leading inactive elements. */
+            swap_memzero(vd, reg_off);
+            return;
+        }
+    }
+
+    /*
+     * Perform the predicated read into a temporary, thus ensuring
+     * if the load of the last element faults, Vd is not modified.
+     */
+#ifdef CONFIG_USER_ONLY
+    swap_memzero(&scratch, reg_off);
+    host_fn(&scratch, vg, g2h(addr), mem_off, mem_max);
+#else
+    memset(&scratch, 0, reg_max);
+    goto start;
+    while (1) {
+        reg_off = find_next_active(vg, reg_off, reg_max, esz);
+        if (reg_off >= reg_max) {
+            break;
+        }
+        mem_off = reg_off >> diffsz;
+        split = max_for_page(addr, mem_off, mem_max);
+
+    start:
+        if (split - mem_off >= (1 << msz)) {
+            /* At least one whole element on this page.  */
+            host = tlb_vaddr_to_host(env, addr + mem_off,
+                                     MMU_DATA_LOAD, mmu_idx);
+            if (host) {
+                mem_off = host_fn(&scratch, vg, host - mem_off,
+                                  mem_off, split);
+                reg_off = mem_off << diffsz;
+                continue;
+            }
+        }
+
+        /*
+         * Perform one normal read.  This may fault, longjmping out to the
+         * main loop in order to raise an exception.  It may succeed, and
+         * as a side-effect load the TLB entry for the next round.  Finally,
+         * in the extremely unlikely case we're performing this operation
+         * on I/O memory, it may succeed but not bring in the TLB entry.
+         * But even then we have still made forward progress.
+         */
+        tlb_fn(env, &scratch, reg_off, addr + mem_off, mmu_idx, retaddr);
+        reg_off += 1 << esz;
+    }
+#endif
+
+    set_helper_retaddr(0);
+    memcpy(vd, &scratch, reg_max);
+}
+
+#define DO_LD1_1(NAME, ESZ) \
+void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
+                            target_ulong addr, uint32_t desc)  \
+{                                                              \
+    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, 0,            \
+              sve_##NAME##_host, sve_##NAME##_tlb);            \
+}
+
+/* TODO: Propagate the endian check back to the translator.  */
+#define DO_LD1_2(NAME, ESZ, MSZ) \
+void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
+                            target_ulong addr, uint32_t desc)  \
+{                                                              \
+    if (arm_cpu_data_is_big_endian(env)) {                     \
+        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
+                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);  \
+    } else {                                                   \
+        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
+                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);  \
+    }                                                          \
+}
+
+DO_LD1_1(ld1bb,  0)
+DO_LD1_1(ld1bhu, 1)
+DO_LD1_1(ld1bhs, 1)
+DO_LD1_1(ld1bsu, 2)
+DO_LD1_1(ld1bss, 2)
+DO_LD1_1(ld1bdu, 3)
+DO_LD1_1(ld1bds, 3)
+
+DO_LD1_2(ld1hh,  1, 1)
+DO_LD1_2(ld1hsu, 2, 1)
+DO_LD1_2(ld1hss, 2, 1)
+DO_LD1_2(ld1hdu, 3, 1)
+DO_LD1_2(ld1hds, 3, 1)
+
+DO_LD1_2(ld1ss,  2, 2)
+DO_LD1_2(ld1sdu, 3, 2)
+DO_LD1_2(ld1sds, 3, 2)
+
+DO_LD1_2(ld1dd,  3, 3)
+
+#undef DO_LD1_1
+#undef DO_LD1_2
+
 #define DO_LD2(NAME, FN, TYPEE, TYPEM, H)                  \
 void HELPER(NAME)(CPUARMState *env, void *vg,              \
                   target_ulong addr, uint32_t desc)        \
@@ -4037,52 +4369,40 @@ void HELPER(NAME)(CPUARMState *env, void *vg,              \
     }                                                      \
 }
 
-DO_LD1(sve_ld1bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
-DO_LD1(sve_ld1bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
-DO_LD1(sve_ld1bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
-DO_LD1(sve_ld1bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
-DO_LD1(sve_ld1bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
-DO_LD1(sve_ld1bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
-
-DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
-DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int16_t, H1_4)
-DO_LD1(sve_ld1hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
-DO_LD1(sve_ld1hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
-
-DO_LD1(sve_ld1sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
-DO_LD1(sve_ld1sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
-
-DO_LD1(sve_ld1bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
 DO_LD2(sve_ld2bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
 DO_LD3(sve_ld3bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
 DO_LD4(sve_ld4bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
 
-DO_LD1(sve_ld1hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
 DO_LD2(sve_ld2hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
 DO_LD3(sve_ld3hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
 DO_LD4(sve_ld4hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
 
-DO_LD1(sve_ld1ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
 DO_LD2(sve_ld2ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
 DO_LD3(sve_ld3ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
 DO_LD4(sve_ld4ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
 
-DO_LD1(sve_ld1dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
 DO_LD2(sve_ld2dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
 DO_LD3(sve_ld3dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
 DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
 
-#undef DO_LD1
 #undef DO_LD2
 #undef DO_LD3
 #undef DO_LD4
 
 /*
  * Load contiguous data, first-fault and no-fault.
+ *
+ * For user-only, one could argue that we should hold the mmap_lock during
+ * the operation so that there is no race between page_check_range and the
+ * load operation.  However, unmapping pages out from under a running thread
+ * is extraordinarily unlikely.  This theoretical race condition also affects
+ * linux-user/ in its get_user/put_user macros.
+ *
+ * TODO: Construct some helpers, written in assembly, that interact with
+ * handle_cpu_signal to produce memory ops which can properly report errors
+ * without racing.
  */
 
-#ifdef CONFIG_USER_ONLY
-
 /* Fault on byte I.  All bits in FFR from I are cleared.  The vector
  * result from I is CONSTRAINED UNPREDICTABLE; we choose the MERGE
  * option, which leaves subsequent data unchanged.
@@ -4100,139 +4420,226 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
     }
 }
 
-/* Hold the mmap lock during the operation so that there is no race
- * between page_check_range and the load operation.  We expect the
- * usual case to have no faults at all, so we check the whole range
- * first and if successful defer to the normal load operation.
- *
- * TODO: Change mmap_lock to a rwlock so that multiple readers
- * can run simultaneously.  This will probably help other uses
- * within QEMU as well.
+/*
+ * Common helper for all contiguous first-fault loads.
  */
-#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                             \
-static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,    \
-                               target_ulong addr, intptr_t oprsz,       \
-                               bool first, uintptr_t ra)                \
-{                                                                       \
-    intptr_t i = 0;                                                     \
-    do {                                                                \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
-        do {                                                            \
-            TYPEM m = 0;                                                \
-            if (pg & 1) {                                               \
-                if (!first &&                                           \
-                    unlikely(page_check_range(addr, sizeof(TYPEM),      \
-                                              PAGE_READ))) {            \
-                    record_fault(env, i, oprsz);                        \
-                    return;                                             \
-                }                                                       \
-                m = FN(env, addr, ra);                                  \
-                first = false;                                          \
-            }                                                           \
-            *(TYPEE *)(vd + H(i)) = m;                                  \
-            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);                   \
-            addr += sizeof(TYPEM);                                      \
-        } while (i & 15);                                               \
-    } while (i < oprsz);                                                \
-}                                                                       \
-void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,                \
-                             target_ulong addr, uint32_t desc)          \
-{                                                                       \
-    intptr_t oprsz = simd_oprsz(desc);                                  \
-    unsigned rd = simd_data(desc);                                      \
-    void *vd = &env->vfp.zregs[rd];                                     \
-    mmap_lock();                                                        \
-    if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
-        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
-    } else {                                                            \
-        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, true, GETPC());    \
-    }                                                                   \
-    mmap_unlock();                                                      \
-}
+static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
+                        uint32_t desc, const uintptr_t retaddr,
+                        const int esz, const int msz,
+                        sve_ld1_host_fn *host_fn,
+                        sve_ld1_tlb_fn *tlb_fn)
+{
+    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const int diffsz = esz - msz;
+    const intptr_t reg_max = simd_oprsz(desc);
+    const intptr_t mem_max = reg_max >> diffsz;
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t split, reg_off, mem_off;
+    void *host;
 
-/* No-fault loads are like first-fault loads without the
- * first faulting special case.
- */
-#define DO_LDNF1(PART)                                                  \
-void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,                \
-                             target_ulong addr, uint32_t desc)          \
-{                                                                       \
-    intptr_t oprsz = simd_oprsz(desc);                                  \
-    unsigned rd = simd_data(desc);                                      \
-    void *vd = &env->vfp.zregs[rd];                                     \
-    mmap_lock();                                                        \
-    if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
-        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
-    } else {                                                            \
-        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, false, GETPC());   \
-    }                                                                   \
-    mmap_unlock();                                                      \
-}
+    /* Skip to the first active element.  */
+    reg_off = find_next_active(vg, 0, reg_max, esz);
+    if (unlikely(reg_off == reg_max)) {
+        /* The entire predicate was false; no load occurs.  */
+        memset(vd, 0, reg_max);
+        return;
+    }
+    mem_off = reg_off >> diffsz;
+    set_helper_retaddr(retaddr);
 
+    /*
+     * If the (remaining) load is entirely within a single page, then:
+     * For softmmu, and the tlb hits, then no faults will occur;
+     * For user-only, either the first load will fault or none will.
+     * We can thus perform the load directly to the destination and
+     * Vd will be unmodified on any exception path.
+     */
+    split = max_for_page(addr, mem_off, mem_max);
+    if (likely(split == mem_max)) {
+        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
+        if (test_host_page(host)) {
+            mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
+            tcg_debug_assert(mem_off == mem_max);
+            set_helper_retaddr(0);
+            /* After any fault, zero any leading inactive elements.  */
+            swap_memzero(vd, reg_off);
+            return;
+        }
+    }
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * The page(s) containing this first element at ADDR+MEM_OFF must
+     * be valid.  Considering that this first element may be misaligned
+     * and cross a page boundary itself, take the rest of the page from
+     * the last byte of the element.
+     */
+    split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
+    mem_off = host_fn(vd, vg, g2h(addr), mem_off, split);
+
+    /* After any fault, zero any leading inactive elements.  */
+    swap_memzero(vd, reg_off);
+    reg_off = mem_off << diffsz;
 #else
+    /*
+     * Perform one normal read, which will fault or not.
+     * But it is likely to bring the page into the tlb.
+     */
+    tlb_fn(env, vd, reg_off, addr + mem_off, mmu_idx, retaddr);
 
-/* TODO: System mode is not yet supported.
- * This would probably use tlb_vaddr_to_host.
- */
-#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                     \
-void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,        \
-                  target_ulong addr, uint32_t desc)             \
-{                                                               \
-    g_assert_not_reached();                                     \
-}
-
-#define DO_LDNF1(PART)                                          \
-void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,        \
-                  target_ulong addr, uint32_t desc)             \
-{                                                               \
-    g_assert_not_reached();                                     \
-}
+    /* After any fault, zero any leading predicated false elts.  */
+    swap_memzero(vd, reg_off);
+    mem_off += 1 << msz;
+    reg_off += 1 << esz;
 
+    /* Try again to read the balance of the page.  */
+    split = max_for_page(addr, mem_off - 1, mem_max);
+    if (split >= (1 << msz)) {
+        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
+        if (host) {
+            mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
+            reg_off = mem_off << diffsz;
+        }
+    }
 #endif
 
-DO_LDFF1(bb_r,  cpu_ldub_data_ra, uint8_t, uint8_t, H1)
-DO_LDFF1(bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
-DO_LDFF1(bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
-DO_LDFF1(bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
-DO_LDFF1(bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
-DO_LDFF1(bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
-DO_LDFF1(bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
+    set_helper_retaddr(0);
+    record_fault(env, reg_off, reg_max);
+}
 
-DO_LDFF1(hh_r,  cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
-DO_LDFF1(hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
-DO_LDFF1(hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
-DO_LDFF1(hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
-DO_LDFF1(hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
+/*
+ * Common helper for all contiguous no-fault loads.
+ */
+static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
+                        uint32_t desc, const int esz, const int msz,
+                        sve_ld1_host_fn *host_fn)
+{
+    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const int diffsz = esz - msz;
+    const intptr_t reg_max = simd_oprsz(desc);
+    const intptr_t mem_max = reg_max >> diffsz;
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t split, reg_off, mem_off;
+    void *host;
 
-DO_LDFF1(ss_r,  cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
-DO_LDFF1(sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
-DO_LDFF1(sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
+#ifdef CONFIG_USER_ONLY
+    host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
+    if (likely(page_check_range(addr, mem_max, PAGE_READ) == 0)) {
+        /* The entire operation is valid and will not fault.  */
+        host_fn(vd, vg, host, 0, mem_max);
+        return;
+    }
+#endif
 
-DO_LDFF1(dd_r,  cpu_ldq_data_ra, uint64_t, uint64_t, )
+    /* There will be no fault, so we may modify in advance.  */
+    memset(vd, 0, reg_max);
 
-#undef DO_LDFF1
+    /* Skip to the first active element.  */
+    reg_off = find_next_active(vg, 0, reg_max, esz);
+    if (unlikely(reg_off == reg_max)) {
+        /* The entire predicate was false; no load occurs.  */
+        return;
+    }
+    mem_off = reg_off >> diffsz;
 
-DO_LDNF1(bb_r)
-DO_LDNF1(bhu_r)
-DO_LDNF1(bhs_r)
-DO_LDNF1(bsu_r)
-DO_LDNF1(bss_r)
-DO_LDNF1(bdu_r)
-DO_LDNF1(bds_r)
+#ifdef CONFIG_USER_ONLY
+    if (page_check_range(addr + mem_off, 1 << msz, PAGE_READ) == 0) {
+        /* At least one load is valid; take the rest of the page.  */
+        split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
+        mem_off = host_fn(vd, vg, host, mem_off, split);
+        reg_off = mem_off << diffsz;
+    }
+#else
+    /*
+     * If the address is not in the TLB, we have no way to bring the
+     * entry into the TLB without also risking a fault.  Note that
+     * the corollary is that we never load from an address not in RAM.
+     *
+     * This last is out of spec, in a weird corner case.
+     * Per the MemNF/MemSingleNF pseudocode, a NF load from Device memory
+     * must not actually hit the bus -- it returns UNKNOWN data instead.
+     * But if you map non-RAM with Normal memory attributes and do a NF
+     * load then it should access the bus.  (Nobody ought actually do this
+     * in the real world, obviously.)
+     *
+     * Then there are the annoying special cases with watchpoints...
+     *
+     * TODO: Add a form of tlb_fill that does not raise an exception,
+     * with a form of tlb_vaddr_to_host and a set of loads to match.
+     * The non_fault_vaddr_to_host would handle everything, usually,
+     * and the loads would handle the iomem path for watchpoints.
+     */
+    host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
+    split = max_for_page(addr, mem_off, mem_max);
+    if (host && split >= (1 << msz)) {
+        mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
+        reg_off = mem_off << diffsz;
+    }
+#endif
 
-DO_LDNF1(hh_r)
-DO_LDNF1(hsu_r)
-DO_LDNF1(hss_r)
-DO_LDNF1(hdu_r)
-DO_LDNF1(hds_r)
+    record_fault(env, reg_off, reg_max);
+}
 
-DO_LDNF1(ss_r)
-DO_LDNF1(sdu_r)
-DO_LDNF1(sds_r)
+#define DO_LDFF1_LDNF1_1(PART, ESZ) \
+void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, 0,                   \
+                sve_ld1##PART##_host, sve_ld1##PART##_tlb);             \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_ldnf1_r(env, vg, addr, desc, ESZ, 0, sve_ld1##PART##_host);     \
+}
 
-DO_LDNF1(dd_r)
+/* TODO: Propagate the endian check back to the translator.  */
+#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
+void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    if (arm_cpu_data_is_big_endian(env)) {                              \
+        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+                    sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);   \
+    } else {                                                            \
+        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+                    sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);   \
+    }                                                                   \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    if (arm_cpu_data_is_big_endian(env)) {                              \
+        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
+                    sve_ld1##PART##_be_host);                           \
+    } else {                                                            \
+        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
+                    sve_ld1##PART##_le_host);                           \
+    }                                                                   \
+}
 
-#undef DO_LDNF1
+DO_LDFF1_LDNF1_1(bb,  0)
+DO_LDFF1_LDNF1_1(bhu, 1)
+DO_LDFF1_LDNF1_1(bhs, 1)
+DO_LDFF1_LDNF1_1(bsu, 2)
+DO_LDFF1_LDNF1_1(bss, 2)
+DO_LDFF1_LDNF1_1(bdu, 3)
+DO_LDFF1_LDNF1_1(bds, 3)
+
+DO_LDFF1_LDNF1_2(hh,  1, 1)
+DO_LDFF1_LDNF1_2(hsu, 2, 1)
+DO_LDFF1_LDNF1_2(hss, 2, 1)
+DO_LDFF1_LDNF1_2(hdu, 3, 1)
+DO_LDFF1_LDNF1_2(hds, 3, 1)
+
+DO_LDFF1_LDNF1_2(ss,  2, 2)
+DO_LDFF1_LDNF1_2(sdu, 3, 2)
+DO_LDFF1_LDNF1_2(sds, 3, 2)
+
+DO_LDFF1_LDNF1_2(dd,  3, 3)
+
+#undef DO_LDFF1_LDNF1_1
+#undef DO_LDFF1_LDNF1_2
 
 /*
  * Store contiguous data, protected by a governing predicate.
-- 
2.19.0
