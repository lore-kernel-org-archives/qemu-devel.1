Received: from eggs.gnu.org ([2001:4830:134:3::10]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePXxF-000798-6W
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePXxB-0005rS-PB
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:09:57 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 14 Dec 2017 19:09:48 +0100
Message-Id: <20171214180948.981-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: don't initialize PATB entry if
 max-cpu-compat < power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Laurent Vivier <lvivier@redhat.com>

if KVM is enabled and KVM capabilities MMU radix is available,
the partition table entry (patb_entry) for the radix mode is
initialized by default in ppc_spapr_reset().

It's a problem if we want to migrate the guest to a POWER8 host
while the kernel is not started to set the value to the one
expected for a POWER8 CPU.

The "-machine max-cpu-compat=power8" should allow to migrate
a POWER9 KVM host to a POWER8 KVM host, but because patb_entry
is set, the destination QEMU tries to enable radix mode on the
POWER8 host. This fails and cancels the migration:

    Process table config unsupported by the host
    error while loading state for instance 0x0 of device 'spapr'
    load of migration failed: Invalid argument

This patch doesn't set the PATB entry if the user provides
a CPU compatibility mode that doesn't support radix mode.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1ac7eb0f8c..66d0ed5256 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1440,7 +1440,10 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
-    if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
+    first_ppc_cpu = POWERPC_CPU(first_cpu);
+    if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
+        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                         spapr->max_compat_pvr)) {
         /* If using KVM with radix mode available, VCPUs can be started
          * without a HPT because KVM will start them in radix mode.
          * Set the GR bit in PATB so that we know there is no HPT. */
@@ -1499,7 +1502,6 @@ static void ppc_spapr_reset(void)
     g_free(fdt);
 
     /* Set up the entry state */
-    first_ppc_cpu = POWERPC_CPU(first_cpu);
     first_ppc_cpu->env.gpr[3] = fdt_addr;
     first_ppc_cpu->env.gpr[5] = 0;
     first_cpu->halted = 0;
-- 
2.14.3
