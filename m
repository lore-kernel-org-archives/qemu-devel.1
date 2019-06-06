Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D70C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049F42070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="gF/YUSy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049F42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYiyO-0000jU-4E
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:21:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1hYixH-0008ML-TG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1hYixG-0004Eu-N0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:20:43 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17975
	helo=sender1.zoho.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fam@euphon.net>)
	id 1hYix9-0003WE-7Y; Wed, 05 Jun 2019 23:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559791176; cv=none; d=zoho.com.cn; s=zohoarc; 
	b=fYykQI+qMtasSOq27ZgIKdK4Uq+e66LtG8zMQQob+HnFqNO6Vp0oYayEe/aEnPVFCp0si1G3QikDy3hbZ73qSa65WeINji9x5F36wRO+0MotqwclDrFmPATViLYoKGyuhwjQKlN7m6I8Wu9XxQ4jROVX+X2OpmEOajg/J5LR6P0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
	s=zohoarc; t=1559791176;
	h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
	bh=DTfRXrt/H+zal+RDVIXjPK3+f2rba7VnZx9zJNi5gIM=; 
	b=iQ0TUchU7/OVQJiYSJidwjMqoY+5M9VcGd8EGT8+Q82JauaXTQT7tJXNRGZB/nsq5AjpSRH/nwdbmeAxpA71A2epXbojJrE8wGMle/0D5uyeBjsx2WWcYAzS426d2VA0apulmofIPxcCQK4a2vHWtQXqfwwy4HI5bbW8BRH9E9o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=euphon.net;
	spf=pass  smtp.mailfrom=fam@euphon.net;
	dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1559791176; 
	s=zoho; d=euphon.net; i=fam@euphon.net;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	l=4368; bh=DTfRXrt/H+zal+RDVIXjPK3+f2rba7VnZx9zJNi5gIM=;
	b=gF/YUSy2t96YEu784ZIpY2DCwqLeERuduKZe9RpnwLdQS0BicP6zION+yqbkY3nC
	HWxmxwD3IRkunuInuU5X9nIBcqtwZCrW2mImDfBo6jKUNVVcra19HLOyvBbnd05nNB1
	pIAfBjNJzdPXjZ2RYZbeK9kK4cJEKJBPRfBubndI=
Received: from localhost (120.52.147.48 [120.52.147.48]) by mx.zoho.com.cn
	with SMTPS id 1559791173940451.02808619303437;
	Thu, 6 Jun 2019 11:19:33 +0800 (CST)
Date: Thu, 6 Jun 2019 11:19:32 +0800
From: Fam Zheng <fam@euphon.net>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190606031932.3nowbnt67o4omxjv@debian>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
	<20190417195355.16123-6-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417195355.16123-6-mlevitsk@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v2 5/5] block/nvme: add support for discard
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 04/17 22:53, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c       | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/trace-events |  2 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 35b925899f..b83912c627 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -110,6 +110,7 @@ typedef struct {
>      bool plugged;
>  
>      bool supports_write_zeros;
> +    bool supports_discard;
>  
>      CoMutex dma_map_lock;
>      CoQueue dma_flush_queue;
> @@ -462,6 +463,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>  
>  
>      s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
> +    s->supports_discard = (idctrl->oncs & NVME_ONCS_DSM) != 0;
>  
>      memset(resp, 0, 4096);
>  
> @@ -1144,6 +1146,83 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
>  }
>  
>  
> +static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
> +        int64_t offset, int bytes)

While you respin, you can align the parameters.

> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeRequest *req;
> +    NvmeDsmRange *buf;
> +    QEMUIOVector local_qiov;
> +    int r;
> +
> +    NvmeCmd cmd = {
> +        .opcode = NVME_CMD_DSM,
> +        .nsid = cpu_to_le32(s->nsid),
> +        .cdw10 = 0, /*number of ranges - 0 based*/
> +        .cdw11 = cpu_to_le32(1 << 2), /*deallocate bit*/
> +    };
> +
> +    NVMeCoData data = {
> +        .ctx = bdrv_get_aio_context(bs),
> +        .ret = -EINPROGRESS,
> +    };
> +
> +    if (!s->supports_discard) {
> +        return -ENOTSUP;
> +    }
> +
> +    assert(s->nr_queues > 1);
> +
> +    buf = qemu_try_blockalign0(bs, 4096);
> +    if (!buf) {
> +            return -ENOMEM;
> +    }
> +
> +    buf->nlb = bytes >> s->blkshift;
> +    buf->slba = offset >> s->blkshift;

This buffer is for the device, do we need to do anything about the endianness?

> +    buf->cattr = 0;
> +
> +    qemu_iovec_init(&local_qiov, 1);
> +    qemu_iovec_add(&local_qiov, buf, 4096);
> +
> +    req = nvme_get_free_req(ioq);
> +    assert(req);
> +
> +    qemu_co_mutex_lock(&s->dma_map_lock);
> +    r = nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
> +    qemu_co_mutex_unlock(&s->dma_map_lock);
> +
> +    if (r) {
> +        req->busy = false;
> +        return r;
> +    }
> +
> +    trace_nvme_dsm(s, offset, bytes);
> +
> +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> +
> +    data.co = qemu_coroutine_self();
> +    while (data.ret == -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    qemu_co_mutex_lock(&s->dma_map_lock);
> +    r = nvme_cmd_unmap_qiov(bs, &local_qiov);
> +    qemu_co_mutex_unlock(&s->dma_map_lock);
> +    if (r) {
> +        return r;
> +    }
> +
> +    trace_nvme_dsm_done(s, offset, bytes, data.ret);
> +
> +    qemu_iovec_destroy(&local_qiov);
> +    qemu_vfree(buf);
> +    return data.ret;
> +
> +}
> +
> +
>  static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
>                                 BlockReopenQueue *queue, Error **errp)
>  {
> @@ -1250,6 +1329,7 @@ static BlockDriver bdrv_nvme = {
>      .bdrv_co_pwritev          = nvme_co_pwritev,
>  
>      .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard         = nvme_co_pdiscard,
>  
>      .bdrv_co_flush_to_disk    = nvme_co_flush,
>      .bdrv_reopen_prepare      = nvme_reopen_prepare,
> diff --git a/block/trace-events b/block/trace-events
> index 943a58569f..e55ac5c40b 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -148,6 +148,8 @@ nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offs
>  nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
>  nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
>  nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
> +nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes %"PRId64""
> +nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
>  nvme_dma_map_flush(void *s) "s %p"
>  nvme_free_req_queue_wait(void *q) "q %p"
>  nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
> -- 
> 2.17.2
> 


