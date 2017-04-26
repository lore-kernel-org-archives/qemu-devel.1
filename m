Received: from eggs.gnu.org ([2001:4830:134:3::10]:56633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwe-0005D4-Q4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3GwY-0007vp-Q1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 16:59:54 +1000
Message-Id: <20170426070034.10727-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/48] target/ppc: Add new H-CALL shells for in
 memory table translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The use of the new in memory tables introduced in ISAv3.00 for translation,
also referred to as process tables, requires the introduction of 3 new
H-CALLs; H_REGISTER_PROCESS_TABLE, H_CLEAN_SLB, and H_INVALIDATE_PID.

Add shells for each of these and register them as the hypercall handlers.
Currently they all log an unimplemented hypercall and return H_FUNCTION.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Fix style nits]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c   | 31 +++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f05a90e..7952129 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -878,6 +878,32 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return ret;
 }
 
+static target_ulong h_clean_slb(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                target_ulong opcode, target_ulong *args)
+{
+    qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx"%s\n",
+                  opcode, " (H_CLEAN_SLB)");
+    return H_FUNCTION;
+}
+
+static target_ulong h_invalidate_pid(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                     target_ulong opcode, target_ulong *args)
+{
+    qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx"%s\n",
+                  opcode, " (H_INVALIDATE_PID)");
+    return H_FUNCTION;
+}
+
+static target_ulong h_register_process_table(PowerPCCPU *cpu,
+                                             sPAPRMachineState *spapr,
+                                             target_ulong opcode,
+                                             target_ulong *args)
+{
+    qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx"%s\n",
+                  opcode, " (H_REGISTER_PROC_TBL)");
+    return H_FUNCTION;
+}
+
 #define H_SIGNAL_SYS_RESET_ALL         -1
 #define H_SIGNAL_SYS_RESET_ALLBUTSELF  -2
 
@@ -1084,6 +1110,11 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_PAGE_INIT, h_page_init);
     spapr_register_hypercall(H_SET_MODE, h_set_mode);
 
+    /* In Memory Table MMU h-calls */
+    spapr_register_hypercall(H_CLEAN_SLB, h_clean_slb);
+    spapr_register_hypercall(H_INVALIDATE_PID, h_invalidate_pid);
+    spapr_register_hypercall(H_REGISTER_PROC_TBL, h_register_process_table);
+
     /* "debugger" hcalls (also used by SLOF). Note: We do -not- differenciate
      * here between the "CI" and the "CACHE" variants, they will use whatever
      * mapping attributes qemu is using. When using KVM, the kernel will
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ba9e689..342f7a6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -361,6 +361,9 @@ struct sPAPRMachineState {
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
+#define H_CLEAN_SLB             0x374
+#define H_INVALIDATE_PID        0x378
+#define H_REGISTER_PROC_TBL     0x37C
 #define H_SIGNAL_SYS_RESET      0x380
 #define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
 
-- 
2.9.3
