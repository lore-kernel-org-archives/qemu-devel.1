Received: from eggs.gnu.org ([209.51.188.92]:54688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9J-0005Xi-Pz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9H-0003BA-Ts
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:21 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:11 +1000
Message-Id: <20190503055316.6441-9-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 08/13] target/ppc: Implement hcall
 H_SET_PARTITION_TABLE
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

The hcall H_SET_PARTITION_TABLE is used by a guest acting as a nested
hypervisor to register the partition table entry for one of its guests
with the real hypervisor.

Implement this hcall for a spapr guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c   | 22 ++++++++++++++++++++++
 include/hw/ppc/spapr.h |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4d7fe337a1..704ceff8e1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1828,6 +1828,25 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_set_partition_table(PowerPCCPU *cpu,
+                                          SpaprMachineState *spapr,
+                                          target_ulong opcode,
+                                          target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong ptcr = args[0];
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    if ((ptcr & PTCR_PATS) > 24)
+        return H_PARAMETER;
+
+    env->spr[SPR_PTCR] = ptcr;
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1934,6 +1953,9 @@ static void hypercall_register_types(void)
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
+    /* Platform-specific hcalls used for nested HV KVM */
+    spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
+
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
                              h_home_node_associativity);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4251215908..e591ee0ba0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -501,7 +501,9 @@ struct SpaprMachineState {
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
+/* Platform-specific hcalls used for nested HV KVM */
+#define H_SET_PARTITION_TABLE   0xF800
+#define KVMPPC_HCALL_MAX        H_SET_PARTITION_TABLE
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
-- 
2.13.6
