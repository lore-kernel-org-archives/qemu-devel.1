Received: from eggs.gnu.org ([2001:4830:134:3::10]:53455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixT-0003kh-CD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixR-0004pM-79
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:35 +1100
Message-Id: <20171215055435.24204-25-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/24] spapr: don't initialize PATB entry if
 max-cpu-compat < power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4f354a8760..6785a90c60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1466,7 +1466,10 @@ static void spapr_machine_reset(void)
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
@@ -1525,7 +1528,6 @@ static void spapr_machine_reset(void)
     g_free(fdt);
 
     /* Set up the entry state */
-    first_ppc_cpu = POWERPC_CPU(first_cpu);
     first_ppc_cpu->env.gpr[3] = fdt_addr;
     first_ppc_cpu->env.gpr[5] = 0;
     first_cpu->halted = 0;
-- 
2.14.3
