Received: from eggs.gnu.org ([2001:4830:134:3::10]:45933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXeyg-0006hH-GM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 23:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXeyd-0007WV-CC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 23:21:30 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 14 Dec 2018 15:21:22 +1100
Message-Id: <20181214042122.101921-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] spapr-iommu: Always advertise the
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When deciding about the huge DMA window, the typical Linux pseries guest
uses the maximum allowed RAM size as the upper limit. We did the same
on QEMU side to match that logic. Now we are going to support a GPU RAM
pass through which is not available at the guest boot time as it requires
the guest driver interaction. As the result, the guest requests a smaller
window than it should. Therefore the guest needs to be patched to
understand this new memory and so does QEMU.

Instead of reimplementing here whatever solution we choose for the guest,
this advertises the biggest possible window size limited by 32 bit
(as defined by LoPAPR). Since the window size has to be power-of-two
(the create rtas call receives a window shift, not a size),
this uses 0x8000.0000 as the maximum number of TCEs possible (rather than
32bit maximum of 0xffff.ffff).

This is safe as:
1. The guest visible emulated table is allocated in KVM (actual pages
are allocated in page fault handler) and QEMU (actual pages are allocated
when updated);
2. The hardware table (and corresponding userspace address table)
supports sparse allocation and also checks for locked_vm limit so
it is unable to cause the host any damage.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* replaced 0xFFFFFFFF with 0x80000000 as a top limit
---
 hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 329feb1..cb8a410 100644
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
+    rtas_st(rets, 2, 0x80000000); /* The largest window we can possibly have */
     rtas_st(rets, 3, pgmask);
     rtas_st(rets, 4, 0); /* DMA migration mask, not supported */
 
-    trace_spapr_iommu_ddw_query(buid, addr, avail, max_window_size, pgmask);
+    trace_spapr_iommu_ddw_query(buid, addr, avail, 0x80000000, pgmask);
     return;
 
 param_error_exit:
-- 
2.17.1
