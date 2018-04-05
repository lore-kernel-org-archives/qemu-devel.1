Received: from eggs.gnu.org ([2001:4830:134:3::10]:50024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f49pU-0007i2-6m
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f49pQ-0005TI-4T
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f49pP-0005T2-Sk
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24541C027412
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 18:41:43 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 05 Apr 2018 12:41:42 -0600
Message-ID: <152295368832.13263.4543726266690410170.stgit@w520.home>
In-Reply-To: <152295356408.13263.6740252773525355794.stgit@w520.home>
References: <152295356408.13263.6740252773525355794.stgit@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.12 1/1] vfio: Use a trace point when a RAM
 section cannot be DMA mapped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Commit 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions")
added an error message if a passed memory section address or size
is not aligned to the page size and thus cannot be DMA mapped.

This patch fixes the trace by printing the region name and the
memory region section offset within the address space (instead of
offset_within_region).

We also turn the error_report into a trace event. Indeed, In some
cases, the traces can be confusing to non expert end-users and
let think the use case does not work (whereas it works as before).

This is the case where a BAR is successively mapped at different
GPAs and its sections are not compatible with dma map. The listener
is called several times and traces are issued for each intermediate
mapping.  The end-user cannot easily match those GPAs against the
final GPA output by lscpi. So let's keep those information to
informed users. In mid term, the plan is to advise the user about
BAR relocation relevance.

Fixes: 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c     |   11 +++++------
 hw/vfio/trace-events |    1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5e8471621800..07ffa0ba1062 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -548,12 +548,11 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
         hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
=20
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
index 79f63a2ff6f7..20109cb7581f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,6 +90,7 @@ vfio_iommu_map_notify(const char *op, uint64_t iova_sta=
rt, uint64_t iova_end) "i
 vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING re=
gion_add 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add=
 [iommu] 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, voi=
d *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
+vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uin=
t64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=3D0x%"PRI=
x64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING re=
gion_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"P=
RIx64" - 0x%"PRIx64
 vfio_disconnect_container(int fd) "close container->fd=3D%d"
