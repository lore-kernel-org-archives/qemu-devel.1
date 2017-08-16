Received: from eggs.gnu.org ([2001:4830:134:3::10]:46484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNg-000165-SC
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNd-0004FE-FS
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58874
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dhuNd-0004F4-8f
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7G9AgRp088451
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ccfy8rt02-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:48 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 16 Aug 2017 03:12:47 -0600
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 14:42:39 +0530
In-Reply-To: <150287457293.9760.17827532208744487789.stgit@aravinda>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150287475974.9760.13295593936611613542.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v3 4/5] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com

Memory error such as bit flips that cannot be corrected
by hardware are passed on to the kernel for handling.
If the memory address in error belongs to guest then
guest kernel is responsible for taking suitable action.
Patch [1] enhances KVM to exit guest with exit reason
set to KVM_EXIT_NMI in such cases.

This patch handles KVM_EXIT_NMI exit. If the guest OS
has registered the machine check handling routine by
calling "ibm,nmi-register", then the handler builds
the error log and invokes the registered handler else
invokes the handler at 0x200.

[1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
	(e20bbd3d and related commits)

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c       |    4 ++
 target/ppc/kvm.c     |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h |   81 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0bb2c4a..6cc3f69 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2346,6 +2346,10 @@ static void ppc_spapr_init(MachineState *machine)
         error_report("Could not get size of LPAR rtas '%s'", filename);
         exit(1);
     }
+
+    /* Resize blob to accommodate error log. */
+    spapr->rtas_size = RTAS_ERRLOG_OFFSET + sizeof(struct RtasMCELog);
+
     spapr->rtas_blob = g_malloc(spapr->rtas_size);
     if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
         error_report("Could not load LPAR rtas '%s'", filename);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8571379..73f64ed 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1782,6 +1782,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = 0;
         break;
 
+    case KVM_EXIT_NMI:
+        DPRINTF("handle NMI exception\n");
+        ret = kvm_handle_nmi(cpu);
+        break;
+
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
@@ -2704,6 +2709,87 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return data & 0xffff;
 }
 
+int kvm_handle_nmi(PowerPCCPU *cpu)
+{
+    struct RtasMCELog mc_log;
+    CPUPPCState *env = &cpu->env;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong msr = 0;
+
+    cpu_synchronize_state(CPU(cpu));
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
+    env->msr = msr;
+
+    if (!spapr->guest_machine_check_addr) {
+        /*
+         * If OS has not registered with "ibm,nmi-register"
+         * jump to 0x200
+         */
+        env->nip = 0x200;
+        return 0;
+    }
+
+    while (spapr->mc_in_progress) {
+        /*
+         * Check whether the same CPU got machine check error
+         * while still handling the mc error (i.e., before
+         * that CPU called "ibm,nmi-interlock"
+         */
+        if (spapr->mc_cpu == cpu->cpu_dt_id) {
+            qemu_system_guest_panicked(NULL);
+        }
+        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
+    }
+    spapr->mc_in_progress = true;
+    spapr->mc_cpu = cpu->cpu_dt_id;
+
+    /* Set error log fields */
+    mc_log.r3 = env->gpr[3];
+    mc_log.err_log.byte0 = 0;
+    mc_log.err_log.byte1 =
+        (RTAS_SEVERITY_ERROR_SYNC << RTAS_ELOG_SEVERITY_SHIFT);
+    mc_log.err_log.byte1 |=
+        (RTAS_DISP_NOT_RECOVERED << RTAS_ELOG_DISPOSITION_SHIFT);
+    mc_log.err_log.byte2 =
+        (RTAS_INITIATOR_MEMORY << RTAS_ELOG_INITIATOR_SHIFT);
+    mc_log.err_log.byte2 |= RTAS_TARGET_MEMORY;
+
+    if (env->spr[SPR_DSISR] & P7_DSISR_MC_UE) {
+        mc_log.err_log.byte3 = RTAS_TYPE_ECC_UNCORR;
+    } else {
+        mc_log.err_log.byte3 = 0;
+    }
+
+    /* Handle all Host/Guest LE/BE combinations */
+    if (env->msr & (1ULL << MSR_LE)) {
+        mc_log.r3 = cpu_to_le64(mc_log.r3);
+    } else {
+        mc_log.r3 = cpu_to_be64(mc_log.r3);
+    }
+
+    cpu_physical_memory_write(spapr->rtas_addr + RTAS_ERRLOG_OFFSET,
+                              &mc_log, sizeof(mc_log));
+
+    env->nip = spapr->guest_machine_check_addr;
+    env->gpr[3] = spapr->rtas_addr + RTAS_ERRLOG_OFFSET;
+
+    return 0;
+}
+
 int kvmppc_enable_hwrng(void)
 {
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6bc6fb3..bc8e3ce 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -70,6 +70,87 @@ void kvmppc_update_sdr1(target_ulong sdr1);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
+int kvm_handle_nmi(PowerPCCPU *cpu);
+
+/* Offset from rtas-base where error log is placed */
+#define RTAS_ERRLOG_OFFSET       0x200
+
+#define RTAS_ELOG_SEVERITY_SHIFT         0x5
+#define RTAS_ELOG_DISPOSITION_SHIFT      0x3
+#define RTAS_ELOG_INITIATOR_SHIFT        0x4
+
+/*
+ * Only required RTAS event severity, disposition, initiator
+ * target and type are copied from arch/powerpc/include/asm/rtas.h
+ */
+
+/* RTAS event severity */
+#define RTAS_SEVERITY_ERROR_SYNC    0x3
+
+/* RTAS event disposition */
+#define RTAS_DISP_NOT_RECOVERED     0x2
+
+/* RTAS event initiator */
+#define RTAS_INITIATOR_MEMORY       0x4
+
+/* RTAS event target */
+#define RTAS_TARGET_MEMORY          0x4
+
+/* RTAS event type */
+#define RTAS_TYPE_ECC_UNCORR        0x09
+
+/*
+ * Currently KVM only passes on the uncorrected machine
+ * check memory error to guest. Other machine check errors
+ * such as SLB multi-hit and TLB multi-hit are recovered
+ * in KVM and are not passed on to guest.
+ *
+ * DSISR Bit for uncorrected machine check error. Based
+ * on arch/powerpc/include/asm/mce.h
+ */
+#define PPC_BIT(bit)                (0x8000000000000000ULL >> bit)
+#define P7_DSISR_MC_UE              (PPC_BIT(48))  /* P8 too */
+
+/* Adopted from kernel source arch/powerpc/include/asm/rtas.h */
+struct rtas_error_log {
+    /* Byte 0 */
+    uint8_t     byte0;          /* Architectural version */
+
+    /* Byte 1 */
+    uint8_t     byte1;
+    /* XXXXXXXX
+     * XXX      3: Severity level of error
+     *    XX    2: Degree of recovery
+     *      X   1: Extended log present?
+     *       XX 2: Reserved
+     */
+
+    /* Byte 2 */
+    uint8_t     byte2;
+    /* XXXXXXXX
+     * XXXX     4: Initiator of event
+     *     XXXX 4: Target of failed operation
+     */
+    uint8_t     byte3;          /* General event or error*/
+    __be32      extended_log_length;    /* length in bytes */
+    unsigned char   buffer[1];      /* Start of extended log */
+                                /* Variable length.      */
+};
+
+/*
+ * Data format in RTAS-Blob
+ *
+ * This structure contains error information related to Machine
+ * Check exception. This is filled up and copied to rtas-blob
+ * upon machine check exception. The address of rtas-blob is
+ * passed on to OS registered machine check notification
+ * routines upon machine check exception
+ */
+struct RtasMCELog {
+    target_ulong r3;
+    struct rtas_error_log err_log;
+};
+
 #else
 
 static inline uint32_t kvmppc_get_tbfreq(void)
