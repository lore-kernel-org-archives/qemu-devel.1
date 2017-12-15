Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSX-0001RY-I4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSV-0002s3-RE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:41 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:45461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePtSV-0002r4-L0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:39 -0500
Received: by mail-it0-x243.google.com with SMTP id z6so21035117iti.4
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:07:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Dec 2017 11:07:26 -0600
Message-Id: <20171215170732.31125-2-richard.henderson@linaro.org>
In-Reply-To: <20171215170732.31125-1-richard.henderson@linaro.org>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] target/*helper: don't check retaddr before
 calling cpu_restore_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

cpu_restore_state officially supports being passed an address it can't
resolve the state for. As a result the checks in the helpers are
superfluous and can be removed. This makes the code consistent with
other users of cpu_restore_state.

Of course this does nothing to address what to do if cpu_restore_state
can't resolve the state but so far it seems this is handled elsewhere.

The change was made with included coccinelle script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: Fixed up comment indentation.  Added second hunk to script to
combine cpu_restore_state and cpu_loop_exit.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/mem_helper.c                  | 13 +++----------
 target/arm/op_helper.c                     | 18 ++++++------------
 target/i386/svm_helper.c                   |  4 +---
 target/lm32/op_helper.c                    |  7 ++-----
 target/m68k/op_helper.c                    |  7 ++-----
 target/microblaze/op_helper.c              |  7 ++-----
 target/moxie/helper.c                      |  4 +---
 target/nios2/mmu.c                         |  7 ++-----
 target/openrisc/mmu_helper.c               |  6 +-----
 target/tricore/op_helper.c                 | 13 +++----------
 target/unicore32/op_helper.c               |  7 ++-----
 scripts/coccinelle/cpu_restore_state.cocci | 19 +++++++++++++++++++
 12 files changed, 44 insertions(+), 68 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_restore_state.cocci

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 3c06baa93a..430eea470b 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -34,9 +34,7 @@ void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     uint64_t pc;
     uint32_t insn;
 
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
+    cpu_restore_state(cs, retaddr);
 
     pc = env->pc;
     insn = cpu_ldl_code(env, pc);
@@ -58,9 +56,7 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
 
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
+    cpu_restore_state(cs, retaddr);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
@@ -80,11 +76,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = alpha_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
-        if (retaddr) {
-            cpu_restore_state(cs, retaddr);
-        }
         /* Exception index and error code are already set */
-        cpu_loop_exit(cs);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c2bb4f3a43..b36206343d 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -182,10 +182,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     if (unlikely(ret)) {
         ARMCPU *cpu = ARM_CPU(cs);
 
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
+        /* now we have a real cpu fault */
+        cpu_restore_state(cs, retaddr);
 
         deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
     }
@@ -199,10 +197,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     ARMCPU *cpu = ARM_CPU(cs);
     ARMMMUFaultInfo fi = {};
 
-    if (retaddr) {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr);
-    }
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr);
 
     fi.type = ARMFault_Alignment;
     deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
@@ -221,10 +217,8 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     ARMCPU *cpu = ARM_CPU(cs);
     ARMMMUFaultInfo fi = {};
 
-    if (retaddr) {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr);
-    }
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr);
 
     /* The EA bit in syndromes and fault status registers is an
      * IMPDEF classification of external aborts. ARM implementations
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index f479239875..303106981c 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -584,9 +584,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
 
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
+    cpu_restore_state(cs, retaddr);
 
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 2177c8ad12..30f670eee8 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -151,11 +151,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = lm32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        /* now we have a real cpu fault */
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 #endif
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 63089511cb..78bfb9f0cc 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -46,11 +46,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = m68k_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        /* now we have a real cpu fault */
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 1e07e21c1c..4cf51568df 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -40,11 +40,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = mb_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        /* now we have a real cpu fault */
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 #endif
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 330299f5a7..2ecee89f11 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -36,9 +36,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            cpu_restore_state(cs, retaddr);
-        }
+        cpu_restore_state(cs, retaddr);
     }
     cpu_loop_exit(cs);
 }
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index fe9298af50..0cd8647510 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -42,11 +42,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = nios2_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        /* now we have a real cpu fault */
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 
diff --git a/target/openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
index a44d0aa51a..a3e182c42d 100644
--- a/target/openrisc/mmu_helper.c
+++ b/target/openrisc/mmu_helper.c
@@ -33,12 +33,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     ret = openrisc_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
 
     if (ret) {
-        if (retaddr) {
-            /* now we have a real cpu fault.  */
-            cpu_restore_state(cs, retaddr);
-        }
         /* Raise Exception.  */
-        cpu_loop_exit(cs);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 #endif
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 7af202c8c0..40ed229486 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -31,9 +31,7 @@ raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
 {
     CPUState *cs = CPU(tricore_env_get_cpu(env));
     /* in case we come from a helper-call we need to restore the PC */
-    if (pc) {
-        cpu_restore_state(cs, pc);
-    }
+    cpu_restore_state(cs, pc);
 
     /* Tin is loaded into d[15] */
     env->gpr_d[15] = tin;
@@ -2804,13 +2802,8 @@ static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
     CPUState *cs = CPU(tricore_env_get_cpu(env));
     cs->exception_index = exception;
     env->error_code = error_code;
-
-    if (pc) {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, pc);
-    }
-
-    cpu_loop_exit(cs);
+    /* now we have a real cpu fault */
+    cpu_loop_exit_restore(cs, pc);
 }
 
 void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
index 0872c29faa..8788642a7f 100644
--- a/target/unicore32/op_helper.c
+++ b/target/unicore32/op_helper.c
@@ -251,11 +251,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = uc32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        /* now we have a real cpu fault */
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 #endif
diff --git a/scripts/coccinelle/cpu_restore_state.cocci b/scripts/coccinelle/cpu_restore_state.cocci
new file mode 100644
index 0000000000..61bc749d14
--- /dev/null
+++ b/scripts/coccinelle/cpu_restore_state.cocci
@@ -0,0 +1,19 @@
+// Remove unneeded tests before calling cpu_restore_state
+//
+// spatch --macro-file scripts/cocci-macro-file.h \
+//        --sp-file ./scripts/coccinelle/cpu_restore_state.cocci \
+//        --keep-comments --in-place --use-gitgrep --dir target
+@@
+expression A;
+expression C;
+@@
+-if (A) {
+     cpu_restore_state(C, A);
+-}
+@@
+expression A;
+expression C;
+@@
+- cpu_restore_state(C, A);
+- cpu_loop_exit(C);
++ cpu_loop_exit_restore(C, A);
-- 
2.14.3
