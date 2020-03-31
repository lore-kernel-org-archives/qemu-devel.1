Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B582C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BC820848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGL0-0001Zp-4n
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJGK8-0000wS-EH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJGK7-0003Dg-GT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:48:56 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJGK5-00037a-6O; Tue, 31 Mar 2020 08:48:53 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DE529BF5F1;
 Tue, 31 Mar 2020 12:48:50 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:48:47 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 07/42] nvme: refactor nvme_addr_read
Message-ID: <20200331124847.wbax7webzl4grv6f@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-8-its@irrelevant.dk>
 <1fb18481dfcfa17c2395f3bcded0aef787badfc7.camel@redhat.com>
 <20200331053948.ompv75njpyhlti7i@apples.localdomain>
 <b46394ffa1e522bc7e0d3dcc5ab4762dfe16866c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b46394ffa1e522bc7e0d3dcc5ab4762dfe16866c.camel@redhat.com>
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

On Mar 31 13:41, Maxim Levitsky wrote:
> On Tue, 2020-03-31 at 07:39 +0200, Klaus Birkelund Jensen wrote:
> > On Mar 25 12:38, Maxim Levitsky wrote:
> > > Note that this patch still contains a bug that it removes the check against the accessed
> > > size, which you fix in later patch.
> > > I prefer to not add a bug in first place
> > > However if you have a reason for this, I won't mind.
> > > 
> > 
> > So yeah. The resons is that there is actually no bug at this point
> > because the controller only supports PRPs. I actually thought there was
> > a bug as well and reported it to qemu-security some months ago as a
> > potential out of bounds access. I was then schooled by Keith on how PRPs
> > work ;) Below is a paraphrased version of Keiths analysis.
> > 
> > The PRPs does not cross page boundaries:
> True
> 
> > 
> >     trans_len = n->page_size - (prp1 % n->page_size);
> > 
> > The PRPs are always verified to be page aligned:
> True
> > 
> >     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
> > 
> > and the transfer length wont go above page size. So, since the beginning
> > of the address is within the CMB and considering that the CMB is of an
> > MB aligned and sized granularity, then we can never cross outside it
> > with PRPs.
> I understand now, however the reason I am arguing about this is
> that this patch actually _removes_ the size bound check
> 
> It was before the patch:
> 
> n->cmbsz && addr >= n->ctrl_mem.addr &&
>       addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)
> 

I don't think it does - the check is just moved to nvme_addr_is_cmb:

    static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
    {
        hwaddr low = n->ctrl_mem.addr;
        hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);

        return addr >= low && addr < hi;
    }

We check that `addr` is less than `hi`. Maybe the name is unfortunate...



