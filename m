Received: from eggs.gnu.org ([2001:4830:134:3::10]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjX-0002CB-CN
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjW-0005yl-4Z
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eHnjV-0005y8-U9
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:46 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 23 Nov 2017 17:23:31 +0800
Message-Id: <20171123092333.16085-2-peterx@redhat.com>
In-Reply-To: <20171123092333.16085-1-peterx@redhat.com>
References: <20171123092333.16085-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] pci: Initialize pci_dev->name before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <rth@twiddle.net>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This moves pci_dev->name initialization earlier so
pci_dev->bus_master_as could get a name instead of an empty string.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5ed3c8dca4..b2d139bd9a 100644
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
2.14.3
