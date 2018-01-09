Received: from eggs.gnu.org ([2001:4830:134:3::10]:48191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eYq65-0006RW-Ay
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eYq64-0001L4-73
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:21:29 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue,  9 Jan 2018 20:21:03 +1100
Message-Id: <20180109092103.18458-4-sjitindarsingh@gmail.com>
In-Reply-To: <20180109092103.18458-1-sjitindarsingh@gmail.com>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [RFC 3/3] target/ppc: Add H-Call
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
based on the setting of the new capabilities added in the previous
patch.

Note: Currently we return H_FUNCTION under TCG which will direct the
      guest to fall back to doing a displacement flush

Discussion:
Is TCG affected?
Is there any point in telling the guest to do these workarounds on TCG
given they're unlikely to translate to host instructions which have the
desired effect?
---
 hw/ppc/spapr_hcall.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 82 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 51eba52e86..b62b47c8d9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1654,6 +1654,84 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+#define CPU_CHARACTERISTIC_SPEC_BARRIER         (1ULL << (63 - 0))
+#define CPU_CHARACTERISTIC_BCCTR_SERIAL         (1ULL << (63 - 1))
+#define CPU_CHARACTERISTIC_ORI_L1_CACHE         (1ULL << (63 - 2))
+#define CPU_CHARACTERISTIC_MTTRIG_L1_CACHE      (1ULL << (63 - 3))
+#define CPU_CHARACTERISTIC_L1_CACHE_PRIV        (1ULL << (63 - 4))
+#define CPU_CHARACTERISTIC_BRANCH_HINTS         (1ULL << (63 - 5))
+#define CPU_CHARACTERISTIC_MTTRIG_THR_RECONF    (1ULL << (63 - 6))
+#define CPU_BEHAVIOUR_FAVOUR_SECURITY           (1ULL << (63 - 0))
+#define CPU_BEHAVIOUR_L1_CACHE_FLUSH            (1ULL << (63 - 1))
+#define CPU_BEHAVIOUR_SPEC_BARRIER              (1ULL << (63 - 2))
+
+static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
+                                              sPAPRMachineState *spapr,
+                                              target_ulong opcode,
+                                              target_ulong *args)
+{
+    uint64_t characteristics = CPU_CHARACTERISTIC_BRANCH_HINTS;
+    uint64_t behaviour = CPU_BEHAVIOUR_FAVOUR_SECURITY;
+    uint8_t safe_cache = spapr_get_cap(spapr, SPAPR_CAP_CFPC);
+    uint8_t safe_bounds_check = spapr_get_cap(spapr, SPAPR_CAP_SBBC);
+    uint8_t safe_indirect_branch = spapr_get_cap(spapr, SPAPR_CAP_IBS);
+
+    /* TODO: Is TCG vulnerable? */
+    if (!kvm_enabled()) {
+        return H_FUNCTION;
+    }
+
+    switch (safe_cache) {
+    case SPAPR_CAP_WORKAROUND:
+        characteristics |= CPU_CHARACTERISTIC_ORI_L1_CACHE;
+        characteristics |= CPU_CHARACTERISTIC_MTTRIG_L1_CACHE;
+        characteristics |= CPU_CHARACTERISTIC_L1_CACHE_PRIV;
+        behaviour |= CPU_BEHAVIOUR_L1_CACHE_FLUSH;
+        break;
+    case SPAPR_CAP_FIXED:
+        break;
+    default: /* broken */
+        if (safe_cache != SPAPR_CAP_BROKEN) {
+            error_report("Invalid value for KVM_CAP_PPC_SAFE_CACHE (%d), assuming broken",
+                         safe_cache);
+        }
+        behaviour |= CPU_BEHAVIOUR_L1_CACHE_FLUSH;
+        break;
+    }
+
+    switch (safe_bounds_check) {
+    case SPAPR_CAP_WORKAROUND:
+        characteristics |= CPU_CHARACTERISTIC_SPEC_BARRIER;
+        behaviour |= CPU_BEHAVIOUR_SPEC_BARRIER;
+        break;
+    case SPAPR_CAP_FIXED:
+        break;
+    default: /* broken */
+        if (safe_bounds_check != SPAPR_CAP_BROKEN) {
+            error_report("Invalid value for KVM_CAP_PPC_SAFE_BOUNDS_CHECK (%d), assuming broken",
+                         safe_bounds_check);
+        }
+        behaviour |= CPU_BEHAVIOUR_SPEC_BARRIER;
+        break;
+    }
+
+    switch (safe_indirect_branch) {
+    case SPAPR_CAP_FIXED:
+        characteristics |= CPU_CHARACTERISTIC_BCCTR_SERIAL;
+    default: /* broken */
+        if (safe_indirect_branch != SPAPR_CAP_BROKEN) {
+            error_report("Invalid value for KVM_CAP_PPC_SAFE_INDIRECT_BRANCH (%d), assuming broken",
+                         safe_indirect_branch);
+        }
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
 
@@ -1733,6 +1811,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_INVALIDATE_PID, h_invalidate_pid);
     spapr_register_hypercall(H_REGISTER_PROC_TBL, h_register_process_table);
 
+    /* hcall-get-cpu-characteristics */
+    spapr_register_hypercall(H_GET_CPU_CHARACTERISTICS, h_get_cpu_characteristics);
+
     /* "debugger" hcalls (also used by SLOF). Note: We do -not- differenciate
      * here between the "CI" and the "CACHE" variants, they will use whatever
      * mapping attributes qemu is using. When using KVM, the kernel will
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2db2f3e2e2..5677c38d2a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -396,6 +396,7 @@ struct sPAPRMachineState {
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_GET_CPU_CHARACTERISTICS 0x1C8
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING          0x1D8
-- 
2.13.6
