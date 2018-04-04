Received: from eggs.gnu.org ([2001:4830:134:3::10]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3p47-000790-Da
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3p43-0005Jb-Fk
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:31:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1f3p43-0005JK-Ae
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:31:27 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed,  4 Apr 2018 22:30:50 +0200
Message-Id: <1522873850-28733-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for 2.12] vfio: Use a trace point when a RAM
 section cannot be DMA mapped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: aik@ozlabs.ru

The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions")
added an error message if a passed memory section address or size
is not aligned to the page size and thus cannot be DMA mapped.

This patch fixes the trace by printing the region name and the
memory region section offset within the address space (instead of
offset_within_region).

We also turn the error_report into a trace event. Indeed, In some
cases, the traces can be confusing to non expert end-users and
let think the use case does not work (whereas it
works as before).

This is the case where a BAR is successively mapped at different
GPAs and its sections are not compatible with dma map. The listener
is called several times and traces are issued for each intermediate
mapping.  The end-user cannot easily match those GPAs against the
final GPA output by lscpi. So let's keep those information to
informed users. In mid term, the plan is to advise the user about
BAR relocation relevance.

Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- use a trace point
- add some details in the commit message
---
 hw/vfio/common.c     | 11 +++++------
 hw/vfio/trace-events |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5e84716..07ffa0b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -548,12 +548,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
 
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
-            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
-                         " is not aligned to 0x%"HWADDR_PRIx
-                         " and cannot be mapped for DMA",
-                         section->offset_within_region,
-                         int128_getlo(section->size),
-                         pgmask + 1);
+            trace_vfio_listener_region_add_no_dma_map(
+                memory_region_name(section->mr),
+                section->offset_within_address_space,
+                int128_getlo(section->size),
+                pgmask + 1);
             return;
         }
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 79f63a2..20109cb 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,6 +90,7 @@ vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "i
 vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
+vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_disconnect_container(int fd) "close container->fd=%d"
-- 
2.5.5
