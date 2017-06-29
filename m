Received: from eggs.gnu.org ([2001:4830:134:3::10]:46922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQRZ2-0005vg-48
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 01:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQRZ1-0006a4-AW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 01:00:24 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 29 Jun 2017 14:59:39 +1000
Message-Id: <20170629045940.11242-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Only set PCR in kvm if actually in
 a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The Processor Compatibility Register (PCR) I used to set the
compatibility mode of the processor using the SET_ONE_REG ioctl on
KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when a compat
mode was actually in use, however a recent patch made it unconditional.
Calling this in KVM_PR fails as there is no handler for that call and it
is thus impossible to start a machine with KVM_PR.

Change ppc_set_compat() so that the ioctl is only actually called if a
compat mode is in use. This means that a KVM_PR guest can boot.
Additionally the current behaviour for KVM_HV is preserved where a compat
mode of 0 set pcr and arch_compat in the vcore struct to zero, both of
which are initialised to zero anyway.

Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

Based on: dwg/ppc-for-2.10

 target/ppc/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f1b67fa..4482206 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -143,7 +143,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
     cpu->compat_pvr = compat_pvr;
     env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
 
-    if (kvm_enabled()) {
+    if (kvm_enabled() && compat_pvr) {
         int ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
-- 
2.9.4
