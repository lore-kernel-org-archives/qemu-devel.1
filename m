Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16003C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE6420781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE6420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9iZ-0003VW-1v
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9hW-0002Us-O1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9hV-0004hq-Mr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:44:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9hT-0004dG-E1; Tue, 31 Mar 2020 01:44:35 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 10B74BF48F;
 Tue, 31 Mar 2020 05:44:34 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:44:30 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 23/42] nvme: add mapping helpers
Message-ID: <20200331054430.z4onw7uqnnuobmnk@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-24-its@irrelevant.dk>
 <165e03c021e92f475dc1037b9421d3588d07799b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165e03c021e92f475dc1037b9421d3588d07799b.camel@redhat.com>
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

On Mar 25 12:45, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> > use them in nvme_map_prp.
> > 
> > This fixes a bug where in the case of a CMB transfer, the device would
> > map to the buffer with a wrong length.
> > 
> > Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c       | 97 +++++++++++++++++++++++++++++++++++--------
> >  hw/block/trace-events |  1 +
> >  2 files changed, 81 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 08267e847671..187c816eb6ad 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -153,29 +158,79 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> >      }
> >  }
> >  
> > +static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> > +                                  size_t len)
> > +{
> > +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) {
> > +        return NVME_DATA_TRAS_ERROR;
> > +    }
> 
> I just noticed that
> in theory (not that it really matters) but addr+len refers to the byte which is already 
> not the part of the transfer.
> 

Oh. Good catch - and I think that it does matter? Can't we end up
rejecting a valid access? Anyway, I fixed it with a '- 1'.

> 
> > +
> > +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> Also intersting is we can add 0 sized iovec.
> 

I added a check on len. This also makes sure the above '- 1' fix doesn't
cause an 'addr + 0 - 1' to be done.


