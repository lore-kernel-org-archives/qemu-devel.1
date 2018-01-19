Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOnF-0007fc-Iq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOnE-0004ty-KT
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:45 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 19 Jan 2018 16:00:05 +1100
Message-Id: <20180119050005.29392-8-sjitindarsingh@gmail.com>
In-Reply-To: <20180119050005.29392-1-sjitindarsingh@gmail.com>
References: <20180119050005.29392-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V5 7/7] target/ppc/spapr: Add H-Call
 H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query
behaviours and available characteristics of the cpu.

Implement the handler for this new H-Call which formulates its response
based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ibs.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V4 -> V5:
 - Assert for invalid cap value
---
 hw/ppc/spapr_hcall.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 51eba52e86..4d0e6eb0cf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1654,6 +1654,60 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
+                                              sPAPRMachineState *spapr,
+                                              target_ulong opcode,
+                                              target_ulong *args)
+{
+    uint64_t characteristics = H_CPU_CHAR_HON_BRANCH_HINTS &
+                               ~H_CPU_CHAR_THR_RECONF_TRIG;
+    uint64_t behaviour = H_CPU_BEHAV_FAVOUR_SECURITY;
+    uint8_t safe_cache = spapr_get_cap(spapr, SPAPR_CAP_CFPC);
+    uint8_t safe_bounds_check = spapr_get_cap(spapr, SPAPR_CAP_SBBC);
+    uint8_t safe_indirect_branch = spapr_get_cap(spapr, SPAPR_CAP_IBS);
+
+    switch (safe_cache) {
+    case SPAPR_CAP_WORKAROUND:
+        characteristics |= H_CPU_CHAR_L1D_FLUSH_ORI30;
+        characteristics |= H_CPU_CHAR_L1D_FLUSH_TRIG2;
+        characteristics |= H_CPU_CHAR_L1D_THREAD_PRIV;
+        behaviour |= H_CPU_BEHAV_L1D_FLUSH_PR;
+        break;
+    case SPAPR_CAP_FIXED:
+        break;
+    default: /* broken */
+        assert(safe_cache == SPAPR_CAP_BROKEN);
+        behaviour |= H_CPU_BEHAV_L1D_FLUSH_PR;
+        break;
+    }
+
+    switch (safe_bounds_check) {
+    case SPAPR_CAP_WORKAROUND:
+        characteristics |= H_CPU_CHAR_SPEC_BAR_ORI31;
+        behaviour |= H_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
+        break;
+    case SPAPR_CAP_FIXED:
+        break;
+    default: /* broken */
+        assert(safe_bounds_check == SPAPR_CAP_BROKEN);
+        behaviour |= H_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
+        break;
+    }
+
+    switch (safe_indirect_branch) {
+    case SPAPR_CAP_FIXED:
+        characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
+    default: /* broken */
+        assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
+        break;
+    }
+
+    args[0] = characteristics;
+    args[1] = behaviour;
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1733,6 +1787,10 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_INVALIDATE_PID, h_invalidate_pid);
     spapr_register_hypercall(H_REGISTER_PROC_TBL, h_register_process_table);
 
+    /* hcall-get-cpu-characteristics */
+    spapr_register_hypercall(H_GET_CPU_CHARACTERISTICS,
+                             h_get_cpu_characteristics);
+
     /* "debugger" hcalls (also used by SLOF). Note: We do -not- differenciate
      * here between the "CI" and the "CACHE" variants, they will use whatever
      * mapping attributes qemu is using. When using KVM, the kernel will
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 549d7a4134..62c077ac20 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -404,6 +404,7 @@ struct sPAPRMachineState {
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_GET_CPU_CHARACTERISTICS 0x1C8
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING          0x1D8
-- 
2.13.6
