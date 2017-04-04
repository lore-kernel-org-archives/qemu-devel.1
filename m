Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvQUQ-0005iG-DK
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvQUP-0006rl-9g
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cvQUP-0006rA-4U
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:25 -0400
Date: Tue, 4 Apr 2017 18:35:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1491320063-12719-2-git-send-email-mst@redhat.com>
References: <1491320063-12719-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491320063-12719-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] pci: Only unmap bus_master_enabled_region
 if was added previously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, jcody@redhat.com

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Normally pci_init_bus_master() would be called either via
bus->machine_done.notify or directly from do_pci_register_device().

However if a device's realize() failed, pci_init_bus_master() is not
called, and do_pci_unregister_device() fails on
memory_region_del_subregion() as it was not mapped.

This adds a check that subregion was mapped before unmapping it.

Fixes: c53598ed18e4 ("pci: Add missing drop of bus master AS reference")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
---
 hw/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bd8043c..259483b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -869,8 +869,10 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     pci_dev->bus->devices[pci_dev->devfn] = NULL;
     pci_config_free(pci_dev);
 
-    memory_region_del_subregion(&pci_dev->bus_master_container_region,
-                                &pci_dev->bus_master_enable_region);
+    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {
+        memory_region_del_subregion(&pci_dev->bus_master_container_region,
+                                    &pci_dev->bus_master_enable_region);
+    }
     address_space_destroy(&pci_dev->bus_master_as);
 }
 
-- 
MST
