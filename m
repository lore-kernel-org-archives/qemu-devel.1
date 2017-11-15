Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GI-0003B2-Ds
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GE-0002rK-EH
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2GE-0002ql-7v
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:06 -0500
Date: Wed, 15 Nov 2017 20:17:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-3-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/10] pci: Initialize pci_dev->name before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This moves pci_dev->name initialization earlier so
pci_dev->bus_master_as could get a name instead of an empty string.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5ed3c8d..b2d139b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1030,6 +1030,7 @@ static PCIDevice *do_pci_register_device(PCIDevice =
*pci_dev, PCIBus *bus,
=20
     pci_dev->devfn =3D devfn;
     pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
+    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
=20
     memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci=
_dev),
                        "bus master container", UINT64_MAX);
@@ -1039,7 +1040,6 @@ static PCIDevice *do_pci_register_device(PCIDevice =
*pci_dev, PCIBus *bus,
     if (qdev_hotplug) {
         pci_init_bus_master(pci_dev);
     }
-    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     pci_dev->irq_state =3D 0;
     pci_config_alloc(pci_dev);
=20
--=20
MST
