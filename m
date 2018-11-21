Received: from eggs.gnu.org ([2001:4830:134:3::10]:57960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gunthorp@deltatee.com>) id 1gPX3L-00005w-N3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gunthorp@deltatee.com>) id 1gPWxM-0002AH-I8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:10:33 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 21 Nov 2018 11:10:13 -0700
Message-Id: <20181121181013.4983-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/block/nvme: fix bug with PCI IRQ pins on
 teardown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Keith Busch <keith.busch@intel.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stephen Bates <stephen@eideticom.com>, Logan Gunthorpe <logang@deltatee.com>

When the submission and completion queues are being torn down
the IRQ will be asserted for the completion queue when the
submsission queue is deleted. Then when the completion queue
is deleted it stays asserted. Thus, on systems that do
not use MSI, no further interrupts can be triggered on the host.

Linux sees this as a long delay when unbinding the nvme device.
Eventually the interrupt timeout occurs and it continues.

To fix this we ensure we deassert the IRQ for a CQ when it is
deleted.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 hw/block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816c8..7cbed75ce5fd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -554,6 +554,7 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_nvme_err_invalid_del_cq_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
+    nvme_irq_deassert(n, cq);
     trace_nvme_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
-- 
2.19.0
