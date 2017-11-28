Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eJjkb-00031r-J8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eJjkW-0001rJ-7D
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:32:53 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 28 Nov 2017 18:32:24 +0100
Message-Id: <20171128173224.1138-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

Migration of pseries is broken with TCG because
QEMU tries to restore KVM MMU state unconditionally.

The result is a SIGSEGV in kvm_vm_ioctl():

    at qemu/accel/kvm/kvm-all.c:2032
    radix=<optimized out>, gtse=<optimized out>, proc_tbl=<optimized out>)
    at qemu/target/ppc/kvm.c:396
    version_id=<optimized out>) at /home/lvivier/qemu/hw/ppc/spapr.c:1578
    vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
    version_id=<optimized out>) at /home/lvivier/qemu/migration/vmstate.c:165
    at qemu/migration/savevm.c:748

This patch fixes the problem by not calling the KVM function with the
TCG mode.

Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
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
2.13.6
