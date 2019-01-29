Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1goSLf-0003SQ-UM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1goSLe-0003An-7G
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:18:39 -0500
Received: from smtp58.i.mail.ru ([217.69.128.38]:48732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1goSLc-00039A-88
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:18:37 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 29 Jan 2019 15:18:17 +0300
Message-Id: <20190129121817.7109-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] arm: Clarify the logic of set_pc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>

Until now, the set_pc logic was unclear, which raised questions about
whether it should be used directly, applying a value to PC or adding
additional checks, for example, set the Thumb bit in Arm cpu. Let's set
the set_pc logic for “Configure the PC, as was done in the ELF file”
and implement synchronize_with_tb hook for preserving PC to cpu_tb_exec.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/arm/boot.c             |  4 ----
 include/qom/cpu.h         | 16 ++++++++++++++--
 target/arm/arm-powerctl.c |  3 ---
 target/arm/cpu.c          | 26 +++++++++++++++++++++++++-
 target/arm/cpu64.c        | 15 ---------------
 5 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c7a67af7a9..05762d0fc1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -697,10 +697,6 @@ static void do_cpu_reset(void *opaque)
                 g_assert_not_reached();
             }
 
-            if (!env->aarch64) {
-                env->thumb = info->entry & 1;
-                entry &= 0xfffffffe;
-            }
             cpu_set_pc(cs, entry);
         } else {
             /* If we are booting Linux then we need to check whether we are
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 16bbed1ae0..deb92c414f 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -103,9 +103,21 @@ struct TranslationBlock;
  * @get_arch_id: Callback for getting architecture-dependent CPU ID.
  * @get_paging_enabled: Callback for inquiring whether paging is enabled.
  * @get_memory_mapping: Callback for obtaining the memory mappings.
- * @set_pc: Callback for setting the Program Counter register.
+ * @set_pc: Callback for setting the Program Counter register. This
+ *       should have the semantics used by the target architecture when
+ *       setting the PC from a source such as an ELF file entry point;
+ *       for example on Arm it will also set the Thumb mode bit based
+ *       on the least significant bit of the new PC value.
+ *       If the target behaviour here is anything other than "set
+ *       the PC register to the value passed in" then the target must
+ *       also implement the synchronize_from_tb hook.
  * @synchronize_from_tb: Callback for synchronizing state from a TCG
- * #TranslationBlock.
+ *       #TranslationBlock. This is called when we abandon execution
+ *       of a TB before starting it, and must set all parts of the CPU
+ *       state which the previous TB in the chain may not have updated.
+ *       This always includes at least the program counter; some targets
+ *       will need to do more. If this hook is not implemented then the
+ *       default is to call @set_pc(tb->pc).
  * @handle_mmu_fault: Callback for handling an MMU fault.
  * @get_phys_page_debug: Callback for obtaining a physical address.
  * @get_phys_page_attrs_debug: Callback for obtaining a physical address and the
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 2b856930fb..f9de5164e5 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -120,11 +120,8 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     if (info->target_aa64) {
         target_cpu->env.xregs[0] = info->context_id;
-        target_cpu->env.thumb = false;
     } else {
         target_cpu->env.regs[0] = info->context_id;
-        target_cpu->env.thumb = info->entry & 1;
-        info->entry &= 0xfffffffe;
     }
 
     /* Start the new CPU at the requested address */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e1f3dd637..2e7bdde9f5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -40,8 +40,31 @@
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (is_a64(env)) {
+        env->pc = value;
+        env->thumb = 0;
+    } else {
+        env->regs[15] = value & ~1;
+        env->thumb = value & 1;
+    }
+}
 
-    cpu->env.regs[15] = value;
+static void arm_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /*
+     * It's OK to look at env for the current mode here, because it's
+     * never possible for an AArch64 TB to chain to an AArch32 TB.
+     */
+    if (is_a64(env)) {
+        env->pc = tb->pc;
+    } else {
+        env->regs[15] = tb->pc;
+    }
 }
 
 static bool arm_cpu_has_work(CPUState *cs)
@@ -2088,6 +2111,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
+    cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e9bc461c36..8653cecd03 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -480,20 +480,6 @@ static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
 
-static void aarch64_cpu_set_pc(CPUState *cs, vaddr value)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    /* It's OK to look at env for the current mode here, because it's
-     * never possible for an AArch64 TB to chain to an AArch32 TB.
-     * (Otherwise we would need to use synchronize_from_tb instead.)
-     */
-    if (is_a64(&cpu->env)) {
-        cpu->env.pc = value;
-    } else {
-        cpu->env.regs[15] = value;
-    }
-}
-
 static gchar *aarch64_gdb_arch_name(CPUState *cs)
 {
     return g_strdup("aarch64");
@@ -504,7 +490,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
 
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
-    cc->set_pc = aarch64_cpu_set_pc;
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 34;
-- 
2.17.1
