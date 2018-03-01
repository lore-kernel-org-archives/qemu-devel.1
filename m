Received: from eggs.gnu.org ([2001:4830:134:3::10]:43226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erJ3E-0005uz-D8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erJ39-0001Ap-Ga
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1erJ39-0001A2-Bw
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:47 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  1 Mar 2018 15:54:28 +0800
Message-Id: <20180301075428.17320-2-famz@redhat.com>
In-Reply-To: <20180301075428.17320-1-famz@redhat.com>
References: <20180301075428.17320-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] block/nvme: fix Coverity reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

1) string not null terminated in sysfs_find_group_file

2) NULL pointer dereference and dead local variable in nvme_init.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

Message-Id: <20180213015240.9352-1-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c        | 10 +++++++---
 util/vfio-helpers.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 10bffbbf2f..75078022f6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -645,7 +645,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
                            false, nvme_handle_event, nvme_poll_cb);
 
-    nvme_identify(bs, namespace, errp);
+    nvme_identify(bs, namespace, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EIO;
@@ -666,8 +666,12 @@ fail_queue:
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
