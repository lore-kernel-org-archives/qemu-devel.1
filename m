Received: from eggs.gnu.org ([209.51.188.92]:35678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3y-00007p-KT
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3u-0001HR-RX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3s-00010H-Qt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:37 -0500
Message-Id: <20190130004811.27372-40-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 39/73] i386: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/cpu.c        | 2 +-
 target/i386/helper.c     | 4 ++--
 target/i386/svm_helper.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a37b984b61..35dea8c152 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5678,7 +5678,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 
 static bool x86_cpu_has_work(CPUState *cs)
 {
-    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs)) != 0;
 }
 
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index a75278f954..9197fb4edc 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1035,12 +1035,12 @@ void do_cpu_init(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
-    int sipi = cs->interrupt_request & CPU_INTERRUPT_SIPI;
+    int sipi = cpu_interrupt_request(cs) & CPU_INTERRUPT_SIPI;
 
     *save = *env;
 
     cpu_reset(cs);
-    cs->interrupt_request = sipi;
+    cpu_interrupt_request_set(cs, sipi);
     memcpy(&env->start_init_save, &save->start_init_save,
            offsetof(CPUX86State, end_init_save) -
            offsetof(CPUX86State, start_init_save));
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index a6d33e55d8..ebf3643ba7 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -316,7 +316,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     if (int_ctl & V_IRQ_MASK) {
         CPUState *cs = CPU(x86_env_get_cpu(env));
 
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_VIRQ);
     }
 
     /* maybe we need to inject an event */
@@ -674,7 +674,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
                        env->vm_vmcb + offsetof(struct vmcb, control.int_ctl));
     int_ctl &= ~(V_TPR_MASK | V_IRQ_MASK);
     int_ctl |= env->v_tpr & V_TPR_MASK;
-    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) {
         int_ctl |= V_IRQ_MASK;
     }
     x86_stl_phys(cs,
-- 
2.17.1
