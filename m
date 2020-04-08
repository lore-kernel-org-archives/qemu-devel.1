Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE8C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2AB206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2AB206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMCEq-0006O3-LO
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 11:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jMCDy-0005bP-Dv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jMCDt-0000Us-KW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:02:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:35884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jMCDr-0000S6-6B; Wed, 08 Apr 2020 11:02:35 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 17032BF5E2;
 Wed,  8 Apr 2020 15:02:33 +0000 (UTC)
Date: Wed, 8 Apr 2020 17:02:29 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 32/42] nvme: allow multiple aios per command
Message-ID: <20200408150229.rv6z5qspuwpnrlhv@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-33-its@irrelevant.dk>
 <d7ed3bb2e27814d414bcba2ace23e633ebe5df9f.camel@redhat.com>
 <20200331054647.pvcjrsnz2xbar3zf@apples.localdomain>
 <bd3c2be383491f1eb321f4e8b5eb5a7df2fc30eb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd3c2be383491f1eb321f4e8b5eb5a7df2fc30eb.camel@redhat.com>
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

On Mar 31 12:10, Maxim Levitsky wrote:
> On Tue, 2020-03-31 at 07:47 +0200, Klaus Birkelund Jensen wrote:
> > On Mar 25 12:57, Maxim Levitsky wrote:
> > > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > > @@ -516,10 +613,10 @@ static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> > > >      return NVME_SUCCESS;
> > > >  }
> > > >  
> > > > -static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
> > > > -                                         uint64_t slba, uint32_t nlb,
> > > > -                                         NvmeRequest *req)
> > > > +static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
> > > > +                                         uint32_t nlb, NvmeRequest *req)
> > > >  {
> > > > +    NvmeNamespace *ns = req->ns;
> > > >      uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
> > > 
> > > This should go to the patch that added nvme_check_bounds as well
> > > 
> > 
> > We can't really, because the NvmeRequest does not hold a reference to
> > the namespace as a struct member at that point. This is also an issue
> > with the nvme_check_prinfo function above.
> 
> I see it now. The changes to NvmeRequest together with this are a good candidate
> to split from this patch to get this patch to size that is easy to review.
> 

I'm factoring those changes and other stuff out into separate patches!



