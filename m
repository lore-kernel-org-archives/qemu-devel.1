Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED27C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827C120663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827C120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkrX-0005WJ-9K
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDka6-0007w0-Gf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDka1-0001vh-TU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:54:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDkZt-0008MN-QB; Mon, 16 Mar 2020 03:54:26 -0400
Received: from apples.localdomain (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6043BBF6A1;
 Mon, 16 Mar 2020 07:54:24 +0000 (UTC)
Date: Mon, 16 Mar 2020 00:54:20 -0700
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 21/26] nvme: add support for scatter gather lists
Message-ID: <20200316075420.pjjwf3cxrbo4kboy@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095229eucas1p2b290e3603d73c129a4f6149805273705@eucas1p2.samsung.com>
 <20200204095208.269131-22-k.jensen@samsung.com>
 <5ffeac0978b02b0efec3c22d9472d43d3ea42024.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ffeac0978b02b0efec3c22d9472d43d3ea42024.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Feb 12 14:07, Maxim Levitsky wrote:
> On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> > For now, support the Data Block, Segment and Last Segment descriptor
> > types.
> > 
> > See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Acked-by: Fam Zheng <fam@euphon.net>
> > ---
> >  block/nvme.c          |  18 +-
> >  hw/block/nvme.c       | 375 +++++++++++++++++++++++++++++++++++-------
> >  hw/block/trace-events |   4 +
> >  include/block/nvme.h  |  62 ++++++-
> >  4 files changed, 389 insertions(+), 70 deletions(-)
> > 
> > diff --git a/block/nvme.c b/block/nvme.c
> > index d41c4bda6e39..521f521054d5 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -446,7 +446,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >          error_setg(errp, "Cannot map buffer for DMA");
> >          goto out;
> >      }
> > -    cmd.prp1 = cpu_to_le64(iova);
> > +    cmd.dptr.prp.prp1 = cpu_to_le64(iova);
> >  
> >      if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> >          error_setg(errp, "Failed to identify controller");
> > @@ -545,7 +545,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> >      }
> >      cmd = (NvmeCmd) {
> >          .opcode = NVME_ADM_CMD_CREATE_CQ,
> > -        .prp1 = cpu_to_le64(q->cq.iova),
> > +        .dptr.prp.prp1 = cpu_to_le64(q->cq.iova),
> >          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> >          .cdw11 = cpu_to_le32(0x3),
> >      };
> > @@ -556,7 +556,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> >      }
> >      cmd = (NvmeCmd) {
> >          .opcode = NVME_ADM_CMD_CREATE_SQ,
> > -        .prp1 = cpu_to_le64(q->sq.iova),
> > +        .dptr.prp.prp1 = cpu_to_le64(q->sq.iova),
> >          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> >          .cdw11 = cpu_to_le32(0x1 | (n << 16)),
> >      };
> > @@ -906,16 +906,16 @@ try_map:
> >      case 0:
> >          abort();
> >      case 1:
> > -        cmd->prp1 = pagelist[0];
> > -        cmd->prp2 = 0;
> > +        cmd->dptr.prp.prp1 = pagelist[0];
> > +        cmd->dptr.prp.prp2 = 0;
> >          break;
> >      case 2:
> > -        cmd->prp1 = pagelist[0];
> > -        cmd->prp2 = pagelist[1];
> > +        cmd->dptr.prp.prp1 = pagelist[0];
> > +        cmd->dptr.prp.prp2 = pagelist[1];
> >          break;
> >      default:
> > -        cmd->prp1 = pagelist[0];
> > -        cmd->prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
> > +        cmd->dptr.prp.prp1 = pagelist[0];
> > +        cmd->dptr.prp.prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
> >          break;
> >      }
> >      trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 204ae1d33234..a91c60fdc111 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -75,8 +75,10 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> >  
> >  static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> >  {
> > -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> > -        memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
> > +    hwaddr hi = addr + size;
> Are you sure you don't want to check for overflow here?
> Its theoretical issue since addr has to be almost full 64 bit
> but still for those things I check this very defensively.
> 

The use of nvme_addr_read in map_prp simply cannot overflow due to how
the size is calculated, but for SGLs it's different. But the overflow is
checked in map_sgl because we have to return a special error code in
that case.

On the other hand there may be other callers of nvme_addr_read in the
future that does not check this, so I'll re-add it.

> > +
> > +    if (n->cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
> Here you fix the bug I mentioned in patch 6. I suggest you to move the fix there.

Done.

> > +        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
> >          return 0;
> >      }
> >  
> > @@ -159,6 +161,48 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> >      }
> >  }
> >  
> > +static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> > +    size_t len)
> > +{
> > +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) {
> > +        return NVME_DATA_TRANSFER_ERROR;
> > +    }
> > +
> > +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> > +
> > +    return NVME_SUCCESS;
> > +}
> > +
> > +static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> > +    hwaddr addr, size_t len)
> > +{
> > +    bool addr_is_cmb = nvme_addr_is_cmb(n, addr);
> > +
> > +    if (addr_is_cmb) {
> > +        if (qsg->sg) {
> > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +        }
> > +
> > +        if (!iov->iov) {
> > +            qemu_iovec_init(iov, 1);
> > +        }
> > +
> > +        return nvme_map_addr_cmb(n, iov, addr, len);
> > +    }
> > +
> > +    if (iov->iov) {
> > +        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +    }
> > +
> > +    if (!qsg->sg) {
> > +        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> > +    }
> > +
> > +    qemu_sglist_add(qsg, addr, len);
> > +
> > +    return NVME_SUCCESS;
> > +}
> 
> Very good refactoring. I would also suggest you to move this to a separate
> patch. I always put refactoring first and then patches that add features.
> 

Done.

> > +
> >  static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> >      uint64_t prp1, uint64_t prp2, uint32_t len, NvmeRequest *req)
> >  {
> > @@ -307,15 +351,240 @@ unmap:
> >      return status;
> >  }
> >  
> > -static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > -    uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
> > +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> > +    QEMUIOVector *iov, NvmeSglDescriptor *segment, uint64_t nsgld,
> > +    uint32_t *len, NvmeRequest *req)
> > +{
> > +    dma_addr_t addr, trans_len;
> > +    uint32_t length;
> > +    uint16_t status;
> > +
> > +    for (int i = 0; i < nsgld; i++) {
> > +        uint8_t type = NVME_SGL_TYPE(segment[i].type);
> > +
> > +        if (type != NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> > +            switch (type) {
> > +            case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
> > +            case NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK:
> > +                return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> > +            default:
> > +                break;
> > +            }
> > +
> > +            return NVME_INVALID_NUM_SGL_DESCRIPTORS | NVME_DNR;
> Since the only way to reach the above statement is by that 'default'
> why not to move it there?

True. Fixed!

> > +        }
> > +
> > +        if (*len == 0) {
> > +            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
> > +                trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
> > +                return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> > +            }
> > +
> > +            break;
> > +        }
> > +
> > +        addr = le64_to_cpu(segment[i].addr);
> > +        length = le32_to_cpu(segment[i].len);
> > +
> > +        if (!length) {
> > +            continue;
> > +        }
> > +
> > +        if (UINT64_MAX - addr < length) {
> > +            return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> > +        }
> > +
> > +        trans_len = MIN(*len, length);
> > +
> > +        status = nvme_map_addr(n, qsg, iov, addr, trans_len);
> > +        if (status) {
> > +            return status;
> > +        }
> > +
> > +        *len -= trans_len;
> > +    }
> > +
> > +    return NVME_SUCCESS;
> > +}
> > +
> > +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> > +    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
> Minor nitpick: 
> Usually structs are passed by reference (that is pointer in C), 
> however I see that you change 'sgl' it in the function.
> IMHO this is a bit hard to read, I usually prefer not to change input parameters.
> 

Uhm, please help me, where am I changing it? That is unintentional I
think.

I *think* I prefer passing it by value, just because it fits nicely with
how different fields of the command is passed like that in other places.
We are "copying" the same amount of data as with PRPs (2x64 bits vs
1x128 bits).

> > +{
> > +    const int MAX_NSGLD = 256;
> 
> I personally would rename that const to something like SG_CHUNK_SIZE and add a comment, since
> it is just an arbitrary chunk size you use to avoid dynamic memory allocation,
> that is so we can avoid confusion vs the spec.

Good point. Done.

> 
> > +
> > +    NvmeSglDescriptor segment[MAX_NSGLD], *sgld, *last_sgld;
> > +    uint64_t nsgld;
> > +    uint32_t length;
> > +    uint16_t status;
> > +    bool sgl_in_cmb = false;
> > +    hwaddr addr;
> > +    int ret;
> > +
> > +    sgld = &sgl;
> > +    addr = le64_to_cpu(sgl.addr);
> > +
> > +    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->nlb,
> > +        len);
> > +
> > +    /*
> > +     * If the entire transfer can be described with a single data block it can
> > +     * be mapped directly.
> > +     */
> > +    if (NVME_SGL_TYPE(sgl.type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> > +        status = nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        goto out;
> > +    }
> > +
> > +    /*
> > +     * If the segment is located in the CMB, the submission queue of the
> > +     * request must also reside there.
> > +     */
> > +    if (nvme_addr_is_cmb(n, addr)) {
> > +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +        }
> > +
> > +        sgl_in_cmb = true;
> > +    }
> > +
> > +    for (;;) {
> > +        length = le32_to_cpu(sgld->len);
> > +
> > +        if (!length || length & 0xf) {
> > +            return NVME_INVALID_SGL_SEG_DESCRIPTOR | NVME_DNR;
> > +        }
> > +
> > +        if (UINT64_MAX - addr < length) {
> I assume you check for overflow here. Looks like very nice way to do it.
> This should be adopted in few more places
> > +            return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> > +        }
> > +
> > +        nsgld = length / sizeof(NvmeSglDescriptor);
> > +
> > +        /* read the segment in chunks of 256 descriptors (4k) */
> That comment is perfect to move/copy to definition of MAX_NSGLD

Done.

> 
> > +        while (nsgld > MAX_NSGLD) {
> > +            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> > +                trace_nvme_dev_err_addr_read(addr);
> > +                status = NVME_DATA_TRANSFER_ERROR;
> > +                goto unmap;
> > +            }
> > +
> > +            status = nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD, &len,
> > +                req);
> > +            if (status) {
> > +                goto unmap;
> > +            }
> > +
> > +            nsgld -= MAX_NSGLD;
> > +            addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> > +        }
> > +
> > +        ret = nvme_addr_read(n, addr, segment, nsgld *
> > +            sizeof(NvmeSglDescriptor));
> Reminding you to fix the line split issues. (align the sizeof on '(')

Done.

> 
> > +        if (ret) {
> > +            trace_nvme_dev_err_addr_read(addr);
> > +            status = NVME_DATA_TRANSFER_ERROR;
> > +            goto unmap;
> > +        }
> > +
> > +        last_sgld = &segment[nsgld - 1];
> > +
> > +        /* if the segment ends with a Data Block, then we are done */
> > +        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> > +            status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
> > +            if (status) {
> > +                goto unmap;
> > +            }
> > +
> > +            break;
> > +        }
> > +
> > +        /* a Last Segment must end with a Data Block descriptor */
> > +        if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
> > +            status = NVME_INVALID_SGL_SEG_DESCRIPTOR | NVME_DNR;
> > +            goto unmap;
> > +        }
> > +
> > +        sgld = last_sgld;
> > +        addr = le64_to_cpu(sgld->addr);
> > +
> > +        /*
> > +         * Do not map the last descriptor; it will be a Segment or Last Segment
> > +         * descriptor instead and handled by the next iteration.
> > +         */
> > +        status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &len, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        /*
> > +         * If the next segment is in the CMB, make sure that the sgl was
> > +         * already located there.
> > +         */
> > +        if (sgl_in_cmb != nvme_addr_is_cmb(n, addr)) {
> > +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +            goto unmap;
> > +        }
> > +    }
> > +
> > +out:
> > +    /* if there is any residual left in len, the SGL was too short */
> > +    if (len) {
> > +        status = NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> > +        goto unmap;
> > +    }
> > +
> > +    return NVME_SUCCESS;
> > +
> > +unmap:
> > +    if (iov->iov) {
> > +        qemu_iovec_destroy(iov);
> > +    }
> > +
> > +    if (qsg->sg) {
> > +        qemu_sglist_destroy(qsg);
> > +    }
> > +
> > +    return status;
> > +}
> Looks good, much better than in V4
> 
> 
> > +
> > +static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > +    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
> >  {
> >      uint16_t status = NVME_SUCCESS;
> >      size_t bytes;
> >  
> > -    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> > -    if (status) {
> > -        return status;
> > +    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> > +    case PSDT_PRP:
> > +        status = nvme_map_prp(n, &req->qsg, &req->iov,
> > +            le64_to_cpu(cmd->dptr.prp.prp1), le64_to_cpu(cmd->dptr.prp.prp2),
> > +            len, req);
> > +        if (status) {
> > +            return status;
> > +        }
> > +
> > +        break;
> > +
> > +    case PSDT_SGL_MPTR_CONTIGUOUS:
> > +    case PSDT_SGL_MPTR_SGL:
> > +        if (!req->sq->sqid) {
> > +            /* SGLs shall not be used for Admin commands in NVMe over PCIe */
> > +            return NVME_INVALID_FIELD;
> > +        }
> > +
> > +        status = nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len,
> > +            req);
> > +        if (status) {
> > +            return status;
> > +        }
> Minor nitpick: you can probably refactor this to an 'err' label in the end of function.

This has been refactored in another patch.

> > +
> > +        break;
> > +
> > +    default:
> > +        return NVME_INVALID_FIELD;
> >      }
> 
> 
> >  
> >      if (req->qsg.nsg > 0) {
> > @@ -351,13 +620,21 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> >  
> >  static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> > -    NvmeNamespace *ns = req->ns;
> > +    uint32_t len = req->nlb << nvme_ns_lbads(req->ns);
> > +    uint64_t prp1, prp2;
> >  
> > -    uint32_t len = req->nlb << nvme_ns_lbads(ns);
> > -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> > +    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> > +    case PSDT_PRP:
> > +        prp1 = le64_to_cpu(cmd->dptr.prp.prp1);
> > +        prp2 = le64_to_cpu(cmd->dptr.prp.prp2);
> >  
> > -    return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> > +        return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> > +    case PSDT_SGL_MPTR_CONTIGUOUS:
> > +    case PSDT_SGL_MPTR_SGL:
> > +        return nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len, req);
> > +    default:
> > +        return NVME_INVALID_FIELD;
> > +    }
> >  }
> >  
> >  static void nvme_aio_destroy(NvmeAIO *aio)
> > @@ -972,8 +1249,6 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
> >  static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> >      uint32_t buf_len, uint64_t off, NvmeRequest *req)
> >  {
> > -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> >      uint32_t nsid = le32_to_cpu(cmd->nsid);
> >  
> >      uint32_t trans_len;
> > @@ -1023,16 +1298,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> >          nvme_clear_events(n, NVME_AER_TYPE_SMART);
> >      }
> >  
> > -    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> > -        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > +    return nvme_dma(n, (uint8_t *) &smart + off, trans_len, cmd,
> > +        DMA_DIRECTION_FROM_DEVICE, req);
> >  }
> >  
> >  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> >      uint64_t off, NvmeRequest *req)
> >  {
> >      uint32_t trans_len;
> > -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> >      NvmeFwSlotInfoLog fw_log;
> >  
> >      if (off > sizeof(fw_log)) {
> > @@ -1043,8 +1316,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> >  
> >      trans_len = MIN(sizeof(fw_log) - off, buf_len);
> >  
> > -    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> > -        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > +    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len, cmd,
> > +        DMA_DIRECTION_FROM_DEVICE, req);
> >  }
> >  
> >  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > @@ -1194,25 +1467,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> >      return NVME_SUCCESS;
> >  }
> >  
> > -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
> > -    NvmeRequest *req)
> > +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> > -    uint64_t prp1 = le64_to_cpu(c->prp1);
> > -    uint64_t prp2 = le64_to_cpu(c->prp2);
> > -
> >      trace_nvme_dev_identify_ctrl();
> >  
> > -    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> > -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > +    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl), cmd,
> > +        DMA_DIRECTION_FROM_DEVICE, req);
> >  }
> >  
> > -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> > -    NvmeRequest *req)
> > +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> >      NvmeNamespace *ns;
> > -    uint32_t nsid = le32_to_cpu(c->nsid);
> > -    uint64_t prp1 = le64_to_cpu(c->prp1);
> > -    uint64_t prp2 = le64_to_cpu(c->prp2);
> > +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> >  
> >      trace_nvme_dev_identify_ns(nsid);
> >  
> > @@ -1223,17 +1489,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> >  
> >      ns = &n->namespaces[nsid - 1];
> >  
> > -    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> > -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > +    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
> > +        DMA_DIRECTION_FROM_DEVICE, req);
> >  }
> >  
> > -static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
> > +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
> >      NvmeRequest *req)
> >  {
> >      static const int data_len = 4 * KiB;
> > -    uint32_t min_nsid = le32_to_cpu(c->nsid);
> > -    uint64_t prp1 = le64_to_cpu(c->prp1);
> > -    uint64_t prp2 = le64_to_cpu(c->prp2);
> > +    uint32_t min_nsid = le32_to_cpu(cmd->nsid);
> >      uint32_t *list;
> >      uint16_t ret;
> >      int i, j = 0;
> > @@ -1250,13 +1514,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
> >              break;
> >          }
> >      }
> > -    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> > +    ret = nvme_dma(n, (uint8_t *) list, data_len, cmd,
> >          DMA_DIRECTION_FROM_DEVICE, req);
> >      g_free(list);
> >      return ret;
> >  }
> >  
> > -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> > +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
> >      NvmeRequest *req)
> >  {
> >      static const int len = 4096;
> > @@ -1268,9 +1532,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> >          uint8_t nid[16];
> >      };
> >  
> > -    uint32_t nsid = le32_to_cpu(c->nsid);
> > -    uint64_t prp1 = le64_to_cpu(c->prp1);
> > -    uint64_t prp2 = le64_to_cpu(c->prp2);
> > +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> >  
> >      struct ns_descr *list;
> >      uint16_t ret;
> > @@ -1293,8 +1555,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> >      list->nidl = 0x10;
> >      *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> >  
> > -    ret = nvme_dma_prp(n, (uint8_t *) list, len, prp1, prp2,
> > -        DMA_DIRECTION_FROM_DEVICE, req);
> > +    ret = nvme_dma(n, (uint8_t *) list, len, cmd, DMA_DIRECTION_FROM_DEVICE,
> > +        req);
> >      g_free(list);
> >      return ret;
> >  }
> > @@ -1305,13 +1567,13 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  
> >      switch (le32_to_cpu(c->cns)) {
> >      case 0x00:
> > -        return nvme_identify_ns(n, c, req);
> > +        return nvme_identify_ns(n, cmd, req);
> >      case 0x01:
> > -        return nvme_identify_ctrl(n, c, req);
> > +        return nvme_identify_ctrl(n, cmd, req);
> >      case 0x02:
> > -        return nvme_identify_ns_list(n, c, req);
> > +        return nvme_identify_ns_list(n, cmd, req);
> >      case 0x03:
> > -        return nvme_identify_ns_descr_list(n, c, req);
> > +        return nvme_identify_ns_descr_list(n, cmd, req);
> >      default:
> >          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
> >          return NVME_INVALID_FIELD | NVME_DNR;
> > @@ -1373,13 +1635,10 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
> >  static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> >      NvmeRequest *req)
> >  {
> > -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> > -
> >      uint64_t timestamp = nvme_get_timestamp(n);
> >  
> > -    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
> > -        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > +    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp), cmd,
> > +        DMA_DIRECTION_FROM_DEVICE, req);
> >  }
> >  
> >  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > @@ -1462,11 +1721,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> >  {
> >      uint16_t ret;
> >      uint64_t timestamp;
> > -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> >  
> > -    ret = nvme_dma_prp(n, (uint8_t *) &timestamp, sizeof(timestamp),
> > -        prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
> > +    ret = nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp), cmd,
> > +        DMA_DIRECTION_TO_DEVICE, req);
> >      if (ret != NVME_SUCCESS) {
> >          return ret;
> >      }
> > @@ -2232,6 +2489,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> >          id->vwc = 1;
> >      }
> >  
> > +    id->sgls = cpu_to_le32(0x1);
> Being part of the spec, it would be nice to #define this as well.

Done.

> > +
> >      strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
> >      pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
> >  
> > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > index 09bfb3782dd0..81d69e15fc32 100644
> > --- a/hw/block/trace-events
> > +++ b/hw/block/trace-events
> > @@ -34,6 +34,7 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
> >  nvme_dev_irq_masked(void) "IRQ is masked"
> >  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> >  nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1
> > 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
> > +nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
> >  nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count
> > %"PRIu64" opc \"%s\" req %p"
> >  nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
> >  nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> > @@ -85,6 +86,9 @@ nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
> >  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> > status 0x%"PRIx16""
> >  nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> >  nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
> > +nvme_dev_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
> > +nvme_dev_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
> > +nvme_dev_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
> >  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> >  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
> >  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index a873776d98b8..dbdeecf82358 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -205,15 +205,53 @@ enum NvmeCmbszMask {
> >  #define NVME_CMBSZ_GETSIZE(cmbsz) \
> >      (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
> >  
> > +enum NvmeSglDescriptorType {
> > +    NVME_SGL_DESCR_TYPE_DATA_BLOCK           = 0x0,
> > +    NVME_SGL_DESCR_TYPE_BIT_BUCKET           = 0x1,
> > +    NVME_SGL_DESCR_TYPE_SEGMENT              = 0x2,
> > +    NVME_SGL_DESCR_TYPE_LAST_SEGMENT         = 0x3,
> > +    NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK     = 0x4,
> > +
> > +    NVME_SGL_DESCR_TYPE_VENDOR_SPECIFIC      = 0xf,
> > +};
> > +
> > +enum NvmeSglDescriptorSubtype {
> > +    NVME_SGL_DESCR_SUBTYPE_ADDRESS = 0x0,
> > +};
> > +
> > +typedef struct NvmeSglDescriptor {
> > +    uint64_t addr;
> > +    uint32_t len;
> > +    uint8_t  rsvd[3];
> > +    uint8_t  type;
> > +} NvmeSglDescriptor;
> 
> I suggest you add a build time struct size check for this,
> just in case compiler tries something funny.
> (look at _nvme_check_size, at nvme.h)
> 

Done.

> Also I think that the spec update change that adds the NvmeSglDescriptor
> should be split into separate patch (or better be added in one big patch that adds all 1.3d features), 
> which would make it also easier to see changes that touch the other nvme driver we have.
> 

Done.

> > +
> > +#define NVME_SGL_TYPE(type)     ((type >> 4) & 0xf)
> > +#define NVME_SGL_SUBTYPE(type)  (type & 0xf)
> > +
> > +typedef union NvmeCmdDptr {
> > +    struct {
> > +        uint64_t    prp1;
> > +        uint64_t    prp2;
> > +    } prp;
> > +
> > +    NvmeSglDescriptor sgl;
> > +} NvmeCmdDptr;
> > +
> > +enum NvmePsdt {
> > +    PSDT_PRP                 = 0x0,
> > +    PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
> > +    PSDT_SGL_MPTR_SGL        = 0x2,
> > +};
> > +
> >  typedef struct NvmeCmd {
> >      uint8_t     opcode;
> > -    uint8_t     fuse;
> > +    uint8_t     flags;
> >      uint16_t    cid;
> >      uint32_t    nsid;
> >      uint64_t    res1;
> >      uint64_t    mptr;
> > -    uint64_t    prp1;
> > -    uint64_t    prp2;
> > +    NvmeCmdDptr dptr;
> >      uint32_t    cdw10;
> >      uint32_t    cdw11;
> >      uint32_t    cdw12;
> > @@ -222,6 +260,9 @@ typedef struct NvmeCmd {
> >      uint32_t    cdw15;
> >  } NvmeCmd;
> >  
> > +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> > +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
> > +
> >  enum NvmeAdminCommands {
> >      NVME_ADM_CMD_DELETE_SQ      = 0x00,
> >      NVME_ADM_CMD_CREATE_SQ      = 0x01,
> > @@ -427,6 +468,11 @@ enum NvmeStatusCodes {
> >      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
> >      NVME_INVALID_NSID           = 0x000b,
> >      NVME_CMD_SEQ_ERROR          = 0x000c,
> > +    NVME_INVALID_SGL_SEG_DESCRIPTOR  = 0x000d,
> > +    NVME_INVALID_NUM_SGL_DESCRIPTORS = 0x000e,
> > +    NVME_DATA_SGL_LENGTH_INVALID     = 0x000f,
> > +    NVME_METADATA_SGL_LENGTH_INVALID = 0x0010,
> > +    NVME_SGL_DESCRIPTOR_TYPE_INVALID = 0x0011,
> >      NVME_INVALID_USE_OF_CMB     = 0x0012,
> >      NVME_LBA_RANGE              = 0x0080,
> >      NVME_CAP_EXCEEDED           = 0x0081,
> > @@ -623,6 +669,16 @@ enum NvmeIdCtrlOncs {
> >  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
> >  #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
> >  
> > +#define NVME_CTRL_SGLS_SUPPORTED(sgls)                 ((sgls) & 0x3)
> > +#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT(sgls)    ((sgls) & (0x1 <<  0))
> > +#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT(sgls) ((sgls) & (0x1 <<  1))
> > +#define NVME_CTRL_SGLS_KEYED(sgls)                     ((sgls) & (0x1 <<  2))
> > +#define NVME_CTRL_SGLS_BITBUCKET(sgls)                 ((sgls) & (0x1 << 16))
> > +#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS(sgls)           ((sgls) & (0x1 << 17))
> > +#define NVME_CTRL_SGLS_EXCESS_LENGTH(sgls)             ((sgls) & (0x1 << 18))
> > +#define NVME_CTRL_SGLS_MPTR_SGL(sgls)                  ((sgls) & (0x1 << 19))
> > +#define NVME_CTRL_SGLS_ADDR_OFFSET(sgls)               ((sgls) & (0x1 << 20))
> > +
> >  typedef struct NvmeFeatureVal {
> >      uint32_t    arbitration;
> >      uint32_t    power_mgmt;
> 
> Best regards,
> 	Maxim Levitsky
> 

