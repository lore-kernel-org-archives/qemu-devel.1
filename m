Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89618C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8D520714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvbCI/S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8D520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3ol-0005aY-CZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3kH-0000Bj-58
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3kE-0006cG-9X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3kE-0006bv-3X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zmSigxpx/z+auRMz6Yx6Io5EHIHzObwLAYliQB239U=;
 b=fvbCI/S68bGISfMOieOtgIl+6TxPeQq270hk+bc6E16wI3e4pPFw/vPDKfdPwJPnTIvM0C
 AAKW/mR+FN6h9x27sZWg3wLUGf3KKOfBYvxfwffC18a8FKky72zptk9m4HWyincXRYVHtT
 EvP4HiUlTmuyNa4JVy92CXHM1Sy22rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-RNzaNS_jMvuFs0Hh9D5kOQ-1; Wed, 25 Mar 2020 06:58:44 -0400
X-MC-Unique: RNzaNS_jMvuFs0Hh9D5kOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A6DDB21;
 Wed, 25 Mar 2020 10:58:42 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90D805C241;
 Wed, 25 Mar 2020 10:58:40 +0000 (UTC)
Message-ID: <ab590abcfe5ea854aa9760086ad3bb000c4564be.camel@redhat.com>
Subject: Re: [PATCH v6 36/42] nvme: add support for scatter gather lists
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:58:39 +0200
In-Reply-To: <20200316142928.153431-37-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-37-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> For now, support the Data Block, Segment and Last Segment descriptor
> types.
> 
> See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 310 +++++++++++++++++++++++++++++++++++-------
>  hw/block/trace-events |   4 +
>  2 files changed, 262 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 49d323566393..b89b96990f52 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -76,7 +76,12 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  
>  static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
> -    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
> +    hwaddr hi = addr + size;
> +    if (hi < addr) {
> +        return 1;
> +    }
> +
> +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {

I would suggest to split this into a separate patch as well, since this contains not just one but 2 bugfixes
for this function and they are not related to sg lists.
Or at least move this to 'nvme: refactor nvme_addr_read' and rename this patch
to something like 'nvme: fix and refactor nvme_addr_read'


>          memcpy(buf, nvme_addr_to_cmb(n, addr), size);
>          return 0;
>      }
> @@ -328,13 +333,242 @@ unmap:
>      return status;
>  }
>  
> -static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -                             uint64_t prp1, uint64_t prp2, DMADirection dir,
> +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> +                                  QEMUIOVector *iov,
> +                                  NvmeSglDescriptor *segment, uint64_t nsgld,
> +                                  size_t *len, NvmeRequest *req)
> +{
> +    dma_addr_t addr, trans_len;
> +    uint32_t blk_len;
> +    uint16_t status;
> +
> +    for (int i = 0; i < nsgld; i++) {
> +        uint8_t type = NVME_SGL_TYPE(segment[i].type);
> +
> +        if (type != NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> +            switch (type) {
> +            case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
> +            case NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK:
> +                return NVME_SGL_DESCR_TYPE_INVALID | NVME_DNR;
> +            default:
To be honest I don't like that 'default'
I would explicitly state which segment types remain 
(I think segment list and last segment list, and various reserved types)
In fact for the reserved types you probably also want to return NVME_SGL_DESCR_TYPE_INVALID)

Also this function as well really begs to have a description prior to it,
something like 'map a sg list section, assuming that it only contains SGL data descriptions,
caller has to ensure this'.


> +                return NVME_INVALID_NUM_SGL_DESCRS | NVME_DNR;
> +            }
> +        }
> +
> +        if (*len == 0) {
> +            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
Nitpick: I would add a small comment here as well describiing
what this does (We reach this point if sg list covers more that that
was specified in the commmand, and the NVME_CTRL_SGLS_EXCESS_LENGTH controller
capability indicates that we support just throwing the extra data away)

> +            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
> +                break;
> +            }
> +
> +            trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
> +
> +        addr = le64_to_cpu(segment[i].addr);
> +        blk_len = le32_to_cpu(segment[i].len);
> +
> +        if (!blk_len) {
> +            continue;
> +        }
> +
> +        if (UINT64_MAX - addr < blk_len) {
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
Good!
> +
> +        trans_len = MIN(*len, blk_len);
> +
> +        status = nvme_map_addr(n, qsg, iov, addr, trans_len);
> +        if (status) {
> +            return status;
> +        }
> +
> +        *len -= trans_len;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                             NvmeSglDescriptor sgl, size_t len,
>                               NvmeRequest *req)
> +{
> +    /*
> +     * Read the segment in chunks of 256 descriptors (one 4k page) to avoid
> +     * dynamically allocating a potentially large SGL. The spec allows the SGL
> +     * to be larger than the command transfer size, so it is not bounded by
> +     * MDTS.
> +     */
Now this is a very good comment!

However I don't fully understand the note about the SGL. I assume that you mean
that the data that SGL covers still should be less that MDTS, but the actual SGL chain,
if assembled really in inefficient way (like 1 byte per each data descriptor) might be larger.


> +    const int SEG_CHUNK_SIZE = 256;
> +
> +    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
> +    uint64_t nsgld;
> +    uint32_t seg_len;
> +    uint16_t status;
> +    bool sgl_in_cmb = false;
> +    hwaddr addr;
> +    int ret;
> +
> +    sgld = &sgl;
> +    addr = le64_to_cpu(sgl.addr);
> +
> +    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->nlb,
> +                           len);
> +
> +    /*
> +     * If the entire transfer can be described with a single data block it can
> +     * be mapped directly.
> +     */
> +    if (NVME_SGL_TYPE(sgl.type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> +        status = nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        goto out;
> +    }
> +
> +    /*
> +     * If the segment is located in the CMB, the submission queue of the
> +     * request must also reside there.
> +     */
> +    if (nvme_addr_is_cmb(n, addr)) {
> +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +        }
> +
> +        sgl_in_cmb = true;
> +    }
> +
> +    for (;;) {
> +        seg_len = le32_to_cpu(sgld->len);
> +
> +        if (!seg_len || seg_len & 0xf) {
> +            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> +        }
It might be worth noting here that we are dealing with sgl (last) segment descriptor
and its length indeed must be non zero and multiple of 16.
Otherwise I confused this for a moment with the alignment requirements on the data itsel.

> +
> +        if (UINT64_MAX - addr < seg_len) {
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
> +
> +        nsgld = seg_len / sizeof(NvmeSglDescriptor);
> +
> +        while (nsgld > SEG_CHUNK_SIZE) {
> +            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> +                trace_nvme_dev_err_addr_read(addr);
> +                status = NVME_DATA_TRANSFER_ERROR;
> +                goto unmap;
> +            }
> +
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, SEG_CHUNK_SIZE,
> +                                       &len, req);
> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            nsgld -= SEG_CHUNK_SIZE;
> +            addr += SEG_CHUNK_SIZE * sizeof(NvmeSglDescriptor);
> +        }
> +
> +        ret = nvme_addr_read(n, addr, segment, nsgld *
> +                             sizeof(NvmeSglDescriptor));
> +        if (ret) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            status = NVME_DATA_TRANSFER_ERROR;
> +            goto unmap;
> +        }
> +
> +        last_sgld = &segment[nsgld - 1];
> +
> +        /* if the segment ends with a Data Block, then we are done */
> +        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            break;
> +        }
> +
> +        /* a Last Segment must end with a Data Block descriptor */
> +        if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
> +            status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> +            goto unmap;
> +        }
> +
> +        sgld = last_sgld;
> +        addr = le64_to_cpu(sgld->addr);
> +
> +        /*
> +         * Do not map the last descriptor; it will be a Segment or Last Segment
> +         * descriptor instead and handled by the next iteration.
> +         */
> +        status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &len, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        /*
> +         * If the next segment is in the CMB, make sure that the sgl was
> +         * already located there.
> +         */
> +        if (sgl_in_cmb != nvme_addr_is_cmb(n, addr)) {
> +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +            goto unmap;
> +        }
> +    }
> +
> +out:
> +    /* if there is any residual left in len, the SGL was too short */
> +    if (len) {
> +        status = NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        goto unmap;
> +    }
> +
> +    return NVME_SUCCESS;
> +
> +unmap:
> +    if (iov->iov) {
> +        qemu_iovec_destroy(iov);
> +    }
> +
> +    if (qsg->sg) {
> +        qemu_sglist_destroy(qsg);
> +    }
> +
> +    return status;
> +}
Looks OK, I might have missed something.

> +
> +static uint16_t nvme_map(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                         size_t len, NvmeRequest *req)
> +{
> +    uint64_t prp1, prp2;
> +
> +    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
> +    case PSDT_PRP:
> +        prp1 = le64_to_cpu(req->cmd.dptr.prp1);
> +        prp2 = le64_to_cpu(req->cmd.dptr.prp2);
> +
> +        return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
> +    case PSDT_SGL_MPTR_CONTIGUOUS:
> +    case PSDT_SGL_MPTR_SGL:
> +        /* SGLs shall not be used for Admin commands in NVMe over PCIe */
> +        if (!req->sq->sqid) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        return nvme_map_sgl(n, qsg, iov, req->cmd.dptr.sgl, len, req);
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +}
Looks OK
> +
> +static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> +                         DMADirection dir, NvmeRequest *req)
>  {
>      uint16_t status = NVME_SUCCESS;
>  
> -    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> +    status = nvme_map(n, &req->qsg, &req->iov, len, req);
>      if (status) {
>          return status;
>      }
> @@ -370,15 +604,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      return status;
>  }
>  
> -static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
> -                         QEMUIOVector *iov, size_t len, NvmeRequest *req)
> -{
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> -
> -    return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
> -}
> -
>  static void nvme_aio_destroy(NvmeAIO *aio)
>  {
>      g_free(aio);
> @@ -846,7 +1071,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          goto invalid;
>      }
>  
> -    status = nvme_map(n, cmd, &req->qsg, &req->iov, len, req);
> +    status = nvme_map(n, &req->qsg, &req->iov, len, req);
>      if (status) {
>          goto invalid;
>      }
> @@ -1013,8 +1238,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>                                  uint32_t buf_len, uint64_t off,
>                                  NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>  
>      uint32_t trans_len;
> @@ -1064,16 +1287,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>          nvme_clear_events(n, NVME_AER_TYPE_SMART);
>      }
>  
> -    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &smart + off, trans_len,
> +                    DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>                                   uint64_t off, NvmeRequest *req)
>  {
>      uint32_t trans_len;
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>      NvmeFwSlotInfoLog fw_log;
>  
>      if (off > sizeof(fw_log)) {
> @@ -1084,8 +1305,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>  
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>  
> -    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
> +                    DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> @@ -1093,8 +1314,6 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>                                  NvmeRequest *req)
>  {
>      uint32_t trans_len;
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>      uint8_t errlog[64];
>  
>      if (!rae) {
> @@ -1109,8 +1328,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>  
>      trans_len = MIN(sizeof(errlog) - off, buf_len);
>  
> -    return nvme_dma_prp(n, errlog, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, errlog, trans_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1255,13 +1473,10 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>  static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
>                                     NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
> -
>      trace_nvme_dev_identify_ctrl();
>  
> -    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> +                    DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> @@ -1269,8 +1484,6 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
>  {
>      NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
>  
>      trace_nvme_dev_identify_ns(nsid);
>  
> @@ -1281,8 +1494,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
>  
>      ns = &n->namespaces[nsid - 1];
>  
> -    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> +                    DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
> @@ -1290,8 +1503,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
>  {
>      static const int data_len = NVME_IDENTIFY_DATA_SIZE;
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
>      uint32_t *list;
>      uint16_t ret;
>      int i, j = 0;
> @@ -1308,8 +1519,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
>              break;
>          }
>      }
> -    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> -                       DMA_DIRECTION_FROM_DEVICE, req);
> +    ret = nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DEVICE,
> +                   req);
>      g_free(list);
>      return ret;
>  }
> @@ -1318,8 +1529,6 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
>                                              NvmeRequest *req)
>  {
>      uint32_t nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
>  
>      void *list;
>      uint16_t ret;
> @@ -1345,8 +1554,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
>      ns_descr->nidl = NVME_NIDT_UUID_LEN;
>      stl_be_p(ns_descr + sizeof(*ns_descr), nsid);
>  
> -    ret = nvme_dma_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, prp1,
> -                       prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    ret = nvme_dma(n, (uint8_t *)list, NVME_IDENTIFY_DATA_SIZE,
> +                   DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
> @@ -1425,13 +1634,10 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>  static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
>                                             NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> -
>      uint64_t timestamp = nvme_get_timestamp(n);
>  
> -    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
> +                    DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1514,11 +1720,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
>  {
>      uint16_t ret;
>      uint64_t timestamp;
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
> -    ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> -                       prp2, DMA_DIRECTION_TO_DEVICE, req);
> +    ret = nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
> +                   DMA_DIRECTION_TO_DEVICE, req);
>      if (ret != NVME_SUCCESS) {
>          return ret;
>      }
> @@ -2306,6 +2510,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->nn = cpu_to_le32(n->num_namespaces);
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
>  
> +    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT);
> +
>      pstrcpy((char *) id->subnqn, sizeof(id->subnqn), "nqn.2019-08.org.qemu:");
>      pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
>  
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index d51c09a4e454..70702cc67d5a 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -34,6 +34,7 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
>  nvme_dev_irq_masked(void) "IRQ is masked"
>  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
>  nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64"
> num_prps %d"
> +nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
>  nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count
> %"PRIu64" opc \"%s\" req %p"
>  nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
>  nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> @@ -89,6 +90,9 @@ nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
>  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> status 0x%"PRIx16""
>  nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
>  nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
> +nvme_dev_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
> +nvme_dev_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""


Best regards,
	Maxim Levitsky





