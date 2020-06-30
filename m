Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7EFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7112206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7112206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq7aj-0007ll-4B
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7a7-0007Ia-MI; Tue, 30 Jun 2020 00:09:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7a4-0001Gz-VG; Tue, 30 Jun 2020 00:09:15 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 080D0BF670;
 Tue, 30 Jun 2020 04:09:08 +0000 (UTC)
Date: Tue, 30 Jun 2020 06:09:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 01/18] hw/block/nvme: Move NvmeRequest has_sg field to
 a bit flag
Message-ID: <20200630040904.ibgyrqcbvc7c33ve@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:33, Dmitry Fomichev wrote:
> In addition to the existing has_sg flag, a few more Boolean
> NvmeRequest flags are going to be introduced in subsequent patches.
> Convert "has_sg" variable to "flags" and define NvmeRequestFlags
> enum for individual flag values.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/block/nvme.c | 8 +++-----
>  hw/block/nvme.h | 6 +++++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 1aee042d4c..3ed9f3d321 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -350,7 +350,7 @@ static void nvme_rw_cb(void *opaque, int ret)
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_INTERNAL_DEV_ERROR;
>      }
> -    if (req->has_sg) {
> +    if (req->flags & NVME_REQ_FLG_HAS_SG) {
>          qemu_sglist_destroy(&req->qsg);
>      }
>      nvme_enqueue_req_completion(cq, req);
> @@ -359,7 +359,6 @@ static void nvme_rw_cb(void *opaque, int ret)
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>           BLOCK_ACCT_FLUSH);
>      req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> @@ -383,7 +382,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> @@ -422,14 +420,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>  
>      dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
>      if (req->qsg.nsg > 0) {
> -        req->has_sg = true;
> +        req->flags |= NVME_REQ_FLG_HAS_SG;
>          req->aiocb = is_write ?
>              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                            nvme_rw_cb, req) :
>              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                           nvme_rw_cb, req);
>      } else {
> -        req->has_sg = false;
>          req->aiocb = is_write ?
>              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
>                              req) :
> @@ -917,6 +914,7 @@ static void nvme_process_sq(void *opaque)
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
>          memset(&req->cqe, 0, sizeof(req->cqe));
> +        req->flags = 0;
>          req->cqe.cid = cmd.cid;
>  
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1d30c0bca2..0460cc0e62 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -16,11 +16,15 @@ typedef struct NvmeAsyncEvent {
>      NvmeAerResult result;
>  } NvmeAsyncEvent;
>  
> +enum NvmeRequestFlags {
> +    NVME_REQ_FLG_HAS_SG   = 1 << 0,
> +};
> +
>  typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
> -    bool                    has_sg;
> +    uint16_t                flags;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;
> -- 
> 2.21.0
> 
> 

