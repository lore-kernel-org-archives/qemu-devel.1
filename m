Received: from eggs.gnu.org ([2001:4830:134:3::10]:49301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX0-000322-2U
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWx-0007AH-RQ
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWx-000797-LS
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:59 -0400
Date: Sun, 15 Oct 2017 06:23:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-22-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/26] hw/gen_pcie_root_port: make IO RO 0 on IO
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

IO_LIMIT and IO_BASE registers should not be writable if
gen_pcie_root_port's io-reserve property is set to 0.
The COMMAND register should have the IO flag read only.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ed03ffc..ad4e6aa 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -85,6 +85,13 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
         rpc->parent_class.exit(d);
         return;
     }
+
+    if (!grp->io_reserve) {
+        pci_word_test_and_clear_mask(d->wmask + PCI_COMMAND,
+                                     PCI_COMMAND_IO);
+        d->wmask[PCI_IO_BASE] = 0;
+        d->wmask[PCI_IO_LIMIT] = 0;
+    }
 }
 
 static const VMStateDescription vmstate_rp_dev = {
-- 
MST
