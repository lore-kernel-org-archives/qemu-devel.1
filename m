Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyvQr-0000m2-8j
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyvQo-00006Z-Kj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:18:45 -0400
Received: from [107.173.13.209] (port=56465 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyvQo-00006N-ED
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:18:42 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 22 Mar 2018 19:18:37 +1100
Message-Id: <20180322081837.21460-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio: Print address space address when
 cannot map MMIO for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>

The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions") added
an error message if a passed memory section address or size is not aligned
to the minimal IOMMU page size. However although it checks
offset_within_address_space for the alignment, offset_within_region is
printed instead which makes it harder to find out what device caused
the message so this replaces offset_within_region with
offset_within_address_space.

While we are here, this replaces '..' with 'size=' (as the second number
is a size, not an end offset) and adds a memory region name.

Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Message on slightly hacked QEMU (iommu pagesize=8K) looks now like this:

qemu-system-x86_64: Region "0000:00:1a.0 BAR 0 mmaps[0]" 0xfebc0000 size=0x1000 is not aligned to 0x2000 and cannot be mapped for DMA
---
 hw/vfio/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5e84716..e2db596 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -548,10 +548,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
 
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
-            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
+            error_report("Region \"%s\" 0x%"HWADDR_PRIx" size=0x%"HWADDR_PRIx
                          " is not aligned to 0x%"HWADDR_PRIx
                          " and cannot be mapped for DMA",
-                         section->offset_within_region,
+                         memory_region_name(section->mr),
+                         section->offset_within_address_space,
                          int128_getlo(section->size),
                          pgmask + 1);
             return;
-- 
2.11.0
