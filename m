Received: from eggs.gnu.org ([2001:4830:134:3::10]:44079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT0Tt-0005Ax-BR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT0Ts-0005zq-Ki
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:46:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 13 Jun 2018 15:45:52 +0800
Message-Id: <20180613074552.15656-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: Reset s->nr_queues upon open failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org

It is wrong to leave this field as 1, as nvme_close() called in the
error handling code in nvme_file_open() will use it and try to free
s->queues again.

Clear the fields to avoid double-free.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..7bdeb0ffce 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -666,6 +666,8 @@ fail_queue:
     nvme_free_queue_pair(bs, s->queues[0]);
 fail:
     g_free(s->queues);
+    s->queues = NULL;
+    s->nr_queues = 0;
     if (s->regs) {
         qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     }
-- 
2.17.0
