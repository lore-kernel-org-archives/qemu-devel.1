Received: from eggs.gnu.org ([209.51.188.92]:37794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0io-0000DQ-AL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0im-0000BK-Bl
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:49 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:42 +0100
Message-Id: <20190131005945.20149-11-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] nvme: use pci_dev directly in nvme_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Li Qiang <liq3ea@163.com>

There is no need to make another reference.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190120055558.32984-4-liq3ea@163.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0b77b49b36..8325b5e88a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1238,7 +1238,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     pci_conf[PCI_INTERRUPT_PIN] =3D 1;
     pci_config_set_prog_interface(pci_dev->config, 0x2);
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
=20
     n->num_namespaces =3D 1;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
@@ -1250,10 +1250,10 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
-    pci_register_bar(&n->parent_obj, 0,
+    pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
=20
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
@@ -1308,7 +1308,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                               "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
             PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
=20
--=20
2.20.1
