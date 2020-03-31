Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C369C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C12220781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C12220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9ky-00073d-9K
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9jz-0005T6-Vh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9jy-0006K6-Hi
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:47:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9ju-0006Gv-Bc; Tue, 31 Mar 2020 01:47:06 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 47C44BF48F;
 Tue, 31 Mar 2020 05:47:05 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:47:02 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 32/42] nvme: allow multiple aios per command
Message-ID: <20200331054647.pvcjrsnz2xbar3zf@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-33-its@irrelevant.dk>
 <d7ed3bb2e27814d414bcba2ace23e633ebe5df9f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7ed3bb2e27814d414bcba2ace23e633ebe5df9f.camel@redhat.com>
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mar 25 12:57, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > This refactors how the device issues asynchronous block backend
> > requests. The NvmeRequest now holds a queue of NvmeAIOs that are
> > associated with the command. This allows multiple aios to be issued for
> > a command. Only when all requests have been completed will the device
> > post a completion queue entry.
> > 
> > Because the device is currently guaranteed to only issue a single aio
> > request per command, the benefit is not immediately obvious. But this
> > functionality is required to support metadata, the dataset management
> > command and other features.
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c       | 377 +++++++++++++++++++++++++++++++-----------
> >  hw/block/nvme.h       | 129 +++++++++++++--
> >  hw/block/trace-events |   6 +
> >  3 files changed, 407 insertions(+), 105 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 0d2b5b45b0c5..817384e3b1a9 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -373,6 +374,99 @@ static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
> >      return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
> >  }
> >  
> > +static void nvme_aio_destroy(NvmeAIO *aio)
> > +{
> > +    g_free(aio);
> > +}
> > +
> > +static inline void nvme_req_register_aio(NvmeRequest *req, NvmeAIO *aio,
> I guess I'll call this nvme_req_add_aio,
> or nvme_add_aio_to_reg.
> Thoughts?
> Also you can leave this as is, but add a comment on top explaining this
> 

nvme_req_add_aio it is :) And comment added.

> > +                                         NvmeAIOOp opc)
> > +{
> > +    aio->opc = opc;
> > +
> > +    trace_nvme_dev_req_register_aio(nvme_cid(req), aio, blk_name(aio->blk),
> > +                                    aio->offset, aio->len,
> > +                                    nvme_aio_opc_str(aio), req);
> > +
> > +    if (req) {
> > +        QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
> > +    }
> > +}
> > +
> > +static void nvme_submit_aio(NvmeAIO *aio)
> OK, this name makes sense
> Also please add a comment on top.

Done.

> > @@ -505,9 +600,11 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
> >      return NVME_SUCCESS;
> >  }
> >  
> > -static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> > -                                         uint16_t ctrl, NvmeRequest *req)
> > +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, uint16_t ctrl,
> > +                                         NvmeRequest *req)
> >  {
> > +    NvmeNamespace *ns = req->ns;
> > +
> This should go to the patch that added nvme_check_prinfo
> 

Probably killing that patch.

> > @@ -516,10 +613,10 @@ static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> >      return NVME_SUCCESS;
> >  }
> >  
> > -static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
> > -                                         uint64_t slba, uint32_t nlb,
> > -                                         NvmeRequest *req)
> > +static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
> > +                                         uint32_t nlb, NvmeRequest *req)
> >  {
> > +    NvmeNamespace *ns = req->ns;
> >      uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
> This should go to the patch that added nvme_check_bounds as well
> 

We can't really, because the NvmeRequest does not hold a reference to
the namespace as a struct member at that point. This is also an issue
with the nvme_check_prinfo function above.

> >  
> >      if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
> > @@ -530,55 +627,154 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
> >      return NVME_SUCCESS;
> >  }
> >  
> > -static void nvme_rw_cb(void *opaque, int ret)
> > +static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +    NvmeNamespace *ns = req->ns;
> > +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
> > +    uint16_t ctrl = le16_to_cpu(rw->control);
> > +    size_t len = req->nlb << nvme_ns_lbads(ns);
> > +    uint16_t status;
> > +
> > +    status = nvme_check_mdts(n, len, req);
> > +    if (status) {
> > +        return status;
> > +    }
> > +
> > +    status = nvme_check_prinfo(n, ctrl, req);
> > +    if (status) {
> > +        return status;
> > +    }
> > +
> > +    status = nvme_check_bounds(n, req->slba, req->nlb, req);
> > +    if (status) {
> > +        return status;
> > +    }
> > +
> > +    return NVME_SUCCESS;
> > +}
> 
> Nitpick: I hate to say it but nvme_check_rw should be in a separate patch as well.
> It will also make diff more readable (when adding a funtion and changing a function
> at the same time, you get a diff between two unrelated things)
> 

Done, but had to do it as a follow up patch.

> >  
> > -static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> > -    NvmeRequest *req)
> > +static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> Very small nitpick about zeros/zeroes: This should move to some refactoring patch to be honest. 
> 

Done ;)

> 
> The patch is still too large IMHO to review properly and few things can be split from it.
> I tried my best to review it but I might have missed something.
> 

Yeah, I know, but thanks for trying!

