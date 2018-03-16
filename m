Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1Q-0005sI-TV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1P-0003Kh-Es
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:16 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:07 -0400
Message-Id: <1521232280-13089-10-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 09/22] target/arm: Add pre-EL change hooks
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

Because the design of the PMU requires that the counter values be
converted between their delta and guest-visible forms for mode
filtering, an additional hook which occurs before the EL is changed is
necessary.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c       | 13 +++++++++++++
 target/arm/cpu.h       | 12 ++++++++----
 target/arm/helper.c    | 14 ++++++++------
 target/arm/internals.h |  7 +++++++
 target/arm/op_helper.c |  8 ++++++++
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5f782bf..a2cb21e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -55,6 +55,18 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_EXITTB);
 }
 
+void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
+                                 void *opaque)
+{
+    ARMELChangeHook *entry;
+    entry = g_malloc0(sizeof (*entry));
+
+    entry->hook = hook;
+    entry->opaque = opaque;
+
+    QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
+}
+
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -747,6 +759,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
 
     /* Some features automatically imply others: */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3b45d3d..b0ef727 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -832,6 +832,7 @@ struct ARMCPU {
      */
     bool cfgend;
 
+    QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
@@ -2895,12 +2896,15 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
 #endif
 
 /**
+ * arm_register_pre_el_change_hook:
  * arm_register_el_change_hook:
- * Register a hook function which will be called back whenever this
- * CPU changes exception level or mode. The hook function will be
- * passed a pointer to the ARMCPU and the opaque data pointer passed
- * to this function when the hook was registered.
+ * Register a hook function which will be called back before or after this CPU
+ * changes exception level or mode. The hook function will be passed a pointer
+ * to the ARMCPU and the opaque data pointer passed to this function when the
+ * hook was registered.
  */
+void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
+                                 void *opaque);
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5d5c738..50eaed7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8253,6 +8253,14 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
+    /* Hooks may change global state so BQL should be held, also the
+     * BQL needs to be held for any modification of
+     * cs->interrupt_request.
+     */
+    g_assert(qemu_mutex_iothread_locked());
+
+    arm_call_pre_el_change_hook(cpu);
+
     assert(!excp_is_internal(cs->exception_index));
     if (arm_el_is_aa64(env, new_el)) {
         arm_cpu_do_interrupt_aarch64(cs);
@@ -8260,12 +8268,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
         arm_cpu_do_interrupt_aarch32(cs);
     }
 
-    /* Hooks may change global state so BQL should be held, also the
-     * BQL needs to be held for any modification of
-     * cs->interrupt_request.
-     */
-    g_assert(qemu_mutex_iothread_locked());
-
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 7df3eda..6ea6766 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -728,6 +728,13 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr);
 
 /* Call any registered EL change hooks */
+static inline void arm_call_pre_el_change_hook(ARMCPU *cpu)
+{
+    ARMELChangeHook *hook, *next;
+    QLIST_FOREACH_SAFE(hook, &cpu->pre_el_change_hooks, node, next) {
+        hook->hook(cpu, hook->opaque);
+    }
+}
 static inline void arm_call_el_change_hook(ARMCPU *cpu)
 {
     ARMELChangeHook *hook, *next;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 7a88fd2..be417ce 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -496,6 +496,10 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    qemu_mutex_lock_iothread();
+    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+
     cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
@@ -1013,6 +1017,10 @@ void HELPER(exception_return)(CPUARMState *env)
         goto illegal_return;
     }
 
+    qemu_mutex_lock_iothread();
+    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+
     if (!return_to_aa64) {
         env->aarch64 = 0;
         /* We do a raw CPSR write because aarch64_sync_64_to_32()
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
