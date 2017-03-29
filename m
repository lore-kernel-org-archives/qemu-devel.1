Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fr-0002rq-5l
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fp-0006KW-SC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ct2Fp-0006KC-Ls
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:29 -0400
Date: Wed, 29 Mar 2017 04:18:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490750257-19907-3-git-send-email-mst@redhat.com>
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490750257-19907-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] pci: Add missing drop of bus master AS
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The recent introduction of a bus master container added
memory_region_add_subregion() into the PCI device registering path but
missed memory_region_del_subregion() in the unregistering path leaving
a reference to the root memory region of the new container.

This adds missing memory_region_del_subregion().

Fixes: 3716d5902d743 ("pci: introduce a bus master container")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1..bd8043c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     pci_dev->bus->devices[pci_dev->devfn] = NULL;
     pci_config_free(pci_dev);
 
+    memory_region_del_subregion(&pci_dev->bus_master_container_region,
+                                &pci_dev->bus_master_enable_region);
     address_space_destroy(&pci_dev->bus_master_as);
 }
 
-- 
MST
