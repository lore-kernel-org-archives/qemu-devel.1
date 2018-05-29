Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNXgt-0006iB-Q3
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNXgs-00039M-HK
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:01:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 29 May 2018 13:59:57 +0800
Message-Id: <20180529055959.32002-9-famz@redhat.com>
In-Reply-To: <20180529055959.32002-1-famz@redhat.com>
References: <20180529055959.32002-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 08/10] iscsi: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Issue EXTENDED COPY (LID1) command to implement the copy_range API.

The parameter data construction code is modified from libiscsi's
iscsi-dd.c.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c            | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 include/scsi/constants.h |   3 +
 2 files changed, 222 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6a365cb07b..5ea75646d9 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2205,6 +2205,221 @@ static void coroutine_fn iscsi_co_invalidate_cache(BlockDriverState *bs,
     iscsi_allocmap_invalidate(iscsilun);
 }
 
+static int coroutine_fn iscsi_co_copy_range_from(BlockDriverState *bs,
+                                                 BdrvChild *src,
+                                                 uint64_t src_offset,
+                                                 BdrvChild *dst,
+                                                 uint64_t dst_offset,
+                                                 uint64_t bytes,
+                                                 BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes, flags);
+}
+
+static struct scsi_task *iscsi_xcopy_task(int param_len)
+{
+    struct scsi_task *task;
+
+    task = g_new0(struct scsi_task, 1);
+
+    task->cdb[0]     = EXTENDED_COPY;
+    task->cdb[10]    = (param_len >> 24) & 0xFF;
+    task->cdb[11]    = (param_len >> 16) & 0xFF;
+    task->cdb[12]    = (param_len >> 8) & 0xFF;
+    task->cdb[13]    = param_len & 0xFF;
+    task->cdb_size   = 16;
+    task->xfer_dir   = SCSI_XFER_WRITE;
+    task->expxferlen = param_len;
+
+    return task;
+}
+
+static void iscsi_populate_target_desc(unsigned char *desc, IscsiLun *lun)
+{
+    struct scsi_inquiry_device_designator *dd = lun->dd;
+
+    memset(desc, 0, 32);
+    desc[0] = IDENT_DESCR_TGT_DESCR;
+    desc[4] = dd->code_set;
+    desc[5] = (dd->designator_type & 0xF)
+        | ((dd->association & 3) << 4);
+    desc[7] = dd->designator_length;
+    memcpy(desc + 8, dd->designator, dd->designator_length);
+
+    desc[28] = 0;
+    desc[29] = (lun->block_size >> 16) & 0xFF;
+    desc[30] = (lun->block_size >> 8) & 0xFF;
+    desc[31] = lun->block_size & 0xFF;
+}
+
+static void iscsi_xcopy_desc_hdr(uint8_t *hdr, int dc, int cat, int src_index,
+                                 int dst_index)
+{
+    hdr[0] = 0x02; /* BLK_TO_BLK_SEG_DESCR */
+    hdr[1] = ((dc << 1) | cat) & 0xFF;
+    hdr[2] = (XCOPY_BLK2BLK_SEG_DESC_SIZE >> 8) & 0xFF;
+    /* don't account for the first 4 bytes in descriptor header*/
+    hdr[3] = (XCOPY_BLK2BLK_SEG_DESC_SIZE - 4 /* SEG_DESC_SRC_INDEX_OFFSET */) & 0xFF;
+    hdr[4] = (src_index >> 8) & 0xFF;
+    hdr[5] = src_index & 0xFF;
+    hdr[6] = (dst_index >> 8) & 0xFF;
+    hdr[7] = dst_index & 0xFF;
+}
+
+static void iscsi_xcopy_populate_desc(uint8_t *desc, int dc, int cat,
+                                      int src_index, int dst_index, int num_blks,
+                                      uint64_t src_lba, uint64_t dst_lba)
+{
+    iscsi_xcopy_desc_hdr(desc, dc, cat, src_index, dst_index);
+
+    /* The caller should verify the request size */
+    assert(num_blks < 65536);
+    desc[10] = (num_blks >> 8) & 0xFF;
+    desc[11] = num_blks & 0xFF;
+    desc[12] = (src_lba >> 56) & 0xFF;
+    desc[13] = (src_lba >> 48) & 0xFF;
+    desc[14] = (src_lba >> 40) & 0xFF;
+    desc[15] = (src_lba >> 32) & 0xFF;
+    desc[16] = (src_lba >> 24) & 0xFF;
+    desc[17] = (src_lba >> 16) & 0xFF;
+    desc[18] = (src_lba >> 8) & 0xFF;
+    desc[19] = src_lba & 0xFF;
+    desc[20] = (dst_lba >> 56) & 0xFF;
+    desc[21] = (dst_lba >> 48) & 0xFF;
+    desc[22] = (dst_lba >> 40) & 0xFF;
+    desc[23] = (dst_lba >> 32) & 0xFF;
+    desc[24] = (dst_lba >> 24) & 0xFF;
+    desc[25] = (dst_lba >> 16) & 0xFF;
+    desc[26] = (dst_lba >> 8) & 0xFF;
+    desc[27] = dst_lba & 0xFF;
+}
+
+static void iscsi_xcopy_populate_header(unsigned char *buf, int list_id, int str,
+                                        int list_id_usage, int prio,
+                                        int tgt_desc_len,
+                                        int seg_desc_len, int inline_data_len)
+{
+    buf[0] = list_id;
+    buf[1] = ((str & 1) << 5) | ((list_id_usage & 3) << 3) | (prio & 7);
+    buf[2] = (tgt_desc_len >> 8) & 0xFF;
+    buf[3] = tgt_desc_len & 0xFF;
+    buf[8] = (seg_desc_len >> 24) & 0xFF;
+    buf[9] = (seg_desc_len >> 16) & 0xFF;
+    buf[10] = (seg_desc_len >> 8) & 0xFF;
+    buf[11] = seg_desc_len & 0xFF;
+    buf[12] = (inline_data_len >> 24) & 0xFF;
+    buf[13] = (inline_data_len >> 16) & 0xFF;
+    buf[14] = (inline_data_len >> 8) & 0xFF;
+    buf[15] = inline_data_len & 0xFF;
+}
+
+static void iscsi_xcopy_data(struct iscsi_data *data,
+                             IscsiLun *src, int64_t src_lba,
+                             IscsiLun *dst, int64_t dst_lba,
+                             uint16_t num_blocks)
+{
+    uint8_t *buf;
+    const int src_offset = XCOPY_DESC_OFFSET;
+    const int dst_offset = XCOPY_DESC_OFFSET + IDENT_DESCR_TGT_DESCR_SIZE;
+    const int seg_offset = dst_offset + IDENT_DESCR_TGT_DESCR_SIZE;
+
+    data->size = XCOPY_DESC_OFFSET +
+                 IDENT_DESCR_TGT_DESCR_SIZE * 2 +
+                 XCOPY_BLK2BLK_SEG_DESC_SIZE;
+    data->data = g_malloc0(data->size);
+    buf = data->data;
+
+    /* Initialise the parameter list header */
+    iscsi_xcopy_populate_header(buf, 1, 0, 2 /* LIST_ID_USAGE_DISCARD */,
+                                0, 2 * IDENT_DESCR_TGT_DESCR_SIZE,
+                                XCOPY_BLK2BLK_SEG_DESC_SIZE,
+                                0);
+
+    /* Initialise CSCD list with one src + one dst descriptor */
+    iscsi_populate_target_desc(&buf[src_offset], src);
+    iscsi_populate_target_desc(&buf[dst_offset], dst);
+
+    /* Initialise one segment descriptor */
+    iscsi_xcopy_populate_desc(&buf[seg_offset], 0, 0, 0, 1, num_blocks,
+                              src_lba, dst_lba);
+}
+
+static int coroutine_fn iscsi_co_copy_range_to(BlockDriverState *bs,
+                                               BdrvChild *src,
+                                               uint64_t src_offset,
+                                               BdrvChild *dst,
+                                               uint64_t dst_offset,
+                                               uint64_t bytes,
+                                               BdrvRequestFlags flags)
+{
+    IscsiLun *dst_lun = dst->bs->opaque;
+    IscsiLun *src_lun;
+    struct IscsiTask iscsi_task;
+    struct iscsi_data data;
+    int r = 0;
+    int block_size;
+
+    if (src->bs->drv->bdrv_co_copy_range_to != iscsi_co_copy_range_to) {
+        return -ENOTSUP;
+    }
+    src_lun = src->bs->opaque;
+
+    if (!src_lun->dd || !dst_lun->dd) {
+        return -ENOTSUP;
+    }
+    if (!is_byte_request_lun_aligned(dst_offset, bytes, dst_lun)) {
+        return -ENOTSUP;
+    }
+    if (!is_byte_request_lun_aligned(src_offset, bytes, src_lun)) {
+        return -ENOTSUP;
+    }
+    if (dst_lun->block_size != src_lun->block_size ||
+        !dst_lun->block_size) {
+        return -ENOTSUP;
+    }
+
+    block_size = dst_lun->block_size;
+    if (bytes / block_size > 65535) {
+        return -ENOTSUP;
+    }
+
+    iscsi_xcopy_data(&data,
+                     src_lun, src_offset / block_size,
+                     dst_lun, dst_offset / block_size,
+                     bytes / block_size);
+
+    iscsi_co_init_iscsitask(dst_lun, &iscsi_task);
+
+    qemu_mutex_lock(&dst_lun->mutex);
+    iscsi_task.task = iscsi_xcopy_task(data.size);
+retry:
+    if (iscsi_scsi_command_async(dst_lun->iscsi, dst_lun->lun,
+                                 iscsi_task.task, iscsi_co_generic_cb,
+                                 &data,
+                                 &iscsi_task) != 0) {
+        r = -EIO;
+        goto out_unlock;
+    }
+
+    iscsi_co_wait_for_task(&iscsi_task, dst_lun);
+
+    if (iscsi_task.do_retry) {
+        iscsi_task.complete = 0;
+        goto retry;
+    }
+
+    if (iscsi_task.status != SCSI_STATUS_GOOD) {
+        r = iscsi_task.err_code;
+        goto out_unlock;
+    }
+
+out_unlock:
+    g_free(iscsi_task.task);
+    qemu_mutex_unlock(&dst_lun->mutex);
+    g_free(iscsi_task.err_str);
+    return r;
+}
+
 static QemuOptsList iscsi_create_opts = {
     .name = "iscsi-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(iscsi_create_opts.head),
@@ -2239,6 +2454,8 @@ static BlockDriver bdrv_iscsi = {
 
     .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
+    .bdrv_co_copy_range_from = iscsi_co_copy_range_from,
+    .bdrv_co_copy_range_to  = iscsi_co_copy_range_to,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
     .bdrv_co_writev        = iscsi_co_writev,
@@ -2274,6 +2491,8 @@ static BlockDriver bdrv_iser = {
 
     .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
+    .bdrv_co_copy_range_from = iscsi_co_copy_range_from,
+    .bdrv_co_copy_range_to  = iscsi_co_copy_range_to,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
     .bdrv_co_writev        = iscsi_co_writev,
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 54733b7110..b53ff8adcb 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -311,6 +311,9 @@
 #define MMC_PROFILE_HDDVD_RW_DL         0x005A
 #define MMC_PROFILE_INVALID             0xFFFF
 
+#define XCOPY_DESC_OFFSET 16
 #define IDENT_DESCR_TGT_DESCR 0xE4
+#define IDENT_DESCR_TGT_DESCR_SIZE 32
+#define XCOPY_BLK2BLK_SEG_DESC_SIZE 28
 
 #endif
-- 
2.14.3
