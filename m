Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9R-0005fU-2H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9Q-0003Gq-1J
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:29 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:13 +1000
Message-Id: <20190503055316.6441-11-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 10/13] target/ppc: Implement hcall
 H_TLB_INVALIDATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The hcall H_TLB_INVALIDATE is used by a guest acting as a nested
hypervisor to perform partition scoped tlb invalidation since these
instructions are hypervisor privileged.

Check the arguments are valid and then invalidate the entire tlb since
this is about all we can do in tcg.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c   | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 68f3282214..a84d5e2163 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -2131,6 +2131,33 @@ void h_exit_nested(PowerPCCPU *cpu)
     env->gpr[3] = trap;
 }
 
+static target_ulong h_nested_tlb_invalidate(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    target_ulong instr = args[0];
+    target_ulong rbval = args[2];
+    int r, ric, prs, is;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    ric = (instr >> 18) & 0x3;
+    prs = (instr >> 17) & 0x1;
+    r = (instr >> 16) & 0x1;
+    is = (rbval >> 10) & 0x3;
+
+    if ((!r) || (prs) || (ric == 3) || (is == 1) || ((!is) && (ric == 1 ||
+                                                               ric == 2)))
+        return H_PARAMETER;
+
+    /* Invalidate everything, not much else we can do */
+    cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -2240,6 +2267,7 @@ static void hypercall_register_types(void)
     /* Platform-specific hcalls used for nested HV KVM */
     spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
     spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
+    spapr_register_hypercall(H_TLB_INVALIDATE, h_nested_tlb_invalidate);
 
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7083dea9ef..6a614c445f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -504,7 +504,8 @@ struct SpaprMachineState {
 /* Platform-specific hcalls used for nested HV KVM */
 #define H_SET_PARTITION_TABLE   0xF800
 #define H_ENTER_NESTED          0xF804
-#define KVMPPC_HCALL_MAX        H_ENTER_NESTED
+#define H_TLB_INVALIDATE        0xF808
+#define KVMPPC_HCALL_MAX        H_TLB_INVALIDATE
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
-- 
2.13.6
