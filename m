Received: from eggs.gnu.org ([2001:4830:134:3::10]:47860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eXceA-0000W4-Ku
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eXce6-0002K2-Lp
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eXce6-0002JP-BM
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:34 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w060i5dU142864
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 19:47:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fahhkn48j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:47:32 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 19:47:31 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 22:47:22 -0200
In-Reply-To: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
Message-Id: <20180106004722.1152-2-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Power9 supports 4 HW threads/core but it's possible to emulate
doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
which returns a bitmap with all SMT modes supported by the host.

Today, QEMU forces the SMT mode based on PVR compat table, this is
silently done in spapr_fixup_cpu_dt. Then, if user passes thread=8 the
guest will end up with 4 threads/core without any feedback to the user.
It is confusing and will crash QEMU if a cpu is hotplugged in that
guest.

This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
supports the SMT mode so it allows Power9 guests to have 8 threads/core
if desired.

Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c       | 14 +++++++++++++-
 hw/ppc/trace-events  |  1 +
 target/ppc/kvm.c     |  5 +++++
 target/ppc/kvm_ppc.h |  6 ++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d1acfe8858..ea2503cd2f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -345,7 +345,19 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = spapr_vcpu_id(cpu);
-        int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
+
+        /* set smt to maximum for this current pvr if the number
+         * passed is higher than defined by PVR compat mode AND
+         * if KVM cannot emulate it.*/
+        int compat_smt = smp_threads;
+        if ((kvmppc_cap_smt_possible() & smp_threads) != smp_threads &&
+                smp_threads > ppc_compat_max_threads(cpu)) {
+            compat_smt = ppc_compat_max_threads(cpu);
+
+            trace_spapr_fixup_cpu_smt(index, smp_threads,
+                    kvmppc_cap_smt_possible(),
+                    ppc_compat_max_threads(cpu));
+        }
 
         if ((index % smt) != 0) {
             continue;
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index b7c3e64b5e..a8e29d7ab1 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -16,6 +16,7 @@ spapr_irq_alloc(int irq) "irq %d"
 spapr_irq_alloc_block(int first, int num, bool lsi, int align) "first irq %d, %d irqs, lsi=%d, alignnum %d"
 spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d irqs"
 spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free"
+spapr_fixup_cpu_smt(int idx, int smpt, int kvmt, int pvrt) "CPU(%d): expected smt %d, kvm support %d, max smt pvr %d"
 
 # hw/ppc/spapr_hcall.c
 spapr_cas_pvr_try(uint32_t pvr) "0x%x"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 518dd06e98..aac5667bf4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2456,6 +2456,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+int kvmppc_cap_smt_possible(void)
+{
+    return cap_ppc_smt_possible;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index ecb55493cc..6ac33d2b4a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
+int kvmppc_cap_smt_possible(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -290,6 +291,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
     return false;
 }
 
+static inline int kvmppc_cap_smt_possible(void)
+{
+    return -1;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.14.1
