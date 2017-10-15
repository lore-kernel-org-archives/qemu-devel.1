Received: from eggs.gnu.org ([2001:4830:134:3::10]:59169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3aU4-0007mY-Gl
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 00:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3aU1-00015o-DL
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 00:25:04 -0400
Received: from ozlabs.ru ([107.173.13.209]:52658)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3aU1-00015i-7N
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 00:25:01 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sun, 15 Oct 2017 15:24:52 +1100
Message-Id: <20171015042452.31714-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH qemu v2 REPOST] pci: Initialize pci_dev->name
 before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>

This moves pci_dev->name initialization earlier so
pci_dev->bus_master_as could get a name instead of an empty string.

Reviewed-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Changes:
v2:
* fixed mistype in the commit log
* added "rb"
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88eba..05c5f75ef0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1020,6 +1020,7 @@ static PCIDevice *do_pci_register_device(PCIDevice =
*pci_dev, PCIBus *bus,
=20
     pci_dev->devfn =3D devfn;
     pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
+    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
=20
     memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci=
_dev),
                        "bus master container", UINT64_MAX);
@@ -1029,7 +1030,6 @@ static PCIDevice *do_pci_register_device(PCIDevice =
*pci_dev, PCIBus *bus,
     if (qdev_hotplug) {
         pci_init_bus_master(pci_dev);
     }
-    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     pci_dev->irq_state =3D 0;
     pci_config_alloc(pci_dev);
=20
--=20
2.11.0
