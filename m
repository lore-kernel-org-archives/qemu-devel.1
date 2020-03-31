Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286BC206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286BC206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9eR-0005KS-7e
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9dL-0003XT-B2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9dJ-0002LB-V8
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:40:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9dH-0002HX-4j; Tue, 31 Mar 2020 01:40:15 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DD110BF48F;
 Tue, 31 Mar 2020 05:40:13 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:40:10 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 09/42] nvme: add max_ioqpairs device parameter
Message-ID: <20200331054010.4wfanhp56nvemb46@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-10-its@irrelevant.dk>
 <aae04efeb49752c420e5ed2ba1ce3312909fbb0e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aae04efeb49752c420e5ed2ba1ce3312909fbb0e.camel@redhat.com>
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

On Mar 25 12:39, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > The num_queues device paramater has a slightly confusing meaning because
> > it accounts for the admin queue pair which is not really optional.
> > Secondly, it is really a maximum value of queues allowed.
> > 
> > Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
> > but keep num_queues for compatibility.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 45 ++++++++++++++++++++++++++-------------------
> >  hw/block/nvme.h |  4 +++-
> >  2 files changed, 29 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 7cf7cf55143e..7dfd8a1a392d 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1332,9 +1333,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >      int64_t bs_size;
> >      uint8_t *pci_conf;
> >  
> > -    if (!n->params.num_queues) {
> > -        error_setg(errp, "num_queues can't be zero");
> > -        return;
> > +    if (n->params.num_queues) {
> > +        warn_report("nvme: num_queues is deprecated; please use max_ioqpairs "
> > +                    "instead");
> > +
> > +        n->params.max_ioqpairs = n->params.num_queues - 1;
> > +    }
> > +
> > +    if (!n->params.max_ioqpairs) {
> > +        error_setg(errp, "max_ioqpairs can't be less than 1");
> >      }
> This is not even a nitpick, but just and idea.
> 
> It might be worth it to allow max_ioqpairs=0 to simulate a 'broken'
> nvme controller. I know that kernel has special handling for such controllers,
> which include only creation of the control character device (/dev/nvme*) through
> which the user can submit commands to try and 'fix' the controller (by re-uploading firmware
> maybe or something like that).
> 
> 

Not sure about the implications of this, so I'll leave that on the TODO
:) But a controller with no I/O queues is an "Administrative Controller"
and perfectly legal in NVMe v1.4 AFAIK.

> >  
> >      if (!n->conf.blk) {
> > @@ -1365,19 +1372,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >      pcie_endpoint_cap_init(pci_dev, 0x80);
> >  
> >      n->num_namespaces = 1;
> > -    n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
> > +    n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> 
> I hate to say it, but it looks like this thing (which I mentioned to you in V5)
> was pre-existing bug, which is indeed fixed now.
> In theory such fixes should go to separate patches, but in this case, I guess it would
> be too much to ask for it.
> Maybe mention this in the commit message instead, so that this fix doesn't stay hidden like that?
> 
> 

I'm convinced now. I have added a preparatory bugfix patch before this
patch.

> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Best regards,
> 	Maxim Levitsky
> 


