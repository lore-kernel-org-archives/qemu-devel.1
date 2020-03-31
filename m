Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E4AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06B2206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06B2206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9e4-0004Q6-Sq
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9d0-0002lv-0m
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9cy-0002Aw-4p
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:39:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9cu-00028X-Aw; Tue, 31 Mar 2020 01:39:52 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 405B2BF48F;
 Tue, 31 Mar 2020 05:39:51 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:39:48 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 07/42] nvme: refactor nvme_addr_read
Message-ID: <20200331053948.ompv75njpyhlti7i@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-8-its@irrelevant.dk>
 <1fb18481dfcfa17c2395f3bcded0aef787badfc7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fb18481dfcfa17c2395f3bcded0aef787badfc7.camel@redhat.com>
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

On Mar 25 12:38, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Pull the controller memory buffer check to its own function. The check
> > will be used on its own in later patches.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index b38d7e548a60..08a83d449de3 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -52,14 +52,22 @@
> >  
> >  static void nvme_process_sq(void *opaque);
> >  
> > +static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> > +{
> > +    hwaddr low = n->ctrl_mem.addr;
> > +    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> > +
> > +    return addr >= low && addr < hi;
> > +}
> > +
> >  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> >  {
> > -    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
> > -                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
> > +    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> >          memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> > -    } else {
> > -        pci_dma_read(&n->parent_obj, addr, buf, size);
> > +        return;
> >      }
> > +
> > +    pci_dma_read(&n->parent_obj, addr, buf, size);
> >  }
> >  
> >  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> 
> Note that this patch still contains a bug that it removes the check against the accessed
> size, which you fix in later patch.
> I prefer to not add a bug in first place
> However if you have a reason for this, I won't mind.
> 

So yeah. The resons is that there is actually no bug at this point
because the controller only supports PRPs. I actually thought there was
a bug as well and reported it to qemu-security some months ago as a
potential out of bounds access. I was then schooled by Keith on how PRPs
work ;) Below is a paraphrased version of Keiths analysis.

The PRPs does not cross page boundaries:

    trans_len = n->page_size - (prp1 % n->page_size);

The PRPs are always verified to be page aligned:

    if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {

and the transfer length wont go above page size. So, since the beginning
of the address is within the CMB and considering that the CMB is of an
MB aligned and sized granularity, then we can never cross outside it
with PRPs.

I could add the check at this point (because it *is* needed for when
SGLs are introduced), but I think it would just be noise and I would
need to explain why the check is there, but not really needed at this
point. Instead I'm adding a new patch before the SGL patch that explains
this.

