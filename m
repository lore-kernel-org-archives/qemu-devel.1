Received: from eggs.gnu.org ([2001:4830:134:3::10]:40448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan@kernelim.com>) id 1dMUHz-0001he-G2
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 03:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan@kernelim.com>) id 1dMUHw-0006Ja-An
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 03:06:27 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan@kernelim.com>) id 1dMUHv-0006Hw-WC
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 03:06:24 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m125so55137369wmm.1
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 00:06:23 -0700 (PDT)
Date: Sun, 18 Jun 2017 10:06:17 +0300
From: Dan Aloni <dan@kernelim.com>
Message-ID: <20170618070617.GA12026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [dan@kernelim.com: [PATCH] nvme: Fix get/set number of
 queues feature, again]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>

Comments?

----- Forwarded message from Dan Aloni <dan@kernelim.com> -----

Date: Sun, 28 May 2017 16:06:49 +0300
From: Dan Aloni <dan@kernelim.com>
To: qemu-devel@nongnu.org
Cc: Alex Friedman <alex@e8storage.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] nvme: Fix get/set number of queues feature, again
X-Mailer: git-send-email 2.9.4

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
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7428db9f0c91..08ddf3a39e2f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -573,7 +573,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = blk_enable_write_cache(n->conf.blk);
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result = cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
+        result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -594,7 +594,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         break;
     case NVME_NUMBER_OF_QUEUES:
         req->cqe.result =
-            cpu_to_le32((n->num_queues - 1) | ((n->num_queues - 1) << 16));
+            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
-- 
2.9.4


----- End forwarded message -----

-- 
Dan Aloni
