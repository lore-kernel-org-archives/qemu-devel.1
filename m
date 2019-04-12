Received: from eggs.gnu.org ([209.51.188.92]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEsbh-0001dO-Cb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEsbg-0000eH-BC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:36:25 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 12 Apr 2019 19:36:03 +1000
Message-Id: <20190412093603.18232-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
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

Cleaned up checkpatch warnings, sorry I didn't realise that exists.

 hw/ppc/spapr_hcall.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..e985bb694d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,90 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    /*
+     * This should check for single-threaded mode. In practice, Linux
+     * does not try to H_JOIN all CPUs.
+     */
+
+    cs->halted = 1;
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+
+    return H_SUCCESS;
+}
+
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
+     * H_CONFER with target == this is not exactly the same as H_JOIN
+     * according to PAPR (e.g., MSR[EE] check and single threaded check
+     * is not done in this case), but unlikely to matter.
+     */
+    if (cpu == spapr_find_cpu(target)) {
+        return h_join(cpu, spapr, opcode, args);
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
+/*
+ * H_PROD and H_CONFER are specified to only modify GPR r3, which is not
+ * achievable running under KVM, although KVM already implements H_CONFER
+ * this way.
+ */
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+
+    /*
+     * Should set the prod flag in the VPA.
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
@@ -1860,6 +1944,10 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_JOIN, h_join);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1
