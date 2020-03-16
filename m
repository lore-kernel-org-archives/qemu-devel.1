Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2711D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2711D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlCG-00050z-Q3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDkZC-0007fV-Gr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDkZA-0008KM-UM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:53:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDkZ6-0007HY-T1; Mon, 16 Mar 2020 03:53:37 -0400
Received: from apples.localdomain (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id A40A5BF6A1;
 Mon, 16 Mar 2020 07:53:35 +0000 (UTC)
Date: Mon, 16 Mar 2020 00:53:31 -0700
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 20/26] nvme: handle dma errors
Message-ID: <20200316075331.j5rgi4iwhnwmec6l@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf@eucas1p2.samsung.com>
 <20200204095208.269131-21-k.jensen@samsung.com>
 <8bbf8a3d3babaa5883ceceea83172d4876768d8e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bbf8a3d3babaa5883ceceea83172d4876768d8e.camel@redhat.com>
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

On Feb 12 13:52, Maxim Levitsky wrote:
> On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> > Handling DMA errors gracefully is required for the device to pass the
> > block/011 test ("disable PCI device while doing I/O") in the blktests
> > suite.
> > 
> > With this patch the device passes the test by retrying "critical"
> > transfers (posting of completion entries and processing of submission
> > queue entries).
> > 
> > If DMA errors occur at any other point in the execution of the command
> > (say, while mapping the PRPs), the command is aborted with a Data
> > Transfer Error status code.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c       | 42 +++++++++++++++++++++++++++++++++---------
> >  hw/block/trace-events |  2 ++
> >  include/block/nvme.h  |  2 +-
> >  3 files changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index f8c81b9e2202..204ae1d33234 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -73,14 +73,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> >      return addr >= low && addr < hi;
> >  }
> >  
> > -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> > +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> >  {
> >      if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> >          memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
> > -        return;
> > +        return 0;
> >      }
> >  
> > -    pci_dma_read(&n->parent_obj, addr, buf, size);
> > +    return pci_dma_read(&n->parent_obj, addr, buf, size);
> >  }
> >  
> >  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> > @@ -168,6 +168,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> >      uint16_t status = NVME_SUCCESS;
> >      bool is_cmb = false;
> >      bool prp_list_in_cmb = false;
> > +    int ret;
> >  
> >      trace_nvme_dev_map_prp(nvme_cid(req), req->cmd.opcode, trans_len, len,
> >          prp1, prp2, num_prps);
> > @@ -218,7 +219,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> >  
> >              nents = (len + n->page_size - 1) >> n->page_bits;
> >              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> > -            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> > +            ret = nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> > +            if (ret) {
> > +                trace_nvme_dev_err_addr_read(prp2);
> > +                status = NVME_DATA_TRANSFER_ERROR;
> > +                goto unmap;
> > +            }
> >              while (len != 0) {
> >                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
> >  
> > @@ -237,7 +243,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> >                      i = 0;
> >                      nents = (len + n->page_size - 1) >> n->page_bits;
> >                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> > -                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans);
> > +                    ret = nvme_addr_read(n, prp_ent, (void *) prp_list,
> > +                        prp_trans);
> > +                    if (ret) {
> > +                        trace_nvme_dev_err_addr_read(prp_ent);
> > +                        status = NVME_DATA_TRANSFER_ERROR;
> > +                        goto unmap;
> > +                    }
> >                      prp_ent = le64_to_cpu(prp_list[i]);
> >                  }
> >  
> > @@ -443,6 +455,7 @@ static void nvme_post_cqes(void *opaque)
> >      NvmeCQueue *cq = opaque;
> >      NvmeCtrl *n = cq->ctrl;
> >      NvmeRequest *req, *next;
> > +    int ret;
> >  
> >      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
> >          NvmeSQueue *sq;
> > @@ -452,15 +465,21 @@ static void nvme_post_cqes(void *opaque)
> >              break;
> >          }
> >  
> > -        QTAILQ_REMOVE(&cq->req_list, req, entry);
> >          sq = req->sq;
> >          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
> >          req->cqe.sq_id = cpu_to_le16(sq->sqid);
> >          req->cqe.sq_head = cpu_to_le16(sq->head);
> >          addr = cq->dma_addr + cq->tail * n->cqe_size;
> > -        nvme_inc_cq_tail(cq);
> > -        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> > +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> >              sizeof(req->cqe));
> > +        if (ret) {
> > +            trace_nvme_dev_err_addr_write(addr);
> > +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                100 * SCALE_MS);
> > +            break;
> > +        }
> > +        QTAILQ_REMOVE(&cq->req_list, req, entry);
> > +        nvme_inc_cq_tail(cq);
> >          nvme_req_clear(req);
> >          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> >      }
> > @@ -1588,7 +1607,12 @@ static void nvme_process_sq(void *opaque)
> >  
> >      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
> >          addr = sq->dma_addr + sq->head * n->sqe_size;
> > -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> > +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> > +            trace_nvme_dev_err_addr_read(addr);
> > +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                100 * SCALE_MS);
> > +            break;
> > +        }
> 
> Note that once the driver is optimized for performance, these timers must go,
> since they run on main thread and also add latency to each request.
> But for now this change is all right.
> 
> About user triggering this each 100ms on purpose, I don't think that this is such a big issue.
> Maybe up that to 500ms or even one second, since this condition will not
> happen in real life usage of the device anyway.
> 

I bumped it to 500ms.

> >          nvme_inc_sq_head(sq);
> >  
> >          req = QTAILQ_FIRST(&sq->req_list);
> > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > index 90a57fb6099a..09bfb3782dd0 100644
> > --- a/hw/block/trace-events
> > +++ b/hw/block/trace-events
> > @@ -83,6 +83,8 @@ nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
> >  nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
> >  nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
> >  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> > status 0x%"PRIx16""
> > +nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> > +nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
> >  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> >  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
> >  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index c1de92179596..a873776d98b8 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -418,7 +418,7 @@ enum NvmeStatusCodes {
> >      NVME_INVALID_OPCODE         = 0x0001,
> >      NVME_INVALID_FIELD          = 0x0002,
> >      NVME_CID_CONFLICT           = 0x0003,
> > -    NVME_DATA_TRAS_ERROR        = 0x0004,
> > +    NVME_DATA_TRANSFER_ERROR    = 0x0004,
> >      NVME_POWER_LOSS_ABORT       = 0x0005,
> >      NVME_INTERNAL_DEV_ERROR     = 0x0006,
> >      NVME_CMD_ABORT_REQ          = 0x0007,
> 
> 
> Best regards,
> 	Maxim Levitsky
> 

