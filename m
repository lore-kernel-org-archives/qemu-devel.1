Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjm-0005Yu-LE
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjl-0004LR-SJ
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Dec 2017 14:48:00 +1100
Message-Id: <20171204034802.7336-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171204034802.7336-1-david@gibson.dropbear.id.au>
References: <20171204034802.7336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/3] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Migration of pseries is broken with TCG because
QEMU tries to restore KVM MMU state unconditionally.

The result is a SIGSEGV in kvm_vm_ioctl():

  #0  kvm_vm_ioctl (s=0x0, type=-2146390353)
      at qemu/accel/kvm/kvm-all.c:2032
  #1  0x00000001003e3e2c in kvmppc_configure_v3_mmu (cpu=<optimized out>,
      radix=<optimized out>, gtse=<optimized out>, proc_tbl=<optimized out>)
      at qemu/target/ppc/kvm.c:396
  #2  0x00000001002f8b88 in spapr_post_load (opaque=0x1019103c0,
      version_id=<optimized out>) at qemu/hw/ppc/spapr.c:1578
  #3  0x000000010059e4cc in vmstate_load_state (f=0x106230000,
      vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
      version_id=<optimized out>) at qemu/migration/vmstate.c:165
  #4  0x00000001005987e0 in vmstate_load (f=<optimized out>, se=<optimized out>)
      at qemu/migration/savevm.c:748

This patch fixes the problem by not calling the KVM function with the
TCG mode.

Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9efddeaee5..a471de6cab 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1570,7 +1570,7 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
-    if (spapr->patb_entry) {
+    if (kvm_enabled() && spapr->patb_entry) {
         PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
         bool radix = !!(spapr->patb_entry & PATBE1_GR);
         bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
-- 
2.14.3
