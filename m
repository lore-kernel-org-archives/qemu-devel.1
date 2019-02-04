Received: from eggs.gnu.org ([209.51.188.92]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaa-0006G7-Lq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTP-0005VQ-Hp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:49 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTP-0005Tt-AF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:47 -0500
Received: by mail-qt1-f176.google.com with SMTP id b8so129717qtj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:47 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-14-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/25] pci/msi: export msi_is_masked()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Peter Xu <peterx@redhat.com>

It is going to be used later on outside MSI code to detect whether one
MSI vector is masked out.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/msi.h | 1 +
 hw/pci/msi.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
-- 
MST
