Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F3C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C25A2187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C25A2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hii7c-0004YW-7I
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihnh-0004vB-6y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihng-0000vA-3L
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihnc-0000tn-QJ; Wed, 03 Jul 2019 12:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE83083F42;
 Wed,  3 Jul 2019 16:07:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com
 [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD323891A4;
 Wed,  3 Jul 2019 16:07:55 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 19:07:54 +0300
Message-Id: <20190703160754.12361-1-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-7-mlevitsk@redhat.com>
References: <20190703155944.9637-7-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 16:07:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4] block/nvme: add support for discard
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events |  2 ++
 2 files changed, 83 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 02e0846643..96a715dcc1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -111,6 +111,7 @@ typedef struct {
     bool plugged;
 
     bool supports_write_zeros;
+    bool supports_discard;
 
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
@@ -460,6 +461,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
     s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
+    s->supports_discard = (idctrl->oncs & NVME_ONCS_DSM) != 0;
 
     memset(resp, 0, 4096);
 
@@ -1149,6 +1151,84 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 
+static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
+                                         int64_t offset,
+                                         int bytes)
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
+    buf->nlb = cpu_to_le32(bytes >> s->blkshift);
+    buf->slba = cpu_to_le64(offset >> s->blkshift);
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
@@ -1363,6 +1443,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_co_pwritev          = nvme_co_pwritev,
 
     .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
+    .bdrv_co_pdiscard         = nvme_co_pdiscard,
 
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
diff --git a/block/trace-events b/block/trace-events
index 12f363bb44..f763f79d99 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -152,6 +152,8 @@ nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offs
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


