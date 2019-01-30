Received: from eggs.gnu.org ([209.51.188.92]:35334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3b-0008H0-IE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3a-00010h-At
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:47 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3a-0000oc-3w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:21 -0500
Message-Id: <20190130004811.27372-24-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 23/73] mips: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: James Hogan <jhogan@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/mips/cps.c           | 2 +-
 hw/misc/mips_itu.c      | 4 ++--
 target/mips/kvm.c       | 2 +-
 target/mips/op_helper.c | 8 ++++----
 target/mips/translate.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index fc97f59af4..57f3c9e5fc 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -49,7 +49,7 @@ static void main_cpu_reset(void *opaque)
     cpu_reset(cs);
 
     /* All VPs are halted on reset. Leave powering up to CPC. */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static bool cpu_mips_itu_supported(CPUMIPSState *env)
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 1257d8fce6..1fab14d332 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -181,7 +181,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
 {
     CPUState *cs;
     CPU_FOREACH(cs) {
-        if (cs->halted && (c->blocked_threads & (1ULL << cs->cpu_index))) {
+        if (cpu_halted(cs) && (c->blocked_threads & (1ULL << cs->cpu_index))) {
             cpu_interrupt(cs, CPU_INTERRUPT_WAKE);
         }
     }
@@ -191,7 +191,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
 static void QEMU_NORETURN block_thread_and_exit(ITCStorageCell *c)
 {
     c->blocked_threads |= 1ULL << current_cpu->cpu_index;
-    current_cpu->halted = 1;
+    cpu_halted_set(current_cpu, 1);
     current_cpu->exception_index = EXCP_HLT;
     cpu_loop_exit_restore(current_cpu, current_cpu->mem_io_pc);
 }
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 8e72850962..0b177a7577 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -156,7 +156,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index aebad24ed6..0b8104c27f 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -649,7 +649,7 @@ static bool mips_vpe_is_wfi(MIPSCPU *c)
 
     /* If the VPE is halted but otherwise active, it means it's waiting for
        an interrupt.  */
-    return cpu->halted && mips_vpe_active(env);
+    return cpu_halted(cpu) && mips_vpe_active(env);
 }
 
 static bool mips_vp_is_wfi(MIPSCPU *c)
@@ -657,7 +657,7 @@ static bool mips_vp_is_wfi(MIPSCPU *c)
     CPUState *cpu = CPU(c);
     CPUMIPSState *env = &c->env;
 
-    return cpu->halted && mips_vp_active(env);
+    return cpu_halted(cpu) && mips_vp_active(env);
 }
 
 static inline void mips_vpe_wake(MIPSCPU *c)
@@ -674,7 +674,7 @@ static inline void mips_vpe_sleep(MIPSCPU *cpu)
 
     /* The VPE was shut off, really go to bed.
        Reset any old _WAKE requests.  */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
 }
 
@@ -2669,7 +2669,7 @@ void helper_wait(CPUMIPSState *env)
 {
     CPUState *cs = CPU(mips_env_get_cpu(env));
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
     /* Last instruction in the block, PC was updated before
        - no need to recover PC and icount */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e9b5d1d860..3e20ce9f1d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -30044,7 +30044,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->tcs[i].CP0_TCHalt = 1;
         }
         env->active_tc.CP0_TCHalt = 1;
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
 
         if (cs->cpu_index == 0) {
             /* VPE0 starts up enabled.  */
@@ -30052,7 +30052,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
 
             /* TC0 starts up unhalted.  */
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->active_tc.CP0_TCHalt = 0;
             env->tcs[0].CP0_TCHalt = 0;
             /* With thread 0 active.  */
-- 
2.17.1
