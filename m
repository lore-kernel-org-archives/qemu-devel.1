Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F4CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ABA208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGeX54oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ABA208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJD2n-0005TX-TW
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJD1w-0004ZF-3K
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJD1u-0007bg-S5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:17:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJD1u-0007bH-Oh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585646274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jU3eA659KfVA33b/a9M9aZeb3RW0pf5TLw2lDm+IpUc=;
 b=aGeX54oJglWP2R6KGikqXfFmWpaP8bWgcCAEhVxHT7eSzFShFr0NNBDIMscCmk+quA48qI
 XgiKtmwk1zpadun1/M2IuMeCemuGWWeTShGSYAKElVg3samKcDUnVtDn2T4+R+8RH/ra1U
 fSIn2UCcKxJpRl+kBvEDy26UBwVKTMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-XEJ2NDCiOmGP31uvj5pnbQ-1; Tue, 31 Mar 2020 05:17:50 -0400
X-MC-Unique: XEJ2NDCiOmGP31uvj5pnbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D748017DF;
 Tue, 31 Mar 2020 09:17:49 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5AC1001B07;
 Tue, 31 Mar 2020 09:17:45 +0000 (UTC)
Message-ID: <60fb7b53420e17f9680d78a250c1045c17ee4a35.camel@redhat.com>
Subject: Re: [PATCH v6 31/42] nvme: add check for prinfo
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:17:45 +0300
In-Reply-To: <20200331054541.55rakuvpl7zaeezo@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-32-its@irrelevant.dk>
 <9d3bad95342559566c391635d9d96e4b56dd08c7.camel@redhat.com>
 <20200331054541.55rakuvpl7zaeezo@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, 2020-03-31 at 07:45 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:57, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Check the validity of the PRINFO field.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c       | 50 ++++++++++++++++++++++++++++++++++++-------
> > >  hw/block/trace-events |  1 +
> > >  include/block/nvme.h  |  1 +
> > >  3 files changed, 44 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 7d5340c272c6..0d2b5b45b0c5 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -505,6 +505,17 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
> > >      return NVME_SUCCESS;
> > >  }
> > >  
> > > +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> > > +                                         uint16_t ctrl, NvmeRequest *req)
> > > +{
> > > +    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK)) {
> > > +        trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > 
> > I refreshed my (still very limited) knowelege on the metadata
> > and the protection info, and this is what I found:
> > 
> > I think that this is very far from complete, because we also have:
> > 
> > 1. PRCHECK. According to the spec it is independent of PRACT
> >    And when some of it is set, 
> >    together with enabled protection (the DPS field in namespace),
> >    Then the 8 bytes of the protection info is checked (optionally using the
> >    the EILBRT and ELBAT/ELBATM fields in the command and CRC of the data for the guard field)
> > 
> >    So this field should also be checked to be zero when protection is disabled
> >    (I don't see an explicit requirement for that in the spec, but neither I see
> >    such requirement for PRACT)
> > 
> > 2. The protection values to be written / checked ((E)ILBRT/(E)LBATM/(E)LBAT)
> >    Same here, but also these should not be set when PRCHECK is not set for reads,
> >    plus some are protection type specific.
> > 
> > 
> > The spec does mention the 'Invalid Protection Information' error code which
> > refers to invalid values in the PRINFO field.
> > So this error code I think should be returned instead of the 'Invalid field'
> > 
> > Another thing to optionaly check is that the metadata pointer for separate metadata.
> >  Is zero as long as we don't support metadata
> > (again I don't see an explicit requirement for this in the spec, but it mentions:
> > 
> > "This field is valid only if the command has metadata that is not interleaved with
> > the logical block data, as specified in the Format NVM command"
> > 
> > )
> > 
> 
> I'm kinda inclined to just drop this patch. The spec actually says that
> the PRACT and PRCHK fields are used only if the namespace is formatted
> to use end-to-end protection information. Since we do not support that,
> I don't think we even need to check it.
> 
> Any opinion on this?
Yep. I also think so.

I did add as much as possible checks on all the reserved fields in nvme-mdev,
checks for all all the unused fields like that, to make it as defensive as possible and to reduce
the attack surface to the minimum.
This can be done later when all the dust settles, its not a high priority for sure.


Best regard,
	Maxim Levitsky


> 



