Received: from eggs.gnu.org ([2001:4830:134:3::10]:50618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNY-0002vl-7I
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNV-0005Yf-HT
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:39:04 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Tue, 17 Apr 2018 16:37:50 -0400
Message-Id: <1523997485-1905-7-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v4 06/21] target/arm: Support multiple EL
 change hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c       | 21 ++++++++++++++++-----
 target/arm/cpu.h       | 20 ++++++++++----------
 target/arm/internals.h |  7 ++++---
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 022d8c5..1f689f6 100644
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff349f5..50d129b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -642,12 +642,17 @@ typedef struct CPUARMState {
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
@@ -836,8 +841,7 @@ struct ARMCPU {
      */
     bool cfgend;
 
-    ARMELChangeHook *el_change_hook;
-    void *el_change_hook_opaque;
+    QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
 
@@ -2906,12 +2910,8 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
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
index 8ce944b..6358c2a 100644
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
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
