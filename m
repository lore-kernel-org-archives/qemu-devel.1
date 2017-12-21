Received: from eggs.gnu.org ([2001:4830:134:3::10]:45950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qm-00083o-MM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1ql-0005q4-LW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:32 -0500
Date: Thu, 21 Dec 2017 16:29:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-16-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/25] hw/block/nvme: QOM'ify PCI NVME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/nvme.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 441e21e..9c5f898 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -920,9 +920,9 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
-static int nvme_init(PCIDevice *pci_dev)
+static void nvme_realize(PCIDevice *pci, Error **errp)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
+    NvmeCtrl *n =3D NVME(pci);
     NvmeIdCtrl *id =3D &n->id_ctrl;
=20
     int i;
@@ -931,30 +931,33 @@ static int nvme_init(PCIDevice *pci_dev)
     Error *local_err =3D NULL;
=20
     if (!n->conf.blk) {
-        return -1;
+        error_setg(errp, "Block device missing");
+        return;
     }
=20
     bs_size =3D blk_getlength(n->conf.blk);
     if (bs_size < 0) {
-        return -1;
+        error_setg_errno(errp, -bs_size, "Could not get length of device=
");
+        return;
     }
=20
     blkconf_serial(&n->conf, &n->serial);
     if (!n->serial) {
-        return -1;
+        error_setg(errp, "Could not get device serial number");
+        return;
     }
     blkconf_blocksizes(&n->conf);
     blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk=
),
                                   false, &local_err);
     if (local_err) {
-        error_report_err(local_err);
-        return -1;
+        error_propagate(errp, local_err);
+        return;
     }
=20
-    pci_conf =3D pci_dev->config;
+    pci_conf =3D pci->config;
     pci_conf[PCI_INTERRUPT_PIN] =3D 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
+    pci_config_set_prog_interface(pci->config, 0x2);
+    pci_config_set_class(pci->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(&n->parent_obj, 0x80);
=20
     n->num_namespaces =3D 1;
@@ -1046,12 +1049,11 @@ static int nvme_init(PCIDevice *pci_dev)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
     }
-    return 0;
 }
=20
-static void nvme_exit(PCIDevice *pci_dev)
+static void nvme_exit(PCIDevice *pci)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
+    NvmeCtrl *n =3D NVME(pci);
=20
     nvme_clear_ctrl(n);
     g_free(n->namespaces);
@@ -1061,7 +1063,7 @@ static void nvme_exit(PCIDevice *pci_dev)
         memory_region_unref(&n->ctrl_mem);
     }
=20
-    msix_uninit_exclusive_bar(pci_dev);
+    msix_uninit_exclusive_bar(pci);
 }
=20
 static Property nvme_props[] =3D {
@@ -1081,7 +1083,7 @@ static void nvme_class_init(ObjectClass *oc, void *=
data)
     DeviceClass *dc =3D DEVICE_CLASS(oc);
     PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(oc);
=20
-    pc->init =3D nvme_init;
+    pc->realize =3D nvme_realize;
     pc->exit =3D nvme_exit;
     pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
--=20
MST
