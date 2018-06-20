Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcom-0003Mw-76
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcok-000530-G4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:06:19 +0100
Message-Id: <20180620130619.11362-4-peter.maydell@linaro.org>
In-Reply-To: <20180620130619.11362-1-peter.maydell@linaro.org>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] target/arm: Handle small regions in
 get_phys_addr_pmsav8()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Allow ARMv8M to handle small MPU and SAU region sizes, by making
get_phys_add_pmsav8() set the page size to the 1 if the MPU or
SAU region covers less than a TARGET_PAGE_SIZE.

We choose to use a size of 1 because it makes no difference to
the core code, and avoids having to track both the base and
limit for SAU and MPU and then convert into an artificially
restricted "page size" that the core code will then ignore.

Since the core TCG code can't handle execution from small
MPU regions, we strip the exec permission from them so that
any execution attempts will cause an MPU exception, rather
than allowing it to end up with a cpu_abort() in
get_page_addr_code().

(The previous code's intention was to make any small page be
treated as having no permissions, but unfortunately errors
in the implementation meant that it didn't behave that way.
It's possible that some binaries using small regions were
accidentally working with our old behaviour and won't now.)

We also retain an existing bug, where we ignored the possibility
that the SAU region might not cover the entire page, in the
case of executable regions. This is necessary because some
currently-working guest code images rely on being able to
execute from addresses which are covered by a page-sized
MPU region but a smaller SAU region. We can remove this
workaround if we ever support execution from small regions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 78 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a7edeb66633..3c6a4c565b1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -41,6 +41,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
 typedef struct V8M_SAttributes {
+    bool subpage; /* true if these attrs don't cover the whole TARGET_PAGE */
     bool ns;
     bool nsc;
     uint8_t sregion;
@@ -9804,6 +9805,8 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
     int r;
     bool idau_exempt = false, idau_ns = true, idau_nsc = true;
     int idau_region = IREGION_NOTVALID;
+    uint32_t addr_page_base = address & TARGET_PAGE_MASK;
+    uint32_t addr_page_limit = addr_page_base + (TARGET_PAGE_SIZE - 1);
 
     if (cpu->idau) {
         IDAUInterfaceClass *iic = IDAU_INTERFACE_GET_CLASS(cpu->idau);
@@ -9841,6 +9844,9 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
                 uint32_t limit = env->sau.rlar[r] | 0x1f;
 
                 if (base <= address && limit >= address) {
+                    if (base > addr_page_base || limit < addr_page_limit) {
+                        sattrs->subpage = true;
+                    }
                     if (sattrs->srvalid) {
                         /* If we hit in more than one region then we must report
                          * as Secure, not NS-Callable, with no valid region
@@ -9880,13 +9886,16 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
 static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
                               hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                              int *prot, ARMMMUFaultInfo *fi, uint32_t *mregion)
+                              int *prot, bool *is_subpage,
+                              ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /* Perform a PMSAv8 MPU lookup (without also doing the SAU check
      * that a full phys-to-virt translation does).
      * mregion is (if not NULL) set to the region number which matched,
      * or -1 if no region number is returned (MPU off, address did not
      * hit a region, address hit in multiple regions).
+     * We set is_subpage to true if the region hit doesn't cover the
+     * entire TARGET_PAGE the address is within.
      */
     ARMCPU *cpu = arm_env_get_cpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
@@ -9894,7 +9903,10 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     int n;
     int matchregion = -1;
     bool hit = false;
+    uint32_t addr_page_base = address & TARGET_PAGE_MASK;
+    uint32_t addr_page_limit = addr_page_base + (TARGET_PAGE_SIZE - 1);
 
+    *is_subpage = false;
     *phys_ptr = address;
     *prot = 0;
     if (mregion) {
@@ -9932,6 +9944,10 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 continue;
             }
 
+            if (base > addr_page_base || limit < addr_page_limit) {
+                *is_subpage = true;
+            }
+
             if (hit) {
                 /* Multiple regions match -- always a failure (unlike
                  * PMSAv7 where highest-numbered-region wins)
@@ -9943,23 +9959,6 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
             matchregion = n;
             hit = true;
-
-            if (base & ~TARGET_PAGE_MASK) {
-                qemu_log_mask(LOG_UNIMP,
-                              "MPU_RBAR[%d]: No support for MPU region base"
-                              "address of 0x%" PRIx32 ". Minimum alignment is "
-                              "%d\n",
-                              n, base, TARGET_PAGE_BITS);
-                continue;
-            }
-            if ((limit + 1) & ~TARGET_PAGE_MASK) {
-                qemu_log_mask(LOG_UNIMP,
-                              "MPU_RBAR[%d]: No support for MPU region limit"
-                              "address of 0x%" PRIx32 ". Minimum alignment is "
-                              "%d\n",
-                              n, limit, TARGET_PAGE_BITS);
-                continue;
-            }
         }
     }
 
@@ -9995,6 +9994,18 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
+    /*
+     * Core QEMU code can't handle execution from small pages yet, so
+     * don't try it. This means any attempted execution will generate
+     * an MPU exception, rather than eventually causing QEMU to exit in
+     * get_page_addr_code().
+     */
+    if (*is_subpage && (*prot & PAGE_EXEC)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "MPU: No support for execution from regions "
+                      "smaller than 1K\n");
+        *prot &= ~PAGE_EXEC;
+    }
     return !(*prot & (1 << access_type));
 }
 
@@ -10002,10 +10013,13 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                                 int *prot, ARMMMUFaultInfo *fi)
+                                 int *prot, target_ulong *page_size,
+                                 ARMMMUFaultInfo *fi)
 {
     uint32_t secure = regime_is_secure(env, mmu_idx);
     V8M_SAttributes sattrs = {};
+    bool ret;
+    bool mpu_is_subpage;
 
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         v8m_security_lookup(env, address, access_type, mmu_idx, &sattrs);
@@ -10033,6 +10047,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
                 } else {
                     fi->type = ARMFault_QEMU_SFault;
                 }
+                *page_size = sattrs.subpage ? 1 : TARGET_PAGE_SIZE;
                 *phys_ptr = address;
                 *prot = 0;
                 return true;
@@ -10055,6 +10070,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
                  * for M_FAKE_FSR_SFAULT in arm_v7m_cpu_do_interrupt().
                  */
                 fi->type = ARMFault_QEMU_SFault;
+                *page_size = sattrs.subpage ? 1 : TARGET_PAGE_SIZE;
                 *phys_ptr = address;
                 *prot = 0;
                 return true;
@@ -10062,8 +10078,22 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
         }
     }
 
-    return pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
-                             txattrs, prot, fi, NULL);
+    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
+                            txattrs, prot, &mpu_is_subpage, fi, NULL);
+    /*
+     * TODO: this is a temporary hack to ignore the fact that the SAU region
+     * is smaller than a page if this is an executable region. We never
+     * supported small MPU regions, but we did (accidentally) allow small
+     * SAU regions, and if we now made small SAU regions not be executable
+     * then this would break previously working guest code. We can't
+     * remove this until/unless we implement support for execution from
+     * small regions.
+     */
+    if (*prot & PAGE_EXEC) {
+        sattrs.subpage = false;
+    }
+    *page_size = sattrs.subpage || mpu_is_subpage ? 1 : TARGET_PAGE_SIZE;
+    return ret;
 }
 
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
@@ -10339,7 +10369,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, address, access_type, mmu_idx,
-                                       phys_ptr, attrs, prot, fi);
+                                       phys_ptr, attrs, prot, page_size, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
@@ -10757,6 +10787,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     uint32_t mregion;
     bool targetpriv;
     bool targetsec = env->v7m.secure;
+    bool is_subpage;
 
     /* Work out what the security state and privilege level we're
      * interested in is...
@@ -10786,7 +10817,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     if (arm_current_el(env) != 0 || alt) {
         /* We can ignore the return value as prot is always set */
         pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                          &phys_addr, &attrs, &prot, &fi, &mregion);
+                          &phys_addr, &attrs, &prot, &is_subpage,
+                          &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.17.1
