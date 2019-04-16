Received: from eggs.gnu.org ([209.51.188.92]:42313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGG8d-0003HX-HN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGG8c-0006IO-F4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:56:07 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 16 Apr 2019 14:55:52 +1000
Message-Id: <20190416045552.24573-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] spapr: add splpar hcalls H_PROD, H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

These implementations have a few deficiencies that are noted, but are
good enough for Linux to use.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

v3: Removed wrong comment about GPR3, drop H_JOIN for now (at least until
it is tested some more in Linux/KVM), and expand the comment about not
prod bit.

 hw/ppc/spapr_hcall.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..8892ad008b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,74 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs = CPU(cpu);
+
+    /*
+     * This does not do a targeted yield or confer, but check the parameter
+     * anyway. -1 means confer to all/any other CPUs.
+     */
+    if (target != -1 && !CPU(spapr_find_cpu(target))) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * PAPR calls for waiting until proded in this case (or presumably
+     * an external interrupt if MSR[EE]=1, without dispatch sequence count
+     * check.
+     */
+    if (cpu == spapr_find_cpu(target)) {
+        cs->halted = 1;
+        cs->exception_index = EXCP_HALTED;
+        cs->exit_request = 1;
+
+        return H_SUCCESS;
+    }
+
+    /*
+     * This does not implement the dispatch sequence check that PAPR calls for,
+     * but PAPR also specifies a stronger implementation where the target must
+     * be run (or EE, or H_PROD) before H_CONFER returns. Without such a hard
+     * scheduling requirement implemented, there is no correctness reason to
+     * implement the dispatch sequence check.
+     */
+    cs->exception_index = EXCP_YIELD;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+
+    /*
+     * PAPR specifies there should be a prod flag should be associated with
+     * a vCPU, which gets set here, tested by H_CEDE, and cleared any time
+     * the vCPU is dispatched, including via preemption.
+     *
+     * We don't implement this because it is not used by Linux. The bit would
+     * be difficult or impossible to use properly because preemption can not
+     * be prevented so dispatch sequence count would have to somehow be used
+     * to detect it.
+     */
+
+    cs = CPU(spapr_find_cpu(target));
+    if (!cs) {
+        return H_PARAMETER;
+    }
+
+    cs->halted = 0;
+    qemu_cpu_kick(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1
