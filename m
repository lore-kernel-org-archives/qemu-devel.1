Received: from eggs.gnu.org ([2001:4830:134:3::10]:57859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX3A-0008Vd-EQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX0y-0006kR-4x
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gPX0x-0006iB-RU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALI9E03097262
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:14:12 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwbscskb7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:14:12 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 21 Nov 2018 18:14:11 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed, 21 Nov 2018 16:13:47 -0200
In-Reply-To: <20181121181347.24035-1-farosas@linux.ibm.com>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
Message-Id: <20181121181347.24035-4-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 3/3] target/ppc: support single stepping
 with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

The hardware singlestep mechanism in POWER works via a Trace Interrupt
(0xd00) that happens after any instruction executes, whenever MSR_SE =
1 (PowerISA Section 6.5.15 - Trace Interrupt).

However, with kvm_hv, the Trace Interrupt happens inside the guest and
KVM has no visibility of it. Therefore, when the gdbstub uses the
KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.

This patch takes advantage of the Trace Interrupt to perform the step
inside the guest, but uses a breakpoint at the Trace Interrupt handler
to return control to KVM. The exit is treated by KVM as a regular
breakpoint and it returns to the host (and QEMU eventually).

Before signalling GDB, QEMU sets the Next Instruction Pointer to the
instruction following the one being stepped, effectively skipping the
interrupt handler execution and hiding the trace interrupt breakpoint
from GDB.

This approach works with both of GDB's 'scheduler-locking' options
(off, step).

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/kvm.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9d0b4f1f3f..93c20099e6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -94,6 +94,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_nested_kvm_hv;
 
 static uint32_t debug_inst_opcode;
+static target_ulong trace_handler_addr;
 
 /* XXX We have a race condition where we actually have a level triggered
  *     interrupt, but the infrastructure can't expose that yet, so the guest
@@ -509,6 +510,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     kvm_get_one_reg(cs, KVM_REG_PPC_DEBUG_INST, &debug_inst_opcode);
     kvmppc_hw_debug_points_init(cenv);
 
+    trace_handler_addr = (cenv->excp_vectors[POWERPC_EXCP_TRACE] |
+                          AIL_C000_0000_0000_4000_OFFSET);
+
     return ret;
 }
 
@@ -1553,6 +1557,24 @@ void kvm_arch_remove_all_hw_breakpoints(void)
 
 void kvm_arch_set_singlestep(CPUState *cs, int enabled)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (kvmppc_is_pr(kvm_state)) {
+            return;
+    }
+
+    if (enabled) {
+        /* MSR_SE = 1 will cause a Trace Interrupt in the guest after
+         * the next instruction executes. */
+        env->msr |= (1ULL << MSR_SE);
+
+        /* We set a breakpoint at the interrupt handler address so
+         * that the singlestep will be seen by KVM (this is treated by
+         * KVM like an ordinary breakpoint) and control is returned to
+         * QEMU. */
+        kvm_insert_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
+    }
 }
 
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
@@ -1594,6 +1616,43 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     }
 }
 
+static int kvm_handle_singlestep(CPUState *cs,
+                                 struct kvm_debug_exit_arch *arch_info)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    target_ulong msr = env->msr;
+    uint32_t insn;
+    int ret = 1;
+    int reg;
+
+    if (kvmppc_is_pr(kvm_state)) {
+        return ret;
+    }
+
+    if (arch_info->address == trace_handler_addr) {
+        cpu_synchronize_state(cs);
+        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
+
+        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&insn,
+                            sizeof(insn), 0);
+
+        /* If the last instruction was a mfmsr, make sure that the
+         * MSR_SE bit is not set to avoid the guest kernel knowing
+         * that it is being single-stepped */
+        if (extract32(insn, 26, 6) == 31 && extract32(insn, 1, 10) == 83) {
+            reg = extract32(insn, 21, 5);
+            env->gpr[reg] &= ~(1ULL << MSR_SE);
+        }
+
+        env->nip = env->spr[SPR_SRR0];
+        env->msr = msr &= ~(1ULL << MSR_SE);
+        cpu_synchronize_state(cs);
+    }
+
+    return ret;
+}
+
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
 {
     CPUState *cs = CPU(cpu);
@@ -1604,7 +1663,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     int flag = 0;
 
     if (cs->singlestep_enabled) {
-        handle = 1;
+        handle = kvm_handle_singlestep(cs, arch_info);
     } else if (arch_info->status) {
         if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
             if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
-- 
2.17.1
