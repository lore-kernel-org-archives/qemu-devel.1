Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151FBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22C320714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pq+8BWcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22C320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Fz-0003cp-Rq
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Bv-0005Bw-BG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Bs-0003AV-9X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Bs-0003AM-4B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585131795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPI7Anq6twiQhYqfZ8d/u4DiukQdyJSMENMk64ZxVPM=;
 b=Pq+8BWcnwhwHCPgeXIa8Q2bCAm0nco1FUYNyLr4VJICU4DgBclyLZTGAbH36LPH6sirrdV
 7asuBH6Nh4CLe5ts25JGuSP/3+ZY1drRoEE+/v43jsuM4R1wnvQLVIaF5K6qXiFS0/7MWl
 vu6aJwvI9CtSy7lOaenYixUy+GVeWu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-j7pkBzOePcysfrm4vwdUPw-1; Wed, 25 Mar 2020 06:23:14 -0400
X-MC-Unique: j7pkBzOePcysfrm4vwdUPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D7261005512;
 Wed, 25 Mar 2020 10:23:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD95494B42;
 Wed, 25 Mar 2020 10:23:09 +0000 (UTC)
Message-ID: <c925091d4d29c53a2df01b9eec71c6d42aa4a8f2.camel@redhat.com>
Subject: Re: [PATCH v5 16/26] nvme: refactor prp mapping
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Wed, 25 Mar 2020 12:23:08 +0200
In-Reply-To: <20200316075123.sjjvycymaht354yg@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095225eucas1p226336a91fb5460dddae5caa85964279f@eucas1p2.samsung.com>
 <20200204095208.269131-17-k.jensen@samsung.com>
 <31c288b86dc817cb0cbe550787542abb31be9e69.camel@redhat.com>
 <20200316075123.sjjvycymaht354yg@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 00:51 -0700, Klaus Birkelund Jensen wrote:
> On Feb 12 13:44, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > > Refactor nvme_map_prp and allow PRPs to be located in the CMB. The logic
> > > ensures that if some of the PRP is in the CMB, all of it must be located
> > > there, as per the specification.
> > 
> > To be honest this looks like not refactoring but a bugfix
> > (old code was just assuming that if first prp entry is in cmb, the rest also is)
> 
> I split it up into a separate bugfix patch.
> 
> > > 
> > > Also combine nvme_dma_{read,write}_prp into a single nvme_dma_prp that
> > > takes an additional DMADirection parameter.
> > 
> > To be honest 'nvme_dma_prp' was not a clear function name to me at first glance.
> > Could you rename this to nvme_dma_prp_rw or so? (Although even that is somewhat unclear
> > to convey the meaning of read/write the data to/from the guest memory areas defined by the prp list.
> > Also could you split this change into a new patch?
> > 
> 
> Splitting into new patch.
> 
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Now you even use your both addresses :-)
> > 
> > > ---
> > >  hw/block/nvme.c       | 245 +++++++++++++++++++++++++++---------------
> > >  hw/block/nvme.h       |   2 +-
> > >  hw/block/trace-events |   1 +
> > >  include/block/nvme.h  |   1 +
> > >  4 files changed, 160 insertions(+), 89 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 4acfc85b56a2..334265efb21e 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -58,6 +58,11 @@
> > >  
> > >  static void nvme_process_sq(void *opaque);
> > >  
> > > +static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
> > > +{
> > > +    return &n->cmbuf[addr - n->ctrl_mem.addr];
> > > +}
> > 
> > To my taste I would put this together with the patch that
> > added nvme_addr_is_cmb. I know that some people are against
> > this citing the fact that you should use the code you add
> > in the same patch. Your call.
> > 
> > Regardless of this I also prefer to put refactoring patches first in the series.
Thanks!
> > 
> > > +
> > >  static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> > >  {
> > >      hwaddr low = n->ctrl_mem.addr;
> > > @@ -152,138 +157,187 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> > >      }
> > >  }
> > >  
> > > -static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> > > -                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
> > > +static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> > > +    uint64_t prp1, uint64_t prp2, uint32_t len, NvmeRequest *req)
> > 
> > Split line alignment (it was correct before).
> > Also while at the refactoring, it would be great to add some documentation
> > to this and few more functions, since its not clear immediately what this does.
> > 
> > 
> > >  {
> > >      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
> > >      trans_len = MIN(len, trans_len);
> > >      int num_prps = (len >> n->page_bits) + 1;
> > > +    uint16_t status = NVME_SUCCESS;
> > > +    bool is_cmb = false;
> > > +    bool prp_list_in_cmb = false;
> > > +
> > > +    trace_nvme_dev_map_prp(nvme_cid(req), req->cmd.opcode, trans_len, len,
> > > +        prp1, prp2, num_prps);
> > >  
> > >      if (unlikely(!prp1)) {
> > >          trace_nvme_dev_err_invalid_prp();
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > -    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
> > > -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> > > -        qsg->nsg = 0;
> > > +    }
> > > +
> > > +    if (nvme_addr_is_cmb(n, prp1)) {
> > > +        is_cmb = true;
> > > +
> > >          qemu_iovec_init(iov, num_prps);
> > > -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
> > > +
> > > +        /*
> > > +         * PRPs do not cross page boundaries, so if the start address (here,
> > > +         * prp1) is within the CMB, it cannot cross outside the controller
> > > +         * memory buffer range. This is ensured by
> > > +         *
> > > +         *   len = n->page_size - (addr % n->page_size)
> > > +         *
> > > +         * Thus, we can directly add to the iovec without risking an out of
> > > +         * bounds access. This also holds for the remaining qemu_iovec_add
> > > +         * calls.
> > > +         */
> > > +        qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp1), trans_len);
> > >      } else {
> > >          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> > >          qemu_sglist_add(qsg, prp1, trans_len);
> > >      }
> > > +
> > >      len -= trans_len;
> > >      if (len) {
> > >          if (unlikely(!prp2)) {
> > >              trace_nvme_dev_err_invalid_prp2_missing();
> > > +            status = NVME_INVALID_FIELD | NVME_DNR;
> > >              goto unmap;
> > >          }
> > > +
> > >          if (len > n->page_size) {
> > >              uint64_t prp_list[n->max_prp_ents];
> > >              uint32_t nents, prp_trans;
> > >              int i = 0;
> > >  
> > > +            if (nvme_addr_is_cmb(n, prp2)) {
> > > +                prp_list_in_cmb = true;
> > > +            }
> > > +
> > >              nents = (len + n->page_size - 1) >> n->page_bits;
> > >              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> > > -            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> > > +            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> > >              while (len != 0) {
> > >                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
> > >  
> > >                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
> > >                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
> > >                          trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
> > > +                        status = NVME_INVALID_FIELD | NVME_DNR;
> > > +                        goto unmap;
> > > +                    }
> > > +
> > > +                    if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
> > > +                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > >                          goto unmap;
> > >                      }
> > >  
> > >                      i = 0;
> > >                      nents = (len + n->page_size - 1) >> n->page_bits;
> > >                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> > > -                    nvme_addr_read(n, prp_ent, (void *)prp_list,
> > > -                        prp_trans);
> > > +                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans);
> > >                      prp_ent = le64_to_cpu(prp_list[i]);
> > >                  }
> > >  
> > >                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
> > >                      trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
> > > +                    status = NVME_INVALID_FIELD | NVME_DNR;
> > > +                    goto unmap;
> > > +                }
> > > +
> > > +                if (is_cmb != nvme_addr_is_cmb(n, prp_ent)) {
> > > +                    status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > >                      goto unmap;
> > >                  }
> > >  
> > >                  trans_len = MIN(len, n->page_size);
> > > -                if (qsg->nsg){
> > > -                    qemu_sglist_add(qsg, prp_ent, trans_len);
> > > +                if (is_cmb) {
> > > +                    qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp_ent),
> > > +                        trans_len);
> > >                  } else {
> > > -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> > > +                    qemu_sglist_add(qsg, prp_ent, trans_len);
> > >                  }
> > > +
> > >                  len -= trans_len;
> > >                  i++;
> > >              }
> > >          } else {
> > > +            if (is_cmb != nvme_addr_is_cmb(n, prp2)) {
> > > +                status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > > +                goto unmap;
> > > +            }
> > > +
> > >              if (unlikely(prp2 & (n->page_size - 1))) {
> > >                  trace_nvme_dev_err_invalid_prp2_align(prp2);
> > > +                status = NVME_INVALID_FIELD | NVME_DNR;
> > >                  goto unmap;
> > >              }
> > > -            if (qsg->nsg) {
> > > +
> > > +            if (is_cmb) {
> > > +                qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp2), len);
> > > +            } else {
> > >                  qemu_sglist_add(qsg, prp2, len);
> > > -            } else {
> > > -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> > >              }
> > >          }
> > >      }
> > > +
> > >      return NVME_SUCCESS;
> > >  
> > > - unmap:
> > > -    qemu_sglist_destroy(qsg);
> > > -    return NVME_INVALID_FIELD | NVME_DNR;
> > > -}
> > 
> > I haven't checked the new nvme_map_prp to the extent that I am sure that
> > it is correct, but it looks reasonable.
> > 
> > > -
> > > -static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > -                                   uint64_t prp1, uint64_t prp2)
> > > -{
> > > -    QEMUSGList qsg;
> > > -    QEMUIOVector iov;
> > > -    uint16_t status = NVME_SUCCESS;
> > > -
> > > -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > > -        return NVME_INVALID_FIELD | NVME_DNR;
> > > -    }
> > > -    if (qsg.nsg > 0) {
> > > -        if (dma_buf_write(ptr, len, &qsg)) {
> > > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > > -        }
> > > -        qemu_sglist_destroy(&qsg);
> > > +unmap:
> > > +    if (is_cmb) {
> > > +        qemu_iovec_destroy(iov);
> > >      } else {
> > > -        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> > > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > > -        }
> > > -        qemu_iovec_destroy(&iov);
> > > +        qemu_sglist_destroy(qsg);
> > >      }
> > > +
> > >      return status;
> > >  }
> > >  
> > > -static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > -    uint64_t prp1, uint64_t prp2)
> > > +static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > +    uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
> > >  {
> > >      QEMUSGList qsg;
> > >      QEMUIOVector iov;
> > >      uint16_t status = NVME_SUCCESS;
> > > +    size_t bytes;
> > >  
> > > -    trace_nvme_dev_dma_read(prp1, prp2);
> > > -
> > > -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > > -        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
> > > +    if (status) {
> > > +        return status;
> > >      }
> > > +
> > >      if (qsg.nsg > 0) {
> > > -        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> > > +        uint64_t residual;
> > > +
> > > +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> > > +            residual = dma_buf_write(ptr, len, &qsg);
> > > +        } else {
> > > +            residual = dma_buf_read(ptr, len, &qsg);
> > > +        }
> > > +
> > > +        if (unlikely(residual)) {
> > >              trace_nvme_dev_err_invalid_dma();
> > >              status = NVME_INVALID_FIELD | NVME_DNR;
> > >          }
> > > +
> > >          qemu_sglist_destroy(&qsg);
> > > +
> > > +        return status;
> > 
> > I would prefer if/else here rather than that early return here.
> > It would make code more symmetric.
> > 
> 
> Looks nicer yeah. Done.
> 
> > > +    }
> > > +
> > > +    if (dir == DMA_DIRECTION_TO_DEVICE) {
> > > +        bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
> > >      } else {
> > > -        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
> > > -            trace_nvme_dev_err_invalid_dma();
> > > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > > -        }
> > > -        qemu_iovec_destroy(&iov);
> > > +        bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
> > >      }
> > > +
> > > +    if (unlikely(bytes != len)) {
> > > +        trace_nvme_dev_err_invalid_dma();
> > > +        status = NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    qemu_iovec_destroy(&iov);
> > > +
> > >      return status;
> > >  }
> > >  
> > > @@ -420,16 +474,20 @@ static void nvme_rw_cb(void *opaque, int ret)
> > >          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
> > >          req->status = NVME_INTERNAL_DEV_ERROR;
> > >      }
> > > -    if (req->has_sg) {
> > > +
> > > +    if (req->qsg.nalloc) {
> > >          qemu_sglist_destroy(&req->qsg);
> > >      }
> > > +    if (req->iov.nalloc) {
> > > +        qemu_iovec_destroy(&req->iov);
> > > +    }
> > > +
> > >      nvme_enqueue_req_completion(cq, req);
> > >  }
> > >  
> > >  static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > >      NvmeRequest *req)
> > >  {
> > > -    req->has_sg = false;
> > >      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> > >           BLOCK_ACCT_FLUSH);
> > >      req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> > > @@ -453,7 +511,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > >          return NVME_LBA_RANGE | NVME_DNR;
> > >      }
> > >  
> > > -    req->has_sg = false;
> > >      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> > >                       BLOCK_ACCT_WRITE);
> > >      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> > > @@ -485,21 +542,24 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > >          return NVME_LBA_RANGE | NVME_DNR;
> > >      }
> > >  
> > > -    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
> > > +    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
> > >          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > >      }
> > >  
> > > -    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
> > >      if (req->qsg.nsg > 0) {
> > > -        req->has_sg = true;
> > > +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
> > > +            acct);
> > > +
> > >          req->aiocb = is_write ?
> > >              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> > >                            nvme_rw_cb, req) :
> > >              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> > >                           nvme_rw_cb, req);
> > >      } else {
> > > -        req->has_sg = false;
> > > +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
> > > +            acct);
> > > +
> > >          req->aiocb = is_write ?
> > >              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
> > >                              req) :
> > > @@ -596,7 +656,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
> > >      sq->size = size;
> > >      sq->cqid = cqid;
> > >      sq->head = sq->tail = 0;
> > > -    sq->io_req = g_new(NvmeRequest, sq->size);
> > > +    sq->io_req = g_new0(NvmeRequest, sq->size);
> > >  
> > >      QTAILQ_INIT(&sq->req_list);
> > >      QTAILQ_INIT(&sq->out_req_list);
> > > @@ -704,8 +764,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> > >          nvme_clear_events(n, NVME_AER_TYPE_SMART);
> > >      }
> > >  
> > > -    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> > > -        prp2);
> > > +    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> > > +        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > >  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > > @@ -724,8 +784,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > >  
> > >      trans_len = MIN(sizeof(fw_log) - off, buf_len);
> > >  
> > > -    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> > > -        prp2);
> > > +    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> > > +        prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > >  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > @@ -869,18 +929,20 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      return NVME_SUCCESS;
> > >  }
> > >  
> > > -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
> > > +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
> > > +    NvmeRequest *req)
> > >  {
> > >      uint64_t prp1 = le64_to_cpu(c->prp1);
> > >      uint64_t prp2 = le64_to_cpu(c->prp2);
> > >  
> > >      trace_nvme_dev_identify_ctrl();
> > >  
> > > -    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> > > -        prp1, prp2);
> > > +    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> > > +        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > > -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> > > +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> > > +    NvmeRequest *req)
> > >  {
> > >      NvmeNamespace *ns;
> > >      uint32_t nsid = le32_to_cpu(c->nsid);
> > > @@ -896,11 +958,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> > >  
> > >      ns = &n->namespaces[nsid - 1];
> > >  
> > > -    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> > > -        prp1, prp2);
> > > +    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> > > +        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > > -static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
> > > +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
> > > +    NvmeRequest *req)
> > >  {
> > >      static const int data_len = 4 * KiB;
> > >      uint32_t min_nsid = le32_to_cpu(c->nsid);
> > > @@ -922,12 +985,14 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
> > >              break;
> > >          }
> > >      }
> > > -    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> > > +    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> > > +        DMA_DIRECTION_FROM_DEVICE, req);
> > >      g_free(list);
> > >      return ret;
> > >  }
> > >  
> > > -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> > > +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> > > +    NvmeRequest *req)
> > >  {
> > >      static const int len = 4096;
> > >  
> > > @@ -963,24 +1028,25 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> > >      list->nidl = 0x10;
> > >      *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> > >  
> > > -    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> > > +    ret = nvme_dma_prp(n, (uint8_t *) list, len, prp1, prp2,
> > > +        DMA_DIRECTION_FROM_DEVICE, req);
> > >      g_free(list);
> > >      return ret;
> > >  }
> > >  
> > > -static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > > +static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > >      NvmeIdentify *c = (NvmeIdentify *)cmd;
> > >  
> > >      switch (le32_to_cpu(c->cns)) {
> > >      case 0x00:
> > > -        return nvme_identify_ns(n, c);
> > > +        return nvme_identify_ns(n, c, req);
> > >      case 0x01:
> > > -        return nvme_identify_ctrl(n, c);
> > > +        return nvme_identify_ctrl(n, c, req);
> > >      case 0x02:
> > > -        return nvme_identify_ns_list(n, c);
> > > +        return nvme_identify_ns_list(n, c, req);
> > >      case 0x03:
> > > -        return nvme_identify_ns_descr_list(n, cmd);
> > > +        return nvme_identify_ns_descr_list(n, c, req);
> > >      default:
> > >          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > @@ -1039,15 +1105,16 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
> > >      return cpu_to_le64(ts.all);
> > >  }
> > >  
> > > -static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> > > +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> > > +    NvmeRequest *req)
> > >  {
> > >      uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > >      uint64_t prp2 = le64_to_cpu(cmd->prp2);
> > >  
> > >      uint64_t timestamp = nvme_get_timestamp(n);
> > >  
> > > -    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
> > > -                                 sizeof(timestamp), prp1, prp2);
> > > +    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
> > > +        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > >  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > @@ -1099,7 +1166,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          trace_nvme_dev_getfeat_numq(result);
> > >          break;
> > >      case NVME_TIMESTAMP:
> > > -        return nvme_get_feature_timestamp(n, cmd);
> > > +        return nvme_get_feature_timestamp(n, cmd, req);
> > >      case NVME_INTERRUPT_COALESCING:
> > >          result = cpu_to_le32(n->features.int_coalescing);
> > >          break;
> > > @@ -1125,15 +1192,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      return NVME_SUCCESS;
> > >  }
> > >  
> > > -static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> > > +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> > > +    NvmeRequest *req)
> > >  {
> > >      uint16_t ret;
> > >      uint64_t timestamp;
> > >      uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > >      uint64_t prp2 = le64_to_cpu(cmd->prp2);
> > >  
> > > -    ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
> > > -                                sizeof(timestamp), prp1, prp2);
> > > +    ret = nvme_dma_prp(n, (uint8_t *) &timestamp, sizeof(timestamp),
> > > +        prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
> > >      if (ret != NVME_SUCCESS) {
> > >          return ret;
> > >      }
> > > @@ -1194,7 +1262,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >              ((n->params.num_queues - 2) << 16));
> > >          break;
> > >      case NVME_TIMESTAMP:
> > > -        return nvme_set_feature_timestamp(n, cmd);
> > > +        return nvme_set_feature_timestamp(n, cmd, req);
> > >      case NVME_ASYNCHRONOUS_EVENT_CONF:
> > >          n->features.async_config = dw11;
> > >          break;
> > > @@ -1246,7 +1314,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      case NVME_ADM_CMD_CREATE_CQ:
> > >          return nvme_create_cq(n, cmd);
> > >      case NVME_ADM_CMD_IDENTIFY:
> > > -        return nvme_identify(n, cmd);
> > > +        return nvme_identify(n, cmd, req);
> > >      case NVME_ADM_CMD_ABORT:
> > >          return nvme_abort(n, cmd, req);
> > >      case NVME_ADM_CMD_SET_FEATURES:
> > > @@ -1282,6 +1350,7 @@ static void nvme_process_sq(void *opaque)
> > >          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> > >          memset(&req->cqe, 0, sizeof(req->cqe));
> > >          req->cqe.cid = cmd.cid;
> > > +        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
> > >  
> > >          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
> > >              nvme_admin_cmd(n, &cmd, req);
> > > @@ -1804,7 +1873,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> > >  
> > >      NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> > >      NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> > > -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> > > +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
> > >      NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> > >      NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> > >      NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
> > > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > > index 7ced5fd485a9..d27baa9d5391 100644
> > > --- a/hw/block/nvme.h
> > > +++ b/hw/block/nvme.h
> > > @@ -27,11 +27,11 @@ typedef struct NvmeRequest {
> > >      struct NvmeSQueue       *sq;
> > >      BlockAIOCB              *aiocb;
> > >      uint16_t                status;
> > > -    bool                    has_sg;
> > >      NvmeCqe                 cqe;
> > >      BlockAcctCookie         acct;
> > >      QEMUSGList              qsg;
> > >      QEMUIOVector            iov;
> > > +    NvmeCmd                 cmd;
> > >      QTAILQ_ENTRY(NvmeRequest)entry;
> > >  } NvmeRequest;
> > >  
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index 9e5a4548bde0..77aa0da99ee0 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -33,6 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
> > >  nvme_dev_irq_pin(void) "pulsing IRQ pin"
> > >  nvme_dev_irq_masked(void) "IRQ is masked"
> > >  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> > > +nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1
> > > 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
> > >  nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> > >  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> > > qflags=%"PRIu16""
> > >  nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16",
> > > qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
> > > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > > index 31eb9397d8c6..c1de92179596 100644
> > > --- a/include/block/nvme.h
> > > +++ b/include/block/nvme.h
> > > @@ -427,6 +427,7 @@ enum NvmeStatusCodes {
> > >      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
> > >      NVME_INVALID_NSID           = 0x000b,
> > >      NVME_CMD_SEQ_ERROR          = 0x000c,
> > > +    NVME_INVALID_USE_OF_CMB     = 0x0012,
> > >      NVME_LBA_RANGE              = 0x0080,
> > >      NVME_CAP_EXCEEDED           = 0x0081,
> > >      NVME_NS_NOT_READY           = 0x0082,
> > 
> > 
> > Overall I would split this commit into real refactoring and bugfixes.
> 
> Done!
> 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> 

Best regards,
	Maxim Levitsky





