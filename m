Received: from eggs.gnu.org ([2001:4830:134:3::10]:55465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4Y-0001j3-Ae
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4X-0006Y1-9B
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:34 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Tue, 12 Jun 2018 17:51:02 -0600
Message-Id: <20180612235103.12633-2-brogers@suse.com>
In-Reply-To: <20180612235103.12633-1-brogers@suse.com>
References: <20180612235103.12633-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH 1/2] xen: add xen disk naming for use in monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, Bruce Rogers <brogers@suse.com>

Provide monitor naming of xen disks, including associating an
attached dev_id for a BlockBackend which has legacy_dev set.
Currently, only xen disks have legacy_dev set to true.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 block/block-backend.c |  5 ++++-
 hw/block/xen_disk.c   | 15 +++++++++++++++
 include/hw/xen/xen.h  |  2 ++
 stubs/xen-common.c    |  5 +++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d55c328736..db39dfe867 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -23,6 +23,7 @@
 #include "qemu/option.h"
 #include "trace.h"
 #include "migration/misc.h"
+#include "hw/xen/xen.h"
 
 /* Number of coroutines to reserve per attached device model */
 #define COROUTINE_POOL_RESERVATION 64
@@ -895,7 +896,9 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
 {
     DeviceState *dev;
 
-    assert(!blk->legacy_dev);
+    if (blk->legacy_dev) {
+        return xen_blk_get_attached_dev_id(blk->dev);
+    }
     dev = blk->dev;
 
     if (!dev) {
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 9fbc0cdb87..fca0597d36 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -745,6 +745,7 @@ static int blk_connect(struct XenDevice *xendev)
     int order, ring_ref;
     unsigned int ring_size, max_grants;
     unsigned int i;
+    Error *errp = NULL;
 
     trace_xen_disk_connect(xendev->name);
 
@@ -801,6 +802,13 @@ static int blk_connect(struct XenDevice *xendev)
         blk_ref(blkdev->blk);
     }
     blk_attach_dev_legacy(blkdev->blk, blkdev);
+    if (!monitor_add_blk(blkdev->blk, g_strdup(blkdev->dev), &errp)) {
+        xen_pv_printf(&blkdev->xendev, 0, "error: %s\n",
+                      error_get_pretty(errp));
+        error_free(errp);
+        return -1;
+    }
+
     blkdev->file_size = blk_getlength(blkdev->blk);
     if (blkdev->file_size < 0) {
         BlockDriverState *bs = blk_bs(blkdev->blk);
@@ -951,6 +959,7 @@ static void blk_disconnect(struct XenDevice *xendev)
     if (blkdev->blk) {
         blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
         blk_detach_dev(blkdev->blk, blkdev);
+        monitor_remove_blk(blkdev->blk);
         blk_unref(blkdev->blk);
         blkdev->blk = NULL;
     }
@@ -998,6 +1007,12 @@ static void blk_event(struct XenDevice *xendev)
     qemu_bh_schedule(blkdev->bh);
 }
 
+char *xen_blk_get_attached_dev_id(void *dev)
+{
+    struct XenBlkDev *blkdev = dev;
+    return g_strdup_printf("xen-qdisk-%i", blkdev->xendev.dev);
+}
+
 struct XenDevOps xen_blkdev_ops = {
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .size       = sizeof(struct XenBlkDev),
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa8fe..a201517675 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -48,4 +48,6 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
+char *xen_blk_get_attached_dev_id(void *dev);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-common.c b/stubs/xen-common.c
index 09fce2dd36..aeac0534ac 100644
--- a/stubs/xen-common.c
+++ b/stubs/xen-common.c
@@ -12,3 +12,8 @@
 void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
 }
+
+char *xen_blk_get_attached_dev_id(void *dev)
+{
+    return g_strdup("");
+}
-- 
2.17.1
