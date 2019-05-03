Received: from eggs.gnu.org ([209.51.188.92]:54832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9W-0005lI-H2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9V-0003P4-84
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:34 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:14 +1000
Message-Id: <20190503055316.6441-12-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 11/13] target/ppc: Implement hcall
 H_COPY_TOFROM_GUEST
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

The hcall H_COPY_TOFROM_GUEST of used by a guest acting as a nested
hypervisor to access quadrants since quadrant access is hypervisor
privileged.

Translate the guest address to be accessed, map the memory and perform
the access on behalf of the guest. If the parameters are invalid, the
address can't be translated or the memory cannot be mapped then fail
the access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h   |  3 +-
 target/ppc/mmu-radix64.c |  7 ++---
 target/ppc/mmu-radix64.h |  4 +++
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index a84d5e2163..a370d70500 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -17,6 +17,7 @@
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/ppc.h"
+#include "mmu-radix64.h"
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
@@ -2158,6 +2159,78 @@ static target_ulong h_nested_tlb_invalidate(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode, target_ulong *args)
+{
+    target_ulong lpid = args[0];
+    target_ulong pid = args[1];
+    vaddr eaddr = args[2];
+    target_ulong gp_to = args[3];
+    target_ulong gp_from = args[4];
+    target_ulong n = args[5];
+    int is_load = !!gp_to;
+    void *from, *to;
+    int prot, psize;
+    hwaddr raddr, to_len, from_len;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    if ((gp_to && gp_from) || (!gp_to && !gp_from)) {
+        return H_PARAMETER;
+    }
+
+    if (eaddr & (0xFFFUL << 52)) {
+        return H_PARAMETER;
+    }
+
+    if (!lpid) {
+        return H_PARAMETER;
+    }
+
+    /* Translate eaddr to raddr */
+    if (ppc_radix64_xlate(cpu, eaddr, is_load, lpid, pid, 1, &raddr, &psize,
+                          &prot, 0)) {
+        return H_NOT_FOUND;
+    }
+    if (((raddr & ((1UL << psize) - 1)) + n) >= (1UL << psize)) {
+        return H_PARAMETER;
+    }
+
+    if (is_load) {
+        gp_from = raddr;
+    } else {
+        gp_to = raddr;
+    }
+
+    /* Map the memory regions and perform a memory copy */
+    from = cpu_physical_memory_map(gp_from, &from_len, 0);
+    if (!from) {
+        return H_NOT_FOUND;
+    }
+    if (from_len < n) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        return H_PARAMETER;
+    }
+    to = cpu_physical_memory_map(gp_to, &to_len, 1);
+    if (!to) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        return H_PARAMETER;
+    }
+    if (to_len < n) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        cpu_physical_memory_unmap(to, to_len, 1, 0);
+        return H_PARAMETER;
+    }
+    memcpy(to, from, n);
+    cpu_physical_memory_unmap(from, from_len, 0, n);
+    cpu_physical_memory_unmap(to, to_len, 1, n);
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -2268,6 +2341,7 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
     spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
     spapr_register_hypercall(H_TLB_INVALIDATE, h_nested_tlb_invalidate);
+    spapr_register_hypercall(H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6a614c445f..d62f4108d4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -505,7 +505,8 @@ struct SpaprMachineState {
 #define H_SET_PARTITION_TABLE   0xF800
 #define H_ENTER_NESTED          0xF804
 #define H_TLB_INVALIDATE        0xF808
-#define KVMPPC_HCALL_MAX        H_TLB_INVALIDATE
+#define H_COPY_TOFROM_GUEST     0xF80C
+#define KVMPPC_HCALL_MAX        H_COPY_TOFROM_GUEST
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 6118ad1b00..2a8147fc38 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -429,10 +429,9 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     return true;
 }
 
-static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
-                             uint64_t lpid, uint64_t pid, bool relocation,
-                             hwaddr *raddr, int *psizep, int *protp,
-                             bool cause_excp)
+int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lpid,
+                      uint64_t pid, bool relocation, hwaddr *raddr, int *psizep,
+                      int *protp, bool cause_excp)
 {
     CPUPPCState *env = &cpu->env;
     ppc_v3_pate_t pate;
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 96228546aa..c0bbd5c332 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -66,6 +66,10 @@ static inline int ppc_radix64_get_prot_amr(PowerPCCPU *cpu)
            (iamr & 0x1 ? 0 : PAGE_EXEC);
 }
 
+int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lpid,
+                      uint64_t pid, bool relocation, hwaddr *raddr, int *psizep,
+                      int *protp, bool cause_excp);
+
 #endif /* TARGET_PPC64 */
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.13.6
