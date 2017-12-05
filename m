Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB4-00013T-I7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB3-0002Lk-C1
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:29 +0000
Message-Id: <1512503192-2239-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/12] target/arm: Use ARMMMUFaultInfo in
 deliver_fault()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>

Now that ARMMMUFaultInfo is guaranteed to have enough information
to construct a fault status code, we can pass it in to the
deliver_fault() function and let it generate the correct type
of FSR for the destination, rather than relying on the value
provided by get_phys_addr().

I don't think there are any cases the old code was getting
wrong, but this is more obviously correct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 79 ++++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 57 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index a40a84a..38e6993 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -116,12 +116,13 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
 }
 
 static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
-                          uint32_t fsr, uint32_t fsc, ARMMMUFaultInfo *fi)
+                          int mmu_idx, ARMMMUFaultInfo *fi)
 {
     CPUARMState *env = &cpu->env;
     int target_el;
     bool same_el;
-    uint32_t syn, exc;
+    uint32_t syn, exc, fsr, fsc;
+    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
 
     target_el = exception_target_el(env);
     if (fi->stage2) {
@@ -130,14 +131,21 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
     }
     same_el = (arm_current_el(env) == target_el);
 
-    if (fsc == 0x3f) {
-        /* Caller doesn't have a long-format fault status code. This
-         * should only happen if this fault will never actually be reported
-         * to an EL that uses a syndrome register. Check that here.
-         * 0x3f is a (currently) reserved FSC code, in case the constructed
-         * syndrome does leak into the guest somehow.
+    if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
+        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
+        /* LPAE format fault status register : bottom 6 bits are
+         * status code in the same form as needed for syndrome
+         */
+        fsr = arm_fi_to_lfsc(fi);
+        fsc = extract32(fsr, 0, 6);
+    } else {
+        fsr = arm_fi_to_sfsc(fi);
+        /* Short format FSR : this fault will never actually be reported
+         * to an EL that uses a syndrome register. Use a (currently)
+         * reserved FSR code in case the constructed syndrome does leak
+         * into the guest somehow.
          */
-        assert(target_el != 2 && !arm_el_is_aa64(env, target_el));
+        fsc = 0x3f;
     }
 
     if (access_type == MMU_INST_FETCH) {
@@ -174,29 +182,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     ret = arm_tlb_fill(cs, addr, access_type, mmu_idx, &fsr, &fi);
     if (unlikely(ret)) {
         ARMCPU *cpu = ARM_CPU(cs);
-        uint32_t fsc;
 
         if (retaddr) {
             /* now we have a real cpu fault */
             cpu_restore_state(cs, retaddr);
         }
 
-        if (fsr & (1 << 9)) {
-            /* LPAE format fault status register : bottom 6 bits are
-             * status code in the same form as needed for syndrome
-             */
-            fsc = extract32(fsr, 0, 6);
-        } else {
-            /* Short format FSR : this fault will never actually be reported
-             * to an EL that uses a syndrome register. Use a (currently)
-             * reserved FSR code in case the constructed syndrome does leak
-             * into the guest somehow. deliver_fault will assert that
-             * we don't target an EL using the syndrome.
-             */
-            fsc = 0x3f;
-        }
-
-        deliver_fault(cpu, addr, access_type, fsr, fsc, &fi);
+        deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
     }
 }
 
@@ -206,27 +198,15 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  int mmu_idx, uintptr_t retaddr)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    uint32_t fsr, fsc;
     ARMMMUFaultInfo fi = {};
-    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
 
     if (retaddr) {
         /* now we have a real cpu fault */
         cpu_restore_state(cs, retaddr);
     }
 
-    /* the DFSR for an alignment fault depends on whether we're using
-     * the LPAE long descriptor format, or the short descriptor format
-     */
-    if (arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        fsr = (1 << 9) | 0x21;
-    } else {
-        fsr = 0x1;
-    }
-    fsc = 0x21;
-
-    deliver_fault(cpu, vaddr, access_type, fsr, fsc, &fi);
+    fi.type = ARMFault_Alignment;
+    deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
 /* arm_cpu_do_transaction_failed: handle a memory system error response
@@ -240,10 +220,7 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    uint32_t fsr, fsc;
     ARMMMUFaultInfo fi = {};
-    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
 
     if (retaddr) {
         /* now we have a real cpu fault */
@@ -256,20 +233,8 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
      * Slave error (1); in QEMU we follow that.
      */
     fi.ea = (response != MEMTX_DECODE_ERROR);
-
-    /* The fault status register format depends on whether we're using
-     * the LPAE long descriptor format, or the short descriptor format.
-     */
-    if (arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        /* long descriptor form, STATUS 0b010000: synchronous ext abort */
-        fsr = (fi.ea << 12) | (1 << 9) | 0x10;
-    } else {
-        /* short descriptor form, FSR 0b01000 : synchronous ext abort */
-        fsr = (fi.ea << 12) | 0x8;
-    }
-    fsc = 0x10;
-
-    deliver_fault(cpu, addr, access_type, fsr, fsc, &fi);
+    fi.type = ARMFault_SyncExternal;
+    deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
 #endif /* !defined(CONFIG_USER_ONLY) */
-- 
2.7.4
