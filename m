Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz6-0005Om-0H
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz3-0002yd-KA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40732
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavz3-0002xn-FM
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:21 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172s2Sx086588
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:58:20 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28euqw6b0n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:58:20 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:58:16 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:49 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <fe7cb0c915e6c88f090e7167410165bf0e7d14bc.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 6/9] spapr: Add h_register_process_table()
 hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Both radix and hash modes require guests to use
h_register_process_table() to set up the MMU. Implement it using the
new KVM ioctl KVM_PPC_CONFIGURE_V3_MMU.

This hypercall is also necessary for fully emulated guests, so it will
need to be reworked to integrate with Suraj's TCG patchset.
---
 hw/ppc/spapr_hcall.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 target/ppc/kvm.c       | 12 ++++++++++++
 target/ppc/kvm_ppc.h   |  1 +
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c9bb6624c4..4de511c386 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1049,6 +1049,50 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
     return H_SUCCESS;
 }
 
+static target_ulong h_register_process_table(PowerPCCPU *cpu,
+                                             sPAPRMachineState *spapr,
+                                             target_ulong opcode,
+                                             target_ulong *args)
+{
+    static target_ulong last_process_table;
+    target_ulong flags = args[0];
+    target_ulong proc_tbl = args[1];
+    target_ulong page_size = args[2];
+    target_ulong table_size = args[3];
+    uint64_t cflags, cproc;
+
+    cflags = (flags & 4) ? KVM_PPC_MMUV3_RADIX : 0;
+    cflags |= (flags & 1) ? KVM_PPC_MMUV3_GTSE : 0;
+    cproc = (flags & 4) ? (1ul << 63) : 0;
+    if (!(flags & 0x10)) {
+        if ((last_process_table & (1ul << 63)) != cproc) {
+            return H_PARAMETER;
+        }
+        cproc = last_process_table;
+    } else if (!(flags & 0x8)) {
+        ; /* do nothing */
+    } else if (flags & 4) {
+        /* radix */
+        if (table_size > 24 || (proc_tbl & 0xfff) || (proc_tbl >> 60)) {
+            return H_PARAMETER;
+        }
+        cproc |= proc_tbl | table_size;
+    } else {
+        /* hash, possibly with process table */
+        if (table_size > 24 || (proc_tbl >> 38) || page_size > 7) {
+            return H_PARAMETER;
+        }
+        cproc = (proc_tbl << 25) | (page_size << 5) | table_size;
+    }
+    last_process_table = cproc;
+    fprintf(stderr, "calling config mmu flags=%lx proctbl=%lx\n",
+            cflags, cproc);
+    if  (!kvmppc_configure_v3_mmu(cpu, cflags, cproc)) {
+        return H_HARDWARE;
+    }
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1136,6 +1180,10 @@ static void hypercall_register_types(void)
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
+
+    /* Power9 MMU support */
+    spapr_register_hypercall(H_REGISTER_PROCESS_TABLE,
+                             h_register_process_table);
 }
 
 type_init(hypercall_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd5bcf70de..92bda0f36d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -347,7 +347,8 @@ struct sPAPRMachineState {
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
-#define MAX_HCALL_OPCODE        H_SET_MODE
+#define H_REGISTER_PROCESS_TABLE 0x37C
+#define MAX_HCALL_OPCODE        H_REGISTER_PROCESS_TABLE
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8d6fd1b067..0d1443616c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -344,6 +344,18 @@ static bool kvm_get_rmmu_info(PowerPCCPU *cpu, struct kvm_ppc_rmmu_info *info)
     return false;
 }
 
+bool kvmppc_configure_v3_mmu(PowerPCCPU *cpu, uint64_t flags, uint64_t proc_tbl)
+{
+    CPUState *cs = CPU(cpu);
+    int ret;
+    struct kvm_ppc_mmuv3_cfg cfg;
+
+    cfg.flags = flags;
+    cfg.process_table = proc_tbl;
+    ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_CONFIGURE_V3_MMU, &cfg);
+    return ret == 0;
+}
+
 static long gethugepagesize(const char *mem_path)
 {
     struct statfs fs;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 1c1b94847c..0b8b77583a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -33,6 +33,7 @@ int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_set_tcr(PowerPCCPU *cpu);
 int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
+bool kvmppc_configure_v3_mmu(PowerPCCPU *cpu, uint64_t flags, uint64_t proctbl);
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
-- 
2.11.0
