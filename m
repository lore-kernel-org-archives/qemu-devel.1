Received: from eggs.gnu.org ([2001:4830:134:3::10]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavyi-00055r-05
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavye-0002so-TB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38019
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavye-0002sW-N8
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:57:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172ruS6139775
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:57:56 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ew5e273q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:57:55 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:57:52 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:46 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <0de3d80bc7658aac7dc5f6b271045463b572c7ff.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 3/9] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
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

Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
information from KVM and present the page encodings in the device tree
under ibm,processor-radix-AP-encodings. This provides page size
information to the guest which is necessary for it to use radix mode.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c   |  7 +++++++
 target/ppc/cpu.h |  5 +++++
 target/ppc/kvm.c | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a642e663d4..d629e2630c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -496,6 +496,13 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu,
                                 ppc_get_compat_smt_threads(cpu)));
+
+    if (env->radix_page_info.count) {
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
+                          env->radix_page_info.entries,
+                          env->radix_page_info.count *
+                          sizeof(env->radix_page_info.entries[0]))));
+    }
 }
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index afb7ddbdd0..5a96d98b6f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -914,6 +914,10 @@ struct ppc_segment_page_sizes {
     struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
 };
 
+struct ppc_radix_page_info {
+    uint32_t count;
+    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
+};
 
 /*****************************************************************************/
 /* The whole PowerPC CPU context */
@@ -1053,6 +1057,7 @@ struct CPUPPCState {
     ppc_slb_t vrma_slb;
     target_ulong rmls;
     bool ci_large_pages;
+    struct ppc_radix_page_info radix_page_info;
 #endif
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ec92c64159..390d6342cc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -328,6 +328,18 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
     kvm_get_fallback_smmu_info(cpu, info);
 }
 
+static bool kvm_get_rmmu_info(PowerPCCPU *cpu, struct kvm_ppc_rmmu_info *info)
+{
+    CPUState *cs = CPU(cpu);
+    int ret;
+
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_MMU_RADIX)) {
+        ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_RMMU_INFO, info);
+        return (ret == 0);
+    }
+    return false;
+}
+
 static long gethugepagesize(const char *mem_path)
 {
     struct statfs fs;
@@ -441,9 +453,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
     static struct kvm_ppc_smmu_info smmu_info;
     static bool has_smmu_info;
+    static struct kvm_ppc_rmmu_info rmmu_info;
+    static bool has_rmmu_info;
     CPUPPCState *env = &cpu->env;
     long rampagesize;
-    int iq, ik, jq, jk;
+    int iq, ik, jq, jk, i;
     bool has_64k_pages = false;
 
     /* We only handle page sizes for 64-bit server guests for now */
@@ -508,6 +522,22 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     if (!has_64k_pages) {
         env->mmu_model &= ~POWERPC_MMU_64K;
     }
+
+    /* Collect radix page info from kernel if not already */
+    if (!has_rmmu_info) {
+        env->radix_page_info.count = 0;
+        if (kvm_get_rmmu_info(cpu, &rmmu_info)) {
+            for (i = 0; i < 8; i++) {
+                if (rmmu_info.ap_encodings[i]) {
+                    env->radix_page_info.entries[i] =
+                        cpu_to_be32(rmmu_info.ap_encodings[i]);
+                    env->radix_page_info.count++;
+                }
+            }
+        }
+        has_rmmu_info = true;
+    }
+
 }
 #else /* defined (TARGET_PPC64) */
 
-- 
2.11.0
