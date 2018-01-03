Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabZ-00018k-3E
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabX-0001uL-Tc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:14 +1100
Message-Id: <20180103042419.14520-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180103042419.14520-1-david@gibson.dropbear.id.au>
References: <20180103042419.14520-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/15] target/ppc: Clean up probing of VMX,
 VSX and DFP availability on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
---
 target/ppc/kvm.c     | 27 ++++++---------------------
 target/ppc/kvm_ppc.h |  2 --
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4664a3ce9d..518dd06e98 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2011,16 +2011,6 @@ uint64_t kvmppc_get_clockfreq(void)
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
@@ -2404,23 +2394,18 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
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
2.14.3
