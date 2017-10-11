Received: from eggs.gnu.org ([2001:4830:134:3::10]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Y8-0003gs-5j
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Y3-0004kt-VA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:07:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 11 Oct 2017 11:06:49 +1100
Message-Id: <20171011000649.22012-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2] spapr: Correct RAM size calculation for HPT
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lvivier@redhat.com, groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In order to prevent the guest from forcing the allocation of large amounts
of qemu memory (or host kernel memory, in the case of KVM HV), we limit
the size of Hashed Page Table (HPT) it is allowed to allocated, based on
its RAM size.

However, the current calculation is not correct: it only adds up the size
of plugged memory, ignoring the base memory size.  This patch corrects it.

While we're there, use get_plugged_memory_size() instead of directly
calling pc_existing_dimms_capacity().  The only difference is that it
will abort on failure, which is right: a failure here indicates something
wrong within qemu.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes in v2:
  * Also remove redundant initializer of current_ram_size

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8d72bb7c1c..0d59d1534d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -472,7 +472,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     target_ulong flags = args[0];
     int shift = args[1];
     sPAPRPendingHPT *pending = spapr->pending_hpt;
-    uint64_t current_ram_size = MACHINE(spapr)->ram_size;
+    uint64_t current_ram_size;
     int rc;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
@@ -494,7 +494,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    current_ram_size = pc_existing_dimms_capacity(&error_fatal);
+    current_ram_size = MACHINE(spapr)->ram_size + get_plugged_memory_size();
 
     /* We only allow the guest to allocate an HPT one order above what
      * we'd normally give them (to stop a small guest claiming a huge
-- 
2.13.6
