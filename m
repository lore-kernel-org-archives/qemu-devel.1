Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD9CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4037F20784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4037F20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9li-0008Vo-Am
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9i0-0002yv-Lk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9hz-00057n-Hz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:45:08 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9hs-00054M-Qd; Tue, 31 Mar 2020 01:45:00 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8A924BF48F;
 Tue, 31 Mar 2020 05:44:59 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:44:56 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 29/42] nvme: refactor request bounds checking
Message-ID: <20200331054456.wl4jayuropl7tku2@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-30-its@irrelevant.dk>
 <27ff4b99b076e90ee7536a9c9063f10201a66096.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27ff4b99b076e90ee7536a9c9063f10201a66096.camel@redhat.com>
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

On Mar 25 12:56, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index eecfad694bf8..ba520c76bae5 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -562,13 +577,14 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> >      uint64_t data_offset = slba << data_shift;
> >      int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
> >      enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> > +    uint16_t status;
> >  
> >      trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba);
> >  
> > -    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
> > +    status = nvme_check_bounds(n, ns, slba, nlb, req);
> > +    if (status) {
> >          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > -        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> > -        return NVME_LBA_RANGE | NVME_DNR;
> > +        return status;
> >      }
> >  
> >      if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
> Looks good as well, once we get support for discard, it will
> use this as well, but for now indeed only write zeros and read/write
> need bounds checking on the IO path.
> 

I have that patch in the submission queue and the check is factored out
there ;)

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 


