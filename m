Received: from eggs.gnu.org ([2001:4830:134:3::10]:54257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfO-0006n0-11
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfM-0003QE-81
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:30 +1000
Message-Id: <20170915035130.8354-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/18] ppc/kvm: use kvm_vm_check_extension() in
 kvmppc_is_pr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

If the host has both KVM PR and KVM HV loaded and we pass:

	-machine pseries,accel=kvm,kvm-type=PR

the kvmppc_is_pr() returns false instead of true. Since the helper
is mostly used as fallback, it doesn't have any real impact with
recent kernels. A notable exception is the workaround to allow
migration between compatible hosts with different PVRs (eg, POWER8
and POWER8E), since KVM still doesn't provide a way to check if a
specific PVR is supported (see commit c363a37a450f for details).

According to the official KVM API documentation [1], KVM_PPC_GET_PVINFO
is "vm ioctl", but we check it as a global ioctl. The following function
in KVM is hence called with kvm == NULL and considers we're in HV mode.

int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
{
	int r;
	/* Assume we're using HV mode when the HV module is loaded */
	int hv_enabled = kvmppc_hv_ops ? 1 : 0;

	if (kvm) {
		/*
		 * Hooray - we know which VM type we're running on. Depend on
		 * that rather than the guess above.
		 */
		hv_enabled = is_kvmppc_hv_enabled(kvm);
	}

Let's use kvm_vm_check_extension() to fix the issue.

[1] https://www.kernel.org/doc/Documentation/virtual/kvm/api.txt

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6442dfcb95..1deaf106d2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -120,7 +120,7 @@ static void kvm_kick_cpu(void *opaque)
 static bool kvmppc_is_pr(KVMState *ks)
 {
     /* Assume KVM-PR if the GET_PVINFO capability is available */
-    return kvm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) != 0;
+    return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) != 0;
 }
 
 static int kvm_ppc_register_host_cpu_type(void);
-- 
2.13.5
