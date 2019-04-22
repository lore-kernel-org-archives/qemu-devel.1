Received: from eggs.gnu.org ([209.51.188.92]:57743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISzQ-0006vw-Ne
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISzO-0005PX-MI
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISzK-0005M2-M9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M6rmhn056878
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s13g88pt1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:34 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:33 +0100
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2019 12:33:26 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155591660602.20338.9804738040071843715.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log upon
 an MCE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com

Upon a machine check exception (MCE) in a guest address space,
KVM causes a guest exit to enable QEMU to build and pass the
error to the guest in the PAPR defined rtas error log format.

This patch builds the rtas error log, copies it to the rtas_addr
and then invokes the guest registered machine check handler. The
handler in the guest takes suitable action(s) depending on the type
and criticality of the error. For example, if an error is
unrecoverable memory corruption in an application inside the
guest, then the guest kernel sends a SIGBUS to the application.
For recoverable errors, the guest performs recovery actions and
logs the error.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |    4 +
 hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    4 +
 3 files changed, 253 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2779efe..ffd1715 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not get size of LPAR rtas '%s'", filename);
         exit(1);
     }
+
+    /* Resize blob to accommodate error log. */
+    spapr->rtas_size = spapr_get_rtas_size(spapr->rtas_size);
+
     spapr->rtas_blob = g_malloc(spapr->rtas_size);
     if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
         error_report("Could not load LPAR rtas '%s'", filename);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 9922a23..4032db0 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -212,6 +212,106 @@ struct hp_extended_log {
     struct rtas_event_log_v6_hp hp;
 } QEMU_PACKED;
 
+struct rtas_event_log_v6_mc {
+#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
+    struct rtas_event_log_v6_section_header hdr;
+    uint32_t fru_id;
+    uint32_t proc_id;
+    uint8_t error_type;
+#define RTAS_LOG_V6_MC_TYPE_UE                           0
+#define RTAS_LOG_V6_MC_TYPE_SLB                          1
+#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
+#define RTAS_LOG_V6_MC_TYPE_TLB                          4
+#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
+#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
+    uint8_t sub_err_type;
+#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
+#define RTAS_LOG_V6_MC_UE_IFETCH                         1
+#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
+#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
+#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
+#define RTAS_LOG_V6_MC_SLB_PARITY                        0
+#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
+#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
+#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
+#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
+#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
+#define RTAS_LOG_V6_MC_TLB_PARITY                        1
+#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
+#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
+    uint8_t reserved_1[6];
+    uint64_t effective_address;
+    uint64_t logical_address;
+} QEMU_PACKED;
+
+struct mc_extended_log {
+    struct rtas_event_log_v6 v6hdr;
+    struct rtas_event_log_v6_mc mc;
+} QEMU_PACKED;
+
+struct MC_ierror_table {
+    unsigned long srr1_mask;
+    unsigned long srr1_value;
+    bool nip_valid; /* nip is a valid indicator of faulting address */
+    uint8_t error_type;
+    uint8_t error_subtype;
+    unsigned int initiator;
+    unsigned int severity;
+};
+
+static const struct MC_ierror_table mc_ierror_table[] = {
+{ 0x00000000081c0000, 0x0000000000040000, true,
+  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000080000, true,
+  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x00000000000c0000, true,
+  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000100000, true,
+  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000140000, true,
+  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000000180000, true,
+  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0, 0, 0, 0, 0, 0 } };
+
+struct MC_derror_table {
+    unsigned long dsisr_value;
+    bool dar_valid; /* dar is a valid indicator of faulting address */
+    uint8_t error_type;
+    uint8_t error_subtype;
+    unsigned int initiator;
+    unsigned int severity;
+};
+
+static const struct MC_derror_table mc_derror_table[] = {
+{ 0x00008000, false,
+  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00004000, true,
+  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000800, true,
+  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000400, true,
+  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000080, true,
+  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PARITY */
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0x00000100, true,
+  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
+  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
+{ 0, false, 0, 0, 0, 0 } };
+
+#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
+
 typedef enum EventClass {
     EVENT_CLASS_INTERNAL_ERRORS     = 0,
     EVENT_CLASS_EPOW                = 1,
@@ -620,6 +720,147 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
 }
 
+ssize_t spapr_get_rtas_size(ssize_t old_rtas_size)
+{
+    g_assert(old_rtas_size < RTAS_ERRLOG_OFFSET);
+    return RTAS_ERROR_LOG_MAX;
+}
+
+static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
+                                        struct mc_extended_log *ext_elog)
+{
+    int i;
+    CPUPPCState *env = &cpu->env;
+    uint32_t summary;
+    uint64_t dsisr = env->spr[SPR_DSISR];
+
+    summary = RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
+    if (recovered) {
+        summary |= RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
+    } else {
+        summary |= RTAS_LOG_DISPOSITION_NOT_RECOVERED;
+    }
+
+    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
+        for (i = 0; mc_derror_table[i].dsisr_value; i++) {
+            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
+                continue;
+            }
+
+            ext_elog->mc.error_type = mc_derror_table[i].error_type;
+            ext_elog->mc.sub_err_type = mc_derror_table[i].error_subtype;
+            if (mc_derror_table[i].dar_valid) {
+                ext_elog->mc.effective_address = cpu_to_be64(env->spr[SPR_DAR]);
+            }
+
+            summary |= mc_derror_table[i].initiator
+                        | mc_derror_table[i].severity;
+
+            return summary;
+        }
+    } else {
+        for (i = 0; mc_ierror_table[i].srr1_mask; i++) {
+            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
+                    mc_ierror_table[i].srr1_value) {
+                continue;
+            }
+
+            ext_elog->mc.error_type = mc_ierror_table[i].error_type;
+            ext_elog->mc.sub_err_type = mc_ierror_table[i].error_subtype;
+            if (mc_ierror_table[i].nip_valid) {
+                ext_elog->mc.effective_address = cpu_to_be64(env->nip);
+            }
+
+            summary |= mc_ierror_table[i].initiator
+                        | mc_ierror_table[i].severity;
+
+            return summary;
+        }
+    }
+
+    summary |= RTAS_LOG_INITIATOR_CPU;
+    return summary;
+}
+
+static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUState *cs = CPU(cpu);
+    uint64_t rtas_addr;
+    CPUPPCState *env = &cpu->env;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong r3, msr = 0;
+    struct rtas_error_log log;
+    struct mc_extended_log *ext_elog;
+    uint32_t summary;
+
+    /*
+     * Properly set bits in MSR before we invoke the handler.
+     * SRR0/1, DAR and DSISR are properly set by KVM
+     */
+    if (!(*pcc->interrupts_big_endian)(cpu)) {
+        msr |= (1ULL << MSR_LE);
+    }
+
+    if (env->msr && (1ULL << MSR_SF)) {
+        msr |= (1ULL << MSR_SF);
+    }
+
+    msr |= (1ULL << MSR_ME);
+
+    if (spapr->guest_machine_check_addr == -1) {
+        /*
+         * This implies that we have hit a machine check between system
+         * reset and "ibm,nmi-register". Fall back to the old machine
+         * check behavior in such cases.
+         */
+        env->spr[SPR_SRR0] = env->nip;
+        env->spr[SPR_SRR1] = env->msr;
+        env->msr = msr;
+        env->nip = 0x200;
+        return;
+    }
+
+    ext_elog = g_malloc0(sizeof(struct mc_extended_log));
+    summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
+
+    log.summary = cpu_to_be32(summary);
+    log.extended_length = cpu_to_be32(sizeof(struct mc_extended_log));
+
+    /* r3 should be in BE always */
+    r3 = cpu_to_be64(env->gpr[3]);
+    env->msr = msr;
+
+    spapr_init_v6hdr(&ext_elog->v6hdr);
+    ext_elog->mc.hdr.section_id = cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MC);
+    ext_elog->mc.hdr.section_length =
+                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
+    ext_elog->mc.hdr.section_version = 1;
+
+    /* get rtas addr from fdt */
+    rtas_addr = spapr_get_rtas_addr();
+    if (!rtas_addr) {
+        /* Unable to fetch rtas_addr. Hence reset the guest */
+        ppc_cpu_do_system_reset(cs);
+    }
+
+    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET, &r3, sizeof(r3));
+    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3),
+                              &log, sizeof(log));
+    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3) +
+                              sizeof(log), ext_elog,
+                              sizeof(struct mc_extended_log));
+
+    /* Save gpr[3] in the guest endian mode */
+    if ((*pcc->interrupts_big_endian)(cpu)) {
+        env->gpr[3] = cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);
+    } else {
+        env->gpr[3] = cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
+    }
+
+    env->nip = spapr->guest_machine_check_addr;
+}
+
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
@@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
         }
     }
     spapr->mc_status = cpu->vcpu_id;
+
+    spapr_mce_dispatch_elog(cpu, recovered);
+
+    return;
 }
 
 static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f7204d0..03f34bf 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
 #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
 
+/* Offset from rtas-base where error log is placed */
+#define RTAS_ERRLOG_OFFSET       0x25
+
 static inline uint64_t ppc64_phys_to_real(uint64_t addr)
 {
     return addr & ~0xF000000000000000ULL;
@@ -798,6 +801,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
+ssize_t spapr_get_rtas_size(ssize_t old_rtas_sizea);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
