Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483AC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBF62073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PW0bUD2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBF62073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qZo-000429-Ji
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 06:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1qZF-0003Uq-I1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1qZC-0004RG-VM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:52:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1qZC-0004Ql-S9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581508350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsUA7sb5liGktulC6I1Q3nUrjiIGCX4tHnD1/fzzUpQ=;
 b=PW0bUD2ZyX/vS3EWUR+vTrKYRUW0fl1QxIgYPcOLg0+qFH/lPNl9AN1nKim9paSN3Ceo0U
 FYuOYWtNcG2kT7hFyQGX4d/vS12TIrQZwTMSmyMNv34J5nx3bv8H9PVyxo4W+4rVVLcnUS
 NoC5MNJipYEc1JECXLJZxpF9/7e/1L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-zALJOmxbOJuoqvtFYB2Z3Q-1; Wed, 12 Feb 2020 06:52:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54E9B800EB2;
 Wed, 12 Feb 2020 11:52:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDEEC5C102;
 Wed, 12 Feb 2020 11:52:22 +0000 (UTC)
Message-ID: <8bbf8a3d3babaa5883ceceea83172d4876768d8e.camel@redhat.com>
Subject: Re: [PATCH v5 20/26] nvme: handle dma errors
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 13:52:11 +0200
In-Reply-To: <20200204095208.269131-21-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf@eucas1p2.samsung.com>
 <20200204095208.269131-21-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zALJOmxbOJuoqvtFYB2Z3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> Handling DMA errors gracefully is required for the device to pass the
> block/011 test ("disable PCI device while doing I/O") in the blktests
> suite.
> 
> With this patch the device passes the test by retrying "critical"
> transfers (posting of completion entries and processing of submission
> queue entries).
> 
> If DMA errors occur at any other point in the execution of the command
> (say, while mapping the PRPs), the command is aborted with a Data
> Transfer Error status code.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 42 +++++++++++++++++++++++++++++++++---------
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  |  2 +-
>  3 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f8c81b9e2202..204ae1d33234 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -73,14 +73,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>      return addr >= low && addr < hi;
>  }
>  
> -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
>      if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
> -        return;
> +        return 0;
>      }
>  
> -    pci_dma_read(&n->parent_obj, addr, buf, size);
> +    return pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> @@ -168,6 +168,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>      uint16_t status = NVME_SUCCESS;
>      bool is_cmb = false;
>      bool prp_list_in_cmb = false;
> +    int ret;
>  
>      trace_nvme_dev_map_prp(nvme_cid(req), req->cmd.opcode, trans_len, len,
>          prp1, prp2, num_prps);
> @@ -218,7 +219,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>  
>              nents = (len + n->page_size - 1) >> n->page_bits;
>              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> +            ret = nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> +            if (ret) {
> +                trace_nvme_dev_err_addr_read(prp2);
> +                status = NVME_DATA_TRANSFER_ERROR;
> +                goto unmap;
> +            }
>              while (len != 0) {
>                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
>  
> @@ -237,7 +243,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                      i = 0;
>                      nents = (len + n->page_size - 1) >> n->page_bits;
>                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans);
> +                    ret = nvme_addr_read(n, prp_ent, (void *) prp_list,
> +                        prp_trans);
> +                    if (ret) {
> +                        trace_nvme_dev_err_addr_read(prp_ent);
> +                        status = NVME_DATA_TRANSFER_ERROR;
> +                        goto unmap;
> +                    }
>                      prp_ent = le64_to_cpu(prp_list[i]);
>                  }
>  
> @@ -443,6 +455,7 @@ static void nvme_post_cqes(void *opaque)
>      NvmeCQueue *cq = opaque;
>      NvmeCtrl *n = cq->ctrl;
>      NvmeRequest *req, *next;
> +    int ret;
>  
>      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>          NvmeSQueue *sq;
> @@ -452,15 +465,21 @@ static void nvme_post_cqes(void *opaque)
>              break;
>          }
>  
> -        QTAILQ_REMOVE(&cq->req_list, req, entry);
>          sq = req->sq;
>          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
>          req->cqe.sq_head = cpu_to_le16(sq->head);
>          addr = cq->dma_addr + cq->tail * n->cqe_size;
> -        nvme_inc_cq_tail(cq);
> -        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
>              sizeof(req->cqe));
> +        if (ret) {
> +            trace_nvme_dev_err_addr_write(addr);
> +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                100 * SCALE_MS);
> +            break;
> +        }
> +        QTAILQ_REMOVE(&cq->req_list, req, entry);
> +        nvme_inc_cq_tail(cq);
>          nvme_req_clear(req);
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
> @@ -1588,7 +1607,12 @@ static void nvme_process_sq(void *opaque)
>  
>      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
>          addr = sq->dma_addr + sq->head * n->sqe_size;
> -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                100 * SCALE_MS);
> +            break;
> +        }

Note that once the driver is optimized for performance, these timers must go,
since they run on main thread and also add latency to each request.
But for now this change is all right.

About user triggering this each 100ms on purpose, I don't think that this is such a big issue.
Maybe up that to 500ms or even one second, since this condition will not
happen in real life usage of the device anyway.

>          nvme_inc_sq_head(sq);
>  
>          req = QTAILQ_FIRST(&sq->req_list);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 90a57fb6099a..09bfb3782dd0 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -83,6 +83,8 @@ nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
>  nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
>  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> status 0x%"PRIx16""
> +nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index c1de92179596..a873776d98b8 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -418,7 +418,7 @@ enum NvmeStatusCodes {
>      NVME_INVALID_OPCODE         = 0x0001,
>      NVME_INVALID_FIELD          = 0x0002,
>      NVME_CID_CONFLICT           = 0x0003,
> -    NVME_DATA_TRAS_ERROR        = 0x0004,
> +    NVME_DATA_TRANSFER_ERROR    = 0x0004,
>      NVME_POWER_LOSS_ABORT       = 0x0005,
>      NVME_INTERNAL_DEV_ERROR     = 0x0006,
>      NVME_CMD_ABORT_REQ          = 0x0007,


Best regards,
	Maxim Levitsky


