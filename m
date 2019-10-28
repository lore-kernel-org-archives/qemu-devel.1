Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0306ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06DA20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj/IV3iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06DA20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4mx-0005rV-K7
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3ww-0002mk-Iy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wt-0001xR-0k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wr-0001wj-Lf
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEa8sQ3p2Gih5MTY0vLHkOBrDz/zYHejSw4/57eoWCA=;
 b=Jj/IV3iGtNNCr3kX4BjuXXwU7D3U2VqAzx7Om18RUzLsod4U0z3ho3fauhc05n2+6NA1ng
 SgNGCr9oQPWxWymqQsqVuwoi81QG7W5j7i1DK2YrB2zCXuZ/9lDvL4zTs0piT/8D++D4qm
 RRvRba/eWTomLcHiUzlwSPLzor5McW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-VFcexWwiPoaZDROsngkKUg-1; Mon, 28 Oct 2019 08:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF46107AD28;
 Mon, 28 Oct 2019 12:16:32 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05B2560BF7;
 Mon, 28 Oct 2019 12:16:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 43/69] block/nvme: add support for discard
Date: Mon, 28 Oct 2019 13:14:35 +0100
Message-Id: <20191028121501.15279-44-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VFcexWwiPoaZDROsngkKUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190913133627.28450-3-mlevitsk@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nvme.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events |  2 ++
 2 files changed, 85 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 0ac38c24e6..d41c4bda6e 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -113,6 +113,7 @@ typedef struct {
     bool plugged;
=20
     bool supports_write_zeroes;
+    bool supports_discard;
=20
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
@@ -465,6 +466,7 @@ static void nvme_identify(BlockDriverState *bs, int nam=
espace, Error **errp)
=20
     oncs =3D le16_to_cpu(idctrl->oncs);
     s->supports_write_zeroes =3D !!(oncs & NVME_ONCS_WRITE_ZEROS);
+    s->supports_discard =3D !!(oncs & NVME_ONCS_DSM);
=20
     memset(resp, 0, 4096);
=20
@@ -1155,6 +1157,86 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockD=
riverState *bs,
 }
=20
=20
+static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
+                                         int64_t offset,
+                                         int bytes)
+{
+    BDRVNVMeState *s =3D bs->opaque;
+    NVMeQueuePair *ioq =3D s->queues[1];
+    NVMeRequest *req;
+    NvmeDsmRange *buf;
+    QEMUIOVector local_qiov;
+    int ret;
+
+    NvmeCmd cmd =3D {
+        .opcode =3D NVME_CMD_DSM,
+        .nsid =3D cpu_to_le32(s->nsid),
+        .cdw10 =3D cpu_to_le32(0), /*number of ranges - 0 based*/
+        .cdw11 =3D cpu_to_le32(1 << 2), /*deallocate bit*/
+    };
+
+    NVMeCoData data =3D {
+        .ctx =3D bdrv_get_aio_context(bs),
+        .ret =3D -EINPROGRESS,
+    };
+
+    if (!s->supports_discard) {
+        return -ENOTSUP;
+    }
+
+    assert(s->nr_queues > 1);
+
+    buf =3D qemu_try_blockalign0(bs, s->page_size);
+    if (!buf) {
+        return -ENOMEM;
+    }
+
+    buf->nlb =3D cpu_to_le32(bytes >> s->blkshift);
+    buf->slba =3D cpu_to_le64(offset >> s->blkshift);
+    buf->cattr =3D 0;
+
+    qemu_iovec_init(&local_qiov, 1);
+    qemu_iovec_add(&local_qiov, buf, 4096);
+
+    req =3D nvme_get_free_req(ioq);
+    assert(req);
+
+    qemu_co_mutex_lock(&s->dma_map_lock);
+    ret =3D nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
+    qemu_co_mutex_unlock(&s->dma_map_lock);
+
+    if (ret) {
+        req->busy =3D false;
+        goto out;
+    }
+
+    trace_nvme_dsm(s, offset, bytes);
+
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co =3D qemu_coroutine_self();
+    while (data.ret =3D=3D -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    qemu_co_mutex_lock(&s->dma_map_lock);
+    ret =3D nvme_cmd_unmap_qiov(bs, &local_qiov);
+    qemu_co_mutex_unlock(&s->dma_map_lock);
+
+    if (ret) {
+        goto out;
+    }
+
+    ret =3D data.ret;
+    trace_nvme_dsm_done(s, offset, bytes, ret);
+out:
+    qemu_iovec_destroy(&local_qiov);
+    qemu_vfree(buf);
+    return ret;
+
+}
+
+
 static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp)
 {
@@ -1261,6 +1343,7 @@ static BlockDriver bdrv_nvme =3D {
     .bdrv_co_pwritev          =3D nvme_co_pwritev,
=20
     .bdrv_co_pwrite_zeroes    =3D nvme_co_pwrite_zeroes,
+    .bdrv_co_pdiscard         =3D nvme_co_pdiscard,
=20
     .bdrv_co_flush_to_disk    =3D nvme_co_flush,
     .bdrv_reopen_prepare      =3D nvme_reopen_prepare,
diff --git a/block/trace-events b/block/trace-events
index 8706eab170..6ba86decca 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -156,6 +156,8 @@ nvme_write_zeroes(void *s, uint64_t offset, uint64_t by=
tes, int flags) "s %p off
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int =
align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int =
is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int r=
et) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
+nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" =
bytes %"PRId64""
+nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p off=
set %"PRId64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *q) "q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) =
"s %p cmd %p req %p qiov %p entries %d"
--=20
2.21.0


