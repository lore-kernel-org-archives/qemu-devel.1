Received: from eggs.gnu.org ([2001:4830:134:3::10]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFc-0001wW-QU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFa-00018J-Ug
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:48 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:16 +0100
Message-Id: <20181122165417.23894-13-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/13] nvme: fix bug with PCI IRQ pins on
 teardown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Logan Gunthorpe <logang@deltatee.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 84062d388f..1687a8e151 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -554,6 +554,7 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd=
)
         trace_nvme_err_invalid_del_cq_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
+    nvme_irq_deassert(n, cq);
     trace_nvme_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
--=20
2.19.1
