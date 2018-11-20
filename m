Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCqJ-0005tb-6b
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCqE-0003SW-TJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:55 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gPCqD-0003Q7-3q
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:50 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 21 Nov 2018 02:09:40 +0530
Message-ID: <1542746383-18288-3-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/5] Add save and load functions for VFIO PCI
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

Save and restore with MSIX type is not tested.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h | 29 ++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6cbb8fa0549d..72daf1a358a0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1234,6 +1234,101 @@ void vfio_pci_write_config(PCIDevice *pdev,
     }
 }
 
+void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar;
+
+        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
+        qemu_put_be32(f, bar);
+    }
+
+    qemu_put_be32(f, vdev->interrupt);
+    if (vdev->interrupt == VFIO_INT_MSI) {
+        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+        bool msi_64bit;
+
+        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                                            2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        msi_addr_lo = pci_default_read_config(pdev,
+                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
+        qemu_put_be32(f, msi_addr_lo);
+
+        if (msi_64bit) {
+            msi_addr_hi = pci_default_read_config(pdev,
+                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                             4);
+        }
+        qemu_put_be32(f, msi_addr_hi);
+
+        msi_data = pci_default_read_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                2);
+        qemu_put_be32(f, msi_data);
+    } else if (vdev->interrupt == VFIO_INT_MSIX) {
+        msix_save(pdev, f);
+    }
+}
+
+void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint32_t pci_cmd, interrupt_type;
+    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+    bool msi_64bit;
+    int i;
+
+    /* retore pci bar configuration */
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar = qemu_get_be32(f);
+
+        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
+    }
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                          pci_cmd | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
+
+    interrupt_type = qemu_get_be32(f);
+
+    if (interrupt_type == VFIO_INT_MSI) {
+        /* restore msi configuration */
+        msi_flags = pci_default_read_config(pdev,
+                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
+
+        msi_addr_lo = qemu_get_be32(f);
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
+                              msi_addr_lo, 4);
+
+        msi_addr_hi = qemu_get_be32(f);
+        if (msi_64bit) {
+            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                  msi_addr_hi, 4);
+        }
+        msi_data = qemu_get_be32(f);
+        vfio_pci_write_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                msi_data, 2);
+
+        vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
+    } else if (vdev->interrupt == VFIO_INT_MSIX) {
+        msix_load(pdev, f);
+    }
+}
+
 /*
  * Interrupt setup
  */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 52b065421a68..890d77d66a6b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -20,6 +20,7 @@
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 
+#ifdef CONFIG_LINUX
 #define PCI_ANY_ID (~0)
 
 struct VFIOPCIDevice;
@@ -198,4 +199,32 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
+void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+
+static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+
+    return OBJECT(vdev);
+}
+
+#else
+static inline void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    g_assert(false);
+}
+
+static inline void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    g_assert(false);
+}
+
+static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
+{
+    return NULL;
+}
+
+#endif
+
 #endif /* HW_VFIO_VFIO_PCI_H */
-- 
2.7.0
