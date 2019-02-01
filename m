Received: from eggs.gnu.org ([209.51.188.92]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0008Gq-TK
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003hB-Nc
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003dJ-DA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wm1-x344.google.com with SMTP id t200so6822773wmt.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.42
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:44 +0000
Message-Id: <20190201160653.13829-39-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/47] arm: Clarify the logic of set_pc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

Until now, the set_pc logic was unclear, which raised questions about
whether it should be used directly, applying a value to PC or adding
additional checks, for example, set the Thumb bit in Arm cpu. Let's set
the set_pc logic for “Configure the PC, as was done in the ELF file”
and implement synchronize_with_tb hook for preserving PC to cpu_tb_exec.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190129121817.7109-1-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qom/cpu.h         | 16 ++++++++++++++--
 hw/arm/boot.c             |  4 ----
 target/arm/arm-powerctl.c |  3 ---
 target/arm/cpu.c          | 26 +++++++++++++++++++++++++-
 target/arm/cpu64.c        | 15 ---------------
 5 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 4c2feb9c17b..1d6099e5d4b 100644
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
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c7a67af7a97..05762d0fc1b 100644
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
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 2b856930fb7..f9de5164e55 100644
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
index 8a9cd0900d2..f00d450d0bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -40,8 +40,31 @@
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
 
-    cpu->env.regs[15] = value;
+    if (is_a64(env)) {
+        env->pc = value;
+        env->thumb = 0;
+    } else {
+        env->regs[15] = value & ~1;
+        env->thumb = value & 1;
+    }
+}
+
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
@@ -2099,6 +2122,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
+    cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e9bc461c362..8653cecd032 100644
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
2.20.1
