Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncTB-00016T-VQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT8-0007X5-Th
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncT8-0007WP-Hm
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id p12-v6so2207430pfh.2
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:06 -0700
Message-Id: <20180809042206.15726-21-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/20] target/arm: Pass TCGMemOpIdx to sve
 memory helpers
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

There is quite a lot of code required to compute cpu_mem_index,
or even put together the full TCGMemOpIdx.  This can easily be
done at translation time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     |   5 ++
 target/arm/sve_helper.c    | 138 +++++++++++++++++++------------------
 target/arm/translate-sve.c |  67 +++++++++++-------
 3 files changed, 121 insertions(+), 89 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc9357766c..24c0444c8d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -796,4 +796,9 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
+/* Note make_memop_idx reserves 4 bits for mmu_idx, and MO_BSWAP is bit 3.
+ * Thus a TCGMemOpIdx, without any MO_ALIGN bits, fits in 8 bits.
+ */
+#define MEMOPIDX_SHIFT  8
+
 #endif
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 6728862326..5bae600d17 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
@@ -3986,7 +3987,7 @@ typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
  * The controlling predicate is known to be true.
  */
 typedef void sve_ld1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
-                            target_ulong vaddr, int mmu_idx, uintptr_t ra);
+                            target_ulong vaddr, TCGMemOpIdx oi, uintptr_t ra);
 typedef sve_ld1_tlb_fn sve_st1_tlb_fn;
 
 /*
@@ -4013,16 +4014,15 @@ static intptr_t sve_##NAME##_host(void *vd, void *vg, void *host,           \
 #ifdef CONFIG_SOFTMMU
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra)  \
 {                                                                           \
-    TCGMemOpIdx oi = make_memop_idx(ctz32(sizeof(TYPEM)) | MOEND, mmu_idx); \
     TYPEM val = TLB(env, addr, oi, ra);                                     \
     *(TYPEE *)(vd + H(reg_off)) = val;                                      \
 }
 #else
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB)                  \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra)  \
 {                                                                           \
     TYPEM val = HOST(g2h(addr));                                            \
     *(TYPEE *)(vd + H(reg_off)) = val;                                      \
@@ -4287,11 +4287,13 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
                       sve_ld1_host_fn *host_fn,
                       sve_ld1_tlb_fn *tlb_fn)
 {
-    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int mmu_idx = get_mmuidx(oi);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    void *vd = &env->vfp.zregs[rd];
     const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
     const intptr_t mem_max = reg_max >> diffsz;
-    const int mmu_idx = cpu_mmu_index(env, false);
     ARMVectorReg scratch;
     void *host, *result;
     intptr_t split;
@@ -4345,7 +4347,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
          * on I/O memory, it may succeed but not bring in the TLB entry.
          * But even then we have still made forward progress.
          */
-        tlb_fn(env, result, reg_off, addr + mem_off, mmu_idx, retaddr);
+        tlb_fn(env, result, reg_off, addr + mem_off, oi, retaddr);
         reg_off += 1 << esz;
     }
 #endif
@@ -4406,9 +4408,9 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
                       sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     ARMVectorReg scratch[2] = { };
 
     set_helper_retaddr(ra);
@@ -4416,8 +4418,8 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
+                tlb_fn(env, &scratch[0], i, addr, oi, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
             }
             i += size, pg >>= size;
             addr += 2 * size;
@@ -4434,9 +4436,9 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
                       sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     ARMVectorReg scratch[3] = { };
 
     set_helper_retaddr(ra);
@@ -4444,9 +4446,9 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, mmu_idx, ra);
+                tlb_fn(env, &scratch[0], i, addr, oi, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, oi, ra);
             }
             i += size, pg >>= size;
             addr += 3 * size;
@@ -4464,9 +4466,9 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
                       sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     ARMVectorReg scratch[4] = { };
 
     set_helper_retaddr(ra);
@@ -4474,10 +4476,10 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, mmu_idx, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, mmu_idx, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, mmu_idx, ra);
-                tlb_fn(env, &scratch[3], i, addr + 3 * size, mmu_idx, ra);
+                tlb_fn(env, &scratch[0], i, addr, oi, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, oi, ra);
+                tlb_fn(env, &scratch[3], i, addr + 3 * size, oi, ra);
             }
             i += size, pg >>= size;
             addr += 4 * size;
@@ -4572,11 +4574,13 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         sve_ld1_host_fn *host_fn,
                         sve_ld1_tlb_fn *tlb_fn)
 {
-    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int mmu_idx = get_mmuidx(oi);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    void *vd = &env->vfp.zregs[rd];
     const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
     const intptr_t mem_max = reg_max >> diffsz;
-    const int mmu_idx = cpu_mmu_index(env, false);
     intptr_t split, reg_off, mem_off;
     void *host;
 
@@ -4620,7 +4624,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     /* Perform one normal read, which will fault or not.
      * But it is likely to bring the page into the tlb.
      */
-    tlb_fn(env, vd, reg_off, addr + mem_off, mmu_idx, retaddr);
+    tlb_fn(env, vd, reg_off, addr + mem_off, oi, retaddr);
 
     /* After any fault, zero any leading predicated false elts.  */
     swap_memzero(vd, reg_off);
@@ -4649,7 +4653,8 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const int esz, const int msz,
                         sve_ld1_host_fn *host_fn)
 {
-    void *vd = &env->vfp.zregs[simd_data(desc)];
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    void *vd = &env->vfp.zregs[rd];
     const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
     const intptr_t mem_max = reg_max >> diffsz;
@@ -4781,15 +4786,14 @@ DO_LDFF1_LDNF1_2(dd,  3, 3)
 #ifdef CONFIG_SOFTMMU
 #define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra) \
 {                                                                           \
-    TCGMemOpIdx oi = make_memop_idx(ctz32(sizeof(TYPEM)) | MOEND, mmu_idx); \
     TLB(env, addr, *(TYPEM *)(vd + H(reg_off)), oi, ra);                    \
 }
 #else
 #define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
+                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra) \
 {                                                                           \
     HOST(g2h(addr), *(TYPEM *)(vd + H(reg_off)));                           \
 }
@@ -4828,9 +4832,9 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
                       const int esize, const int msize,
                       sve_st1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     void *vd = &env->vfp.zregs[rd];
 
     set_helper_retaddr(ra);
@@ -4838,7 +4842,7 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, vd, i, addr, mmu_idx, ra);
+                tlb_fn(env, vd, i, addr, oi, ra);
             }
             i += esize, pg >>= esize;
             addr += msize;
@@ -4852,9 +4856,9 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
                       const int esize, const int msize,
                       sve_st1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     void *d1 = &env->vfp.zregs[rd];
     void *d2 = &env->vfp.zregs[(rd + 1) & 31];
 
@@ -4863,8 +4867,8 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, mmu_idx, ra);
-                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
+                tlb_fn(env, d1, i, addr, oi, ra);
+                tlb_fn(env, d2, i, addr + msize, oi, ra);
             }
             i += esize, pg >>= esize;
             addr += 2 * msize;
@@ -4878,9 +4882,9 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
                       const int esize, const int msize,
                       sve_st1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     void *d1 = &env->vfp.zregs[rd];
     void *d2 = &env->vfp.zregs[(rd + 1) & 31];
     void *d3 = &env->vfp.zregs[(rd + 2) & 31];
@@ -4890,9 +4894,9 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, mmu_idx, ra);
-                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, mmu_idx, ra);
+                tlb_fn(env, d1, i, addr, oi, ra);
+                tlb_fn(env, d2, i, addr + msize, oi, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, oi, ra);
             }
             i += esize, pg >>= esize;
             addr += 3 * msize;
@@ -4906,9 +4910,9 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
                       const int esize, const int msize,
                       sve_st1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned rd = simd_data(desc);
     void *d1 = &env->vfp.zregs[rd];
     void *d2 = &env->vfp.zregs[(rd + 1) & 31];
     void *d3 = &env->vfp.zregs[(rd + 2) & 31];
@@ -4919,10 +4923,10 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, mmu_idx, ra);
-                tlb_fn(env, d2, i, addr + msize, mmu_idx, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, mmu_idx, ra);
-                tlb_fn(env, d4, i, addr + 3 * msize, mmu_idx, ra);
+                tlb_fn(env, d1, i, addr, oi, ra);
+                tlb_fn(env, d2, i, addr + msize, oi, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, oi, ra);
+                tlb_fn(env, d4, i, addr + 3 * msize, oi, ra);
             }
             i += esize, pg >>= esize;
             addr += 4 * msize;
@@ -5015,9 +5019,9 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
                        zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned scale = simd_data(desc);
     ARMVectorReg scratch = { };
 
     set_helper_retaddr(ra);
@@ -5026,7 +5030,7 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         do {
             if (pg & 1) {
                 target_ulong off = off_fn(vm, i);
-                tlb_fn(env, &scratch, i, base + (off << scale), mmu_idx, ra);
+                tlb_fn(env, &scratch, i, base + (off << scale), oi, ra);
             }
             i += 4, pg >>= 4;
         } while (i & 15);
@@ -5041,9 +5045,9 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
                        zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    unsigned scale = simd_data(desc);
     ARMVectorReg scratch = { };
 
     set_helper_retaddr(ra);
@@ -5051,7 +5055,7 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (pg & 1) {
             target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, &scratch, i * 8, base + (off << scale), mmu_idx, ra);
+            tlb_fn(env, &scratch, i * 8, base + (off << scale), oi, ra);
         }
     }
     set_helper_retaddr(0);
@@ -5157,7 +5161,7 @@ typedef bool sve_ld1_nf_fn(CPUARMState *env, void *vd, intptr_t reg_off,
 #ifdef CONFIG_SOFTMMU
 #define DO_LD_NF(NAME, H, TYPEE, TYPEM, HOST) \
 static bool sve_ld##NAME##_nf(CPUARMState *env, void *vd, intptr_t reg_off, \
-                            target_ulong addr, int mmu_idx)                 \
+                              target_ulong addr, int mmu_idx)               \
 {                                                                           \
     target_ulong next_page = -(addr | TARGET_PAGE_MASK);                    \
     if (likely(next_page - addr >= sizeof(TYPEM))) {                        \
@@ -5216,9 +5220,10 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                                 zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
                                 sve_ld1_nf_fn *nonfault_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int mmu_idx = get_mmuidx(oi);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t reg_off, reg_max = simd_oprsz(desc);
-    unsigned scale = simd_data(desc);
     target_ulong addr;
 
     /* Skip to the first true predicate.  */
@@ -5228,7 +5233,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, mmu_idx, ra);
+        tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
         set_helper_retaddr(0);
@@ -5257,9 +5262,10 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                                 zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
                                 sve_ld1_nf_fn *nonfault_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int mmu_idx = get_mmuidx(oi);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t reg_off, reg_max = simd_oprsz(desc);
-    unsigned scale = simd_data(desc);
     target_ulong addr;
 
     /* Skip to the first true predicate.  */
@@ -5269,7 +5275,7 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, mmu_idx, ra);
+        tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
         set_helper_retaddr(0);
@@ -5381,9 +5387,9 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
                        zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc);
-    unsigned scale = simd_data(desc);
 
     set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
@@ -5391,7 +5397,7 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         do {
             if (pg & 1) {
                 target_ulong off = off_fn(vm, i);
-                tlb_fn(env, vd, i, base + (off << scale), mmu_idx, ra);
+                tlb_fn(env, vd, i, base + (off << scale), oi, ra);
             }
             i += 4, pg >>= 4;
         } while (i & 15);
@@ -5403,16 +5409,16 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
                        zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
+    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    unsigned scale = simd_data(desc);
 
     set_helper_retaddr(ra);
     for (i = 0; i < oprsz; i++) {
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (pg & 1) {
             target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, vd, i * 8, base + (off << scale), mmu_idx, ra);
+            tlb_fn(env, vd, i * 8, base + (off << scale), oi, ra);
         }
     }
     set_helper_retaddr(0);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 20492e9b8b..05ba0518c8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4600,25 +4600,34 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
+static TCGMemOpIdx sve_memopidx(DisasContext *s, int dtype)
+{
+    return make_memop_idx(s->be_data | dtype_mop[dtype], get_mem_index(s));
+}
+
 static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-                       gen_helper_gvec_mem *fn)
+                       int dtype, gen_helper_gvec_mem *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
-    TCGv_i32 desc;
+    TCGv_i32 t_desc;
+    int desc;
 
     /* For e.g. LD4, there are not enough arguments to pass all 4
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = tcg_const_i32(simd_desc(vsz, vsz, zt));
+    desc = sve_memopidx(s, dtype);
+    desc |= zt << MEMOPIDX_SHIFT;
+    desc = simd_desc(vsz, vsz, desc);
+    t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
-    fn(cpu_env, t_pg, addr, desc);
+    fn(cpu_env, t_pg, addr, t_desc);
 
     tcg_temp_free_ptr(t_pg);
-    tcg_temp_free_i32(desc);
+    tcg_temp_free_i32(t_desc);
 }
 
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
@@ -4681,7 +4690,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
@@ -4763,7 +4772,8 @@ static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype,
+                   fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
@@ -4821,7 +4831,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype,
+                   fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
@@ -4836,11 +4847,14 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     };
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
-    TCGv_i32 desc;
-    int poff;
+    TCGv_i32 t_desc;
+    int desc, poff;
 
     /* Load the first quadword using the normal predicated load helpers.  */
-    desc = tcg_const_i32(simd_desc(16, 16, zt));
+    desc = sve_memopidx(s, msz_dtype(msz));
+    desc |= zt << MEMOPIDX_SHIFT;
+    desc = simd_desc(16, 16, desc);
+    t_desc = tcg_const_i32(desc);
 
     poff = pred_full_reg_offset(s, pg);
     if (vsz > 16) {
@@ -4864,10 +4878,10 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_pg, cpu_env, poff);
 
-    fns[s->be_data == MO_BE][msz](cpu_env, t_pg, addr, desc);
+    fns[s->be_data == MO_BE][msz](cpu_env, t_pg, addr, t_desc);
 
     tcg_temp_free_ptr(t_pg);
-    tcg_temp_free_i32(desc);
+    tcg_temp_free_i32(t_desc);
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -5019,7 +5033,7 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         fn = fn_multiple[be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(msz), fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
@@ -5057,24 +5071,31 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a, uint32_t insn)
  *** SVE gather loads / scatter stores
  */
 
-static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm, int scale,
-                       TCGv_i64 scalar, gen_helper_gvec_mem_scatter *fn)
+static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
+                       int scale, TCGv_i64 scalar, int msz,
+                       gen_helper_gvec_mem_scatter *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
-    TCGv_i32 desc = tcg_const_i32(simd_desc(vsz, vsz, scale));
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
+    TCGv_i32 t_desc;
+    int desc;
+
+    desc = sve_memopidx(s, msz_dtype(msz));
+    desc |= scale << MEMOPIDX_SHIFT;
+    desc = simd_desc(vsz, vsz, desc);
+    t_desc = tcg_const_i32(desc);
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, cpu_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, cpu_env, vec_full_reg_offset(s, zt));
-    fn(cpu_env, t_zt, t_pg, t_zm, scalar, desc);
+    fn(cpu_env, t_zt, t_pg, t_zm, scalar, t_desc);
 
     tcg_temp_free_ptr(t_zt);
     tcg_temp_free_ptr(t_zm);
     tcg_temp_free_ptr(t_pg);
-    tcg_temp_free_i32(desc);
+    tcg_temp_free_i32(t_desc);
 }
 
 /* Indexed by [be][ff][xs][u][msz].  */
@@ -5263,7 +5284,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
     assert(fn != NULL);
 
     do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
-               cpu_reg_sp(s, a->rn), fn);
+               cpu_reg_sp(s, a->rn), a->msz, fn);
     return true;
 }
 
@@ -5294,7 +5315,7 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
      * by loading the immediate into the scalar parameter.
      */
     imm = tcg_const_i64(a->imm << a->msz);
-    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, fn);
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, fn);
     tcg_temp_free_i64(imm);
     return true;
 }
@@ -5369,7 +5390,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
         g_assert_not_reached();
     }
     do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
-               cpu_reg_sp(s, a->rn), fn);
+               cpu_reg_sp(s, a->rn), a->msz, fn);
     return true;
 }
 
@@ -5400,7 +5421,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
      * by loading the immediate into the scalar parameter.
      */
     imm = tcg_const_i64(a->imm << a->msz);
-    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, fn);
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, fn);
     tcg_temp_free_i64(imm);
     return true;
 }
-- 
2.17.1
