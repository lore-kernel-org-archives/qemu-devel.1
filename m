Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDY-0006Po-9Y
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDV-0002WX-TZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:12 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cbsDV-0002W2-Jl
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:09 -0500
Received: by mail-wr0-x236.google.com with SMTP id i10so88258848wrb.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 09:09:09 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Feb 2017 17:08:56 +0000
Message-Id: <20170209170904.5713-17-alex.bennee@linaro.org>
In-Reply-To: <20170209170904.5713-1-alex.bennee@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 16/24] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

While the vargs approach was flexible the original MTTCG ended up
having munge the bits to a bitmap so the data could be used in
deferred work helpers. Instead of hiding that in cputlb we push the
change to the API to make it take a bitmap of MMU indexes instead.

For ARM some the resulting flushes end up being quite long so to aid
readability I've tended to move the index shifting to a new line so
all the bits being or-ed together line up nicely, for example:

    tlb_flush_page_by_mmuidx(other_cs, pageaddr,
                             (1 << ARMMMUIdx_S1SE1) |
                             (1 << ARMMMUIdx_S1SE0));

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[AT: SPARC parts only]
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
[PM: ARM parts only]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v9
  - use (1 << ARMMMUIdx_foo) form to reduce churn in ARM
  - checkpatch fixes (mostly > 80 chars)
  - add r-b tag
v10
  - add r-b tag
---
 cputlb.c                   |  60 +++++++++--------------
 include/exec/exec-all.h    |  13 ++---
 target/arm/helper.c        | 116 ++++++++++++++++++++++++++++-----------------
 target/sparc/ldst_helper.c |   8 ++--
 4 files changed, 107 insertions(+), 90 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 5dfd3c3ba9..97e5c12de8 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -122,26 +122,25 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
-static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
+static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
+    unsigned long mmu_idx_bitmask = idxmap;
+    int mmu_idx;
 
     assert_cpu_is_self(cpu);
     tlb_debug("start\n");
 
     tb_lock();
 
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
-
-        if (mmu_idx < 0) {
-            break;
-        }
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
-        tlb_debug("%d\n", mmu_idx);
+        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
+            tlb_debug("%d\n", mmu_idx);
 
-        memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
-        memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+        }
     }
 
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
@@ -149,12 +148,9 @@ static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
     tb_unlock();
 }
 
-void tlb_flush_by_mmuidx(CPUState *cpu, ...)
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
-    va_list argp;
-    va_start(argp, cpu);
-    v_tlb_flush_by_mmuidx(cpu, argp);
-    va_end(argp);
+    v_tlb_flush_by_mmuidx(cpu, idxmap);
 }
 
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
@@ -219,13 +215,11 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     }
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
-    int i, k;
-    va_list argp;
-
-    va_start(argp, addr);
+    unsigned long mmu_idx_bitmap = idxmap;
+    int i, page, mmu_idx;
 
     assert_cpu_is_self(cpu);
     tlb_debug("addr "TARGET_FMT_lx"\n", addr);
@@ -236,31 +230,23 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   env->tlb_flush_addr, env->tlb_flush_mask);
 
-        v_tlb_flush_by_mmuidx(cpu, argp);
-        va_end(argp);
+        v_tlb_flush_by_mmuidx(cpu, idxmap);
         return;
     }
 
     addr &= TARGET_PAGE_MASK;
-    i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
+    page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
 
-        if (mmu_idx < 0) {
-            break;
-        }
-
-        tlb_debug("idx %d\n", mmu_idx);
-
-        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
+            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
 
-        /* check whether there are vltb entries that need to be flushed */
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], addr);
+            /* check whether there are vltb entries that need to be flushed */
+            for (i = 0; i < CPU_VTLB_SIZE; i++) {
+                tlb_flush_entry(&env->tlb_v_table[mmu_idx][i], addr);
+            }
         }
     }
-    va_end(argp);
 
     tb_flush_jmp_cache(cpu, addr);
 }
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e43cb68355..a6c17ed74a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -106,21 +106,22 @@ void tlb_flush(CPUState *cpu);
  * tlb_flush_page_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
  * @addr: virtual address of page to be flushed
- * @...: list of MMU indexes to flush, terminated by a negative value
+ * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush one page from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...);
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
+                              uint16_t idxmap);
 /**
  * tlb_flush_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
- * @...: list of MMU indexes to flush, terminated by a negative value
+ * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush all entries from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_by_mmuidx(CPUState *cpu, ...);
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
@@ -169,11 +170,11 @@ static inline void tlb_flush(CPUState *cpu)
 }
 
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            target_ulong addr, ...)
+                                            target_ulong addr, uint16_t idxmap)
 {
 }
 
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, ...)
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 414191efb0..599eca872a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -578,8 +578,10 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = ENV_GET_CPU(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                        ARMMMUIdx_S2NS, -1);
+    tlb_flush_by_mmuidx(cs,
+                        (1 << ARMMMUIdx_S12NSE1) |
+                        (1 << ARMMMUIdx_S12NSE0) |
+                        (1 << ARMMMUIdx_S2NS));
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -588,8 +590,10 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                            ARMMMUIdx_S12NSE0, ARMMMUIdx_S2NS, -1);
+        tlb_flush_by_mmuidx(other_cs,
+                            (1 << ARMMMUIdx_S12NSE1) |
+                            (1 << ARMMMUIdx_S12NSE0) |
+                            (1 << ARMMMUIdx_S2NS));
     }
 }
 
@@ -611,7 +615,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S2NS, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S2NS));
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -627,7 +631,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 40);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S2NS, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S2NS));
     }
 }
 
@@ -636,7 +640,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = ENV_GET_CPU(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E2, -1);
+    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E2));
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -645,7 +649,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E2, -1);
+        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E2));
     }
 }
 
@@ -655,7 +659,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E2, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E2));
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -665,7 +669,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E2, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E2));
     }
 }
 
@@ -2499,8 +2503,10 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
     if (raw_read(env, ri) != value) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                            ARMMMUIdx_S2NS, -1);
+        tlb_flush_by_mmuidx(cs,
+                            (1 << ARMMMUIdx_S12NSE1) |
+                            (1 << ARMMMUIdx_S12NSE0) |
+                            (1 << ARMMMUIdx_S2NS));
         raw_write(env, ri, value);
     }
 }
@@ -2859,9 +2865,13 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+        tlb_flush_by_mmuidx(cs,
+                            (1 << ARMMMUIdx_S1SE1) |
+                            (1 << ARMMMUIdx_S1SE0));
     } else {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0, -1);
+        tlb_flush_by_mmuidx(cs,
+                            (1 << ARMMMUIdx_S12NSE1) |
+                            (1 << ARMMMUIdx_S12NSE0));
     }
 }
 
@@ -2873,10 +2883,13 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+            tlb_flush_by_mmuidx(other_cs,
+                                (1 << ARMMMUIdx_S1SE1) |
+                                (1 << ARMMMUIdx_S1SE0));
         } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(other_cs,
+                                (1 << ARMMMUIdx_S12NSE1) |
+                                (1 << ARMMMUIdx_S12NSE0));
         }
     }
 }
@@ -2892,13 +2905,19 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+        tlb_flush_by_mmuidx(cs,
+                            (1 << ARMMMUIdx_S1SE1) |
+                            (1 << ARMMMUIdx_S1SE0));
     } else {
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                                ARMMMUIdx_S2NS, -1);
+            tlb_flush_by_mmuidx(cs,
+                                (1 << ARMMMUIdx_S12NSE1) |
+                                (1 << ARMMMUIdx_S12NSE0) |
+                                (1 << ARMMMUIdx_S2NS));
         } else {
-            tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(cs,
+                                (1 << ARMMMUIdx_S12NSE1) |
+                                (1 << ARMMMUIdx_S12NSE0));
         }
     }
 }
@@ -2909,7 +2928,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E2, -1);
+    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E2));
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2918,7 +2937,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E3, -1);
+    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E3));
 }
 
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2934,13 +2953,18 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+            tlb_flush_by_mmuidx(other_cs,
+                                (1 << ARMMMUIdx_S1SE1) |
+                                (1 << ARMMMUIdx_S1SE0));
         } else if (has_el2) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, ARMMMUIdx_S2NS, -1);
+            tlb_flush_by_mmuidx(other_cs,
+                                (1 << ARMMMUIdx_S12NSE1) |
+                                (1 << ARMMMUIdx_S12NSE0) |
+                                (1 << ARMMMUIdx_S2NS));
         } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(other_cs,
+                                (1 << ARMMMUIdx_S12NSE1) |
+                                (1 << ARMMMUIdx_S12NSE0));
         }
     }
 }
@@ -2951,7 +2975,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E2, -1);
+        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E2));
     }
 }
 
@@ -2961,7 +2985,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E3, -1);
+        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E3));
     }
 }
 
@@ -2978,11 +3002,13 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1SE1,
-                                 ARMMMUIdx_S1SE0, -1);
+        tlb_flush_page_by_mmuidx(cs, pageaddr,
+                                 (1 << ARMMMUIdx_S1SE1) |
+                                 (1 << ARMMMUIdx_S1SE0));
     } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S12NSE1,
-                                 ARMMMUIdx_S12NSE0, -1);
+        tlb_flush_page_by_mmuidx(cs, pageaddr,
+                                 (1 << ARMMMUIdx_S12NSE1) |
+                                 (1 << ARMMMUIdx_S12NSE0));
     }
 }
 
@@ -2997,7 +3023,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E2, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E2));
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3011,7 +3037,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E3, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E3));
 }
 
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3023,11 +3049,13 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1SE1,
-                                     ARMMMUIdx_S1SE0, -1);
+            tlb_flush_page_by_mmuidx(other_cs, pageaddr,
+                                     (1 << ARMMMUIdx_S1SE1) |
+                                     (1 << ARMMMUIdx_S1SE0));
         } else {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S12NSE1,
-                                     ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_page_by_mmuidx(other_cs, pageaddr,
+                                     (1 << ARMMMUIdx_S12NSE1) |
+                                     (1 << ARMMMUIdx_S12NSE0));
         }
     }
 }
@@ -3039,7 +3067,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E2, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E2));
     }
 }
 
@@ -3050,7 +3078,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E3, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E3));
     }
 }
 
@@ -3073,7 +3101,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S2NS, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S2NS));
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3089,7 +3117,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 48);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S2NS, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S2NS));
     }
 }
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c05d6af75..57968d9143 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1768,13 +1768,15 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
           case 1:
               env->dmmu.mmu_primary_context = val;
               env->immu.mmu_primary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_IDX, MMU_KERNEL_IDX, -1);
+              tlb_flush_by_mmuidx(CPU(cpu),
+                                  (1 << MMU_USER_IDX) | (1 << MMU_KERNEL_IDX));
               break;
           case 2:
               env->dmmu.mmu_secondary_context = val;
               env->immu.mmu_secondary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_SECONDARY_IDX,
-                                  MMU_KERNEL_SECONDARY_IDX, -1);
+              tlb_flush_by_mmuidx(CPU(cpu),
+                                  (1 << MMU_USER_SECONDARY_IDX) |
+                                  (1 << MMU_KERNEL_SECONDARY_IDX));
               break;
           default:
               cpu_unassigned_access(cs, addr, true, false, 1, size);
-- 
2.11.0
