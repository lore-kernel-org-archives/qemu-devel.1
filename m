Received: from eggs.gnu.org ([2001:4830:134:3::10]:54370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Egi-0000h1-LY
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 18:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Egh-0005tH-Pk
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 18:00:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:16 -0300
Message-Id: <20170417215916.12431-8-ehabkost@redhat.com>
In-Reply-To: <20170417215916.12431-1-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 7/7] pci: Set phb->bus inside
 pci_bus_new_inplace()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Every single caller of pci_bus_new_inplace() sets phb->bus to point to
'bus'. Do that inside pci_bus_new_inplace() to avoid code duplication
and make it harder to break.

Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci-host/prep.c      | 2 --
 hw/pci-host/versatile.c | 1 -
 hw/pci/pci.c            | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 2e2cd267f4..6efa5bc5ef 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -284,8 +284,6 @@ static void raven_pcihost_initfn(Object *obj)
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
     pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
=20
-    h->bus =3D &s->pci_bus;
-
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DE=
VICE);
     pci_dev =3D DEVICE(&s->pci_dev);
     qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 24ef87610b..630f1ac1c5 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -389,7 +389,6 @@ static void pci_vpb_init(Object *obj)
     pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), h, "pci",
                         &s->pci_mem_space, &s->pci_io_space,
                         PCI_DEVFN(11, 0), TYPE_PCI_BUS);
-    h->bus =3D &s->pci_bus;
=20
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PC=
I_HOST);
     qdev_set_parent_bus(DEVICE(&s->pci_dev), BUS(&s->pci_bus));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 486aeb7514..ef226f8b41 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -397,6 +397,7 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size=
,
 {
     qbus_create_inplace(bus, bus_size, typename, DEVICE(phb), name);
     pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_mi=
n);
+    phb->bus =3D bus;
 }
=20
 PCIBus *pci_bus_new(PCIHostState *phb, const char *name,
--=20
2.11.0.259.g40922b1
