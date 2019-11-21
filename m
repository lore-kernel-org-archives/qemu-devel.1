Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F8720872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F8720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXl8F-0003xz-5k
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iXl64-0001nV-D5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iXl62-0004Fu-E5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:58:04 -0500
Received: from charlie.dont.surf ([128.199.63.193]:40968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iXl5v-0004DJ-1P; Thu, 21 Nov 2019 06:57:55 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 84DE2BF5E2;
 Thu, 21 Nov 2019 11:57:52 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:57:51 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 14/20] nvme: allow multiple aios per command
Message-ID: <20191121115751.GB1211716@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-15-its@irrelevant.dk>
 <CADSWDzvEdK1MXXNeF6bFiyC0UDY-wTp7_ZdeV-i_Ys5YdGoyqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzvEdK1MXXNeF6bFiyC0UDY-wTp7_ZdeV-i_Ys5YdGoyqg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:25:06PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> On Tue, 15 Oct 2019 at 11:55, Klaus Jensen <its@irrelevant.dk> wrote:
> > @@ -341,19 +344,18 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> Any reason why the nvme_dma_write_prp is missing the changes applied
> to nvme_dma_read_prp ?
> 

This was adressed by proxy through changes to the previous patch
(by combining the read/write functions).

> > +    case NVME_AIO_OPC_WRITE_ZEROES:
> > +        block_acct_start(stats, acct, aio->iov.size, BLOCK_ACCT_WRITE);
> > +        aio->aiocb = blk_aio_pwrite_zeroes(aio->blk, aio->offset,
> > +            aio->iov.size, BDRV_REQ_MAY_UNMAP, nvme_aio_cb, aio);
> Minor: aio->blk  => blk
> 

Thanks. Fixed this in a couple of other places as well.

> > @@ -621,8 +880,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> >      sq = n->sq[qid];
> >      while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> >          req = QTAILQ_FIRST(&sq->out_req_list);
> > -        assert(req->aiocb);
> > -        blk_aio_cancel(req->aiocb);
> > +        while (!QTAILQ_EMPTY(&req->aio_tailq)) {
> > +            aio = QTAILQ_FIRST(&req->aio_tailq);
> > +            assert(aio->aiocb);
> > +            blk_aio_cancel(aio->aiocb);
> What about releasing memory associated with given aio ?

I believe the callback is still called when cancelled? That should take
care of it. Or have I misunderstood that? At least for the DMAAIOCBs it
is.

> > +struct NvmeAIO {
> > +    NvmeRequest *req;
> > +
> > +    NvmeAIOOp       opc;
> > +    int64_t         offset;
> > +    BlockBackend    *blk;
> > +    BlockAIOCB      *aiocb;
> > +    BlockAcctCookie acct;
> > +
> > +    NvmeAIOCompletionFunc *cb;
> > +    void                  *cb_arg;
> > +
> > +    QEMUSGList   *qsg;
> > +    QEMUIOVector iov;
> 
> There is a bit of inconsistency on the ownership of IOVs and SGLs.
> SGLs now seem to be owned by request whereas IOVs by the aio.
> WOuld be good to have that unified or documented at least.
> 

Fixed this. The NvmeAIO only holds pointers now.

> > +#define NVME_REQ_TRANSFER_DMA  0x1
> This one does not seem to be used ....
> 

I have dropped the flags and reverted to a simple req->is_cmb as that is
all that is really needed.


