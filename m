Received: from eggs.gnu.org ([2001:4830:134:3::10]:53829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlq-0001ii-Ew
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlm-000687-DL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:54 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:51324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsZlm-00067N-0R
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:50 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 01F2AABC7F
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 21:25:48 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 21:25:43 +0200
Message-ID: <150541714343.1616.11893912014879112098.stgit@bahia.lan>
In-Reply-To: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

The following capabilities are VM specific:
- KVM_CAP_PPC_SMT_POSSIBLE
- KVM_CAP_PPC_HTAB_FD
- KVM_CAP_PPC_ALLOC_HTAB

If both KVM HV and KVM PR are present, checking them always return
the HV value, even if we explicitely requested to use PR.

This has no visible effect for KVM_CAP_PPC_ALLOC_HTAB, because we also
try the KVM_PPC_ALLOCATE_HTAB ioctl which is only suppored by HV. As
a consequence, the spapr code doesn't even check KVM_CAP_PPC_HTAB_FD.

However, this will cause kvmppc_hint_smt_possible(), introduced by
commit fa98fbfcdfcb9, to report several VSMT modes (eg, Available
VSMT modes: 8 4 2 1) whereas PR only support mode 1.

This patch fixes all three anyway to use kvm_vm_check_extension(). It
is okay since the VM is already created at the time kvm_arch_init() or
kvmppc_reset_htab() is called.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1deaf106d2b9..208c70e81426 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -131,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_interrupt_level = kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL);
     cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
-    cap_ppc_smt_possible = kvm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
+    cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
     cap_ppc_rma = kvm_check_extension(s, KVM_CAP_PPC_RMA);
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
@@ -143,7 +143,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_ppc_watchdog = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_WATCHDOG);
     /* Note: we don't set cap_papr here, because this capability is
      * only activated after this by kvmppc_set_papr() */
-    cap_htab_fd = kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
+    cap_htab_fd = kvm_vm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls = kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
     cap_ppc_smt = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
@@ -2353,7 +2353,7 @@ int kvmppc_reset_htab(int shift_hint)
         /* Full emulation, tell caller to allocate htab itself */
         return 0;
     }
-    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
         int ret;
         ret = kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift);
         if (ret == -ENOTTY) {
