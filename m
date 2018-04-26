Received: from eggs.gnu.org ([2001:4830:134:3::10]:39709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQy-0002l1-HJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-0001Xl-F3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQx-0001OF-79
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQt-00032r-00
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:05 +0100
Message-Id: <20180426104715.21702-10-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/19] target/arm: Support multiple EL change
 hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1523997485-1905-7-git-send-email-alindsay@codeaurora.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 20 ++++++++++----------
 target/arm/internals.h |  7 ++++---
 target/arm/cpu.c       | 21 ++++++++++++++++-----
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6bd8ff5917..b3def5afad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -632,12 +632,17 @@ typedef struct CPUARMState {
 } CPUARMState;
 
 /**
- * ARMELChangeHook:
+ * ARMELChangeHookFn:
  * type of a function which can be registered via arm_register_el_change_hook()
  * to get callbacks when the CPU changes its exception level or mode.
  */
-typedef void ARMELChangeHook(ARMCPU *cpu, void *opaque);
-
+typedef void ARMELChangeHookFn(ARMCPU *cpu, void *opaque);
+typedef struct ARMELChangeHook ARMELChangeHook;
+struct ARMELChangeHook {
+    ARMELChangeHookFn *hook;
+    void *opaque;
+    QLIST_ENTRY(ARMELChangeHook) node;
+};
 
 /* These values map onto the return values for
  * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
@@ -826,8 +831,7 @@ struct ARMCPU {
      */
     bool cfgend;
 
-    ARMELChangeHook *el_change_hook;
-    void *el_change_hook_opaque;
+    QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
 
@@ -2894,12 +2898,8 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
  * CPU changes exception level or mode. The hook function will be
  * passed a pointer to the ARMCPU and the opaque data pointer passed
  * to this function when the hook was registered.
- *
- * Note that we currently only support registering a single hook function,
- * and will assert if this function is called twice.
- * This facility is intended for the use of the GICv3 emulation.
  */
-void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
+void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque);
 
 /**
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ce944b7a0..6358c2ad5a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -727,11 +727,12 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
 
-/* Call the EL change hook if one has been registered */
+/* Call any registered EL change hooks */
 static inline void arm_call_el_change_hook(ARMCPU *cpu)
 {
-    if (cpu->el_change_hook) {
-        cpu->el_change_hook(cpu, cpu->el_change_hook_opaque);
+    ARMELChangeHook *hook, *next;
+    QLIST_FOREACH_SAFE(hook, &cpu->el_change_hooks, node, next) {
+        hook->hook(cpu, hook->opaque);
     }
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 022d8c5787..1f689f6817 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -55,13 +55,15 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_EXITTB);
 }
 
-void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
+void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
-    /* We currently only support registering a single hook function */
-    assert(!cpu->el_change_hook);
-    cpu->el_change_hook = hook;
-    cpu->el_change_hook_opaque = opaque;
+    ARMELChangeHook *entry = g_new0(ARMELChangeHook, 1);
+
+    entry->hook = hook;
+    entry->opaque = opaque;
+
+    QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
@@ -552,6 +554,8 @@ static void arm_cpu_initfn(Object *obj)
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
                                          g_free, g_free);
 
+    QLIST_INIT(&cpu->el_change_hooks);
+
 #ifndef CONFIG_USER_ONLY
     /* Our inbound IRQ and FIQ lines */
     if (kvm_enabled()) {
@@ -713,7 +717,14 @@ static void arm_cpu_post_init(Object *obj)
 static void arm_cpu_finalizefn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMELChangeHook *hook, *next;
+
     g_hash_table_destroy(cpu->cp_regs);
+
+    QLIST_FOREACH_SAFE(hook, &cpu->el_change_hooks, node, next) {
+        QLIST_REMOVE(hook, node);
+        g_free(hook);
+    }
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.0
