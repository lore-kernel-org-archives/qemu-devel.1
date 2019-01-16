Received: from eggs.gnu.org ([209.51.188.92]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbnH-00030d-LW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbZX-00036p-4z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjbZW-00034A-NB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:54 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 16 Jan 2019 11:08:14 +0800
Message-Id: <20190116030815.27273-4-peterx@redhat.com>
In-Reply-To: <20190116030815.27273-1-peterx@redhat.com>
References: <20190116030815.27273-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] pci/msi: export msi_is_masked()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

It is going to be used later on outside MSI code to detect whether one
MSI vector is masked out.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/msi.c         | 2 +-
 include/hw/pci/msi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 5e05ce5ec2..47d2b0f33c 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -286,7 +286,7 @@ void msi_reset(PCIDevice *dev)
     MSI_DEV_PRINTF(dev, "reset\n");
 }
 
-static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
+bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
 {
     uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
     uint32_t mask, data;
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index 4837bcf490..8440eaee11 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -39,6 +39,7 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
              bool msi_per_vector_mask, Error **errp);
 void msi_uninit(struct PCIDevice *dev);
 void msi_reset(PCIDevice *dev);
+bool msi_is_masked(const PCIDevice *dev, unsigned int vector);
 void msi_notify(PCIDevice *dev, unsigned int vector);
 void msi_send_message(PCIDevice *dev, MSIMessage msg);
 void msi_write_config(PCIDevice *dev, uint32_t addr, uint32_t val, int len);
-- 
2.17.1
