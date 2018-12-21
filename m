Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeI-00016x-TO
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeE-00005u-UU
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:00 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:56 +1100
Message-Id: <20181221054606.22007-31-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/40] spapr-iommu: Always advertise the maximum
 possible DMA window size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas_ddw.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 329feb148f..cb8a410359 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -96,9 +96,8 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cp=
u,
                                          uint32_t nret, target_ulong ret=
s)
 {
     sPAPRPHBState *sphb;
-    uint64_t buid, max_window_size;
+    uint64_t buid;
     uint32_t avail, addr, pgmask =3D 0;
-    MachineState *machine =3D MACHINE(spapr);
=20
     if ((nargs !=3D 3) || (nret !=3D 5)) {
         goto param_error_exit;
@@ -114,27 +113,15 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU=
 *cpu,
     /* Translate page mask to LoPAPR format */
     pgmask =3D spapr_page_mask_to_query_mask(sphb->page_size_mask);
=20
-    /*
-     * This is "Largest contiguous block of TCEs allocated specifically
-     * for (that is, are reserved for) this PE".
-     * Return the maximum number as maximum supported RAM size was in 4K=
 pages.
-     */
-    if (machine->ram_size =3D=3D machine->maxram_size) {
-        max_window_size =3D machine->ram_size;
-    } else {
-        max_window_size =3D machine->device_memory->base +
-                          memory_region_size(&machine->device_memory->mr=
);
-    }
-
     avail =3D SPAPR_PCI_DMA_MAX_WINDOWS - spapr_phb_get_active_win_num(s=
phb);
=20
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     rtas_st(rets, 1, avail);
-    rtas_st(rets, 2, max_window_size >> SPAPR_TCE_PAGE_SHIFT);
+    rtas_st(rets, 2, 0x80000000); /* The largest window we can possibly =
have */
     rtas_st(rets, 3, pgmask);
     rtas_st(rets, 4, 0); /* DMA migration mask, not supported */
=20
-    trace_spapr_iommu_ddw_query(buid, addr, avail, max_window_size, pgma=
sk);
+    trace_spapr_iommu_ddw_query(buid, addr, avail, 0x80000000, pgmask);
     return;
=20
 param_error_exit:
--=20
2.19.2
