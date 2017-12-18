Received: from eggs.gnu.org ([2001:4830:134:3::10]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx75-0005dE-Hr
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx6A-0000mK-Pz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:13:55 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 12:12:41 -0300
Message-Id: <20171218151244.9975-2-f4bug@amsat.org>
In-Reply-To: <20171218151244.9975-1-f4bug@amsat.org>
References: <20171218151244.9975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] hw/block/nvme: QOM'ify PCI NVME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/nvme.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 441e21ed1f..9c5f898da0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -920,9 +920,9 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
-static int nvme_init(PCIDevice *pci_dev)
+static void nvme_realize(PCIDevice *pci, Error **errp)
 {
-    NvmeCtrl *n = NVME(pci_dev);
+    NvmeCtrl *n = NVME(pci);
     NvmeIdCtrl *id = &n->id_ctrl;
 
     int i;
@@ -931,30 +931,33 @@ static int nvme_init(PCIDevice *pci_dev)
     Error *local_err = NULL;
 
     if (!n->conf.blk) {
-        return -1;
+        error_setg(errp, "Block device missing");
+        return;
     }
 
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
-        return -1;
+        error_setg_errno(errp, -bs_size, "Could not get length of device");
+        return;
     }
 
     blkconf_serial(&n->conf, &n->serial);
     if (!n->serial) {
-        return -1;
+        error_setg(errp, "Could not get device serial number");
+        return;
     }
     blkconf_blocksizes(&n->conf);
     blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                   false, &local_err);
     if (local_err) {
-        error_report_err(local_err);
-        return -1;
+        error_propagate(errp, local_err);
+        return;
     }
 
-    pci_conf = pci_dev->config;
+    pci_conf = pci->config;
     pci_conf[PCI_INTERRUPT_PIN] = 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
+    pci_config_set_prog_interface(pci->config, 0x2);
+    pci_config_set_class(pci->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(&n->parent_obj, 0x80);
 
     n->num_namespaces = 1;
@@ -1046,12 +1049,11 @@ static int nvme_init(PCIDevice *pci_dev)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
     }
-    return 0;
 }
 
-static void nvme_exit(PCIDevice *pci_dev)
+static void nvme_exit(PCIDevice *pci)
 {
-    NvmeCtrl *n = NVME(pci_dev);
+    NvmeCtrl *n = NVME(pci);
 
     nvme_clear_ctrl(n);
     g_free(n->namespaces);
@@ -1061,7 +1063,7 @@ static void nvme_exit(PCIDevice *pci_dev)
         memory_region_unref(&n->ctrl_mem);
     }
 
-    msix_uninit_exclusive_bar(pci_dev);
+    msix_uninit_exclusive_bar(pci);
 }
 
 static Property nvme_props[] = {
@@ -1081,7 +1083,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
-    pc->init = nvme_init;
+    pc->realize = nvme_realize;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
-- 
2.15.1
