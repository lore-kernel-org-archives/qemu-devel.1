Received: from eggs.gnu.org ([2001:4830:134:3::10]:44491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqb-0008Ag-MZ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqX-0001PL-SE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:06 +1100
Message-Id: <20170303032507.16142-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/17] spapr: Small cleanup of PPC MMU enums
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

The PPC MMU types are sometimes treated as if they were a bit field
and sometime as if they were an enum which causes maintenance
problems: flipping bits in the MMU type (which is done on both the 1TB
segment and 64K segment bits) currently produces new MMU type
values that are not handled in every "switch" on it, sometimes causing
an abort().

This patch provides some macros that can be used to filter out the
"bit field-like" bits so that the remainder of the value can be
switched on, like an enum. This allows removal of all of the
"degraded" types from the list and should ease maintenance.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 10 +++----
 target/ppc/cpu-qom.h    | 12 ++++-----
 target/ppc/kvm.c        |  8 +++---
 target/ppc/mmu-hash64.c | 12 ++++-----
 target/ppc/mmu_helper.c | 71 ++++++++++++++++++++-----------------------------
 target/ppc/translate.c  | 14 +++++-----
 6 files changed, 55 insertions(+), 72 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 81e2ada..14192ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -407,18 +407,16 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
     uint8_t *pa_features;
     size_t pa_size;
 
-    switch (env->mmu_model) {
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    case POWERPC_MMU_VER_2_06:
         pa_features = pa_features_206;
         pa_size = sizeof(pa_features_206);
         break;
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_VER_2_07:
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
         break;
-    case POWERPC_MMU_3_00:
+    case POWERPC_MMU_VER_3_00:
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
         break;
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index da7eb5a..81500e5 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -80,22 +80,22 @@ enum powerpc_mmu_t {
     POWERPC_MMU_2_06       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
                              | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | 0x00000003,
-    /* Architecture 2.06 "degraded" (no 1T segments)           */
-    POWERPC_MMU_2_06a      = POWERPC_MMU_64 | POWERPC_MMU_AMR
-                             | 0x00000003,
     /* Architecture 2.07 variant                               */
     POWERPC_MMU_2_07       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
                              | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | 0x00000004,
-    /* Architecture 2.07 "degraded" (no 1T segments)           */
-    POWERPC_MMU_2_07a      = POWERPC_MMU_64 | POWERPC_MMU_AMR
-                             | 0x00000004,
     /* Architecture 3.00 variant                               */
     POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
                              | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | POWERPC_MMU_V3
                              | 0x00000005,
 };
+#define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
+#define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
+#define POWERPC_MMU_VER_2_03 POWERPC_MMU_VER(POWERPC_MMU_2_03)
+#define POWERPC_MMU_VER_2_06 POWERPC_MMU_VER(POWERPC_MMU_2_06)
+#define POWERPC_MMU_VER_2_07 POWERPC_MMU_VER(POWERPC_MMU_2_07)
+#define POWERPC_MMU_VER_3_00 POWERPC_MMU_VER(POWERPC_MMU_3_00)
 
 /*****************************************************************************/
 /* Exception model                                                           */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9b51484..1adb55c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -283,8 +283,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
             info->flags |= KVM_PPC_1T_SEGMENTS;
         }
 
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
+        if (POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_06 ||
+           POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_07) {
             info->slb_size = 32;
         } else {
             info->slb_size = 64;
@@ -298,8 +298,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
         i++;
 
         /* 64K on MMU 2.06 and later */
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
+        if (POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_06 ||
+            POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_07) {
             info->sps[i].page_shift = 16;
             info->sps[i].slb_enc = 0x110;
             info->sps[i].enc[0].page_shift = 16;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d5a871f..14d34e5 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1032,8 +1032,8 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
     uint64_t lpcr = 0;
 
     /* Filter out bits */
-    switch (env->mmu_model) {
-    case POWERPC_MMU_64B: /* 970 */
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    case POWERPC_MMU_VER_64B: /* 970 */
         if (val & 0x40) {
             lpcr |= LPCR_LPES0;
         }
@@ -1059,26 +1059,26 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
          * to dig HRMOR out of HID5
          */
         break;
-    case POWERPC_MMU_2_03: /* P5p */
+    case POWERPC_MMU_VER_2_03: /* P5p */
         lpcr = val & (LPCR_RMLS | LPCR_ILE |
                       LPCR_LPES0 | LPCR_LPES1 |
                       LPCR_RMI | LPCR_HDICE);
         break;
-    case POWERPC_MMU_2_06: /* P7 */
+    case POWERPC_MMU_VER_2_06: /* P7 */
         lpcr = val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
                       LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
                       LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
                       LPCR_MER | LPCR_TC |
                       LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
         break;
-    case POWERPC_MMU_2_07: /* P8 */
+    case POWERPC_MMU_VER_2_07: /* P8 */
         lpcr = val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
                       LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
                       LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE1 |
                       LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
                       LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
         break;
-    case POWERPC_MMU_3_00: /* P9 */
+    case POWERPC_MMU_VER_3_00: /* P9 */
         lpcr = val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
                       (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
                       LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 18a76d2..65d1c86 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1266,7 +1266,7 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
 
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
 {
-    switch (env->mmu_model) {
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
     case POWERPC_MMU_BOOKE:
         mmubooke_dump_mmu(f, cpu_fprintf, env);
         break;
@@ -1278,15 +1278,13 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
         mmu6xx_dump_mmu(f, cpu_fprintf, env);
         break;
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_64B:
-    case POWERPC_MMU_2_03:
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_VER_64B:
+    case POWERPC_MMU_VER_2_03:
+    case POWERPC_MMU_VER_2_06:
+    case POWERPC_MMU_VER_2_07:
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
-    case POWERPC_MMU_3_00:
+    case POWERPC_MMU_VER_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
@@ -1425,16 +1423,14 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
 
-    switch (env->mmu_model) {
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_64B:
-    case POWERPC_MMU_2_03:
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_VER_64B:
+    case POWERPC_MMU_VER_2_03:
+    case POWERPC_MMU_VER_2_06:
+    case POWERPC_MMU_VER_2_07:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
-    case POWERPC_MMU_3_00:
+    case POWERPC_MMU_VER_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
@@ -1924,6 +1920,12 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
 
+#if defined(TARGET_PPC64)
+    if (env->mmu_model & POWERPC_MMU_64) {
+        env->tlb_need_flush = 0;
+        tlb_flush(CPU(cpu));
+    } else
+#endif /* defined(TARGET_PPC64) */
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
@@ -1948,21 +1950,12 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
         break;
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
-#if defined(TARGET_PPC64)
-    case POWERPC_MMU_64B:
-    case POWERPC_MMU_2_03:
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
-    case POWERPC_MMU_3_00:
-#endif /* defined(TARGET_PPC64) */
         env->tlb_need_flush = 0;
         tlb_flush(CPU(cpu));
         break;
     default:
         /* XXX: TODO */
-        cpu_abort(CPU(cpu), "Unknown MMU model %d\n", env->mmu_model);
+        cpu_abort(CPU(cpu), "Unknown MMU model %x\n", env->mmu_model);
         break;
     }
 }
@@ -1971,6 +1964,16 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(FLUSH_ALL_TLBS)
     addr &= TARGET_PAGE_MASK;
+#if defined(TARGET_PPC64)
+    if (env->mmu_model & POWERPC_MMU_64) {
+        /* tlbie invalidate TLBs for all segments */
+        /* XXX: given the fact that there are too many segments to invalidate,
+         *      and we still don't have a tlb_flush_mask(env, n, mask) in QEMU,
+         *      we just invalidate all TLBs
+         */
+        env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+    } else
+#endif /* defined(TARGET_PPC64) */
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
@@ -1988,22 +1991,6 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
          */
         env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
         break;
-#if defined(TARGET_PPC64)
-    case POWERPC_MMU_64B:
-    case POWERPC_MMU_2_03:
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
-    case POWERPC_MMU_3_00:
-        /* tlbie invalidate TLBs for all segments */
-        /* XXX: given the fact that there are too many segments to invalidate,
-         *      and we still don't have a tlb_flush_mask(env, n, mask) in QEMU,
-         *      we just invalidate all TLBs
-         */
-        env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
-        break;
-#endif /* defined(TARGET_PPC64) */
     default:
         /* Should never reach here with other MMU models */
         assert(0);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1de554a..b6abc60 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7078,19 +7078,17 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     if (env->spr_cb[SPR_LPCR].name)
         cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
 
-    switch (env->mmu_model) {
+    switch (POWERPC_MMU_VER(env->mmu_model)) {
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_64B:
-    case POWERPC_MMU_2_03:
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
-    case POWERPC_MMU_3_00:
+    case POWERPC_MMU_VER_64B:
+    case POWERPC_MMU_VER_2_03:
+    case POWERPC_MMU_VER_2_06:
+    case POWERPC_MMU_VER_2_07:
+    case POWERPC_MMU_VER_3_00:
 #endif
         if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
             cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
-- 
2.9.3
