Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4Y-0001jL-Mj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4X-0006YD-Jf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:34 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Tue, 12 Jun 2018 17:51:03 -0600
Message-Id: <20180612235103.12633-3-brogers@suse.com>
In-Reply-To: <20180612235103.12633-1-brogers@suse.com>
References: <20180612235103.12633-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH 2/2] xen: add block resize support for xen disks
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

In the context of a monitor based disk resize, provide notification
of the new size to the front end xen block driver via a xenstore update.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 block/block-backend.c          | 7 +++++++
 blockdev.c                     | 8 ++++++++
 hw/block/xen_disk.c            | 9 +++++++++
 include/hw/xen/xen.h           | 2 ++
 include/sysemu/block-backend.h | 2 ++
 stubs/xen-common.c             | 4 ++++
 6 files changed, 32 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index db39dfe867..e1b0db8363 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2003,6 +2003,13 @@ int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
     return bdrv_truncate(blk->root, offset, prealloc, errp);
 }
 
+void blk_legacy_resize_cb(BlockBackend *blk)
+{
+    if (blk->legacy_dev) {
+        xen_blk_resize_cb(blk->dev);
+    }
+}
+
 static void blk_pdiscard_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
diff --git a/blockdev.c b/blockdev.c
index 4862323012..4dd34ad424 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3174,6 +3174,7 @@ void qmp_block_resize(bool has_device, const char *device,
 {
     Error *local_err = NULL;
     BlockBackend *blk = NULL;
+    BlockBackend *cb_blk = NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
     int ret;
@@ -3186,6 +3187,10 @@ void qmp_block_resize(bool has_device, const char *device,
         return;
     }
 
+    if (has_device) {
+        cb_blk = blk_by_name(device);
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3212,6 +3217,9 @@ void qmp_block_resize(bool has_device, const char *device,
 
     bdrv_drained_begin(bs);
     ret = blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
+    if (!ret && cb_blk) {
+        blk_legacy_resize_cb(cb_blk);
+    }
     bdrv_drained_end(bs);
 
 out:
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index fca0597d36..e69c7f590c 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1013,6 +1013,15 @@ char *xen_blk_get_attached_dev_id(void *dev)
     return g_strdup_printf("xen-qdisk-%i", blkdev->xendev.dev);
 }
 
+void xen_blk_resize_cb(void *dev)
+{
+    struct XenBlkDev *blkdev = dev;
+    blkdev->file_size = blk_getlength(blkdev->blk);
+    xenstore_write_be_int64(&blkdev->xendev, "sectors",
+                            blkdev->file_size / blkdev->file_blk);
+    xen_be_set_state(&blkdev->xendev, blkdev->xendev.be_state);
+}
+
 struct XenDevOps xen_blkdev_ops = {
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .size       = sizeof(struct XenBlkDev),
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index a201517675..d923ae53f1 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -50,4 +50,6 @@ void xen_register_framebuffer(struct MemoryRegion *mr);
 
 char *xen_blk_get_attached_dev_id(void *dev);
 
+void xen_blk_resize_cb(void *dev);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8d03d493c2..0ccaf5b035 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -236,4 +236,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
                                    int bytes, BdrvRequestFlags flags);
 
+void blk_legacy_resize_cb(BlockBackend *blk);
+
 #endif
diff --git a/stubs/xen-common.c b/stubs/xen-common.c
index aeac0534ac..c2cbf81a87 100644
--- a/stubs/xen-common.c
+++ b/stubs/xen-common.c
@@ -17,3 +17,7 @@ char *xen_blk_get_attached_dev_id(void *dev)
 {
     return g_strdup("");
 }
+
+void xen_blk_resize_cb(void *dev)
+{
+}
-- 
2.17.1
