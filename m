Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMUGr-0002s3-Q9
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMU70-0006iR-IJ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:31:55 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 13 Nov 2018 19:31:02 +1100
Message-Id: <20181113083104.2692-6-aik@ozlabs.ru>
In-Reply-To: <20181113083104.2692-1-aik@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu RFC 5/7] spapr-iommu: Always advertise the
 maximum possible DMA window size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>

When deciding about the huge DMA window, the typical Linux pseries guest
uses the maximum allowed RAM size as the upper limit. We did the same
on QEMU side to match that logic. Now we are going to support GPU RAM
pass through which is not available at the guest boot time as it requires
the guest driver interaction. As the result, the guest requests a smaller
window than it should. Therefore the guest needs to be patched to
understand this new memory and so does QEMU.

Instead of reimplementing here whatever solution we will choose for
the guest, this advertises the biggest possible window size limited by
32 bit (as defined by LoPAPR).

This seems to be safe as:
1. The guest visible emulated table is allocated in KVM (actual pages
are allocated in page fault handler) and QEMU (actual pages are allocated
when changed);
2. The hardware table (and corresponding userspace addresses cache)
supports sparse allocation and also checks for locked_vm limit so
it is unable to cause the host any damage.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 329feb1..df60351 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -96,9 +96,8 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
                                          uint32_t nret, target_ulong rets)
 {
     sPAPRPHBState *sphb;
-    uint64_t buid, max_window_size;
+    uint64_t buid;
     uint32_t avail, addr, pgmask = 0;
-    MachineState *machine = MACHINE(spapr);
 
     if ((nargs != 3) || (nret != 5)) {
         goto param_error_exit;
@@ -114,27 +113,15 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
     /* Translate page mask to LoPAPR format */
     pgmask = spapr_page_mask_to_query_mask(sphb->page_size_mask);
 
-    /*
-     * This is "Largest contiguous block of TCEs allocated specifically
-     * for (that is, are reserved for) this PE".
-     * Return the maximum number as maximum supported RAM size was in 4K pages.
-     */
-    if (machine->ram_size == machine->maxram_size) {
-        max_window_size = machine->ram_size;
-    } else {
-        max_window_size = machine->device_memory->base +
-                          memory_region_size(&machine->device_memory->mr);
-    }
-
     avail = SPAPR_PCI_DMA_MAX_WINDOWS - spapr_phb_get_active_win_num(sphb);
 
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     rtas_st(rets, 1, avail);
-    rtas_st(rets, 2, max_window_size >> SPAPR_TCE_PAGE_SHIFT);
+    rtas_st(rets, 2, 0xFFFFFFFF); /* Largest contiguous block of TCEs */
     rtas_st(rets, 3, pgmask);
     rtas_st(rets, 4, 0); /* DMA migration mask, not supported */
 
-    trace_spapr_iommu_ddw_query(buid, addr, avail, max_window_size, pgmask);
+    trace_spapr_iommu_ddw_query(buid, addr, avail, 0xFFFFFFFF, pgmask);
     return;
 
 param_error_exit:
-- 
2.17.1
