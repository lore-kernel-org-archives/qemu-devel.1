Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0881BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B972082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="C9aaTxni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B972082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0rMI-0002aP-2n
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 15:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0rLd-00025S-3C; Wed, 29 Jul 2020 15:02:41 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0rLZ-0001TO-CV; Wed, 29 Jul 2020 15:02:40 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 75250BF616;
 Wed, 29 Jul 2020 19:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596049354;
 bh=HDn/fsoI0LT+XpknII3lRMyqCtKZCBk8ktNX1QR08vM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C9aaTxnij84bqk9v5w1p4yFPR89RNSI5W1f7O22xx/zUDH3YU5kbCAXmvn/r/tBz1
 IWXV0xl8ZR9zvrVH/RnrySbDWdHYTHhKxI+vDyOppbXWBROeWSZVv2lx9WO/fzgKlG
 ZH+YuyM+zKg8KHfpvSbA+uC+cw7JEfVzSM2aLC/MSQqH7gzMIt0G7Gwf0bLG34hV8+
 CYCXK5X9v9ORw2hqN8EJTsEw75dgqplTBpMKI6kKiA55RNeRAmjyik1Ro+zyu4LJhf
 dISkDHp+lDe8PTGkdD50XWmV3aWsVsf17TPmMn+pGnxA4X7/PS2xwlhogMsSXBgdJB
 RNbzqEOolwpbw==
Date: Wed, 29 Jul 2020 21:02:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 12/16] hw/block/nvme: refactor NvmeRequest clearing
Message-ID: <20200729190233.GD213853@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-13-its@irrelevant.dk>
 <1878330443116667e7394dac111976f8697408fe.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1878330443116667e7394dac111976f8697408fe.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 20:47, Maxim Levitsky wrote:
> On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Move clearing of the structure from "clear before use" to "clear
> > after use".
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index e2932239c661..431f26c2f589 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -209,6 +209,11 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> >      }
> >  }
> >  
> > +static void nvme_req_clear(NvmeRequest *req)
> > +{
> > +    memset(&req->cqe, 0x0, sizeof(req->cqe));
> > +}
> > +
> >  static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> >                                    size_t len)
> >  {
> > @@ -458,6 +463,7 @@ static void nvme_post_cqes(void *opaque)
> >          nvme_inc_cq_tail(cq);
> >          pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> >              sizeof(req->cqe));
> > +        nvme_req_clear(req);
> 
> Don't we need some barrier here to avoid reordering the writes?
> pci_dma_write does seem to include a barrier prior to the write it does
> but not afterward.
> 


> Also what is the motivation of switching the order?

This was just preference. But I did not consider that I would be
breaking any DMA rules here.

> I think somewhat that it is a good thing to clear a buffer,
> before it is setup.
> 

I'll reverse my preference and keep the status quo since I have no
better motivation than personal preference.

The introduction of nvme_req_clear is just in preparation for
consolidating more cleanup here, but I'll drop this patch and introduce
nvme_req_clear later.

