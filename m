Received: from eggs.gnu.org ([2001:4830:134:3::10]:46552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gR3Re-0007FK-3k
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gR3Rc-0001zu-Uo
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:04:06 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 25 Nov 2018 15:03:55 -0800
Message-Id: <1543187035-32757-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] nvme: Only generate interupt if warranted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

So far the code generates interrupts even if it doesn't pass any new
information to the user. This can result in spurious interrupts as
sometimes observed with Linux.

Only generate interrupts if warranted, ie if anything new is passed
to the emulated code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/block/nvme.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9fbe567..c543c01 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -252,6 +252,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq = opaque;
     NvmeCtrl *n = cq->ctrl;
     NvmeRequest *req, *next;
+    bool assert_irq = false;
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -271,8 +272,11 @@ static void nvme_post_cqes(void *opaque)
         pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+        assert_irq = true;
+    }
+    if (assert_irq) {
+        nvme_irq_assert(n, cq);
     }
-    nvme_irq_assert(n, cq);
 }
 
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
-- 
2.7.4
