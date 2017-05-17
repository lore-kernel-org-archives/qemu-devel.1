Received: from eggs.gnu.org ([2001:4830:134:3::10]:48317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6lI-000195-VV
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6lE-0005Sa-Mu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:41 -0400
Date: Thu, 18 May 2017 00:45:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1495057396-13387-13-git-send-email-mst@redhat.com>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, qemu-stable@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

From: "Herongguang (Stephen)" <herongguang.he@huawei.com>

If a pci device is not reset by VM (by writing into config space)
and unplugged by VM, after that when VM reboots, qemu may assert:
pcibus_reset: Assertion `bus->irq_count[i] == 0' failed

Cc: qemu-stable@nongnu.org
Signed-off-by: herongguang <herongguang.he@huawei.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b..98ccc27 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1083,6 +1083,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
         pc->exit(pci_dev);
     }
 
+    pci_device_deassert_intx(pci_dev);
     do_pci_unregister_device(pci_dev);
 }
 
-- 
MST
