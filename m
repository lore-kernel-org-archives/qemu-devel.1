Received: from eggs.gnu.org ([209.51.188.92]:43513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdT-0000hG-RU
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdS-00076i-N8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:23 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Wed, 17 Apr 2019 22:53:55 +0300
Message-Id: <20190417195355.16123-6-mlevitsk@redhat.com>
In-Reply-To: <20190417195355.16123-1-mlevitsk@redhat.com>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] block/nvme: add support for discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c       | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events |  2 ++
 2 files changed, 82 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 35b925899f..b83912c627 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -110,6 +110,7 @@ typedef struct {
     bool plugged;
 
     bool supports_write_zeros;
+    bool supports_discard;
 
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
@@ -462,6 +463,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
 
     s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
+    s->supports_discard = (idctrl->oncs & NVME_ONCS_DSM) != 0;
 
     memset(resp, 0, 4096);
 
@@ -1144,6 +1146,83 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 
+static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
+        int64_t offset, int bytes)
+{
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *ioq = s->queues[1];
+    NVMeRequest *req;
+    NvmeDsmRange *buf;
+    QEMUIOVector local_qiov;
+    int r;
+
+    NvmeCmd cmd = {
+        .opcode = NVME_CMD_DSM,
+        .nsid = cpu_to_le32(s->nsid),
+        .cdw10 = 0, /*number of ranges - 0 based*/
+        .cdw11 = cpu_to_le32(1 << 2), /*deallocate bit*/
+    };
+
+    NVMeCoData data = {
+        .ctx = bdrv_get_aio_context(bs),
+        .ret = -EINPROGRESS,
+    };
+
+    if (!s->supports_discard) {
+        return -ENOTSUP;
+    }
+
+    assert(s->nr_queues > 1);
+
+    buf = qemu_try_blockalign0(bs, 4096);
+    if (!buf) {
+            return -ENOMEM;
+    }
+
+    buf->nlb = bytes >> s->blkshift;
+    buf->slba = offset >> s->blkshift;
+    buf->cattr = 0;
+
+    qemu_iovec_init(&local_qiov, 1);
+    qemu_iovec_add(&local_qiov, buf, 4096);
+
+    req = nvme_get_free_req(ioq);
+    assert(req);
+
+    qemu_co_mutex_lock(&s->dma_map_lock);
+    r = nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
+    qemu_co_mutex_unlock(&s->dma_map_lock);
+
+    if (r) {
+        req->busy = false;
+        return r;
+    }
+
+    trace_nvme_dsm(s, offset, bytes);
+
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    qemu_co_mutex_lock(&s->dma_map_lock);
+    r = nvme_cmd_unmap_qiov(bs, &local_qiov);
+    qemu_co_mutex_unlock(&s->dma_map_lock);
+    if (r) {
+        return r;
+    }
+
+    trace_nvme_dsm_done(s, offset, bytes, data.ret);
+
+    qemu_iovec_destroy(&local_qiov);
+    qemu_vfree(buf);
+    return data.ret;
+
+}
+
+
 static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp)
 {
@@ -1250,6 +1329,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_co_pwritev          = nvme_co_pwritev,
 
     .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
+    .bdrv_co_pdiscard         = nvme_co_pdiscard,
 
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
diff --git a/block/trace-events b/block/trace-events
index 943a58569f..e55ac5c40b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -148,6 +148,8 @@ nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offs
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
+nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes %"PRId64""
+nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *q) "q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
-- 
2.17.2
