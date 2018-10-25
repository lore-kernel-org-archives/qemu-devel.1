Received: from eggs.gnu.org ([2001:4830:134:3::10]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTu6-00036E-6O
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTu5-0005BT-9l
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFTu4-00059Y-Up
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:53:37 -0400
Date: Wed, 24 Oct 2018 20:53:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025005110.249256-11-mst@redhat.com>
References: <20181025005110.249256-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025005110.249256-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/28] x86_iommu/amd: make the address space
 naming consistent with intel-iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

From: "Singh, Brijesh" <brijesh.singh@amd.com>

To be consistent with intel-iommu:

- rename the address space to use '_' instead of '-'
- update the memory region relationships

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7206bb09c2..4bec1c6688 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -55,6 +55,7 @@ struct AMDVIAddressSpace {
     uint8_t bus_num;            /* bus number                           */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
+    MemoryRegion root;          /* AMDVI Root memory map region */
     IOMMUMemoryRegion iommu;    /* Device's address translation region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
@@ -1032,8 +1033,9 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
 
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
+    char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as;
+    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
 
     iommu_as = s->address_spaces[bus_num];
@@ -1046,19 +1048,37 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
+        snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
+
         iommu_as[devfn] = g_malloc0(sizeof(AMDVIAddressSpace));
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
 
-        memory_region_init_iommu(&iommu_as[devfn]->iommu,
-                                 sizeof(iommu_as[devfn]->iommu),
+        amdvi_dev_as = iommu_as[devfn];
+
+        /*
+         * Memory region relationships looks like (Address range shows
+         * only lower 32 bits to make it short in length...):
+         *
+         * |-----------------+-------------------+----------|
+         * | Name            | Address range     | Priority |
+         * |-----------------+-------------------+----------+
+         * | amdvi_root      | 00000000-ffffffff |        0 |
+         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
+         * |-----------------+-------------------+----------|
+         */
+        memory_region_init_iommu(&amdvi_dev_as->iommu,
+                                 sizeof(amdvi_dev_as->iommu),
                                  TYPE_AMD_IOMMU_MEMORY_REGION,
                                  OBJECT(s),
-                                 "amd-iommu", UINT64_MAX);
-        address_space_init(&iommu_as[devfn]->as,
-                           MEMORY_REGION(&iommu_as[devfn]->iommu),
-                           "amd-iommu");
+                                 "amd_iommu", UINT64_MAX);
+        memory_region_init(&amdvi_dev_as->root, OBJECT(s),
+                           "amdvi_root", UINT64_MAX);
+        address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
+                                            MEMORY_REGION(&amdvi_dev_as->iommu),
+                                            1);
     }
     return &iommu_as[devfn]->as;
 }
-- 
MST
