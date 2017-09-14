Received: from eggs.gnu.org ([2001:4830:134:3::10]:56820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsRgt-0005Dz-5X
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsRgp-0008NZ-1n
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:48:15 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:47414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsRgo-0008MA-Rb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:48:10 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 45C83A2DA7
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:48:09 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 12:48:04 +0200
Message-ID: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc/kvm: use kvm_vm_check_extension() in
 kvmppc_is_pr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

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
---
 target/ppc/kvm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6442dfcb95b3..1deaf106d2b9 100644
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
