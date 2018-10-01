Received: from eggs.gnu.org ([2001:4830:134:3::10]:59070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747a-0005FO-Sp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747X-00056M-Lx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:46 -0400
Received: from mail-co1nam03on0614.outbound.protection.outlook.com
	([2a01:111:f400:fe48::614]:8231
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747W-00054U-Gf
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:42 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:34 +0000
Message-ID: <1538423049-29524-5-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 4/9] x86_iommu/amd: make the address space
 naming consistent with intel-iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

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
---
 hw/i386/amd_iommu.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7206bb0..4bec1c6 100644
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
@@ -1032,8 +1033,9 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegio=
n *iommu, hwaddr addr,
=20
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int d=
evfn)
 {
+    char name[128];
     AMDVIState *s =3D opaque;
-    AMDVIAddressSpace **iommu_as;
+    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num =3D pci_bus_num(bus);
=20
     iommu_as =3D s->address_spaces[bus_num];
@@ -1046,19 +1048,37 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *b=
us, void *opaque, int devfn)
=20
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
+        snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
+
         iommu_as[devfn] =3D g_malloc0(sizeof(AMDVIAddressSpace));
         iommu_as[devfn]->bus_num =3D (uint8_t)bus_num;
         iommu_as[devfn]->devfn =3D (uint8_t)devfn;
         iommu_as[devfn]->iommu_state =3D s;
=20
-        memory_region_init_iommu(&iommu_as[devfn]->iommu,
-                                 sizeof(iommu_as[devfn]->iommu),
+        amdvi_dev_as =3D iommu_as[devfn];
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
+                                            MEMORY_REGION(&amdvi_dev_as->i=
ommu),
+                                            1);
     }
     return &iommu_as[devfn]->as;
 }
--=20
2.7.4
