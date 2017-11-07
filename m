Received: from eggs.gnu.org ([2001:4830:134:3::10]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41l-0006Vp-9U
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41j-0005uj-Ga
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41j-0005rx-4q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41g-0004ST-Uj
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:16 +0000
Message-Id: <1510061722-14092-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/7] arm: implement cache/shareability attribute
 bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Baumann <Andrew.Baumann@microsoft.com>

On a successful address translation instruction, PAR is supposed to
contain cacheability and shareability attributes determined by the
translation. We previously returned 0 for these bits (in line with the
general strategy of ignoring caches and memory attributes), but some
guest OSes may depend on them.

This patch collects the attribute bits in the page-table walk, and
updates PAR with the correct attributes for all LPAE translations.
Short descriptor formats still return 0 for these bits, as in the
prior implementation.

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Message-id: 20171031223830.4608-1-Andrew.Baumann@microsoft.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 164 insertions(+), 14 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96113fe..f61fb3e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,17 +19,23 @@
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 #ifndef CONFIG_USER_ONLY
+/* Cacheability and shareability attributes for a memory access */
+typedef struct ARMCacheAttrs {
+    unsigned int attrs:8; /* as in the MAIR register encoding */
+    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
+} ARMCacheAttrs;
+
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                           target_ulong *page_size, uint32_t *fsr,
-                          ARMMMUFaultInfo *fi);
+                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr, uint32_t *fsr,
-                               ARMMMUFaultInfo *fi);
+                               ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
 typedef struct V8M_SAttributes {
@@ -2159,9 +2165,10 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     uint64_t par64;
     MemTxAttrs attrs = {};
     ARMMMUFaultInfo fi = {};
+    ARMCacheAttrs cacheattrs = {};
 
-    ret = get_phys_addr(env, value, access_type, mmu_idx,
-                        &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
+    ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
+                        &prot, &page_size, &fsr, &fi, &cacheattrs);
     if (extended_addresses_enabled(env)) {
         /* fsr is a DFSR/IFSR value for the long descriptor
          * translation table format, but with WnR always clear.
@@ -2173,7 +2180,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
             if (!attrs.secure) {
                 par64 |= (1 << 9); /* NS */
             }
-            /* We don't set the ATTR or SH fields in the PAR. */
+            par64 |= (uint64_t)cacheattrs.attrs << 56; /* ATTR */
+            par64 |= cacheattrs.shareability << 7; /* SH */
         } else {
             par64 |= 1; /* F */
             par64 |= (fsr & 0x3f) << 1; /* FS */
@@ -6925,7 +6933,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
         return false;
     }
     if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx,
-                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi)) {
+                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi, NULL)) {
         /* the MPU lookup failed */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
@@ -8207,7 +8215,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         int ret;
 
         ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
-                                 &txattrs, &s2prot, &s2size, fsr, fi);
+                                 &txattrs, &s2prot, &s2size, fsr, fi, NULL);
         if (ret) {
             fi->s2addr = addr;
             fi->stage2 = true;
@@ -8608,11 +8616,41 @@ static bool check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, int level,
     return true;
 }
 
+/* Translate from the 4-bit stage 2 representation of
+ * memory attributes (without cache-allocation hints) to
+ * the 8-bit representation of the stage 1 MAIR registers
+ * (which includes allocation hints).
+ *
+ * ref: shared/translation/attrs/S2AttrDecode()
+ *      .../S2ConvertAttrsHints()
+ */
+static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
+{
+    uint8_t hiattr = extract32(s2attrs, 2, 2);
+    uint8_t loattr = extract32(s2attrs, 0, 2);
+    uint8_t hihint = 0, lohint = 0;
+
+    if (hiattr != 0) { /* normal memory */
+        if ((env->cp15.hcr_el2 & HCR_CD) != 0) { /* cache disabled */
+            hiattr = loattr = 1; /* non-cacheable */
+        } else {
+            if (hiattr != 1) { /* Write-through or write-back */
+                hihint = 3; /* RW allocate */
+            }
+            if (loattr != 1) { /* Write-through or write-back */
+                lohint = 3; /* RW allocate */
+            }
+        }
+    }
+
+    return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
+}
+
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr, uint32_t *fsr,
-                               ARMMMUFaultInfo *fi)
+                               ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
@@ -8929,6 +8967,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
          */
         txattrs->secure = false;
     }
+
+    if (cacheattrs != NULL) {
+        if (mmu_idx == ARMMMUIdx_S2NS) {
+            cacheattrs->attrs = convert_stage2_attrs(env,
+                                                     extract32(attrs, 0, 4));
+        } else {
+            /* Index into MAIR registers for cache attributes */
+            uint8_t attrindx = extract32(attrs, 0, 3);
+            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+            assert(attrindx <= 7);
+            cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
+        }
+        cacheattrs->shareability = extract32(attrs, 6, 2);
+    }
+
     *phys_ptr = descaddr;
     *page_size_ptr = page_size;
     return false;
@@ -9490,6 +9543,93 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
     return false;
 }
 
+/* Combine either inner or outer cacheability attributes for normal
+ * memory, according to table D4-42 and pseudocode procedure
+ * CombineS1S2AttrHints() of ARM DDI 0487B.b (the ARMv8 ARM).
+ *
+ * NB: only stage 1 includes allocation hints (RW bits), leading to
+ * some asymmetry.
+ */
+static uint8_t combine_cacheattr_nibble(uint8_t s1, uint8_t s2)
+{
+    if (s1 == 4 || s2 == 4) {
+        /* non-cacheable has precedence */
+        return 4;
+    } else if (extract32(s1, 2, 2) == 0 || extract32(s1, 2, 2) == 2) {
+        /* stage 1 write-through takes precedence */
+        return s1;
+    } else if (extract32(s2, 2, 2) == 2) {
+        /* stage 2 write-through takes precedence, but the allocation hint
+         * is still taken from stage 1
+         */
+        return (2 << 2) | extract32(s1, 0, 2);
+    } else { /* write-back */
+        return s1;
+    }
+}
+
+/* Combine S1 and S2 cacheability/shareability attributes, per D4.5.4
+ * and CombineS1S2Desc()
+ *
+ * @s1:      Attributes from stage 1 walk
+ * @s2:      Attributes from stage 2 walk
+ */
+static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
+{
+    uint8_t s1lo = extract32(s1.attrs, 0, 4), s2lo = extract32(s2.attrs, 0, 4);
+    uint8_t s1hi = extract32(s1.attrs, 4, 4), s2hi = extract32(s2.attrs, 4, 4);
+    ARMCacheAttrs ret;
+
+    /* Combine shareability attributes (table D4-43) */
+    if (s1.shareability == 2 || s2.shareability == 2) {
+        /* if either are outer-shareable, the result is outer-shareable */
+        ret.shareability = 2;
+    } else if (s1.shareability == 3 || s2.shareability == 3) {
+        /* if either are inner-shareable, the result is inner-shareable */
+        ret.shareability = 3;
+    } else {
+        /* both non-shareable */
+        ret.shareability = 0;
+    }
+
+    /* Combine memory type and cacheability attributes */
+    if (s1hi == 0 || s2hi == 0) {
+        /* Device has precedence over normal */
+        if (s1lo == 0 || s2lo == 0) {
+            /* nGnRnE has precedence over anything */
+            ret.attrs = 0;
+        } else if (s1lo == 4 || s2lo == 4) {
+            /* non-Reordering has precedence over Reordering */
+            ret.attrs = 4;  /* nGnRE */
+        } else if (s1lo == 8 || s2lo == 8) {
+            /* non-Gathering has precedence over Gathering */
+            ret.attrs = 8;  /* nGRE */
+        } else {
+            ret.attrs = 0xc; /* GRE */
+        }
+
+        /* Any location for which the resultant memory type is any
+         * type of Device memory is always treated as Outer Shareable.
+         */
+        ret.shareability = 2;
+    } else { /* Normal memory */
+        /* Outer/inner cacheability combine independently */
+        ret.attrs = combine_cacheattr_nibble(s1hi, s2hi) << 4
+                  | combine_cacheattr_nibble(s1lo, s2lo);
+
+        if (ret.attrs == 0x44) {
+            /* Any location for which the resultant memory type is Normal
+             * Inner Non-cacheable, Outer Non-cacheable is always treated
+             * as Outer Shareable.
+             */
+            ret.shareability = 2;
+        }
+    }
+
+    return ret;
+}
+
+
 /* get_phys_addr - get the physical address for this virtual address
  *
  * Find the physical address corresponding to the given virtual address,
@@ -9514,12 +9654,14 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
  * @prot: set to the permissions for the page containing phys_ptr
  * @page_size: set to the size of the page containing phys_ptr
  * @fsr: set to the DFSR/IFSR value on failure
+ * @fi: set to fault info if the translation fails
+ * @cacheattrs: (if non-NULL) set to the cacheability/shareability attributes
  */
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                           target_ulong *page_size, uint32_t *fsr,
-                          ARMMMUFaultInfo *fi)
+                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
@@ -9529,10 +9671,11 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             hwaddr ipa;
             int s2_prot;
             int ret;
+            ARMCacheAttrs cacheattrs2 = {};
 
             ret = get_phys_addr(env, address, access_type,
                                 stage_1_mmu_idx(mmu_idx), &ipa, attrs,
-                                prot, page_size, fsr, fi);
+                                prot, page_size, fsr, fi, cacheattrs);
 
             /* If S1 fails or S2 is disabled, return early.  */
             if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
@@ -9543,10 +9686,17 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             /* S1 is done. Now do S2 translation.  */
             ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_S2NS,
                                      phys_ptr, attrs, &s2_prot,
-                                     page_size, fsr, fi);
+                                     page_size, fsr, fi,
+                                     cacheattrs != NULL ? &cacheattrs2 : NULL);
             fi->s2addr = ipa;
             /* Combine the S1 and S2 perms.  */
             *prot &= s2_prot;
+
+            /* Combine the S1 and S2 cache attributes, if needed */
+            if (!ret && cacheattrs != NULL) {
+                *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
+            }
+
             return ret;
         } else {
             /*
@@ -9617,7 +9767,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
 
     if (regime_using_lpae_format(env, mmu_idx)) {
         return get_phys_addr_lpae(env, address, access_type, mmu_idx, phys_ptr,
-                                  attrs, prot, page_size, fsr, fi);
+                                  attrs, prot, page_size, fsr, fi, cacheattrs);
     } else if (regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, address, access_type, mmu_idx, phys_ptr,
                                 attrs, prot, page_size, fsr, fi);
@@ -9645,7 +9795,7 @@ bool arm_tlb_fill(CPUState *cs, vaddr address,
 
     ret = get_phys_addr(env, address, access_type,
                         core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
-                        &attrs, &prot, &page_size, fsr, fi);
+                        &attrs, &prot, &page_size, fsr, fi, NULL);
     if (!ret) {
         /* Map a single [sub]page.  */
         phys_addr &= TARGET_PAGE_MASK;
@@ -9674,7 +9824,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     *attrs = (MemTxAttrs) {};
 
     ret = get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
-                        attrs, &prot, &page_size, &fsr, &fi);
+                        attrs, &prot, &page_size, &fsr, &fi, NULL);
 
     if (ret) {
         return -1;
-- 
2.7.4
