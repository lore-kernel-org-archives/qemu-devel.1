Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fIdrV-0001dr-8R
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fIdrU-0006tA-2g
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:45 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <petrutlucian94@gmail.com>)
	id 1fIdrT-0006t1-P0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:44 -0400
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so1016883wrm.1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:35:43 -0700 (PDT)
From: petrutlucian94@gmail.com
Date: Tue, 15 May 2018 20:35:22 +0300
Message-Id: <1526405722-10887-3-git-send-email-lpetrut@cloudbasesolutions.com>
In-Reply-To: <1526405722-10887-1-git-send-email-lpetrut@cloudbasesolutions.com>
References: <1526405722-10887-1-git-send-email-lpetrut@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH v2 3/3] WHPX: fix some compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

From: Lucian Petrut <lpetrut@cloudbasesolutions.com>

This patch fixes a few compiler warnings, especially in case of
x86 targets, where the number of registers was not properly handled
and could cause an overflow.

Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
---
 target/i386/whpx-all.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 0a29d56..2fd3397 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -226,24 +226,31 @@ static void whpx_set_registers(CPUState *cpu)
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
-    struct whpx_register_set vcxt = {0};
+    struct whpx_register_set vcxt;
     HRESULT hr;
-    int idx = 0;
+    int idx;
+    int idx_next;
     int i;
     int v86, r86;
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    memset(&vcxt, 0, sizeof(struct whpx_register_set));
+
     v86 = (env->eflags & VM_MASK);
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
     vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
+    idx = 0;
+
     /* Indexes for first 16 registers match between HV and QEMU definitions */
-    for (idx = 0; idx < CPU_NB_REGS64; idx += 1) {
-        vcxt.values[idx].Reg64 = env->regs[idx];
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
+        vcxt.values[idx].Reg64 = (uint64_t)env->regs[idx];
     }
+    idx = idx_next;
 
     /* Same goes for RIP and RFLAGS */
     assert(whpx_register_names[idx] == WHvX64RegisterRip);
@@ -290,10 +297,12 @@ static void whpx_set_registers(CPUState *cpu)
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    for (i = 0; i < 16; i += 1, idx += 1) {
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
         vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
         vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
     }
+    idx = idx_next;
 
     /* 8 FP registers */
     assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
@@ -384,7 +393,8 @@ static void whpx_get_registers(CPUState *cpu)
     struct whpx_register_set vcxt;
     uint64_t tpr, apic_base;
     HRESULT hr;
-    int idx = 0;
+    int idx;
+    int idx_next;
     int i;
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
@@ -399,10 +409,14 @@ static void whpx_get_registers(CPUState *cpu)
                      hr);
     }
 
+    idx = 0;
+
     /* Indexes for first 16 registers match between HV and QEMU definitions */
-    for (idx = 0; idx < CPU_NB_REGS64; idx += 1) {
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
         env->regs[idx] = vcxt.values[idx].Reg64;
     }
+    idx = idx_next;
 
     /* Same goes for RIP and RFLAGS */
     assert(whpx_register_names[idx] == WHvX64RegisterRip);
@@ -449,10 +463,12 @@ static void whpx_get_registers(CPUState *cpu)
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    for (i = 0; i < 16; i += 1, idx += 1) {
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
         env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
         env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
     }
+    idx = idx_next;
 
     /* 8 FP registers */
     assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
@@ -701,11 +717,14 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
     uint8_t tpr;
-    WHV_X64_PENDING_INTERRUPTION_REGISTER new_int = {0};
+    WHV_X64_PENDING_INTERRUPTION_REGISTER new_int;
     UINT32 reg_count = 0;
-    WHV_REGISTER_VALUE reg_values[3] = {0};
+    WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
 
+    memset(&new_int, 0, sizeof(new_int));
+    memset(reg_values, 0, sizeof(reg_values));
+
     qemu_mutex_lock_iothread();
 
     /* Inject NMI */
@@ -928,11 +947,13 @@ static int whpx_vcpu_run(CPUState *cpu)
             break;
 
         case WHvRunVpExitReasonX64Cpuid: {
-            WHV_REGISTER_VALUE reg_values[5] = {0};
+            WHV_REGISTER_VALUE reg_values[5];
             WHV_REGISTER_NAME reg_names[5];
             UINT32 reg_count = 5;
             UINT64 rip, rax, rcx, rdx, rbx;
 
+            memset(reg_values, 0, sizeof(reg_values));
+
             rip = vcpu->exit_ctx.VpContext.Rip +
                   vcpu->exit_ctx.VpContext.InstructionLength;
             switch (vcpu->exit_ctx.CpuidAccess.Rax) {
@@ -1203,7 +1224,7 @@ static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
         error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
                      " Host:%p, hr=%08lx",
                      (add ? "MAP" : "UNMAP"), name,
-                     (void *)start_pa, (void *)size, host_va, hr);
+                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
     }
 }
 
@@ -1234,8 +1255,8 @@ static void whpx_process_section(MemoryRegionSection *section, int add)
     host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
             + section->offset_within_region + delta;
 
-    whpx_update_mapping(start_pa, size, (void *)host_va, add,
-                       memory_region_is_rom(mr), mr->name);
+    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
+                        memory_region_is_rom(mr), mr->name);
 }
 
 static void whpx_region_add(MemoryListener *listener,
-- 
2.7.4
