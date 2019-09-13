Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2D9206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2D9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8loZ-0000Nr-RP
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8lko-0004Qj-1x
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8lkm-0003Qc-Kg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8lkj-0003Og-NO; Fri, 13 Sep 2019 09:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C7DB9D1D1;
 Fri, 13 Sep 2019 13:36:45 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E9AE5D712;
 Fri, 13 Sep 2019 13:36:40 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:36:26 +0300
Message-Id: <20190913133627.28450-2-mlevitsk@redhat.com>
In-Reply-To: <20190913133627.28450-1-mlevitsk@redhat.com>
References: <20190913133627.28450-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 13 Sep 2019 13:36:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] block/nvme: add support for write zeros
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
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c         | 72 +++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events   |  1 +
 include/block/nvme.h | 19 +++++++++++-
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 5be3a39b63..d95265fae4 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -111,6 +111,8 @@ typedef struct {
     uint64_t max_transfer;
     bool plugged;
 
+    bool supports_write_zeroes;
+
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
 
@@ -421,6 +423,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     NvmeIdNs *idns;
     NvmeLBAF *lbaf;
     uint8_t *resp;
+    uint16_t oncs;
     int r;
     uint64_t iova;
     NvmeCmd cmd = {
@@ -458,6 +461,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->max_transfer = MIN_NON_ZERO(s->max_transfer,
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
+    oncs = le16_to_cpu(idctrl->oncs);
+    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
+
     memset(resp, 0, 4096);
 
     cmd.cdw10 = 0;
@@ -470,6 +476,12 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->nsze = le64_to_cpu(idns->nsze);
     lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
 
+    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(idns->dlfeat) &&
+            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
+                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES) {
+        bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
+    }
+
     if (lbaf->ms) {
         error_setg(errp, "Namespaces with metadata are not yet supported");
         goto out;
@@ -764,6 +776,8 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     BDRVNVMeState *s = bs->opaque;
 
+    bs->supported_write_flags = BDRV_REQ_FUA;
+
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
@@ -792,7 +806,6 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
     }
-    bs->supported_write_flags = BDRV_REQ_FUA;
     return 0;
 fail:
     nvme_close(bs);
@@ -1086,6 +1099,60 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
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
+    uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
+
+    if (!s->supports_write_zeroes) {
+        return -ENOTSUP;
+    }
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
+    trace_nvme_write_zeroes(s, offset, bytes, flags);
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
@@ -1190,6 +1257,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
+
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
 
diff --git a/block/trace-events b/block/trace-events
index 04209f058d..651aa461d5 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -149,6 +149,7 @@ nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6,
 nvme_handle_event(void *s) "s %p"
 nvme_poll_cb(void *s) "s %p"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
+nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3ec8efcc43..33304c5a65 100644
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
+    uint8_t     res34[94];
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
 } NvmeIdNs;
 
+
+/*Deallocate Logical Block Features*/
+#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
+#define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
+
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x7)
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES       1
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
+
+
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
-- 
2.17.2


