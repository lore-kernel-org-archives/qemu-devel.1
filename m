Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D423C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2234B20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2234B20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9lG-0007mS-8o
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9kC-0005rb-UL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9kB-0006QJ-T4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:47:24 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9k9-0006Ox-Gw; Tue, 31 Mar 2020 01:47:21 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 69F5FBF48F;
 Tue, 31 Mar 2020 05:47:20 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:47:17 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 35/42] nvme: handle dma errors
Message-ID: <20200331054717.dmszcg2uh4oltjed@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-36-its@irrelevant.dk>
 <5eff4d8fd359e455960b4996bcadbc3ac9bd7f85.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5eff4d8fd359e455960b4996bcadbc3ac9bd7f85.camel@redhat.com>
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

On Mar 25 12:58, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
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
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c       | 45 ++++++++++++++++++++++++++++++++-----------
> >  hw/block/trace-events |  2 ++
> >  include/block/nvme.h  |  2 +-
> >  3 files changed, 37 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 15ca2417af04..49d323566393 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -164,7 +164,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> >                                    size_t len)
> >  {
> >      if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) {
> > -        return NVME_DATA_TRAS_ERROR;
> > +        return NVME_DATA_TRANSFER_ERROR;
> 
> Minor nitpick: this is also a non functional refactoring.
> I don't think that each piece of a refactoring should be in a separate patch,
> so I usually group all the non functional (aka cosmetic) refactoring in one patch, usually the first in the series.
> But I try not to leave such refactoring in the functional patches.
> 
> However, since there is not that much cases like that left, I don't mind leaving this particular case as is.
> 

Noted. Keeping it here for now ;)

> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Best regards,
> 	Maxim Levitsky
> 


