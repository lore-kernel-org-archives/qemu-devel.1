Received: from eggs.gnu.org ([208.118.235.92]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQt-0005wR-Ml
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQt-0005jb-1J
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:15 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 22:18:40 -0700
Message-Id: <1540876720-9574-5-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 4/4] nvme: use pci_dev directly in nvme_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

There is no need to make another reference.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a406c23..f63e344 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1235,7 +1235,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_dev->config, 0x2);
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
 
     n->num_namespaces = 1;
     n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
@@ -1247,10 +1247,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
-    pci_register_bar(&n->parent_obj, 0,
+    pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    if (msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL)) {
+    if (msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL)) {
         error_setg(errp, "msix_init_exclusive_bar failed");
         return;
     }
@@ -1308,7 +1308,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                               "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
             PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
 
-- 
1.8.3.1
