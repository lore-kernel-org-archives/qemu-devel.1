Received: from eggs.gnu.org ([2001:4830:134:3::10]:41940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAW8-0008WV-SD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAW7-0008IS-N3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:13 +0800
Message-Id: <20180608060417.10170-3-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] block: Check if block drivers can do copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This avoids the wasteful cluster allocation in qcow2 before actually
trying an unsupported copy range call, for example.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   | 12 ++++++++++++
 block/file-posix.c        |  9 +++++++++
 block/io.c                |  3 +++
 block/iscsi.c             |  8 ++++++++
 block/qcow2.c             | 11 +++++++++++
 block/raw-format.c        |  6 ++++++
 include/block/block_int.h |  4 ++++
 7 files changed, 53 insertions(+)

diff --git a/block.c b/block.c
index 501b64c819..28aa8d8a65 100644
--- a/block.c
+++ b/block.c
@@ -5320,3 +5320,15 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
 }
+
+bool bdrv_can_copy_range(BdrvChild *src, BdrvChild *dst)
+{
+    BlockDriverState *bs;
+
+    if (!src || !src->bs) {
+        return false;
+    }
+    bs = src->bs;
+    return bs && bs->drv && bs->drv->bdrv_can_copy_range &&
+           bs->drv->bdrv_can_copy_range(bs, dst);
+}
diff --git a/block/file-posix.c b/block/file-posix.c
index c6dae38f94..41c491c65b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2539,6 +2539,13 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                NULL, bytes, QEMU_AIO_COPY_RANGE);
 }
 
+static bool raw_can_copy_range(BlockDriverState *bs,
+                               BdrvChild *dst)
+{
+    return dst->bs && dst->bs->drv &&
+           dst->bs->drv->bdrv_can_copy_range == raw_can_copy_range;
+}
+
 BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
@@ -2564,6 +2571,7 @@ BlockDriver bdrv_file = {
     .bdrv_aio_pdiscard = raw_aio_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
+    .bdrv_can_copy_range = raw_can_copy_range,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
@@ -3044,6 +3052,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_aio_pdiscard   = hdev_aio_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
+    .bdrv_can_copy_range = raw_can_copy_range,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
diff --git a/block/io.c b/block/io.c
index b7beaeeb9f..d8039793c2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2913,6 +2913,9 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
     BlockDriverState *dst_bs = dst->bs;
     int ret;
 
+    if (!bdrv_can_copy_range(src, dst)) {
+        return -ENOTSUP;
+    }
     bdrv_inc_in_flight(src_bs);
     bdrv_inc_in_flight(dst_bs);
     tracked_request_begin(&src_req, src_bs, src_offset,
diff --git a/block/iscsi.c b/block/iscsi.c
index c2fbd8a8aa..6c465ebd46 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2420,6 +2420,12 @@ out_unlock:
     return r;
 }
 
+static bool iscsi_can_copy_range(BlockDriverState *bs, BdrvChild *dst)
+{
+    return dst->bs && dst->bs->drv &&
+           dst->bs->drv->bdrv_can_copy_range == iscsi_can_copy_range;
+}
+
 static QemuOptsList iscsi_create_opts = {
     .name = "iscsi-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(iscsi_create_opts.head),
@@ -2456,6 +2462,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_copy_range_from = iscsi_co_copy_range_from,
     .bdrv_co_copy_range_to  = iscsi_co_copy_range_to,
+    .bdrv_can_copy_range   = iscsi_can_copy_range,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
     .bdrv_co_writev        = iscsi_co_writev,
@@ -2493,6 +2500,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_copy_range_from = iscsi_co_copy_range_from,
     .bdrv_co_copy_range_to  = iscsi_co_copy_range_to,
+    .bdrv_can_copy_range   = iscsi_can_copy_range,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
     .bdrv_co_writev        = iscsi_co_writev,
diff --git a/block/qcow2.c b/block/qcow2.c
index 549fee9b69..1326410d1c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3440,6 +3440,16 @@ fail:
     return ret;
 }
 
+static bool qcow2_can_copy_range(BlockDriverState *bs, BdrvChild *dst)
+{
+    bool r = bdrv_can_copy_range(bs->file, dst);
+
+    if (bs->backing) {
+        r = r && bdrv_can_copy_range(bs->backing, dst);
+    }
+    return r;
+}
+
 static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                           PreallocMode prealloc, Error **errp)
 {
@@ -4690,6 +4700,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
     .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
     .bdrv_co_copy_range_to  = qcow2_co_copy_range_to,
+    .bdrv_can_copy_range    = qcow2_can_copy_range,
     .bdrv_truncate          = qcow2_truncate,
     .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
     .bdrv_make_empty        = qcow2_make_empty,
diff --git a/block/raw-format.c b/block/raw-format.c
index f2e468df6f..707b25fc77 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -527,6 +527,11 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                  flags);
 }
 
+static bool raw_can_copy_range(BlockDriverState *bs, BdrvChild *dst)
+{
+    return bdrv_can_copy_range(bs->file, dst);
+}
+
 BlockDriver bdrv_raw = {
     .format_name          = "raw",
     .instance_size        = sizeof(BDRVRawState),
@@ -545,6 +550,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_block_status = &raw_co_block_status,
     .bdrv_co_copy_range_from = &raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
+    .bdrv_can_copy_range  = &raw_can_copy_range,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 888b7f7bff..2c51cd420f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -235,6 +235,9 @@ struct BlockDriver {
                                               uint64_t bytes,
                                               BdrvRequestFlags flags);
 
+    bool (*bdrv_can_copy_range)(BlockDriverState *bs,
+                                BdrvChild *dst);
+
     /*
      * Building block for bdrv_block_status[_above] and
      * bdrv_is_allocated[_above].  The driver should answer only
@@ -1139,5 +1142,6 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
 int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        BdrvChild *dst, uint64_t dst_offset,
                                        uint64_t bytes, BdrvRequestFlags flags);
+bool bdrv_can_copy_range(BdrvChild *src, BdrvChild *dst);
 
 #endif /* BLOCK_INT_H */
-- 
2.17.0
