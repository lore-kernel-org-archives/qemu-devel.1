Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F3C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E10620714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6WlhVK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E10620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3F6-0001gv-8h
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3DS-0007yu-5V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3DN-0004Eq-Vt
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3DN-0004EX-Oi
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585131889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waVwNwlawXCNnHzMpUQ4Lzs6CevUY17GBInBQ/AnPHs=;
 b=i6WlhVK17KXLYTnDixE3UFdr4FZvPJpqQXowcKrbFC6sm3ls+9eXyvh5uYOhs5CSwCHt2q
 rex1NH9o6aW5iBnWBGJm3f2O2wgDJgjkSVPkPeRN+x9KsuvGYK010H0Y8c2voRm0b30suP
 q88EMPIr0MgQYfZsauIb3nmO8LOykhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-M11tEEOqOxW6zGEK1uc2IA-1; Wed, 25 Mar 2020 06:24:45 -0400
X-MC-Unique: M11tEEOqOxW6zGEK1uc2IA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5175FDBB8;
 Wed, 25 Mar 2020 10:24:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2011036D00;
 Wed, 25 Mar 2020 10:24:38 +0000 (UTC)
Message-ID: <0df81e729bfa37635defb3b1ec5d9ab3b7d62189.camel@redhat.com>
Subject: Re: [PATCH v5 17/26] nvme: allow multiple aios per command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Wed, 25 Mar 2020 12:24:37 +0200
In-Reply-To: <20200316075314.kkxepmapzjwz2o6r@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095226eucas1p2429f45a5e23fe6ed57dee293be5e1b44@eucas1p2.samsung.com>
 <20200204095208.269131-18-k.jensen@samsung.com>
 <aa7155248e6fe6b93e123c93a1e185f8641661ab.camel@redhat.com>
 <20200316075314.kkxepmapzjwz2o6r@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 00:53 -0700, Klaus Birkelund Jensen wrote:
> On Feb 12 13:48, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > > This refactors how the device issues asynchronous block backend
> > > requests. The NvmeRequest now holds a queue of NvmeAIOs that are
> > > associated with the command. This allows multiple aios to be issued for
> > > a command. Only when all requests have been completed will the device
> > > post a completion queue entry.
> > > 
> > > Because the device is currently guaranteed to only issue a single aio
> > > request per command, the benefit is not immediately obvious. But this
> > > functionality is required to support metadata, the dataset management
> > > command and other features.
> > 
> > I don't know what the strategy will be chosen for supporting metadata
> > (qemu doesn't have any notion of metadata in the block layer), but for dataset management
> > you are right. Dataset management command can contain a table of areas to discard
> > (although in reality I have seen no driver putting there more that one entry).
> > 
> 
> The strategy is different depending on how the metadata is transferred
> between host and device. For the "separate buffer" case, metadata is
> transferred using a separate memory pointer in the nvme command (MPTR).
> In this case the metadata is kept separately on a new blockdev attached
> to the namespace.
Looks reasonable.
> 


> In the other case, metadata is transferred as part of an extended lba
> (say 512 + 8 bytes) and kept inline on the main namespace blockdev. This
> is challenging for QEMU as it breaks interoperability of the image with
> other devices. But that is a discussion for fresh RFC ;)

Yes, this one is quite problemetic. IMHO even the kernel opted out to not
support this kind of metadata (I know that since I played with one of Intel's enterprise
SSDs when I developed nvme-mdev, and sadly this is the only kind of metadata it supports).
I guess if we have to support this format (for the sake of making our nvme virtual device
as feature complete as possible for driver development), I would emulate this with a
separate drive as well.

> 
> Note that the support for multiple AIOs is also used for DULBE support
This is a typo? I don't recall something like that from the spec.

> down the line when I get around to posting those patches. So this is
> preparatory for a lot of features that requires persistant state across
> device power off.
All right. Thanks again for your work. I wish I had all these features
when I developed nvme-mdev, it would make my life much easier.

> 
> > 
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c       | 449 +++++++++++++++++++++++++++++++++---------
> > >  hw/block/nvme.h       | 134 +++++++++++--
> > >  hw/block/trace-events |   8 +
> > >  3 files changed, 480 insertions(+), 111 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 334265efb21e..e97da35c4ca1 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -19,7 +19,8 @@
> > >   *      -drive file=<file>,if=none,id=<drive_id>
> > >   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> > >   *              cmb_size_mb=<cmb_size_mb[optional]>, \
> > > - *              num_queues=<N[optional]>
> > > + *              num_queues=<N[optional]>, \
> > > + *              mdts=<mdts[optional]>
> > 
> > Could you split mdts checks into a separate patch? This is not related to the series.
> 
> Absolutely. Done.
Perfect, thanks!
> 
> > 
> > >   *
> > >   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> > >   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> > > @@ -57,6 +58,7 @@
> > >      } while (0)
> > >  
> > >  static void nvme_process_sq(void *opaque);
> > > +static void nvme_aio_cb(void *opaque, int ret);
> > >  
> > >  static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
> > >  {
> > > @@ -341,6 +343,107 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > >      return status;
> > >  }
> > >  
> > > +static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    NvmeNamespace *ns = req->ns;
> > > +
> > > +    uint32_t len = req->nlb << nvme_ns_lbads(ns);
> > > +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> > > +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> > > +
> > > +    return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
> > > +}
> > 
> > Same here, this is another nice refactoring and it should be in separate patch.
> 
> Done.
> 
> > 
> > > +
> > > +static void nvme_aio_destroy(NvmeAIO *aio)
> > > +{
> > > +    g_free(aio);
> > > +}
> > > +
> > > +static inline void nvme_req_register_aio(NvmeRequest *req, NvmeAIO *aio,
> > > +    NvmeAIOOp opc)
> > > +{
> > > +    aio->opc = opc;
> > > +
> > > +    trace_nvme_dev_req_register_aio(nvme_cid(req), aio, blk_name(aio->blk),
> > > +        aio->offset, aio->len, nvme_aio_opc_str(aio), req);
> > > +
> > > +    if (req) {
> > > +        QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
> > > +    }
> > > +}
> > > +
> > > +static void nvme_aio(NvmeAIO *aio)
> > 
> > Function name not clear to me. Maybe change this to something like nvme_submit_aio.
> 
> Fixed.
> 
> > > +{
> > > +    BlockBackend *blk = aio->blk;
> > > +    BlockAcctCookie *acct = &aio->acct;
> > > +    BlockAcctStats *stats = blk_get_stats(blk);
> > > +
> > > +    bool is_write, dma;
> > > +
> > > +    switch (aio->opc) {
> > > +    case NVME_AIO_OPC_NONE:
> > > +        break;
> > > +
> > > +    case NVME_AIO_OPC_FLUSH:
> > > +        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> > > +        aio->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
> > > +        break;
> > > +
> > > +    case NVME_AIO_OPC_WRITE_ZEROES:
> > > +        block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
> > > +        aio->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
> > > +            BDRV_REQ_MAY_UNMAP, nvme_aio_cb, aio);
> > > +        break;
> > > +
> > > +    case NVME_AIO_OPC_READ:
> > > +    case NVME_AIO_OPC_WRITE:
> > > +        dma = aio->qsg != NULL;
> > 
> > This doesn't work.
> > aio->qsg is always not null since nvme_rw_aio sets this to &req->qsg
> > which is then written to aio->qsg by nvme_aio_new.
> 
> Ouch. This is a refactoring gone awry. Very nicely spotted.
> 
> > 
> > That is yet another reason I really don't like these parallel QEMUSGList
> > and QEMUIOVector. However I see that few other qemu drivers do this,
> > thus this is probably a necessary evil.
> > 
> > What we can do maybe is to do dma_memory_map on the SG list,
> > and then deal with QEMUIOVector only. Virtio does this
> > (virtqueue_pop/virtqueue_push)
> 
> Yeah, I agree. But I really wanna use the dma helpers to not mess around
> with that complexity.
Yea, after reviewing all of the patchset, I also kind of got used to this,
so I don't mind leaving this like that for now.

> 
> > 
> > 
> > > +        is_write = (aio->opc == NVME_AIO_OPC_WRITE);
> > > +
> > > +        block_acct_start(stats, acct, aio->len,
> > > +            is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> > > +
> > > +        if (dma) {
> > > +            aio->aiocb = is_write ?
> > > +                dma_blk_write(blk, aio->qsg, aio->offset,
> > > +                    BDRV_SECTOR_SIZE, nvme_aio_cb, aio) :
> > > +                dma_blk_read(blk, aio->qsg, aio->offset,
> > > +                    BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
> > > +
> > 
> > Extra space
> > > +            return;
> > > +        }
> > > +
> > > +        aio->aiocb = is_write ?
> > > +            blk_aio_pwritev(blk, aio->offset, aio->iov, 0,
> > > +                nvme_aio_cb, aio) :
> > > +            blk_aio_preadv(blk, aio->offset, aio->iov, 0,
> > > +                nvme_aio_cb, aio);
> > > +
> > > +        break;
> > > +    }
> > > +}
> > > +
> > > +static void nvme_rw_aio(BlockBackend *blk, uint64_t offset, NvmeRequest *req)
> > > +{
> > > +    NvmeAIO *aio;
> > > +    size_t len = req->qsg.nsg > 0 ? req->qsg.size : req->iov.size;
> > > +
> > > +    aio = g_new0(NvmeAIO, 1);
> > > +
> > > +    *aio = (NvmeAIO) {
> > > +        .blk = blk,
> > > +        .offset = offset,
> > > +        .len = len,
> > > +        .req = req,
> > > +        .qsg = &req->qsg,
> > > +        .iov = &req->iov,
> > > +    };
> > > +
> > > +    nvme_req_register_aio(req, aio, nvme_req_is_write(req) ?
> > > +        NVME_AIO_OPC_WRITE : NVME_AIO_OPC_READ);
> > 
> > nitpick: I think I don't like the nvme_req_register_aio name either, but I don't think I have
> > a better name for it yet. 
> 
> If you figure out a better name, let me know ;) I through about
> "enqueue", but thats not really what it's doing. It is just registering
> that an AIO is associated with the request. Maybe "post" or something,
> not sure.
nvme_reg_add_aio maybe (with a comment on top explaining what it does)?
> 
> > > +    nvme_aio(aio);
> > > +}
> > > +
> > >  static void nvme_post_cqes(void *opaque)
> > >  {
> > >      NvmeCQueue *cq = opaque;
> > > @@ -364,6 +467,7 @@ static void nvme_post_cqes(void *opaque)
> > >          nvme_inc_cq_tail(cq);
> > >          pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> > >              sizeof(req->cqe));
> > > +        nvme_req_clear(req);
> > >          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> > >      }
> > >      if (cq->tail != cq->head) {
> > > @@ -374,8 +478,8 @@ static void nvme_post_cqes(void *opaque)
> > >  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
> > >  {
> > >      assert(cq->cqid == req->sq->cqid);
> > > -    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
> > > -        req->status);
> > > +    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid, req->status);
> > > +
> > >      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
> > >      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
> > >      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> > > @@ -460,135 +564,272 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> > >      }
> > >  }
> > >  
> > > -static void nvme_rw_cb(void *opaque, int ret)
> > > +static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
> > > +    NvmeRequest *req)
> > > +{
> > > +    uint8_t mdts = n->params.mdts;
> > > +
> > > +    if (mdts && len > n->page_size << mdts) {
> > > +        trace_nvme_dev_err_mdts(nvme_cid(req), n->page_size << mdts, len);
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    return NVME_SUCCESS;
> > > +}
> > > +
> > > +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeRequest *req)
> > > +{
> > > +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
> > > +    NvmeNamespace *ns = req->ns;
> > > +
> > > +    uint16_t ctrl = le16_to_cpu(rw->control);
> > > +
> > > +    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK)) {
> > > +        trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    return NVME_SUCCESS;
> > > +}
> > > +
> > > +static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
> > > +    uint32_t nlb, NvmeRequest *req)
> > > +{
> > > +    NvmeNamespace *ns = req->ns;
> > > +    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
> > > +
> > > +    if (unlikely((slba + nlb) > nsze)) {
> > > +        block_acct_invalid(blk_get_stats(n->conf.blk),
> > > +            nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> > > +        trace_nvme_dev_err_invalid_lba_range(slba, nlb, nsze);
> > > +        return NVME_LBA_RANGE | NVME_DNR;
> > > +    }
> > 
> > Double check this in regard to integer overflows, e.g if slba + nlb overflows.
> > 
> > That is what I did in my nvme-mdev:
> > 
> > static inline bool check_range(u64 start, u64 size, u64 end)
> > {
> > 	u64 test = start + size;
> > 
> > 	/* check for overflow */
> > 	if (test < start || test < size)
> > 		return false;
> > 	return test <= end;
> > }
> > 
> 
> Fixed in new patch.
> 
> > > +
> > > +    return NVME_SUCCESS;
> > > +}
> > > +
> > > +static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
> > > +{
> > > +    NvmeNamespace *ns = req->ns;
> > > +    size_t len = req->nlb << nvme_ns_lbads(ns);
> > > +    uint16_t status;
> > > +
> > > +    status = nvme_check_mdts(n, len, req);
> > > +    if (status) {
> > > +        return status;
> > > +    }
> > > +
> > > +    status = nvme_check_prinfo(n, req);
> > > +    if (status) {
> > > +        return status;
> > > +    }
> > > +
> > > +    status = nvme_check_bounds(n, req->slba, req->nlb, req);
> > > +    if (status) {
> > > +        return status;
> > > +    }
> > > +
> > > +    return NVME_SUCCESS;
> > > +}
> > 
> > Note that there are more things to check if we don't support metadata,
> > like for instance the metadata pointer in the submission entry is NULL.
> > 
> 
> Yeah. I think these will be introduced along the way. It's a step
> towards better compliance, but it doesnt break the device.
> 
> > All these check_ functions are very good but they should move to
> > a separate patch since they just implement parts of the spec
> > and have nothing to do with the patch subject.
> > 
> 
> Done. 
> 
> > > +
> > > +static void nvme_rw_cb(NvmeRequest *req, void *opaque)
> > >  {
> > > -    NvmeRequest *req = opaque;
> > >      NvmeSQueue *sq = req->sq;
> > >      NvmeCtrl *n = sq->ctrl;
> > >      NvmeCQueue *cq = n->cq[sq->cqid];
> > >  
> > > -    if (!ret) {
> > > -        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
> > > -        req->status = NVME_SUCCESS;
> > > -    } else {
> > > -        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
> > > -        req->status = NVME_INTERNAL_DEV_ERROR;
> > > -    }
> > > -
> > > -    if (req->qsg.nalloc) {
> > > -        qemu_sglist_destroy(&req->qsg);
> > > -    }
> > > -    if (req->iov.nalloc) {
> > > -        qemu_iovec_destroy(&req->iov);
> > > -    }
> > > +    trace_nvme_dev_rw_cb(nvme_cid(req), req->cmd.nsid);
> > >  
> > >      nvme_enqueue_req_completion(cq, req);
> > >  }
> > >  
> > > -static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > > -    NvmeRequest *req)
> > > +static void nvme_aio_cb(void *opaque, int ret)
> > >  {
> > > -    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> > > -         BLOCK_ACCT_FLUSH);
> > > -    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> > > +    NvmeAIO *aio = opaque;
> > > +    NvmeRequest *req = aio->req;
> > >  
> > > -    return NVME_NO_COMPLETE;
> > > -}
> > > +    BlockBackend *blk = aio->blk;
> > > +    BlockAcctCookie *acct = &aio->acct;
> > > +    BlockAcctStats *stats = blk_get_stats(blk);
> > >  
> > > -static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > > -    NvmeRequest *req)
> > > -{
> > > -    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> > > -    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> > > -    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> > > -    uint64_t slba = le64_to_cpu(rw->slba);
> > > -    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
> > > -    uint64_t offset = slba << data_shift;
> > > -    uint32_t count = nlb << data_shift;
> > > -
> > > -    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
> > > -        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> > > -        return NVME_LBA_RANGE | NVME_DNR;
> > > -    }
> > > -
> > > -    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> > > -                     BLOCK_ACCT_WRITE);
> > > -    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> > > -                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
> > > -    return NVME_NO_COMPLETE;
> > > -}
> > > -
> > > -static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > > -    NvmeRequest *req)
> > > -{
> > > -    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> > > -    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
> > > -    uint64_t slba = le64_to_cpu(rw->slba);
> > > -    uint64_t prp1 = le64_to_cpu(rw->prp1);
> > > -    uint64_t prp2 = le64_to_cpu(rw->prp2);
> > > -
> > > -    uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> > > -    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> > > -    uint64_t data_size = (uint64_t)nlb << data_shift;
> > > -    uint64_t data_offset = slba << data_shift;
> > > -    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
> > > -    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> > > +    Error *local_err = NULL;
> > >  
> > > -    trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba);
> > > +    trace_nvme_dev_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
> > > +        nvme_aio_opc_str(aio), req);
> > >  
> > > -    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > -        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> > > -        return NVME_LBA_RANGE | NVME_DNR;
> > > +    if (req) {
> > 
> > I wonder in which case the aio callback will be called without req.
> > Looking at the code it looks like that can't happen.
> > (NvmeAIO is created by nvme_aio_new and all its callers pass not null req)
> 
> Yeah, this is preparatory for a patchset I have where an AIO can be
> issued by the controller autonomously.
ok then.
> 
> > 
> > > +        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
> > >      }
> > >  
> > > -    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > -        return NVME_INVALID_FIELD | NVME_DNR;
> > > -    }
> > > -
> > > -    if (req->qsg.nsg > 0) {
> > > -        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
> > > -            acct);
> > > -
> > > -        req->aiocb = is_write ?
> > > -            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> > > -                          nvme_rw_cb, req) :
> > > -            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
> > > -                         nvme_rw_cb, req);
> > > +    if (!ret) {
> > > +        block_acct_done(stats, acct);
> > >      } else {
> > > -        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
> > > -            acct);
> > > +        block_acct_failed(stats, acct);
> > >  
> > > -        req->aiocb = is_write ?
> > > -            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
> > > -                            req) :
> > > -            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
> > > -                           req);
> > > +        if (req) {
> > > +            uint16_t status;
> > > +
> > > +            switch (aio->opc) {
> > > +            case NVME_AIO_OPC_READ:
> > > +                status = NVME_UNRECOVERED_READ;
> > > +                break;
> > > +            case NVME_AIO_OPC_WRITE:
> > > +            case NVME_AIO_OPC_WRITE_ZEROES:
> > > +                status = NVME_WRITE_FAULT;
> > > +                break;
> > > +            default:
> > > +                status = NVME_INTERNAL_DEV_ERROR;
> > > +                break;
> > > +            }
> > > +
> > > +            trace_nvme_dev_err_aio(nvme_cid(req), aio, blk_name(blk),
> > > +                aio->offset, nvme_aio_opc_str(aio), req, status);
> > > +
> > > +            error_setg_errno(&local_err, -ret, "aio failed");
> > > +            error_report_err(local_err);
> > > +
> > > +            /*
> > > +             * An Internal Error trumps all other errors. For other errors,
> > > +             * only set the first error encountered. Any additional errors will
> > > +             * be recorded in the error information log page.
> > > +             */
> > > +            if (!req->status ||
> > > +                nvme_status_is_error(status, NVME_INTERNAL_DEV_ERROR)) {
> > > +                req->status = status;
> > > +            }
> > > +        }
> > > +    }
> > > +
> > > +    if (aio->cb) {
> > > +        aio->cb(aio, aio->cb_arg, ret);
> > > +    }
> > > +
> > > +    if (req && QTAILQ_EMPTY(&req->aio_tailq)) {
> > > +        if (req->cb) {
> > > +            req->cb(req, req->cb_arg);
> > > +        } else {
> > > +            NvmeSQueue *sq = req->sq;
> > > +            NvmeCtrl *n = sq->ctrl;
> > > +            NvmeCQueue *cq = n->cq[sq->cqid];
> > > +
> > > +            nvme_enqueue_req_completion(cq, req);
> > > +        }
> > >      }
> > >  
> > > +    nvme_aio_destroy(aio);
> > > +}
> > > +
> > > +static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    NvmeAIO *aio = g_new0(NvmeAIO, 1);
> > > +
> > > +    *aio = (NvmeAIO) {
> > > +        .blk = n->conf.blk,
> > > +        .req = req,
> > > +    };
> > > +
> > > +    nvme_req_register_aio(req, aio, NVME_AIO_OPC_FLUSH);
> > > +    nvme_aio(aio);
> > > +
> > > +    return NVME_NO_COMPLETE;
> > > +}
> > > +
> > > +static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    NvmeAIO *aio;
> > > +
> > > +    NvmeNamespace *ns = req->ns;
> > > +    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
> > > +
> > > +    int64_t offset;
> > > +    size_t count;
> > > +    uint16_t status;
> > > +
> > > +    req->slba = le64_to_cpu(rw->slba);
> > > +    req->nlb  = le16_to_cpu(rw->nlb) + 1;
> > > +
> > > +    trace_nvme_dev_write_zeros(nvme_cid(req), le32_to_cpu(cmd->nsid),
> > > +        req->slba, req->nlb);
> > > +
> > > +    status = nvme_check_bounds(n, req->slba, req->nlb, req);
> > > +    if (unlikely(status)) {
> > > +        block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE);
> > > +        return status;
> > > +    }
> > 
> > This refactoring also should be in a separate patch.
> 
> Done.
> 
> > 
> > > +
> > > +    offset = req->slba << nvme_ns_lbads(ns);
> > > +    count = req->nlb << nvme_ns_lbads(ns);
> > > +
> > > +    aio = g_new0(NvmeAIO, 1);
> > > +
> > > +    *aio = (NvmeAIO) {
> > > +        .blk = n->conf.blk,
> > > +        .offset = offset,
> > > +        .len = count,
> > > +        .req = req,
> > > +    };
> > > +
> > > +    nvme_req_register_aio(req, aio, NVME_AIO_OPC_WRITE_ZEROES);
> > > +    nvme_aio(aio);
> > > +
> > > +    return NVME_NO_COMPLETE;
> > > +}
> > > +
> > > +static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
> > > +    NvmeNamespace *ns = req->ns;
> > > +    int status;
> > > +
> > > +    enum BlockAcctType acct =
> > > +        nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> > > +
> > > +    req->nlb  = le16_to_cpu(rw->nlb) + 1;
> > > +    req->slba = le64_to_cpu(rw->slba);
> > > +
> > > +    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
> > > +        req->nlb << nvme_ns_lbads(req->ns), req->slba);
> > > +
> > > +    status = nvme_check_rw(n, req);
> > > +    if (status) {
> > > +        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > +        return status;
> > > +    }
> > > +
> > > +    status = nvme_map(n, cmd, req);
> > > +    if (status) {
> > > +        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > +        return status;
> > > +    }
> > > +
> > > +    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
> > > +    nvme_req_set_cb(req, nvme_rw_cb, NULL);
> > > +
> > >      return NVME_NO_COMPLETE;
> > >  }
> > >  
> > >  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > > -    NvmeNamespace *ns;
> > >      uint32_t nsid = le32_to_cpu(cmd->nsid);
> > >  
> > > +    trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid),
> > > +        cmd->opcode);
> > > +
> > >      if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > >          trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > >          return NVME_INVALID_NSID | NVME_DNR;
> > >      }
> > >  
> > > -    ns = &n->namespaces[nsid - 1];
> > > +    req->ns = &n->namespaces[nsid - 1];
> > > +
> > >      switch (cmd->opcode) {
> > >      case NVME_CMD_FLUSH:
> > > -        return nvme_flush(n, ns, cmd, req);
> > > +        return nvme_flush(n, cmd, req);
> > >      case NVME_CMD_WRITE_ZEROS:
> > > -        return nvme_write_zeros(n, ns, cmd, req);
> > > +        return nvme_write_zeros(n, cmd, req);
> > >      case NVME_CMD_WRITE:
> > >      case NVME_CMD_READ:
> > > -        return nvme_rw(n, ns, cmd, req);
> > > +        return nvme_rw(n, cmd, req);
> > >      default:
> > >          trace_nvme_dev_err_invalid_opc(cmd->opcode);
> > >          return NVME_INVALID_OPCODE | NVME_DNR;
> > > @@ -612,6 +853,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      NvmeRequest *req, *next;
> > >      NvmeSQueue *sq;
> > >      NvmeCQueue *cq;
> > > +    NvmeAIO *aio;
> > >      uint16_t qid = le16_to_cpu(c->qid);
> > >  
> > >      if (unlikely(!qid || nvme_check_sqid(n, qid))) {
> > > @@ -624,8 +866,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      sq = n->sq[qid];
> > >      while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> > >          req = QTAILQ_FIRST(&sq->out_req_list);
> > > -        assert(req->aiocb);
> > > -        blk_aio_cancel(req->aiocb);
> > > +        while (!QTAILQ_EMPTY(&req->aio_tailq)) {
> > > +            aio = QTAILQ_FIRST(&req->aio_tailq);
> > > +            assert(aio->aiocb);
> > > +            blk_aio_cancel(aio->aiocb);
> > > +        }
> > >      }
> > >      if (!nvme_check_cqid(n, sq->cqid)) {
> > >          cq = n->cq[sq->cqid];
> > > @@ -662,6 +907,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
> > >      QTAILQ_INIT(&sq->out_req_list);
> > >      for (i = 0; i < sq->size; i++) {
> > >          sq->io_req[i].sq = sq;
> > > +        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
> > >          QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
> > >      }
> > >      sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
> > > @@ -800,6 +1046,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      uint32_t numdl, numdu;
> > >      uint64_t off, lpol, lpou;
> > >      size_t   len;
> > > +    uint16_t status;
> > >  
> > >      numdl = (dw10 >> 16);
> > >      numdu = (dw11 & 0xffff);
> > > @@ -815,6 +1062,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  
> > >      trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
> > >  
> > > +    status = nvme_check_mdts(n, len, req);
> > > +    if (status) {
> > > +        return status;
> > > +    }
> > > +
> > >      switch (lid) {
> > >      case NVME_LOG_ERROR_INFO:
> > >          if (!rae) {
> > > @@ -1348,7 +1600,7 @@ static void nvme_process_sq(void *opaque)
> > >          req = QTAILQ_FIRST(&sq->req_list);
> > >          QTAILQ_REMOVE(&sq->req_list, req, entry);
> > >          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> > > -        memset(&req->cqe, 0, sizeof(req->cqe));
> > > +
> > >          req->cqe.cid = cmd.cid;
> > >          memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
> > >  
> > > @@ -1928,6 +2180,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      id->ieee[0] = 0x00;
> > >      id->ieee[1] = 0x02;
> > >      id->ieee[2] = 0xb3;
> > > +    id->mdts = params->mdts;
> > >      id->ver = cpu_to_le32(NVME_SPEC_VER);
> > >      id->oacs = cpu_to_le16(0);
> > >  
> > > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > > index d27baa9d5391..3319f8edd7e1 100644
> > > --- a/hw/block/nvme.h
> > > +++ b/hw/block/nvme.h
> > > @@ -8,7 +8,8 @@
> > >      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> > >      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
> > >      DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
> > > -    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64)
> > > +    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64), \
> > > +    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
> > >  
> > >  typedef struct NvmeParams {
> > >      char     *serial;
> > > @@ -16,6 +17,7 @@ typedef struct NvmeParams {
> > >      uint32_t cmb_size_mb;
> > >      uint8_t  aerl;
> > >      uint32_t aer_max_queued;
> > > +    uint8_t  mdts;
> > >  } NvmeParams;
> > >  
> > >  typedef struct NvmeAsyncEvent {
> > > @@ -23,17 +25,58 @@ typedef struct NvmeAsyncEvent {
> > >      NvmeAerResult result;
> > >  } NvmeAsyncEvent;
> > >  
> > > -typedef struct NvmeRequest {
> > > -    struct NvmeSQueue       *sq;
> > > -    BlockAIOCB              *aiocb;
> > > -    uint16_t                status;
> > > -    NvmeCqe                 cqe;
> > > -    BlockAcctCookie         acct;
> > > -    QEMUSGList              qsg;
> > > -    QEMUIOVector            iov;
> > > -    NvmeCmd                 cmd;
> > > -    QTAILQ_ENTRY(NvmeRequest)entry;
> > > -} NvmeRequest;
> > > +typedef struct NvmeRequest NvmeRequest;
> > > +typedef void NvmeRequestCompletionFunc(NvmeRequest *req, void *opaque);
> > > +
> > > +struct NvmeRequest {
> > > +    struct NvmeSQueue    *sq;
> > > +    struct NvmeNamespace *ns;
> > > +
> > > +    NvmeCqe  cqe;
> > > +    NvmeCmd  cmd;
> > > +    uint16_t status;
> > > +
> > > +    uint64_t slba;
> > > +    uint32_t nlb;
> > > +
> > > +    QEMUSGList   qsg;
> > > +    QEMUIOVector iov;
> > > +
> > > +    NvmeRequestCompletionFunc *cb;
> > > +    void                      *cb_arg;
> > > +
> > > +    QTAILQ_HEAD(, NvmeAIO)    aio_tailq;
> > > +    QTAILQ_ENTRY(NvmeRequest) entry;
> > > +};
> > > +
> > > +static inline void nvme_req_clear(NvmeRequest *req)
> > > +{
> > > +    req->ns = NULL;
> > > +    memset(&req->cqe, 0, sizeof(req->cqe));
> > > +    req->status = NVME_SUCCESS;
> > > +    req->slba = req->nlb = 0x0;
> > > +    req->cb = req->cb_arg = NULL;
> > > +
> > > +    if (req->qsg.sg) {
> > > +        qemu_sglist_destroy(&req->qsg);
> > > +    }
> > > +
> > > +    if (req->iov.iov) {
> > > +        qemu_iovec_destroy(&req->iov);
> > > +    }
> > > +}
> > > +
> > > +static inline void nvme_req_set_cb(NvmeRequest *req,
> > > +    NvmeRequestCompletionFunc *cb, void *cb_arg)
> > > +{
> > > +    req->cb = cb;
> > > +    req->cb_arg = cb_arg;
> > > +}
> > > +
> > > +static inline void nvme_req_clear_cb(NvmeRequest *req)
> > > +{
> > > +    req->cb = req->cb_arg = NULL;
> > > +}
> > >  
> > >  typedef struct NvmeSQueue {
> > >      struct NvmeCtrl *ctrl;
> > > @@ -85,6 +128,60 @@ static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> > >      return 1 << nvme_ns_lbads(ns);
> > >  }
> > >  
> > > +typedef enum NvmeAIOOp {
> > > +    NVME_AIO_OPC_NONE         = 0x0,
> > > +    NVME_AIO_OPC_FLUSH        = 0x1,
> > > +    NVME_AIO_OPC_READ         = 0x2,
> > > +    NVME_AIO_OPC_WRITE        = 0x3,
> > > +    NVME_AIO_OPC_WRITE_ZEROES = 0x4,
> > > +} NvmeAIOOp;
> > > +
> > > +typedef struct NvmeAIO NvmeAIO;
> > > +typedef void NvmeAIOCompletionFunc(NvmeAIO *aio, void *opaque, int ret);
> > > +
> > > +struct NvmeAIO {
> > > +    NvmeRequest *req;
> > > +
> > > +    NvmeAIOOp       opc;
> > > +    int64_t         offset;
> > > +    size_t          len;
> > > +    BlockBackend    *blk;
> > > +    BlockAIOCB      *aiocb;
> > > +    BlockAcctCookie acct;
> > > +
> > > +    NvmeAIOCompletionFunc *cb;
> > > +    void                  *cb_arg;
> > > +
> > > +    QEMUSGList   *qsg;
> > > +    QEMUIOVector *iov;
> > > +
> > > +    QTAILQ_ENTRY(NvmeAIO) tailq_entry;
> > > +};
> > > +
> > > +static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
> > > +{
> > > +    switch (aio->opc) {
> > > +    case NVME_AIO_OPC_NONE:         return "NVME_AIO_OP_NONE";
> > > +    case NVME_AIO_OPC_FLUSH:        return "NVME_AIO_OP_FLUSH";
> > > +    case NVME_AIO_OPC_READ:         return "NVME_AIO_OP_READ";
> > > +    case NVME_AIO_OPC_WRITE:        return "NVME_AIO_OP_WRITE";
> > > +    case NVME_AIO_OPC_WRITE_ZEROES: return "NVME_AIO_OP_WRITE_ZEROES";
> > > +    default:                        return "NVME_AIO_OP_UNKNOWN";
> > > +    }
> > > +}
> > > +
> > > +static inline bool nvme_req_is_write(NvmeRequest *req)
> > > +{
> > > +    switch (req->cmd.opcode) {
> > > +    case NVME_CMD_WRITE:
> > > +    case NVME_CMD_WRITE_UNCOR:
> > > +    case NVME_CMD_WRITE_ZEROS:
> > > +        return true;
> > > +    default:
> > > +        return false;
> > > +    }
> > > +}
> > > +
> > >  #define TYPE_NVME "nvme"
> > >  #define NVME(obj) \
> > >          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> > > @@ -139,10 +236,21 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> > >  static inline uint16_t nvme_cid(NvmeRequest *req)
> > >  {
> > >      if (req) {
> > > -        return le16_to_cpu(req->cqe.cid);
> > > +        return le16_to_cpu(req->cmd.cid);
> > >      }
> > >  
> > >      return 0xffff;
> > >  }
> > >  
> > > +static inline bool nvme_status_is_error(uint16_t status, uint16_t err)
> > > +{
> > > +    /* strip DNR and MORE */
> > > +    return (status & 0xfff) == err;
> > > +}
> > > +
> > > +static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
> > > +{
> > > +    return req->sq->ctrl;
> > > +}
> > > +
> > >  #endif /* HW_NVME_H */
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index 77aa0da99ee0..90a57fb6099a 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -34,7 +34,12 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
> > >  nvme_dev_irq_masked(void) "IRQ is masked"
> > >  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> > >  nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1
> > > 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
> > > +nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count
> > > %"PRIu64" opc \"%s\" req %p"
> > > +nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
> > > +nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> > >  nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> > > +nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
> > > +nvme_dev_write_zeros(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
> > >  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> > > qflags=%"PRIu16""
> > >  nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16",
> > > qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
> > >  nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
> > > @@ -75,6 +80,9 @@ nvme_dev_mmio_shutdown_set(void) "shutdown bit set"
> > >  nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
> > >  
> > >  # nvme traces for error conditions
> > > +nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
> > > +nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
> > > +nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p
> > > status 0x%"PRIx16""
> > >  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> > >  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
> > >  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> > 
> > 
> > 
> > The patch is large, I tried my best to spot issues, but I might have missed some.
> > Please split it as I pointed out.
> 
> Done!
> 
> > Overall I do like most of the changes.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> 
Thanks!

Best regards,
	Maxim Levitsky






