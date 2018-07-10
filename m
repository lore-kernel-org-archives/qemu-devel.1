Received: from eggs.gnu.org ([2001:4830:134:3::10]:44524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunl-0005Kf-3A
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcung-0001iu-Vn
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:56 +0200
Message-Id: <20180710154304.18304-17-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/24] block: Add copy offloading trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

A few trace points that can help reveal what is happening in a copy
offloading I/O path.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 2 ++
 block/io.c         | 4 ++++
 block/iscsi.c      | 3 +++
 block/trace-events | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1185c7c5cc..09f6b938f6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1488,6 +1488,8 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
         ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
                                       aiocb->aio_fd2, &out_off,
                                       bytes, 0);
+        trace_file_copy_file_range(aiocb->bs, aiocb->aio_fildes, in_off,
+                                   aiocb->aio_fd2, out_off, bytes, 0, ret);
         if (ret == 0) {
             /* No progress (e.g. when beyond EOF), let the caller fall back to
              * buffer I/O. */
diff --git a/block/io.c b/block/io.c
index 6be9c40f23..9b2aa04010 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3019,6 +3019,8 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags)
 {
+    trace_bdrv_co_copy_range_from(src, src_offset, dst, dst_offset, bytes,
+                                  read_flags, write_flags);
     return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
                                        bytes, read_flags, write_flags, true);
 }
@@ -3033,6 +3035,8 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags)
 {
+    trace_bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes,
+                                read_flags, write_flags);
     return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
                                        bytes, read_flags, write_flags, false);
 }
diff --git a/block/iscsi.c b/block/iscsi.c
index 38b917a1e5..bb69faf34a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -44,6 +44,7 @@
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
 #include "scsi/utils.h"
+#include "trace.h"
 
 /* Conflict between scsi/utils.h and libiscsi! :( */
 #define SCSI_XFER_NONE ISCSI_XFER_NONE
@@ -2399,6 +2400,8 @@ retry:
     }
 
 out_unlock:
+
+    trace_iscsi_xcopy(src_lun, src_offset, dst_lun, dst_offset, bytes, r);
     g_free(iscsi_task.task);
     qemu_mutex_unlock(&dst_lun->mutex);
     g_free(iscsi_task.err_str);
diff --git a/block/trace-events b/block/trace-events
index 854d5525af..3e8c47bb24 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -15,6 +15,8 @@ bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs
 bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
+bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
+bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 
 # block/stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
@@ -57,6 +59,7 @@ qmp_block_stream(void *bs, void *job) "bs %p job %p"
 # block/file-posix.c
 file_paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d type %d"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
+file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 
 # block/qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
@@ -150,3 +153,6 @@ nvme_free_req_queue_wait(void *q) "q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
+
+# block/iscsi.c
+iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p offset %"PRIu64" bytes %"PRIu64" ret %d"
-- 
2.13.6
