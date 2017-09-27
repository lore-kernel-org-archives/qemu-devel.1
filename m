Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70M-0001Qg-OD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70I-0003zY-Be
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:51 +1000
Message-Id: <20170927074316.4454-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/26] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1deaf106d2..208c70e814 100644
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
-- 
2.13.5
