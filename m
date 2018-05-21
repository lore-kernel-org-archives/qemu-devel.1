Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKePq-00042K-Oj
	for qemu-devel@nongnu.org; Mon, 21 May 2018 02:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKePp-000256-QM
	for qemu-devel@nongnu.org; Mon, 21 May 2018 02:35:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 21 May 2018 14:35:16 +0800
Message-Id: <20180521063516.5479-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: Make nvme_init error handling code more
 readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Coverity doesn't like the tests under fail label (report CID 1385847).
Reset the fields so the clean up order is more apparent.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..8239b920c8 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -560,6 +560,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     qemu_co_queue_init(&s->dma_flush_queue);
     s->nsid = namespace;
     s->aio_context = bdrv_get_aio_context(bs);
+
+    /* Fields we've not touched should be zero-initialized by block layer
+     * already, but reset them anyway to make the error handling code easier to
+     * reason. */
+    s->regs = NULL;
+    s->vfio = NULL;
+
     ret = event_notifier_init(&s->irq_notifier, 0);
     if (ret) {
         error_setg(errp, "Failed to init event notifier");
-- 
2.14.3
