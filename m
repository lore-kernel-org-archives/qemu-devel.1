Received: from eggs.gnu.org ([2001:4830:134:3::10]:57096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIw-0006U6-95
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIu-0006us-U6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:54 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIu-0006tl-NZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:52 -0400
Received: by mail-wr0-x241.google.com with SMTP id u11so6644474wri.12
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:31 +0200
Message-Id: <1522071403-52486-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/16] WHPX improve vcpu_post_run perf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM)" <juterry@microsoft.com>

This removes the additional call to WHvGetVirtualProcessorRegisters in
whpx_vcpu_post_run now that the WHV_VP_EXIT_CONTEXT is returned in all
WHV_RUN_VP_EXIT_CONTEXT structures.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1521039163-138-4-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 63e6e1b..bf33d32 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -153,7 +153,7 @@ struct whpx_vcpu {
     bool interruptable;
     uint64_t tpr;
     uint64_t apic_base;
-    WHV_X64_PENDING_INTERRUPTION_REGISTER interrupt_in_flight;
+    bool interruption_pending;
 
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
@@ -695,7 +695,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     qemu_mutex_lock_iothread();
 
     /* Inject NMI */
-    if (!vcpu->interrupt_in_flight.InterruptionPending &&
+    if (!vcpu->interruption_pending &&
         cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
@@ -724,7 +724,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Get pending hard interruption or replay one that was overwritten */
-    if (!vcpu->interrupt_in_flight.InterruptionPending &&
+    if (!vcpu->interruption_pending &&
         vcpu->interruptable && (env->eflags & IF_MASK)) {
         assert(!new_int.InterruptionPending);
         if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
@@ -781,44 +781,25 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
 static void whpx_vcpu_post_run(CPUState *cpu)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
-    WHV_REGISTER_VALUE reg_values[4];
-    const WHV_REGISTER_NAME reg_names[4] = {
-        WHvX64RegisterRflags,
-        WHvX64RegisterCr8,
-        WHvRegisterPendingInterruption,
-        WHvRegisterInterruptState,
-    };
 
-    hr = WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                         reg_names, 4, reg_values);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get interrupt state regusters,"
-                     " hr=%08lx", hr);
-        vcpu->interruptable = false;
-        return;
-    }
+    env->eflags = vcpu->exit_ctx.VpContext.Rflags;
 
-    assert(reg_names[0] == WHvX64RegisterRflags);
-    env->eflags = reg_values[0].Reg64;
-
-    assert(reg_names[1] == WHvX64RegisterCr8);
-    if (vcpu->tpr != reg_values[1].Reg64) {
-        vcpu->tpr = reg_values[1].Reg64;
+    uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
+    if (vcpu->tpr != tpr) {
+        vcpu->tpr = tpr;
         qemu_mutex_lock_iothread();
         cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
         qemu_mutex_unlock_iothread();
     }
 
-    assert(reg_names[2] == WHvRegisterPendingInterruption);
-    vcpu->interrupt_in_flight = reg_values[2].PendingInterruption;
+    vcpu->interruption_pending =
+        vcpu->exit_ctx.VpContext.ExecutionState.InterruptionPending;
 
-    assert(reg_names[3] == WHvRegisterInterruptState);
-    vcpu->interruptable = !reg_values[3].InterruptState.InterruptShadow;
+    vcpu->interruptable =
+        !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
 
     return;
 }
-- 
1.8.3.1
