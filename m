Received: from eggs.gnu.org ([209.51.188.92]:48404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27T-00055h-Vd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27T-0007xV-38
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:57:59 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Mon, 15 Apr 2019 16:57:42 +0300
Message-Id: <20190415135746.7571-2-mlevitsk@redhat.com>
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] block/nvme: don't flip CQ phase bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Phase bits are only set by the hardware to indicate new completions
and not by the device driver.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0684bbd077..2d208000df 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -340,8 +340,6 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
         qemu_mutex_lock(&q->lock);
         c->cid = cpu_to_le16(0);
         q->inflight--;
-        /* Flip Phase Tag bit. */
-        c->status = cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
         progress = true;
     }
     if (progress) {
-- 
2.17.2
