Received: from eggs.gnu.org ([2001:4830:134:3::10]:42352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKk0-00059A-5q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKjz-0005mX-2a
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKjy-0005mJ-T7
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:21:56 +0100
Message-Id: <20170831082210.8362-2-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 01/15] nvme: Fix get/set number of
 queues feature, again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dan Aloni <dan@kernelim.com>, Alex Friedman <alex@e8storage.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Dan Aloni <dan@kernelim.com>

The number of queues that should be return by the admin command should:

  1) Only mention the number of non-admin queues.
  2) It is zero-based, meaning that '0 == one non-admin queue',
     '1 == two non-admin queues', and so forth.

Because our `num_queues` means the number of queues _plus_ the admin
queue, then the right calculation for the number returned from the admin
command is `num_queues - 2`, combining the two requirements mentioned.

The issue was discovered by reducing num_queues from 64 to 8 and running
a Linux VM with an SMP parameter larger than that (e.g. 22). It tries to
utilize all queues, and therefore fails with an invalid queue number
when trying to queue I/Os on the last queue.

Signed-off-by: Dan Aloni <dan@kernelim.com>
CC: Alex Friedman <alex@e8storage.com>
CC: Keith Busch <keith.busch@intel.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6071dc12d8..9aa32692a3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -615,7 +615,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = blk_enable_write_cache(n->conf.blk);
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result = cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
+        result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -636,7 +636,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         break;
     case NVME_NUMBER_OF_QUEUES:
         req->cqe.result =
-            cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
+            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
-- 
2.13.5
