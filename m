Received: from eggs.gnu.org ([2001:4830:134:3::10]:56712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwrI-0001Ei-0o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr3-0007ie-Ir
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwr3-0007gC-BL
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr2-0001ia-99
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:23 +0100
Message-Id: <1504790904-17018-31-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/31] target/arm: Implement new
 do_transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the new do_transaction_failed hook for ARM, which should
cause the CPU to take a prefetch abort or data abort.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1504626814-23124-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/internals.h | 10 ++++++++++
 target/arm/cpu.c       |  1 +
 target/arm/op_helper.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4afebd9..5d7f24c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -472,6 +472,16 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr);
 
+/* arm_cpu_do_transaction_failed: handle a memory system error response
+ * (eg "no device/memory present at address") by raising an external abort
+ * exception
+ */
+void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr addr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr);
+
 /* Call the EL change hook if one has been registered */
 static inline void arm_call_el_change_hook(ARMCPU *cpu)
 {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 116b567..f8b2fdb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1707,6 +1707,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #else
     cc->do_interrupt = arm_cpu_do_interrupt;
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+    cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs = arm_asidx_from_attrs;
     cc->vmsd = &vmstate_arm_cpu;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8f6db80..d1bca46 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -229,6 +229,49 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     deliver_fault(cpu, vaddr, access_type, fsr, fsc, &fi);
 }
 
+/* arm_cpu_do_transaction_failed: handle a memory system error response
+ * (eg "no device/memory present at address") by raising an external abort
+ * exception
+ */
+void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr addr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint32_t fsr, fsc;
+    ARMMMUFaultInfo fi = {};
+    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
+
+    if (retaddr) {
+        /* now we have a real cpu fault */
+        cpu_restore_state(cs, retaddr);
+    }
+
+    /* The EA bit in syndromes and fault status registers is an
+     * IMPDEF classification of external aborts. ARM implementations
+     * usually use this to indicate AXI bus Decode error (0) or
+     * Slave error (1); in QEMU we follow that.
+     */
+    fi.ea = (response != MEMTX_DECODE_ERROR);
+
+    /* The fault status register format depends on whether we're using
+     * the LPAE long descriptor format, or the short descriptor format.
+     */
+    if (arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
+        /* long descriptor form, STATUS 0b010000: synchronous ext abort */
+        fsr = (fi.ea << 12) | (1 << 9) | 0x10;
+    } else {
+        /* short descriptor form, FSR 0b01000 : synchronous ext abort */
+        fsr = (fi.ea << 12) | 0x8;
+    }
+    fsc = 0x10;
+
+    deliver_fault(cpu, addr, access_type, fsr, fsc, &fi);
+}
+
 #endif /* !defined(CONFIG_USER_ONLY) */
 
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
-- 
2.7.4
