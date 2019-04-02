Received: from eggs.gnu.org ([209.51.188.92]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCUR-000891-SQ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCR7-0002T4-E9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:58:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  2 Apr 2019 16:40:26 +1100
Message-Id: <20190402054028.20926-4-david@gibson.dropbear.id.au>
In-Reply-To: <20190402054028.20926-1-david@gibson.dropbear.id.au>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC for-4.1 3/5] pcie: Remove redundant test in
 pcie_mmcfg_data_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

This function has an explicit test for accesses above the device's config
size, in which case it returns ~0x0.  But pci_host_config_read_common()
which it is about to call already has checks against the config space
limit and likewise returns ~0x0 in that case.  So, remove the redundant
test.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pcie_host.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 553db56778..8f4435838e 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -70,11 +70,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
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
