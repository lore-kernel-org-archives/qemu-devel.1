Received: from eggs.gnu.org ([2001:4830:134:3::10]:41764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13l-0003Sb-60
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13k-0008N0-JJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:57 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 28 Oct 2018 23:29:41 -0700
Message-Id: <1540794581-33578-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
References: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] nvme: free cmbuf in nvme_exit
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

This avoid a memory leak in unhotplug nvme device.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 359a06d0ad..09d7c90259 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1332,6 +1332,9 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
 
+    if (n->cmb_size_mb) {
+        g_free(n->cmbuf);
+    }
     msix_uninit_exclusive_bar(pci_dev);
 }
 
-- 
2.11.0
