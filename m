Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DAC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD1A218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1A218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiDB-0001gO-K6
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgX-0007qa-O0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgV-0002Zu-9S
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihgR-0002YP-L2; Wed, 03 Jul 2019 12:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E56A031628E7;
 Wed,  3 Jul 2019 16:00:34 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com
 [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 047FE503EA;
 Wed,  3 Jul 2019 16:00:31 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 18:59:43 +0300
Message-Id: <20190703155944.9637-6-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-1-mlevitsk@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 03 Jul 2019 16:00:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/6] block/nvme: add support for write zeros
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c         | 69 +++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events   |  1 +
 include/block/nvme.h | 19 +++++++++++-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 152d27b07f..02e0846643 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -110,6 +110,8 @@ typedef struct {
     uint64_t max_transfer;
     bool plugged;
 
+    bool supports_write_zeros;
+
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
 
@@ -457,6 +459,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->max_transfer = MIN_NON_ZERO(s->max_transfer,
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
+    s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
+
     memset(resp, 0, 4096);
 
     cmd.cdw10 = 0;
@@ -469,6 +473,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->nsze = le64_to_cpu(idns->nsze);
     lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
 
+    if (NVME_ID_NS_DLFEAT_WRITE_ZEROS(idns->dlfeat) &&
+            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
+                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS)
+        bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
+
     if (lbaf->ms) {
         error_setg(errp, "Namespaces with metadata are not yet supported");
         goto out;
@@ -763,6 +772,8 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     BDRVNVMeState *s = bs->opaque;
 
+    bs->supported_write_flags = BDRV_REQ_FUA;
+
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
@@ -791,7 +802,6 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
     }
-    bs->supported_write_flags = BDRV_REQ_FUA;
     return 0;
 fail:
     nvme_close(bs);
@@ -1085,6 +1095,60 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 }
 
 
+static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
+                                              int64_t offset,
+                                              int bytes,
+                                              BdrvRequestFlags flags)
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
@@ -1297,6 +1361,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
+
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
 
diff --git a/block/trace-events b/block/trace-events
index 9ccea755da..12f363bb44 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -148,6 +148,7 @@ nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6,
 nvme_handle_event(void *s) "s %p"
 nvme_poll_cb(void *s) "s %p"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
+nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3ec8efcc43..65eb65c740 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -653,12 +653,29 @@ typedef struct NvmeIdNs {
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
 
+
+/*Deallocate Logical Block Features*/
+#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
+#define NVME_ID_NS_DLFEAT_WRITE_ZEROS(dlfeat)     ((dlfeat) & 0x04)
+
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x3)
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS       1
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
+
+
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
-- 
2.17.2


