Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDDC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA642072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gt9KWIiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA642072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWHJ-0007oU-NH
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1ipWFP-0006Av-Si
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1ipWFJ-0001EY-Ct
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:06 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1ipWFJ-0001Bp-1C
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:01 -0500
Received: by mail-io1-xd41.google.com with SMTP id c16so6745804ioo.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ykui0b3+dzoWSYCOtBfD7E2DCP0miZWhLPtZ+4aEHFM=;
 b=gt9KWIiK5UtaWJ+lRCyQwul2Se+/AVele71ZmmKWG1qKfwOliYjHz9toqm0+k0jrmj
 zxmg/dkEwi98EFqayMUPim7M0T8hAB1njKv8djOFjrm75X98SFRN8Ee3dlL4dXl92OPI
 UG/ynyEjH8QdXTfTklkGd0sAvOa4yR/cJ0+6nzbGnEMkQJZBc/BWksIG7lLMQEPtVVZb
 ieJ3NXCFb2NeeylzinMF3TyY/ZbbZndvtE9qpv2mk1QXei1wEA5iPVtkh6g8DlGHjlmX
 ZGWXpQIaS2aI7/qnDJnr/oijAlT/GFuIDlguJzsxG0jmt2oEQxKOPmGMUS2irRC/HXUO
 OGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ykui0b3+dzoWSYCOtBfD7E2DCP0miZWhLPtZ+4aEHFM=;
 b=lJ/Fg+bEKmrunE8hMTfnrJMoVAGy7V3kzRJR9kj1ZFPnxMBJLyvMqKnTIiAVJiO+u+
 P5SaWVkXQzZuvTA9NA1hTl2Fcc0EB6zoN5ss9hIf2QkiVT6c5QfQLseCfP3JRnsLIc1r
 sK0qMTo4hlPv/LzlnJg2xJ/BCBdEQ67g9/HhSsZdPTfk9d78srwjiAq204Ltxfc+01vI
 fMu4UaMVj5ve2rKRzE1bSYGrEDZV9U3WXAIB+bIJ8KABgrokr+GNPL+/0aFISpZfjBY4
 bLqDr5k0DR5cI0k8pbgHhVscap097Ta+dWd+gjP6/CEMtObIDyYR3SuzUHGlM68MPDZW
 UqAg==
X-Gm-Message-State: APjAAAVu+G6AT8W1NyJj8aQDxXfn46//N1koztQG5GrBWBGHiuEgckIE
 TUqorw0KeClSaSqrDgTgpU/h+F7KJ3KG46VYvipegQ==
X-Google-Smtp-Source: APXvYqwhkXV7yaGDwrVNxpYW3NUcPMOver6tYHd30pTIFGL6z1nYin6oNsu3D/3RHmWsu2RtQC8KVdHzjjnju9cLkw0=
X-Received: by 2002:a6b:6219:: with SMTP id f25mr6916800iog.248.1578570299797; 
 Thu, 09 Jan 2020 03:44:59 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191219130948eucas1p27bdef1318a097df34396a2a18b318064@eucas1p2.samsung.com>
 <20191219130921.309264-1-k.jensen@samsung.com>
 <20191219130921.309264-21-k.jensen@samsung.com>
In-Reply-To: <20191219130921.309264-21-k.jensen@samsung.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 9 Jan 2020 11:44:48 +0000
Message-ID: <CADSWDzuFqk56Y1t_3P5m5Q-DsMaeVok+-+RxRqhuohdRSjRK2g@mail.gmail.com>
Subject: Re: [PATCH v4 20/24] nvme: add support for scatter gather lists
To: Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On Thu, 19 Dec 2019 at 13:09, Klaus Jensen <k.jensen@samsung.com> wrote:
>
> For now, support the Data Block, Segment and Last Segment descriptor
> types.
>
> See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Fam Zheng <fam@euphon.net>
> ---
>  block/nvme.c          |  18 +-
>  hw/block/nvme.c       | 379 +++++++++++++++++++++++++++++++++++-------
>  hw/block/trace-events |   3 +
>  include/block/nvme.h  |  62 ++++++-
>  4 files changed, 393 insertions(+), 69 deletions(-)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index d41c4bda6e39..521f521054d5 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -446,7 +446,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          error_setg(errp, "Cannot map buffer for DMA");
>          goto out;
>      }
> -    cmd.prp1 = cpu_to_le64(iova);
> +    cmd.dptr.prp.prp1 = cpu_to_le64(iova);
>
>      if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
>          error_setg(errp, "Failed to identify controller");
> @@ -545,7 +545,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      }
>      cmd = (NvmeCmd) {
>          .opcode = NVME_ADM_CMD_CREATE_CQ,
> -        .prp1 = cpu_to_le64(q->cq.iova),
> +        .dptr.prp.prp1 = cpu_to_le64(q->cq.iova),
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x3),
>      };
> @@ -556,7 +556,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      }
>      cmd = (NvmeCmd) {
>          .opcode = NVME_ADM_CMD_CREATE_SQ,
> -        .prp1 = cpu_to_le64(q->sq.iova),
> +        .dptr.prp.prp1 = cpu_to_le64(q->sq.iova),
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x1 | (n << 16)),
>      };
> @@ -906,16 +906,16 @@ try_map:
>      case 0:
>          abort();
>      case 1:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = 0;
> +        cmd->dptr.prp.prp1 = pagelist[0];
> +        cmd->dptr.prp.prp2 = 0;
>          break;
>      case 2:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = pagelist[1];
> +        cmd->dptr.prp.prp1 = pagelist[0];
> +        cmd->dptr.prp.prp2 = pagelist[1];
>          break;
>      default:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
> +        cmd->dptr.prp.prp1 = pagelist[0];
> +        cmd->dptr.prp.prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
>          break;
>      }
>      trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f6591285b504..b3fca3c4ea58 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -73,7 +73,12 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>
>  static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
> -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> +    hwaddr hi = addr + size;
> +    if (hi < addr) {

What is the actual use case for that ?

> +        return 1;
> +    }
> +
> +    if (n->cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
>          memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
>          return 0;
>      }
> @@ -301,17 +306,287 @@ unmap:
>      return status;
>  }
>
> -static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -    uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
> +static uint16_t nvme_map_to_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> +    size_t len)
> +{
> +    hwaddr hi = addr + len;
> +    if (hi < addr) {
> +        return NVME_DATA_TRANSFER_ERROR;
> +    }
> +
> +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, hi)) {
> +        return NVME_DATA_TRANSFER_ERROR;
> +    }
> +
> +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> +    QEMUIOVector *iov, NvmeSglDescriptor *segment, uint64_t nsgld,
> +    uint32_t *len, bool is_cmb, NvmeRequest *req)
> +{
> +    dma_addr_t addr, trans_len;
> +    uint16_t status;
> +
> +    for (int i = 0; i < nsgld; i++) {
> +        if (NVME_SGL_TYPE(segment[i].type) != SGL_DESCR_TYPE_DATA_BLOCK) {
> +            trace_nvme_dev_err_invalid_sgl_descriptor(nvme_cid(req),
> +                NVME_SGL_TYPE(segment[i].type));
> +            return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> +        }
> +
> +        if (*len == 0) {
> +            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
> +                trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
> +                return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> +            }
> +
> +            break;
> +        }
> +
> +        addr = le64_to_cpu(segment[i].addr);
> +        trans_len = MIN(*len, le64_to_cpu(segment[i].len));
> +
> +        if (nvme_addr_is_cmb(n, addr)) {
> +            /*
> +             * All data and metadata, if any, associated with a particular
> +             * command shall be located in either the CMB or host memory. Thus,
> +             * if an address if found to be in the CMB and we have already

s/address if/address is ?

> +             * mapped data that is in host memory, the use is invalid.
> +             */
> +            if (!is_cmb && qsg->size) {
> +                return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +            }
> +        } else {
> +            /*
> +             * Similarly, if the address does not reference the CMB, but we
> +             * have already established that the request has data or metadata
> +             * in the CMB, the use is invalid.
> +             */
> +            if (is_cmb) {
> +                return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +            }
> +        }
> +
> +        if (is_cmb) {
> +            status = nvme_map_to_cmb(n, iov, addr, trans_len);
> +            if (status) {
> +                return status;
> +            }
> +        } else {
> +            qemu_sglist_add(qsg, addr, trans_len);
> +        }
> +
> +        *len -= trans_len;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
> +{
> +    const int MAX_NSGLD = 256;
> +
> +    NvmeSglDescriptor segment[MAX_NSGLD];
> +    uint64_t nsgld;
> +    uint16_t status;
> +    bool is_cmb = false;
> +    bool sgl_in_cmb = false;
> +    hwaddr addr = le64_to_cpu(sgl.addr);
> +
> +    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->nlb, len);
> +
> +    if (nvme_addr_is_cmb(n, addr)) {
> +        is_cmb = true;
> +
> +        qemu_iovec_init(iov, 1);
> +    } else {
> +        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> +    }
> +
> +    /*
> +     * If the entire transfer can be described with a single data block it can
> +     * be mapped directly.
> +     */
> +    if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> +        status = nvme_map_sgl_data(n, qsg, iov, &sgl, 1, &len, is_cmb, req);
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

Why not combining this with the condition few lines above
for the nvme_addr_is_cmb ? Also is the sgl_in_cmb really needed ?
If the address is from CMB, that  implies the queue is also there,
otherwise we wouldn't progress beyond this point. Isn't is_cmb sufficient ?

> +    }
> +
> +    while (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_SEGMENT) {
> +        bool addr_is_cmb;
> +
> +        nsgld = le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
> +
> +        /* read the segment in chunks of 256 descriptors (4k) */
> +        while (nsgld > MAX_NSGLD) {
> +            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> +                trace_nvme_dev_err_addr_read(addr);
> +                status = NVME_DATA_TRANSFER_ERROR;
> +                goto unmap;
> +            }
> +
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD, &len,
> +                is_cmb, req);

This will probably fail if there is a BitBucket Descriptor on the way (?)

> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            nsgld -= MAX_NSGLD;
> +            addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> +        }
> +
> +        if (nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor))) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            status = NVME_DATA_TRANSFER_ERROR;
> +            goto unmap;
> +        }
> +
> +        sgl = segment[nsgld - 1];
> +        addr = le64_to_cpu(sgl.addr);
> +
> +        /* an SGL is allowed to end with a Data Block in a regular Segment */
> +        if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len,
> +                is_cmb, req);
> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            goto out;
> +        }
> +
> +        /* do not map last descriptor */
> +        status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &len,
> +            is_cmb, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        /*
> +         * If the next segment is in the CMB, make sure that the sgl was
> +         * already located there.
> +         */
> +        addr_is_cmb = nvme_addr_is_cmb(n, addr);
> +        if ((sgl_in_cmb && !addr_is_cmb) || (!sgl_in_cmb && addr_is_cmb)) {
> +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +            goto unmap;
> +        }
> +    }
> +
> +    /*
> +     * If the segment did not end with a Data Block or a Segment descriptor, it
> +     * must be a Last Segment descriptor.
> +     */
> +    if (NVME_SGL_TYPE(sgl.type) != SGL_DESCR_TYPE_LAST_SEGMENT) {
> +        trace_nvme_dev_err_invalid_sgl_descriptor(nvme_cid(req),
> +            NVME_SGL_TYPE(sgl.type));
> +        status = NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> +        goto unmap;
> +    }
> +
> +    nsgld = le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
> +
> +    while (nsgld > MAX_NSGLD) {
> +        if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            status = NVME_DATA_TRANSFER_ERROR;
> +            goto unmap;
> +        }
> +
> +        status = nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD, &len,
> +            is_cmb, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        nsgld -= MAX_NSGLD;
> +        addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> +    }
> +

This seems to be the same as the while loop above. Why not making it common ?

BR
Beata

> +    if (nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor))) {
> +        trace_nvme_dev_err_addr_read(addr);
> +        status = NVME_DATA_TRANSFER_ERROR;
> +        goto unmap;
> +    }
> +
> +    status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, is_cmb, req);
> +    if (status) {
> +        goto unmap;
> +    }
> +
> +out:
> +    /* if there is any residual left in len, the SGL was too short */
> +    if (len) {
> +        status = NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> +        goto unmap;
> +    }
> +
> +    return NVME_SUCCESS;
> +
> +unmap:
> +    if (is_cmb) {
> +        qemu_iovec_destroy(iov);
> +    } else {
> +        qemu_sglist_destroy(qsg);
> +    }
> +
> +    return status;
> +}
> +
> +static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> +    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
>  {
>      QEMUSGList qsg;
>      QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>      size_t bytes;
>
> -    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
> -    if (status) {
> -        return status;
> +    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> +    case PSDT_PRP:
> +        status = nvme_map_prp(n, &qsg, &iov, le64_to_cpu(cmd->dptr.prp.prp1),
> +            le64_to_cpu(cmd->dptr.prp.prp2), len, req);
> +        if (status) {
> +            return status;
> +        }
> +
> +        break;
> +
> +    case PSDT_SGL_MPTR_CONTIGUOUS:
> +    case PSDT_SGL_MPTR_SGL:
> +        if (!req->sq->sqid) {
> +            /* SGLs shall not be used for Admin commands in NVMe over PCIe */
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        status = nvme_map_sgl(n, &qsg, &iov, cmd->dptr.sgl, len, req);
> +        if (status) {
> +            return status;
> +        }
> +
> +        break;
> +
> +    default:
> +        return NVME_INVALID_FIELD;
>      }
>
>      if (qsg.nsg > 0) {
> @@ -351,13 +626,21 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>
>  static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> -    NvmeNamespace *ns = req->ns;
> +    uint32_t len = req->nlb << nvme_ns_lbads(req->ns);
> +    uint64_t prp1, prp2;
>
> -    uint32_t len = req->nlb << nvme_ns_lbads(ns);
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> +    case PSDT_PRP:
> +        prp1 = le64_to_cpu(cmd->dptr.prp.prp1);
> +        prp2 = le64_to_cpu(cmd->dptr.prp.prp2);
>
> -    return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> +        return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> +    case PSDT_SGL_MPTR_CONTIGUOUS:
> +    case PSDT_SGL_MPTR_SGL:
> +        return nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len, req);
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
>  }
>
>  static void nvme_aio_destroy(NvmeAIO *aio)
> @@ -976,8 +1259,6 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>  static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      uint32_t buf_len, uint64_t off, NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>
>      uint32_t trans_len;
> @@ -1027,16 +1308,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>          nvme_clear_events(n, NVME_AER_TYPE_SMART);
>      }
>
> -    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> -        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &smart + off, trans_len, cmd,
> +        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>
>  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>      uint64_t off, NvmeRequest *req)
>  {
>      uint32_t trans_len;
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
>      NvmeFwSlotInfoLog fw_log;
>
>      if (off > sizeof(fw_log)) {
> @@ -1047,8 +1326,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>
> -    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> -        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len, cmd,
> +        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1198,25 +1477,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>
> -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
> -    NvmeRequest *req)
> +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
> -
>      trace_nvme_dev_identify_ctrl();
>
> -    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl), cmd,
> +        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>
> -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> -    NvmeRequest *req)
> +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
> -    uint32_t nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
>
>      trace_nvme_dev_identify_ns(nsid);
>
> @@ -1227,17 +1499,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
>
>      ns = &n->namespaces[nsid - 1];
>
> -    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
> +        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>
> -static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
> +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
>      static const int data_len = 4 * KiB;
> -    uint32_t min_nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    uint32_t min_nsid = le32_to_cpu(cmd->nsid);
>      uint32_t *list;
>      uint16_t ret;
>      int i, j = 0;
> @@ -1254,13 +1524,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
>              break;
>          }
>      }
> -    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> +    ret = nvme_dma(n, (uint8_t *) list, data_len, cmd,
>          DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
>
> -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
>      static const int len = 4096;
> @@ -1272,9 +1542,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
>          uint8_t nid[16];
>      };
>
> -    uint32_t nsid = le32_to_cpu(c->nsid);
> -    uint64_t prp1 = le64_to_cpu(c->prp1);
> -    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
>
>      struct ns_descr *list;
>      uint16_t ret;
> @@ -1297,8 +1565,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
>      list->nidl = 0x10;
>      *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
>
> -    ret = nvme_dma_prp(n, (uint8_t *) list, len, prp1, prp2,
> -        DMA_DIRECTION_FROM_DEVICE, req);
> +    ret = nvme_dma(n, (uint8_t *) list, len, cmd, DMA_DIRECTION_FROM_DEVICE,
> +        req);
>      g_free(list);
>      return ret;
>  }
> @@ -1309,13 +1577,13 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>
>      switch (le32_to_cpu(c->cns)) {
>      case 0x00:
> -        return nvme_identify_ns(n, c, req);
> +        return nvme_identify_ns(n, cmd, req);
>      case 0x01:
> -        return nvme_identify_ctrl(n, c, req);
> +        return nvme_identify_ctrl(n, cmd, req);
>      case 0x02:
> -        return nvme_identify_ns_list(n, c, req);
> +        return nvme_identify_ns_list(n, cmd, req);
>      case 0x03:
> -        return nvme_identify_ns_descr_list(n, c, req);
> +        return nvme_identify_ns_descr_list(n, cmd, req);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1377,13 +1645,10 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>  static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> -
>      uint64_t timestamp = nvme_get_timestamp(n);
>
> -    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
> -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> +    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp), cmd,
> +        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1466,11 +1731,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
>  {
>      uint16_t ret;
>      uint64_t timestamp;
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
>
> -    ret = nvme_dma_prp(n, (uint8_t *) &timestamp, sizeof(timestamp),
> -        prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
> +    ret = nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp), cmd,
> +        DMA_DIRECTION_TO_DEVICE, req);
>      if (ret != NVME_SUCCESS) {
>          return ret;
>      }
> @@ -2238,6 +2501,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>          id->vwc = 1;
>      }
>
> +    id->sgls = cpu_to_le32(0x1);
> +
>      strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
>      pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 09bfb3782dd0..8901cf087ee2 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -34,6 +34,7 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
>  nvme_dev_irq_masked(void) "IRQ is masked"
>  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
>  nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
> +nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
>  nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
>  nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
>  nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> @@ -85,6 +86,8 @@ nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
>  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
>  nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
>  nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_err_invalid_sgl_descriptor(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
> +nvme_dev_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index a873776d98b8..f3d41daae105 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -205,15 +205,53 @@ enum NvmeCmbszMask {
>  #define NVME_CMBSZ_GETSIZE(cmbsz) \
>      (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
>
> +enum NvmeSglDescriptorType {
> +    SGL_DESCR_TYPE_DATA_BLOCK           = 0x0,
> +    SGL_DESCR_TYPE_BIT_BUCKET           = 0x1,
> +    SGL_DESCR_TYPE_SEGMENT              = 0x2,
> +    SGL_DESCR_TYPE_LAST_SEGMENT         = 0x3,
> +    SGL_DESCR_TYPE_KEYED_DATA_BLOCK     = 0x4,
> +
> +    SGL_DESCR_TYPE_VENDOR_SPECIFIC      = 0xf,
> +};
> +
> +enum NvmeSglDescriptorSubtype {
> +    SGL_DESCR_SUBTYPE_ADDRESS = 0x0,
> +    SGL_DESCR_SUBTYPE_OFFSET  = 0x1,
> +};
> +
> +typedef struct NvmeSglDescriptor {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint8_t  rsvd[3];
> +    uint8_t  type;
> +} NvmeSglDescriptor;
> +
> +#define NVME_SGL_TYPE(type)     (type >> 4)
> +
> +typedef union NvmeCmdDptr {
> +    struct {
> +        uint64_t    prp1;
> +        uint64_t    prp2;
> +    } prp;
> +
> +    NvmeSglDescriptor sgl;
> +} NvmeCmdDptr;
> +
> +enum NvmePsdt {
> +    PSDT_PRP                 = 0x0,
> +    PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
> +    PSDT_SGL_MPTR_SGL        = 0x2,
> +};
> +
>  typedef struct NvmeCmd {
>      uint8_t     opcode;
> -    uint8_t     fuse;
> +    uint8_t     flags;
>      uint16_t    cid;
>      uint32_t    nsid;
>      uint64_t    res1;
>      uint64_t    mptr;
> -    uint64_t    prp1;
> -    uint64_t    prp2;
> +    NvmeCmdDptr dptr;
>      uint32_t    cdw10;
>      uint32_t    cdw11;
>      uint32_t    cdw12;
> @@ -222,6 +260,9 @@ typedef struct NvmeCmd {
>      uint32_t    cdw15;
>  } NvmeCmd;
>
> +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
> +
>  enum NvmeAdminCommands {
>      NVME_ADM_CMD_DELETE_SQ      = 0x00,
>      NVME_ADM_CMD_CREATE_SQ      = 0x01,
> @@ -427,6 +468,11 @@ enum NvmeStatusCodes {
>      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
>      NVME_INVALID_NSID           = 0x000b,
>      NVME_CMD_SEQ_ERROR          = 0x000c,
> +    NVME_INVALID_SGL_SEG_DESCRIPTOR  = 0x000d,
> +    NVME_INVALID_NUM_SGL_DESCRIPTORS = 0x000e,
> +    NVME_DATA_SGL_LENGTH_INVALID     = 0x000f,
> +    NVME_METADATA_SGL_LENGTH_INVALID = 0x0010,
> +    NVME_SGL_DESCRIPTOR_TYPE_INVALID = 0x0011,
>      NVME_INVALID_USE_OF_CMB     = 0x0012,
>      NVME_LBA_RANGE              = 0x0080,
>      NVME_CAP_EXCEEDED           = 0x0081,
> @@ -623,6 +669,16 @@ enum NvmeIdCtrlOncs {
>  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
>  #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
>
> +#define NVME_CTRL_SGLS_SUPPORTED(sgls)                 ((sgls) & 0x3)
> +#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT(sgls)    ((sgls) & (0x1 <<  0))
> +#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT(sgls) ((sgls) & (0x1 <<  1))
> +#define NVME_CTRL_SGLS_KEYED(sgls)                     ((sgls) & (0x1 <<  2))
> +#define NVME_CTRL_SGLS_BITBUCKET(sgls)                 ((sgls) & (0x1 << 16))
> +#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS(sgls)           ((sgls) & (0x1 << 17))
> +#define NVME_CTRL_SGLS_EXCESS_LENGTH(sgls)             ((sgls) & (0x1 << 18))
> +#define NVME_CTRL_SGLS_MPTR_SGL(sgls)                  ((sgls) & (0x1 << 19))
> +#define NVME_CTRL_SGLS_ADDR_OFFSET(sgls)               ((sgls) & (0x1 << 20))
> +
>  typedef struct NvmeFeatureVal {
>      uint32_t    arbitration;
>      uint32_t    power_mgmt;
> --
> 2.24.1
>

