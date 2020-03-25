Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC8EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F6A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlYQZ5Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F6A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3s4-0002k5-NJ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3ja-0007Ft-Hh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3jW-0005gX-FL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3jW-0005er-7x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STYYtIQKksmx2Oyyf4v/Bc4HNqMbN0gClGtCnyQ3IhE=;
 b=NlYQZ5Qhcma9WErxbD62WRVwNHVfzDMcerPDyUQeM2eVhqqN+k4SLQW4a4rlcjA5e2NFjq
 cMa0ZBBs40pj820QMb1DohU8fIzxBHyTiUm/+778zAAaCrY2K7RwWfggctHADWig9ZozSW
 ySCmS4uCcIrBvRO7v7huSNhPygvKdL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-frr31SACMZakfdpg89qRjg-1; Wed, 25 Mar 2020 06:57:58 -0400
X-MC-Unique: frr31SACMZakfdpg89qRjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E431005509;
 Wed, 25 Mar 2020 10:57:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEEEA5C1A2;
 Wed, 25 Mar 2020 10:57:54 +0000 (UTC)
Message-ID: <d7ed3bb2e27814d414bcba2ace23e633ebe5df9f.camel@redhat.com>
Subject: Re: [PATCH v6 32/42] nvme: allow multiple aios per command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:57:53 +0200
In-Reply-To: <20200316142928.153431-33-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-33-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This refactors how the device issues asynchronous block backend
> requests. The NvmeRequest now holds a queue of NvmeAIOs that are
> associated with the command. This allows multiple aios to be issued for
> a command. Only when all requests have been completed will the device
> post a completion queue entry.
> 
> Because the device is currently guaranteed to only issue a single aio
> request per command, the benefit is not immediately obvious. But this
> functionality is required to support metadata, the dataset management
> command and other features.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 377 +++++++++++++++++++++++++++++++-----------
>  hw/block/nvme.h       | 129 +++++++++++++--
>  hw/block/trace-events |   6 +
>  3 files changed, 407 insertions(+), 105 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 0d2b5b45b0c5..817384e3b1a9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -59,6 +59,7 @@
>      } while (0)
>  
>  static void nvme_process_sq(void *opaque);
> +static void nvme_aio_cb(void *opaque, int ret);
>  
>  static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
>  {
> @@ -373,6 +374,99 @@ static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
>      return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
>  }
>  
> +static void nvme_aio_destroy(NvmeAIO *aio)
> +{
> +    g_free(aio);
> +}
> +
> +static inline void nvme_req_register_aio(NvmeRequest *req, NvmeAIO *aio,
I guess I'll call this nvme_req_add_aio,
or nvme_add_aio_to_reg.
Thoughts?
Also you can leave this as is, but add a comment on top explaining this

> +                                         NvmeAIOOp opc)
> +{
> +    aio->opc = opc;
> +
> +    trace_nvme_dev_req_register_aio(nvme_cid(req), aio, blk_name(aio->blk),
> +                                    aio->offset, aio->len,
> +                                    nvme_aio_opc_str(aio), req);
> +
> +    if (req) {
> +        QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
> +    }
> +}
> +
> +static void nvme_submit_aio(NvmeAIO *aio)
OK, this name makes sense
Also please add a comment on top.
> +{
> +    BlockBackend *blk = aio->blk;
> +    BlockAcctCookie *acct = &aio->acct;
> +    BlockAcctStats *stats = blk_get_stats(blk);
> +
> +    bool is_write;
> +
> +    switch (aio->opc) {
> +    case NVME_AIO_OPC_NONE:
> +        break;
> +
> +    case NVME_AIO_OPC_FLUSH:
> +        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> +        aio->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
> +        break;
> +
> +    case NVME_AIO_OPC_WRITE_ZEROES:
> +        block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
> +        aio->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
> +                                           BDRV_REQ_MAY_UNMAP, nvme_aio_cb,
> +                                           aio);
> +        break;
> +
> +    case NVME_AIO_OPC_READ:
> +    case NVME_AIO_OPC_WRITE:
> +        is_write = (aio->opc == NVME_AIO_OPC_WRITE);
> +
> +        block_acct_start(stats, acct, aio->len,
> +                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> +
> +        if (aio->qsg) {
> +            if (is_write) {
> +                aio->aiocb = dma_blk_write(blk, aio->qsg, aio->offset,
> +                                           BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
> +            } else {
> +                aio->aiocb = dma_blk_read(blk, aio->qsg, aio->offset,
> +                                          BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
> +            }
> +        } else {
> +            if (is_write) {
> +                aio->aiocb = blk_aio_pwritev(blk, aio->offset, aio->iov, 0,
> +                                             nvme_aio_cb, aio);
> +            } else {
> +                aio->aiocb = blk_aio_preadv(blk, aio->offset, aio->iov, 0,
> +                                            nvme_aio_cb, aio);
> +            }
> +        }
Looks much better that way that a early return!

> +
> +        break;
> +    }
> +}
> +
> +static void nvme_rw_aio(BlockBackend *blk, uint64_t offset, NvmeRequest *req)
> +{
> +    NvmeAIO *aio;
> +    size_t len = req->qsg.nsg > 0 ? req->qsg.size : req->iov.size;
> +
> +    aio = g_new0(NvmeAIO, 1);
> +
> +    *aio = (NvmeAIO) {
> +        .blk = blk,
> +        .offset = offset,
> +        .len = len,
> +        .req = req,
> +        .qsg = req->qsg.sg ? &req->qsg : NULL,
> +        .iov = req->iov.iov ? &req->iov : NULL,
OK, this is the fix for the bug I mentioned in V5, looks good.

> +    };
> +
> +    nvme_req_register_aio(req, aio, nvme_req_is_write(req) ?
> +                          NVME_AIO_OPC_WRITE : NVME_AIO_OPC_READ);
> +    nvme_submit_aio(aio);
> +}
> +
>  static void nvme_post_cqes(void *opaque)
>  {
>      NvmeCQueue *cq = opaque;
> @@ -396,6 +490,7 @@ static void nvme_post_cqes(void *opaque)
>          nvme_inc_cq_tail(cq);
>          pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
>              sizeof(req->cqe));
> +        nvme_req_clear(req);
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
>      if (cq->tail != cq->head) {
> @@ -406,8 +501,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> -    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
> -                                          req->status);
> +    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid, req->status);
> +
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -505,9 +600,11 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
>      return NVME_SUCCESS;
>  }
>  
> -static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> -                                         uint16_t ctrl, NvmeRequest *req)
> +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, uint16_t ctrl,
> +                                         NvmeRequest *req)
>  {
> +    NvmeNamespace *ns = req->ns;
> +
This should go to the patch that added nvme_check_prinfo

>      if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK)) {
>          trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -516,10 +613,10 @@ static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
>      return NVME_SUCCESS;
>  }
>  
> -static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
> -                                         uint64_t slba, uint32_t nlb,
> -                                         NvmeRequest *req)
> +static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
> +                                         uint32_t nlb, NvmeRequest *req)
>  {
> +    NvmeNamespace *ns = req->ns;
>      uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
This should go to the patch that added nvme_check_bounds as well

>  
>      if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
> @@ -530,55 +627,154 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
>      return NVME_SUCCESS;
>  }
>  
> -static void nvme_rw_cb(void *opaque, int ret)
> +static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns = req->ns;
> +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
> +    uint16_t ctrl = le16_to_cpu(rw->control);
> +    size_t len = req->nlb << nvme_ns_lbads(ns);
> +    uint16_t status;
> +
> +    status = nvme_check_mdts(n, len, req);
> +    if (status) {
> +        return status;
> +    }
> +
> +    status = nvme_check_prinfo(n, ctrl, req);
> +    if (status) {
> +        return status;
> +    }
> +
> +    status = nvme_check_bounds(n, req->slba, req->nlb, req);
> +    if (status) {
> +        return status;
> +    }
> +
> +    return NVME_SUCCESS;
> +}

Nitpick: I hate to say it but nvme_check_rw should be in a separate patch as well.
It will also make diff more readable (when adding a funtion and changing a function
at the same time, you get a diff between two unrelated things)


> +
> +static void nvme_rw_cb(NvmeRequest *req, void *opaque)
>  {
> -    NvmeRequest *req = opaque;
>      NvmeSQueue *sq = req->sq;
>      NvmeCtrl *n = sq->ctrl;
>      NvmeCQueue *cq = n->cq[sq->cqid];
>  
> -    if (!ret) {
> -        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
> -        req->status = NVME_SUCCESS;
> -    } else {
> -        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
> -        req->status = NVME_INTERNAL_DEV_ERROR;
> -    }
> -
> -    if (req->qsg.nalloc) {
> -        qemu_sglist_destroy(&req->qsg);
> -    }
> -    if (req->iov.nalloc) {
> -        qemu_iovec_destroy(&req->iov);
> -    }
> +    trace_nvme_dev_rw_cb(nvme_cid(req), req->cmd.nsid);
>  
>      nvme_enqueue_req_completion(cq, req);
>  }
>  
> -static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static void nvme_aio_cb(void *opaque, int ret)
>  {
> -    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> -         BLOCK_ACCT_FLUSH);
> -    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> +    NvmeAIO *aio = opaque;
> +    NvmeRequest *req = aio->req;
> +
> +    BlockBackend *blk = aio->blk;
> +    BlockAcctCookie *acct = &aio->acct;
> +    BlockAcctStats *stats = blk_get_stats(blk);
> +
> +    Error *local_err = NULL;
> +
> +    trace_nvme_dev_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
> +                          nvme_aio_opc_str(aio), req);
> +
> +    if (req) {
> +        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
> +    }
> +
> +    if (!ret) {
> +        block_acct_done(stats, acct);
> +    } else {
> +        block_acct_failed(stats, acct);
> +
> +        if (req) {
> +            uint16_t status;
> +
> +            switch (aio->opc) {
> +            case NVME_AIO_OPC_READ:
> +                status = NVME_UNRECOVERED_READ;
> +                break;
> +            case NVME_AIO_OPC_WRITE:
> +            case NVME_AIO_OPC_WRITE_ZEROES:
> +                status = NVME_WRITE_FAULT;
> +                break;
> +            default:
> +                status = NVME_INTERNAL_DEV_ERROR;
> +                break;
> +            }
> +
> +            trace_nvme_dev_err_aio(nvme_cid(req), aio, blk_name(blk),
> +                                   aio->offset, nvme_aio_opc_str(aio), req,
> +                                   status);
> +
> +            error_setg_errno(&local_err, -ret, "aio failed");
> +            error_report_err(local_err);
> +
> +            /*
> +             * An Internal Error trumps all other errors. For other errors,
> +             * only set the first error encountered. Any additional errors will
> +             * be recorded in the error information log page.
> +             */
> +            if (!req->status ||
> +                nvme_status_is_error(status, NVME_INTERNAL_DEV_ERROR)) {
> +                req->status = status;
> +            }
> +        }
> +    }
> +
> +    if (aio->cb) {
> +        aio->cb(aio, aio->cb_arg, ret);
> +    }
> +
> +    if (req && QTAILQ_EMPTY(&req->aio_tailq)) {
> +        if (req->cb) {
> +            req->cb(req, req->cb_arg);
> +        } else {
> +            NvmeSQueue *sq = req->sq;
> +            NvmeCtrl *n = sq->ctrl;
> +            NvmeCQueue *cq = n->cq[sq->cqid];
> +
> +            nvme_enqueue_req_completion(cq, req);
> +        }
> +    }
> +
> +    nvme_aio_destroy(aio);
> +}
> +
> +static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    NvmeAIO *aio = g_new0(NvmeAIO, 1);
> +
> +    *aio = (NvmeAIO) {
> +        .blk = n->conf.blk,
> +        .req = req,
> +    };
> +
> +    nvme_req_register_aio(req, aio, NVME_AIO_OPC_FLUSH);
> +    nvme_submit_aio(aio);
>  
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
Very small nitpick about zeros/zeroes: This should move to some refactoring patch to be honest. 

>  {
> -    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> -    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> -    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> -    uint64_t slba = le64_to_cpu(rw->slba);
> -    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
> -    uint64_t offset = slba << data_shift;
> -    uint32_t count = nlb << data_shift;
> +    NvmeAIO *aio;
> +
> +    NvmeNamespace *ns = req->ns;
> +    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
>      uint16_t ctrl = le16_to_cpu(rw->control);
> +
> +    int64_t offset;
> +    size_t count;
>      uint16_t status;
>  
> -    status = nvme_check_prinfo(n, ns, ctrl, req);
> +    req->slba = le64_to_cpu(rw->slba);
> +    req->nlb  = le16_to_cpu(rw->nlb) + 1;
> +
> +    trace_nvme_dev_write_zeroes(nvme_cid(req), le32_to_cpu(cmd->nsid),
> +                                req->slba, req->nlb);
> +
> +    status = nvme_check_prinfo(n, ctrl, req);
>      if (status) {
>          goto invalid;
>      }
> @@ -588,15 +784,26 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          goto invalid;
>      }
>  
> -    status = nvme_check_bounds(n, ns, slba, nlb, req);
> +    status = nvme_check_bounds(n, req->slba, req->nlb, req);
>      if (status) {
>          goto invalid;
>      }
>  
> -    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> -                     BLOCK_ACCT_WRITE);
> -    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> -                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
> +    offset = req->slba << nvme_ns_lbads(ns);
> +    count = req->nlb << nvme_ns_lbads(ns);
> +
> +    aio = g_new0(NvmeAIO, 1);
> +
> +    *aio = (NvmeAIO) {
> +        .blk = n->conf.blk,
> +        .offset = offset,
> +        .len = count,
> +        .req = req,
> +    };
> +
> +    nvme_req_register_aio(req, aio, NVME_AIO_OPC_WRITE_ZEROES);
> +    nvme_submit_aio(aio);
> +
>      return NVME_NO_COMPLETE;
>  
>  invalid:
> @@ -604,63 +811,36 @@ invalid:
>      return status;
>  }
>  
> -static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> -    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> -    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
> -    uint64_t slba = le64_to_cpu(rw->slba);
> -    uint16_t ctrl = le16_to_cpu(rw->control);
> +    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
> +    NvmeNamespace *ns = req->ns;
> +    uint32_t len;
> +    int status;
>  
> -    uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> -    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> -    uint64_t data_size = (uint64_t)nlb << data_shift;
> -    uint64_t data_offset = slba << data_shift;
> -    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
> -    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> -    uint16_t status;
> +    enum BlockAcctType acct =
> +        nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
>  
> -    trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba);
> +    req->nlb  = le16_to_cpu(rw->nlb) + 1;
> +    req->slba = le64_to_cpu(rw->slba);
>  
> -    status = nvme_check_mdts(n, data_size, req);
> -    if (status) {
> -        goto invalid;
> -    }
> +    len = req->nlb << nvme_ns_lbads(ns);
>  
> -    status = nvme_check_prinfo(n, ns, ctrl, req);
> -    if (status) {
> -        goto invalid;
> -    }
> +    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
> +                      req->nlb << nvme_ns_lbads(req->ns), req->slba);
>  
> -    status = nvme_check_bounds(n, ns, slba, nlb, req);
> +    status = nvme_check_rw(n, req);
>      if (status) {
>          goto invalid;
>      }
>  
> -    status = nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req);
> +    status = nvme_map(n, cmd, &req->qsg, &req->iov, len, req);
>      if (status) {
>          goto invalid;
>      }
>  
> -    if (req->qsg.nsg > 0) {
> -        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
> -                         acct);
> -
> -        req->aiocb = is_write ?
> -            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> -                          nvme_rw_cb, req) :
> -            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> -                         nvme_rw_cb, req);
> -    } else {
> -        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
> -                         acct);
> -
> -        req->aiocb = is_write ?
> -            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
> -                            req) :
> -            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
> -                           req);
> -    }
> +    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
> +    nvme_req_set_cb(req, nvme_rw_cb, NULL);
>  
>      return NVME_NO_COMPLETE;
>  
> @@ -671,23 +851,26 @@ invalid:
>  
>  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> -    NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>  
> +    trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid),
> +                          cmd->opcode);
> +
>      if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
>          trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
>  
> -    ns = &n->namespaces[nsid - 1];
> +    req->ns = &n->namespaces[nsid - 1];
> +
>      switch (cmd->opcode) {
>      case NVME_CMD_FLUSH:
> -        return nvme_flush(n, ns, cmd, req);
> +        return nvme_flush(n, cmd, req);
>      case NVME_CMD_WRITE_ZEROS:
> -        return nvme_write_zeros(n, ns, cmd, req);
> +        return nvme_write_zeroes(n, cmd, req);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
> -        return nvme_rw(n, ns, cmd, req);
> +        return nvme_rw(n, cmd, req);
>      default:
>          trace_nvme_dev_err_invalid_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -711,6 +894,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      NvmeRequest *req, *next;
>      NvmeSQueue *sq;
>      NvmeCQueue *cq;
> +    NvmeAIO *aio;
>      uint16_t qid = le16_to_cpu(c->qid);
>  
>      if (unlikely(!qid || nvme_check_sqid(n, qid))) {
> @@ -723,8 +907,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      sq = n->sq[qid];
>      while (!QTAILQ_EMPTY(&sq->out_req_list)) {
>          req = QTAILQ_FIRST(&sq->out_req_list);
> -        assert(req->aiocb);
> -        blk_aio_cancel(req->aiocb);
> +        while (!QTAILQ_EMPTY(&req->aio_tailq)) {
> +            aio = QTAILQ_FIRST(&req->aio_tailq);
> +            assert(aio->aiocb);
> +            blk_aio_cancel(aio->aiocb);
> +        }
>      }
>      if (!nvme_check_cqid(n, sq->cqid)) {
>          cq = n->cq[sq->cqid];
> @@ -761,6 +948,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
>      QTAILQ_INIT(&sq->out_req_list);
>      for (i = 0; i < sq->size; i++) {
>          sq->io_req[i].sq = sq;
> +        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
>          QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
>      }
>      sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
> @@ -1474,8 +1662,9 @@ static void nvme_process_sq(void *opaque)
>          req = QTAILQ_FIRST(&sq->req_list);
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> -        memset(&req->cqe, 0, sizeof(req->cqe));
> +
>          req->cqe.cid = cmd.cid;
> +        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
>  
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
>              nvme_admin_cmd(n, &cmd, req);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index b05c2153aebf..5d5fa8c8833a 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -27,16 +27,58 @@ typedef struct NvmeAsyncEvent {
>      NvmeAerResult result;
>  } NvmeAsyncEvent;
>  
> -typedef struct NvmeRequest {
> -    struct NvmeSQueue       *sq;
> -    BlockAIOCB              *aiocb;
> -    uint16_t                status;
> -    NvmeCqe                 cqe;
> -    BlockAcctCookie         acct;
> -    QEMUSGList              qsg;
> -    QEMUIOVector            iov;
> -    QTAILQ_ENTRY(NvmeRequest)entry;
> -} NvmeRequest;
> +typedef struct NvmeRequest NvmeRequest;
> +typedef void NvmeRequestCompletionFunc(NvmeRequest *req, void *opaque);
> +
> +struct NvmeRequest {
> +    struct NvmeSQueue    *sq;
> +    struct NvmeNamespace *ns;
> +
> +    NvmeCqe  cqe;
> +    NvmeCmd  cmd;
> +    uint16_t status;
> +
> +    uint64_t slba;
> +    uint32_t nlb;
> +
> +    QEMUSGList   qsg;
> +    QEMUIOVector iov;
> +
> +    NvmeRequestCompletionFunc *cb;
> +    void                      *cb_arg;
> +
> +    QTAILQ_HEAD(, NvmeAIO)    aio_tailq;
> +    QTAILQ_ENTRY(NvmeRequest) entry;
> +};
> +
> +static inline void nvme_req_clear(NvmeRequest *req)
> +{
> +    req->ns = NULL;
> +    memset(&req->cqe, 0, sizeof(req->cqe));
> +    req->status = NVME_SUCCESS;
> +    req->slba = req->nlb = 0x0;
> +    req->cb = req->cb_arg = NULL;
> +
> +    if (req->qsg.sg) {
> +        qemu_sglist_destroy(&req->qsg);
> +    }
> +
> +    if (req->iov.iov) {
> +        qemu_iovec_destroy(&req->iov);
> +    }
> +}
> +
> +static inline void nvme_req_set_cb(NvmeRequest *req,
> +                                   NvmeRequestCompletionFunc *cb, void *cb_arg)
> +{
> +    req->cb = cb;
> +    req->cb_arg = cb_arg;
> +}
> +
> +static inline void nvme_req_clear_cb(NvmeRequest *req)
> +{
> +    req->cb = req->cb_arg = NULL;
> +}
>  
>  typedef struct NvmeSQueue {
>      struct NvmeCtrl *ctrl;
> @@ -88,6 +130,60 @@ static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
>      return 1 << nvme_ns_lbads(ns);
>  }
>  
> +typedef enum NvmeAIOOp {
> +    NVME_AIO_OPC_NONE         = 0x0,
> +    NVME_AIO_OPC_FLUSH        = 0x1,
> +    NVME_AIO_OPC_READ         = 0x2,
> +    NVME_AIO_OPC_WRITE        = 0x3,
> +    NVME_AIO_OPC_WRITE_ZEROES = 0x4,
> +} NvmeAIOOp;
> +
> +typedef struct NvmeAIO NvmeAIO;
> +typedef void NvmeAIOCompletionFunc(NvmeAIO *aio, void *opaque, int ret);
> +
> +struct NvmeAIO {
> +    NvmeRequest *req;
> +
> +    NvmeAIOOp       opc;
> +    int64_t         offset;
> +    size_t          len;
> +    BlockBackend    *blk;
> +    BlockAIOCB      *aiocb;
> +    BlockAcctCookie acct;
> +
> +    NvmeAIOCompletionFunc *cb;
> +    void                  *cb_arg;
> +
> +    QEMUSGList   *qsg;
> +    QEMUIOVector *iov;
> +
> +    QTAILQ_ENTRY(NvmeAIO) tailq_entry;
> +};
> +
> +static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
> +{
> +    switch (aio->opc) {
> +    case NVME_AIO_OPC_NONE:         return "NVME_AIO_OP_NONE";
> +    case NVME_AIO_OPC_FLUSH:        return "NVME_AIO_OP_FLUSH";
> +    case NVME_AIO_OPC_READ:         return "NVME_AIO_OP_READ";
> +    case NVME_AIO_OPC_WRITE:        return "NVME_AIO_OP_WRITE";
> +    case NVME_AIO_OPC_WRITE_ZEROES: return "NVME_AIO_OP_WRITE_ZEROES";
> +    default:                        return "NVME_AIO_OP_UNKNOWN";
> +    }
> +}
> +
> +static inline bool nvme_req_is_write(NvmeRequest *req)
> +{
> +    switch (req->cmd.opcode) {
> +    case NVME_CMD_WRITE:
> +    case NVME_CMD_WRITE_UNCOR:
> +    case NVME_CMD_WRITE_ZEROS:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  #define TYPE_NVME "nvme"
>  #define NVME(obj) \
>          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -140,10 +236,21 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
>  static inline uint16_t nvme_cid(NvmeRequest *req)
>  {
>      if (req) {
> -        return le16_to_cpu(req->cqe.cid);
> +        return le16_to_cpu(req->cmd.cid);
>      }
>  
>      return 0xffff;
>  }
>  
> +static inline bool nvme_status_is_error(uint16_t status, uint16_t err)
> +{
> +    /* strip DNR and MORE */
> +    return (status & 0xfff) == err;
> +}
> +
> +static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
> +{
> +    return req->sq->ctrl;
> +}
> +
>  #endif /* HW_NVME_H */
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 2aceb0537e05..aa449e314818 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -34,7 +34,12 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
>  nvme_dev_irq_masked(void) "IRQ is masked"
>  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
>  nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64"
> num_prps %d"
> +nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count
> %"PRIu64" opc \"%s\" req %p"
> +nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
> +nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
>  nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> +nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
> +nvme_dev_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
>  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> qflags=%"PRIu16""
>  nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16",
> qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
>  nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
> @@ -81,6 +86,7 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_
>  # nvme traces for error conditions
>  nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
>  nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
> +nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> status 0x%"PRIx16""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""

The patch is still too large IMHO to review properly and few things can be split from it.
I tried my best to review it but I might have missed something.

Best regards,
	Maxim Levitsky





