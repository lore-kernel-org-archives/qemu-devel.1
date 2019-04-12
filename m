Received: from eggs.gnu.org ([209.51.188.92]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt5T-0003df-TV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt5S-0005n7-Rw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:07:11 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:54 +0200
Message-Id: <20190412100354.6409-28-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 27/27] vfio-pci: Implement the DMA fault
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com, vincent.stehle@arm.com

Whenever the eventfd is triggered, we retrieve the DMA faults
from the mmapped fault region and inject them in the iommu
memory region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89399a290f..fcbb92cf27 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2820,10 +2820,63 @@ static void vfio_unregister_req_notifier(VFIOPCID=
evice *vdev)
 static void vfio_dma_fault_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev =3D opaque;
+    PCIDevice *pdev =3D &vdev->pdev;
+    AddressSpace *as =3D pci_device_iommu_address_space(pdev);
+    IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+    struct vfio_region_fault_prod header;
+    struct iommu_fault *queue;
+    char *queue_buffer =3D NULL;
+    ssize_t bytes;
=20
     if (!event_notifier_test_and_clear(&vdev->dma_fault_notifier)) {
         return;
     }
+
+    if (!vdev->fault_prod_region.size || !vdev->fault_cons_region.size) =
{
+        return;
+    }
+
+    bytes =3D pread(vdev->vbasedev.fd, &header, sizeof(header),
+                  vdev->fault_prod_region.fd_offset);
+    if (bytes !=3D sizeof(header)) {
+        error_report("%s unable to read the fault region header (0x%lx)"=
,
+                     __func__, bytes);
+        return;
+    }
+
+    /* Normally the fault queue is mmapped */
+    queue =3D (struct iommu_fault *)vdev->fault_prod_region.mmaps[0].mma=
p;
+    if (!queue) {
+        size_t queue_size =3D header.nb_entries * header.entry_size;
+
+        error_report("%s: fault queue not mmapped: slower fault handling=
",
+                     vdev->vbasedev.name);
+
+        queue_buffer =3D g_malloc(queue_size);
+        bytes =3D  pread(vdev->vbasedev.fd, queue_buffer, queue_size,
+                       vdev->fault_prod_region.fd_offset + header.offset=
);
+        if (bytes !=3D queue_size) {
+            error_report("%s unable to read the fault queue (0x%lx)",
+                         __func__, bytes);
+            return;
+        }
+
+        queue =3D (struct iommu_fault *)queue_buffer;
+    }
+
+    while (vdev->fault_cons_index !=3D header.prod) {
+        memory_region_inject_faults(iommu_mr, 1,
+                                    &queue[vdev->fault_cons_index]);
+        vdev->fault_cons_index =3D
+            (vdev->fault_cons_index + 1) % header.nb_entries;
+    }
+    bytes =3D pwrite(vdev->vbasedev.fd, &vdev->fault_cons_index, 4,
+                   vdev->fault_cons_region.fd_offset + 4);
+    if (bytes !=3D 4) {
+        error_report("%s unable to write the fault region cons index (0x=
%lx)",
+                     __func__, bytes);
+    }
+    g_free(queue_buffer);
 }
=20
 static void vfio_register_dma_fault_notifier(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 24ec43ac81..aef69c4487 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -138,6 +138,7 @@ typedef struct VFIOPCIDevice {
     EventNotifier dma_fault_notifier;
     VFIORegion fault_prod_region;
     VFIORegion fault_cons_region;
+    uint32_t fault_cons_index;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
--=20
2.20.1
