Received: from eggs.gnu.org ([209.51.188.92]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl675-00061t-AJ
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl674-0004SZ-Ip
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:43 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 19 Jan 2019 21:55:58 -0800
Message-Id: <20190120055558.32984-4-liq3ea@163.com>
In-Reply-To: <20190120055558.32984-1-liq3ea@163.com>
References: <20190120055558.32984-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] nvme: use pci_dev directly in nvme_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com, philmd@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

There is no need to make another reference.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0b77b49b36..8325b5e88a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1238,7 +1238,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_dev->config, 0x2);
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
 
     n->num_namespaces = 1;
     n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
@@ -1250,10 +1250,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
-    pci_register_bar(&n->parent_obj, 0,
+    pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -1308,7 +1308,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                               "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
             PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
 
-- 
2.17.1
