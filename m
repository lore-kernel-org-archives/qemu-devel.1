Received: from eggs.gnu.org ([209.51.188.92]:48457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27X-0005A9-S2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27W-0007zw-Ku
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:03 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Mon, 15 Apr 2019 16:57:45 +0300
Message-Id: <20190415135746.7571-5-mlevitsk@redhat.com>
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] block/nvme: add support for write zeros
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
 block/nvme.c         | 69 +++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events   |  1 +
 include/block/nvme.h | 17 ++++++++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0d9b521760..5121e809f0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -109,6 +109,8 @@ typedef struct {
     uint64_t max_transfer;
     bool plugged;
 
+    bool supports_write_zeros;
+
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
 
@@ -457,6 +459,10 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->max_transfer = MIN_NON_ZERO(s->max_transfer,
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
+
+
+    s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
+
     memset(resp, 0, 4096);
 
     cmd.cdw10 = 0;
@@ -469,6 +475,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->nsze = le64_to_cpu(idns->nsze);
     lbaf = &idns->lbaf[idns->flbas & 0x0f];
 
+    if (NVME_ID_NS_DLFEAT_DALLOC_WZEROS(idns->dlfeat) &&
+            NVME_ID_NS_DLFEAT_READ_BEHAVIER(idns->dlfeat) ==
+                    NVME_ID_NS_DLFEAT_READ_BEHAVIER_ZEROS)
+        bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
+
     if (lbaf->ms) {
         error_setg(errp, "Namespaces with metadata are not yet supported");
         goto out;
@@ -763,6 +774,8 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     BDRVNVMeState *s = bs->opaque;
 
+    bs->supported_write_flags = BDRV_REQ_FUA;
+
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
@@ -791,7 +804,6 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
     }
-    bs->supported_write_flags = BDRV_REQ_FUA;
     return 0;
 fail:
     nvme_close(bs);
@@ -1080,6 +1092,58 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 }
 
 
+static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
+    int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *ioq = s->queues[1];
+    NVMeRequest *req;
+
+    if (!s->supports_write_zeros) {
+        return -ENOTSUP;
+    }
+
+    uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
+
+    NvmeCmd cmd = {
+        .opcode = NVME_CMD_WRITE_ZEROS,
+        .nsid = cpu_to_le32(s->nsid),
+        .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
+        .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
+    };
+
+    NVMeCoData data = {
+        .ctx = bdrv_get_aio_context(bs),
+        .ret = -EINPROGRESS,
+    };
+
+    if (flags & BDRV_REQ_MAY_UNMAP) {
+        cdw12 |= (1 << 25);
+    }
+
+    if (flags & BDRV_REQ_FUA) {
+        cdw12 |= (1 << 30);
+    }
+
+    cmd.cdw12 = cpu_to_le32(cdw12);
+
+    trace_nvme_write_zeros(s, offset, bytes, flags);
+    assert(s->nr_queues > 1);
+    req = nvme_get_free_req(ioq);
+    assert(req);
+
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    trace_nvme_rw_done(s, true, offset, bytes, data.ret);
+    return data.ret;
+}
+
+
 static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp)
 {
@@ -1184,6 +1248,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
+
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
 
diff --git a/block/trace-events b/block/trace-events
index 7335a42540..943a58569f 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -144,6 +144,7 @@ nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6,
 nvme_handle_event(void *s) "s %p"
 nvme_poll_cb(void *s) "s %p"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
+nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 0eae6f9f15..f625aefd3b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -653,12 +653,27 @@ typedef struct NvmeIdNs {
     uint8_t     mc;
     uint8_t     dpc;
     uint8_t     dps;
-    uint8_t     res30[98];
+
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint8_t     dlfeat;
+
+    uint8_t     res30[94];
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
 } NvmeIdNs;
 
+#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)         ((dlfeat) & 0x10)
+#define NVME_ID_NS_DLFEAT_DALLOC_WZEROS(dlfeat)     ((dlfeat) & 0x04)
+
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIER(dlfeat)     ((dlfeat) & 0x3)
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_UNDEFINED  0
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ZEROS  1
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ONES   2
+
+
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
-- 
2.17.2
