Received: from eggs.gnu.org ([2001:4830:134:3::10]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQw-0002jf-Tn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQv-0001Vc-IO
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQv-0001OF-AS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQt-00033I-Mq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:06 +0100
Message-Id: <20180426104715.21702-11-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/19] target/arm: Add pre-EL change hooks
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

Because the design of the PMU requires that the counter values be
converted between their delta and guest-visible forms for mode
filtering, an additional hook which occurs before the EL is changed is
necessary.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1523997485-1905-8-git-send-email-alindsay@codeaurora.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 22 +++++++++++++++++++---
 target/arm/internals.h |  7 +++++++
 target/arm/cpu.c       | 16 ++++++++++++++++
 target/arm/helper.c    | 14 ++++++++------
 target/arm/op_helper.c |  8 ++++++++
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b3def5afad..b9b47f4b22 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -831,6 +831,7 @@ struct ARMCPU {
      */
     bool cfgend;
 
+    QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
@@ -2893,14 +2894,29 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
 #endif
 
 /**
- * arm_register_el_change_hook:
- * Register a hook function which will be called back whenever this
+ * arm_register_pre_el_change_hook:
+ * Register a hook function which will be called immediately before this
  * CPU changes exception level or mode. The hook function will be
  * passed a pointer to the ARMCPU and the opaque data pointer passed
  * to this function when the hook was registered.
+ *
+ * Note that if a pre-change hook is called, any registered post-change hooks
+ * are guaranteed to subsequently be called.
  */
-void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
+void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque);
+/**
+ * arm_register_el_change_hook:
+ * Register a hook function which will be called immediately after this
+ * CPU changes exception level or mode. The hook function will be
+ * passed a pointer to the ARMCPU and the opaque data pointer passed
+ * to this function when the hook was registered.
+ *
+ * Note that any registered hooks registered here are guaranteed to be called
+ * if pre-change hooks have been.
+ */
+void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
+        *opaque);
 
 /**
  * aa32_vfp_dreg:
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6358c2ad5a..dc9357766c 100644
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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1f689f6817..d175c5e94f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -55,6 +55,17 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_EXITTB);
 }
 
+void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
+                                 void *opaque)
+{
+    ARMELChangeHook *entry = g_new0(ARMELChangeHook, 1);
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
@@ -554,6 +565,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
                                          g_free, g_free);
 
+    QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
 
 #ifndef CONFIG_USER_ONLY
@@ -721,6 +733,10 @@ static void arm_cpu_finalizefn(Object *obj)
 
     g_hash_table_destroy(cpu->cp_regs);
 
+    QLIST_FOREACH_SAFE(hook, &cpu->pre_el_change_hooks, node, next) {
+        QLIST_REMOVE(hook, node);
+        g_free(hook);
+    }
     QLIST_FOREACH_SAFE(hook, &cpu->el_change_hooks, node, next) {
         QLIST_REMOVE(hook, node);
         g_free(hook);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3238aacaa6..81e88f255b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8249,6 +8249,14 @@ void arm_cpu_do_interrupt(CPUState *cs)
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
@@ -8256,12 +8264,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
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
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 84f08bf815..f728f25e4b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -511,6 +511,10 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    qemu_mutex_lock_iothread();
+    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+
     cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
@@ -1028,6 +1032,10 @@ void HELPER(exception_return)(CPUARMState *env)
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
2.17.0
