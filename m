Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j1-0005dA-5Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8it-00089C-Ds
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46846
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8it-00088j-7W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJo5078816
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:06 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyj9209vb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:04 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:04 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:02 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-42-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 41/54] target/ppc: Clean up probing of VMX,
 VSX and DFP availability on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

When constructing the "host" cpu class we modify whether the VMX and VSX
vector extensions and DFP (Decimal Floating Point) are available
based on whether KVM can support those instructions.  This can depend on
policy in the host kernel as well as on the actual host cpu capabilities.

However, the way we probe for this is not very nice: we explicitly check
the host's device tree.  That works in practice, but it's not really
correct, since the device tree is a property of the host kernel's platform
which we don't really know about.  We get away with it because the only
modern POWER platforms happen to encode VMX, VSX and DFP availability in
the device tree in the same way.

Arguably we should have an explicit KVM capability for this, but we haven't
needed one so far.  Barring specific KVM policies which don't yet exist,
each of these instruction classes will be available in the guest if and
only if they're available in the qemu userspace process.  We can determine
that from the ELF AUX vector we're supplied with.

Once reworked like this, there are no more callers for kvmppc_get_vmx() and
kvmppc_get_dfp() so remove them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 3f2ca480eb872b4946baf77f756236b637a5b15a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/kvm.c     | 27 ++++++---------------------
 target/ppc/kvm_ppc.h |  2 --
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9d57debf0e..81d9bd56c7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2014,16 +2014,6 @@ uint64_t kvmppc_get_clockfreq(void)
     return kvmppc_read_int_cpu_dt("clock-frequency");
 }
 
-uint32_t kvmppc_get_vmx(void)
-{
-    return kvmppc_read_int_cpu_dt("ibm,vmx");
-}
-
-uint32_t kvmppc_get_dfp(void)
-{
-    return kvmppc_read_int_cpu_dt("ibm,dfp");
-}
-
 static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pvinfo)
  {
      PowerPCCPU *cpu = ppc_env_get_cpu(env);
@@ -2407,23 +2397,18 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
 static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-    uint32_t vmx = kvmppc_get_vmx();
-    uint32_t dfp = kvmppc_get_dfp();
     uint32_t dcache_size = kvmppc_read_int_cpu_dt("d-cache-size");
     uint32_t icache_size = kvmppc_read_int_cpu_dt("i-cache-size");
 
     /* Now fix up the class with information we can query from the host */
     pcc->pvr = mfpvr();
 
-    if (vmx != -1) {
-        /* Only override when we know what the host supports */
-        alter_insns(&pcc->insns_flags, PPC_ALTIVEC, vmx > 0);
-        alter_insns(&pcc->insns_flags2, PPC2_VSX, vmx > 1);
-    }
-    if (dfp != -1) {
-        /* Only override when we know what the host supports */
-        alter_insns(&pcc->insns_flags2, PPC2_DFP, dfp);
-    }
+    alter_insns(&pcc->insns_flags, PPC_ALTIVEC,
+                qemu_getauxval(AT_HWCAP) & PPC_FEATURE_HAS_ALTIVEC);
+    alter_insns(&pcc->insns_flags2, PPC2_VSX,
+                qemu_getauxval(AT_HWCAP) & PPC_FEATURE_HAS_VSX);
+    alter_insns(&pcc->insns_flags2, PPC2_DFP,
+                qemu_getauxval(AT_HWCAP) & PPC_FEATURE_HAS_DFP);
 
     if (dcache_size != -1) {
         pcc->l1_dcache_size = dcache_size;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index d6be38ecaf..ecb55493cc 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -15,8 +15,6 @@
 
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
-uint32_t kvmppc_get_vmx(void);
-uint32_t kvmppc_get_dfp(void);
 bool kvmppc_get_host_model(char **buf);
 bool kvmppc_get_host_serial(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
-- 
2.11.0
