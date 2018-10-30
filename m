Received: from eggs.gnu.org ([208.118.235.92]:57348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQj-0005m6-1T
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQi-0005VU-Gi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:05 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 22:18:39 -0700
Message-Id: <1540876720-9574-4-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 3/4] nvme: check msix_init_exclusive_bar return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

As this function can fail.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 72c9644..a406c23 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1250,7 +1250,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(&n->parent_obj, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
+    if (msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL)) {
+        error_setg(errp, "msix_init_exclusive_bar failed");
+        return;
+    }
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
-- 
1.8.3.1
