Received: from eggs.gnu.org ([2001:4830:134:3::10]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePsmy-0007av-Av
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePsmw-0006V5-Vi
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:24:44 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 16:24:36 +0000
Message-Id: <1513355076-5075-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Handle page table walk load
 failures correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Instead of ignoring the response from address_space_ld*()
(indicating an attempt to read a page table descriptor from
an invalid physical address), use it to report the failure
correctly.

Since this is another couple of locations where we need to
decide the value of the ARMMMUFaultInfo ea bit based on a
MemTxResult, we factor out that operation into a helper
function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Now we've fixed the get-phys-addr functions to always report
errors via the ARMMMUFaultInfo struct, it's pretty easy to
detect and report external aborts on translation table walks.

 target/arm/internals.h | 10 ++++++++++
 target/arm/helper.c    | 39 ++++++++++++++++++++++++++++++++++-----
 target/arm/op_helper.c |  7 +------
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 876854d..89f5d2f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -687,6 +687,16 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
     return fsc;
 }
 
+static inline bool arm_extabort_type(MemTxResult result)
+{
+    /* The EA bit in syndromes and fault status registers is an
+     * IMPDEF classification of external aborts. ARM implementations
+     * usually use this to indicate AXI bus Decode error (0) or
+     * Slave error (1); in QEMU we follow that.
+     */
+    return result != MEMTX_DECODE_ERROR;
+}
+
 /* Do a page table walk and add page to TLB if possible */
 bool arm_tlb_fill(CPUState *cpu, vaddr address,
                   MMUAccessType access_type, int mmu_idx,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1395f9..2575a83 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8305,6 +8305,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
                                  &txattrs, &s2prot, &s2size, fi, NULL);
         if (ret) {
+            assert(fi->type != ARMFault_None);
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
@@ -8328,7 +8329,9 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     MemTxAttrs attrs = {};
+    MemTxResult result = MEMTX_OK;
     AddressSpace *as;
+    uint32_t data;
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
@@ -8337,10 +8340,16 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
         return 0;
     }
     if (regime_translation_big_endian(env, mmu_idx)) {
-        return address_space_ldl_be(as, addr, attrs, NULL);
+        data = address_space_ldl_be(as, addr, attrs, &result);
     } else {
-        return address_space_ldl_le(as, addr, attrs, NULL);
+        data = address_space_ldl_le(as, addr, attrs, &result);
     }
+    if (result == MEMTX_OK) {
+        return data;
+    }
+    fi->type = ARMFault_SyncExternalOnWalk;
+    fi->ea = arm_extabort_type(result);
+    return 0;
 }
 
 static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
@@ -8349,7 +8358,9 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     MemTxAttrs attrs = {};
+    MemTxResult result = MEMTX_OK;
     AddressSpace *as;
+    uint32_t data;
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
@@ -8358,10 +8369,16 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
         return 0;
     }
     if (regime_translation_big_endian(env, mmu_idx)) {
-        return address_space_ldq_be(as, addr, attrs, NULL);
+        data = address_space_ldq_be(as, addr, attrs, &result);
     } else {
-        return address_space_ldq_le(as, addr, attrs, NULL);
+        data = address_space_ldq_le(as, addr, attrs, &result);
+    }
+    if (result == MEMTX_OK) {
+        return data;
     }
+    fi->type = ARMFault_SyncExternalOnWalk;
+    fi->ea = arm_extabort_type(result);
+    return 0;
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
@@ -8390,6 +8407,9 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
                        mmu_idx, fi);
+    if (fi->type != ARMFault_None) {
+        goto do_fault;
+    }
     type = (desc & 3);
     domain = (desc >> 5) & 0x0f;
     if (regime_el(env, mmu_idx) == 1) {
@@ -8426,6 +8446,9 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
         }
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
                            mmu_idx, fi);
+        if (fi->type != ARMFault_None) {
+            goto do_fault;
+        }
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
             fi->type = ARMFault_Translation;
@@ -8508,6 +8531,9 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
                        mmu_idx, fi);
+    if (fi->type != ARMFault_None) {
+        goto do_fault;
+    }
     type = (desc & 3);
     if (type == 0 || (type == 3 && !arm_feature(env, ARM_FEATURE_PXN))) {
         /* Section translation fault, or attempt to use the encoding
@@ -8559,6 +8585,9 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         table = (desc & 0xfffffc00) | ((address >> 10) & 0x3fc);
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
                            mmu_idx, fi);
+        if (fi->type != ARMFault_None) {
+            goto do_fault;
+        }
         ap = ((desc >> 4) & 3) | ((desc >> 7) & 4);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
@@ -8964,7 +8993,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         descaddr &= ~7ULL;
         nstable = extract32(tableattrs, 4, 1);
         descriptor = arm_ldq_ptw(cs, descaddr, !nstable, mmu_idx, fi);
-        if (fi->s1ptw) {
+        if (fi->type != ARMFault_None) {
             goto do_fault;
         }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c2bb4f3..2f35ff7 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -226,12 +226,7 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
         cpu_restore_state(cs, retaddr);
     }
 
-    /* The EA bit in syndromes and fault status registers is an
-     * IMPDEF classification of external aborts. ARM implementations
-     * usually use this to indicate AXI bus Decode error (0) or
-     * Slave error (1); in QEMU we follow that.
-     */
-    fi.ea = (response != MEMTX_DECODE_ERROR);
+    fi.ea = arm_extabort_type(response);
     fi.type = ARMFault_SyncExternal;
     deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
-- 
2.7.4
