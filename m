Received: from eggs.gnu.org ([2001:4830:134:3::10]:43153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdRke-0001Eu-4c
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 22:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdRkd-0002Qp-2y
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 22:54:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 12 Jul 2018 10:54:20 +0800
Message-Id: <20180712025420.4932-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] nvme: Fix nvme_init error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

It is wrong to leave this field as 1, as nvme_close() called in the
error handling code in nvme_file_open() will use it and try to free
s->queues again.

Another problem is the cleaning ups are duplicated between the fail*
labels of nvme_init() and nvme_file_open(), which calls nvme_close().

A third problem is nvme_close() misses g_free() and
event_notifier_cleanup().

Fix all of them.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Adopt the suggested fix by Kevin.
---
 block/nvme.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..37805e8890 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -569,13 +569,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->vfio = qemu_vfio_open_pci(device, errp);
     if (!s->vfio) {
         ret = -EINVAL;
-        goto fail;
+        goto out;
     }
 
     s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, NVME_BAR_SIZE, errp);
     if (!s->regs) {
         ret = -EINVAL;
-        goto fail;
+        goto out;
     }
 
     /* Perform initialize sequence as described in NVMe spec "7.6.1
@@ -585,7 +585,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     if (!(cap & (1ULL << 37))) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
-        goto fail;
+        goto out;
     }
 
     s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
@@ -603,7 +603,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                              PRId64 " ms)",
                        timeout_ms);
             ret = -ETIMEDOUT;
-            goto fail;
+            goto out;
         }
     }
 
@@ -613,7 +613,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
     if (!s->queues[0]) {
         ret = -EINVAL;
-        goto fail;
+        goto out;
     }
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
     s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
@@ -633,14 +633,14 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                              PRId64 " ms)",
                        timeout_ms);
             ret = -ETIMEDOUT;
-            goto fail_queue;
+            goto out;
         }
     }
 
     ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
                                  VFIO_PCI_MSIX_IRQ_INDEX, errp);
     if (ret) {
-        goto fail_queue;
+        goto out;
     }
     aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
                            false, nvme_handle_event, nvme_poll_cb);
@@ -649,30 +649,15 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EIO;
-        goto fail_handler;
+        goto out;
     }
 
     /* Set up command queues. */
     if (!nvme_add_io_queue(bs, errp)) {
         ret = -EIO;
-        goto fail_handler;
     }
-    return 0;
-
-fail_handler:
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
-                           false, NULL, NULL);
-fail_queue:
-    nvme_free_queue_pair(bs, s->queues[0]);
-fail:
-    g_free(s->queues);
-    if (s->regs) {
-        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
-    }
-    if (s->vfio) {
-        qemu_vfio_close(s->vfio);
-    }
-    event_notifier_cleanup(&s->irq_notifier);
+out:
+    /* Cleaning up is done in nvme_file_open() upon error. */
     return ret;
 }
 
@@ -739,8 +724,10 @@ static void nvme_close(BlockDriverState *bs)
     for (i = 0; i < s->nr_queues; ++i) {
         nvme_free_queue_pair(bs, s->queues[i]);
     }
+    g_free(s->queues);
     aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
                            false, NULL, NULL);
+    event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
 }
-- 
2.17.1
