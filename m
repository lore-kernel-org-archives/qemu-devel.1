Received: from eggs.gnu.org ([209.51.188.92]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0006J5-SN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0008Kw-0v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 24 Apr 2019 14:19:57 +1000
Message-Id: <20190424041959.4087-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190424041959.4087-1-david@gibson.dropbear.id.au>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, qemu-ppc@nongnu.org

These functions have an explicit test for accesses above the device's
config size.  But pci_host_config_{read,write}_common() which they're
about to call already have checks against the config space limit and
do the right thing.  So, remove the redundant tests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pcie_host.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 553db56778..1ee4945a6d 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr=
 mmcfg_addr,
     }
     addr =3D PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit =3D pci_config_size(pci_dev);
-    if (limit <=3D addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <=3D addr < 4K has no effects. */
-        return;
-    }
     pci_host_config_write_common(pci_dev, addr, limit, val, len);
 }
=20
@@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
     }
     addr =3D PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit =3D pci_config_size(pci_dev);
-    if (limit <=3D addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <=3D addr < 4K has no effects. */
-        return ~0x0;
-    }
     return pci_host_config_read_common(pci_dev, addr, limit, len);
 }
=20
--=20
2.20.1
