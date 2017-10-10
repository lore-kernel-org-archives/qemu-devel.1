Received: from eggs.gnu.org ([2001:4830:134:3::10]:55435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1uU9-0002J4-2w
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1uU3-0003Zx-7W
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:22:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 11 Oct 2017 00:21:59 +1100
Message-Id: <20171010132159.15787-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] spapr: Correct RAM size calculation for HPT
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
 hw/ppc/spapr_hcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8d72bb7c1c..06af1b15c0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -494,7 +494,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    current_ram_size = pc_existing_dimms_capacity(&error_fatal);
+    current_ram_size = ram_size + get_plugged_memory_size();
 
     /* We only allow the guest to allocate an HPT one order above what
      * we'd normally give them (to stop a small guest claiming a huge
-- 
2.13.6
