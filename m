Received: from eggs.gnu.org ([2001:4830:134:3::10]:33694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant9-0000pn-WF
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant6-0005TN-Rd
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eant6-0005St-Jy
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0EJO3wY074230
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:10 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ffpquws5q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:09 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sun, 14 Jan 2018 14:24:08 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sun, 14 Jan 2018 17:23:49 -0200
In-Reply-To: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
References: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
Message-Id: <20180114192349.22212-3-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] ppc: spapr: Check if thread argument is
 supported by host KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, lvivier@redhat.com

QEMU currently checks whether SMT passed is valid or not. However, it
doesn't check if KVM supports such mode when kvm is enabled.

This patch relies on KVM_CAP_PPC_SMT_POSSIBLE to make it sure that QEMU
will either set a valid SMT mode or warn an error message and quit.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c       | 10 ++++++++++
 target/ppc/kvm.c     |  5 +++++
 target/ppc/kvm_ppc.h |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d1acfe8858..aed4d25fc4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2261,12 +2261,22 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
                      "on a pseries machine");
         goto out;
     }
+
     if (!is_power_of_2(smp_threads)) {
         error_setg(&local_err, "Cannot support %d threads/core on a pseries "
                      "machine because it must be a power of 2", smp_threads);
         goto out;
     }
 
+    if (kvm_enabled() && kvmppc_cap_smt_possible() > 0) {
+        if ((kvmppc_cap_smt_possible() & smp_threads) != smp_threads) {
+            error_setg(&local_err, "KVM does not support %d threads/core.",
+                    smp_threads);
+            kvmppc_hint_smt_possible(&local_err);
+            goto out;
+        }
+    }
+
     /* Detemine the VSMT mode to use: */
     if (vsmt_user) {
         if (spapr->vsmt < smp_threads) {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 914be687e7..4a8ff4d63c 100644
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
index ecb55493cc..2221850723 100644
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
+    return 0;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.14.3
