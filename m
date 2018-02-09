Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekAXI-0001bf-GT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekAXH-0007Zn-Ht
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:24:24 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 16:24:12 +0100
Message-Id: <20180209152412.23626-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block/nvme: fix Coverity reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com

1) string not null terminated in sysfs_find_group_file

2) NULL pointer dereference and dead local variable in nvme_init.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nvme.c        | 14 ++++++--------
 util/vfio-helpers.c |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e9d0e218fc..ce217ffc81 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -553,7 +553,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t cap;
     uint64_t timeout_ms;
     uint64_t deadline, now;
-    Error *local_err = NULL;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -645,11 +644,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                            false, nvme_handle_event, nvme_poll_cb);
 
     nvme_identify(bs, namespace, errp);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EIO;
-        goto fail_handler;
-    }
 
     /* Set up command queues. */
     if (!nvme_add_io_queue(bs, errp)) {
@@ -665,8 +659,12 @@ fail_queue:
     nvme_free_queue_pair(bs, s->queues[0]);
 fail:
     g_free(s->queues);
-    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
-    qemu_vfio_close(s->vfio);
+    if (s->regs) {
+        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
+    }
+    if (s->vfio) {
+        qemu_vfio_close(s->vfio);
+    }
     event_notifier_cleanup(&s->irq_notifier);
     return ret;
 }
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index f478b68400..006674c916 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -104,7 +104,7 @@ static char *sysfs_find_group_file(const char *device, Error **errp)
     char *path = NULL;
 
     sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group", device);
-    sysfs_group = g_malloc(PATH_MAX);
+    sysfs_group = g_malloc0(PATH_MAX);
     if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) == -1) {
         error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
         goto out;
-- 
2.14.3
