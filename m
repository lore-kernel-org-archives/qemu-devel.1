Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC020C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66F720675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T07mstuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66F720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDJL-0004EV-Ts
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDEW-0006Mb-9C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDEU-0007Be-VT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:30:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJDEU-0007BO-RG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585647054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrAqn8W746tZQOuxQWJQVpdNnmLsWyNfAWFbGkHp5gk=;
 b=T07mstuoww0KerKoMcX7qlnHUTsPtKWaMHftj5bcPx0Y3r1SulTQ7WfuVmvaNYtqISvKcf
 TYRMFME7WynjxnbuL5vbTnSPWpo9ZGHS7pSUm74iElDYRv02B2mFVyBxGx4Xh+RrJoqvCZ
 NUDoUf5nPCKTV9Gn/Ejf91yBfuqzJuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-MbWwbOsAMJabkonGRk6Wkg-1; Tue, 31 Mar 2020 05:30:50 -0400
X-MC-Unique: MbWwbOsAMJabkonGRk6Wkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFC6800D5C;
 Tue, 31 Mar 2020 09:30:49 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8E74100EBB6;
 Tue, 31 Mar 2020 09:30:46 +0000 (UTC)
Message-ID: <e2a6ef78286154a8e830f6b8c03ad51bec1ec971.camel@redhat.com>
Subject: Re: [PATCH v6 23/42] nvme: add mapping helpers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:30:45 +0300
In-Reply-To: <20200331054430.z4onw7uqnnuobmnk@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-24-its@irrelevant.dk>
 <165e03c021e92f475dc1037b9421d3588d07799b.camel@redhat.com>
 <20200331054430.z4onw7uqnnuobmnk@apples.localdomain>
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

On Tue, 2020-03-31 at 07:44 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:45, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> > > use them in nvme_map_prp.
> > > 
> > > This fixes a bug where in the case of a CMB transfer, the device would
> > > map to the buffer with a wrong length.
> > > 
> > > Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c       | 97 +++++++++++++++++++++++++++++++++++--------
> > >  hw/block/trace-events |  1 +
> > >  2 files changed, 81 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 08267e847671..187c816eb6ad 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -153,29 +158,79 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> > >      }
> > >  }
> > >  
> > > +static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> > > +                                  size_t len)
> > > +{
> > > +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) {
> > > +        return NVME_DATA_TRAS_ERROR;
> > > +    }
> > 
> > I just noticed that
> > in theory (not that it really matters) but addr+len refers to the byte which is already 
> > not the part of the transfer.
> > 
> 
> Oh. Good catch - and I think that it does matter? Can't we end up
> rejecting a valid access? Anyway, I fixed it with a '- 1'.

Actually thinking again about it, we can indeed reject the access if the data happens
to to include last byte of CMB. That can absolutely happen.

When I wrote this I was thinking the other way around that we might reject data
that is in regular ram and 'touches' the CMB, which indeed won't happen since
RAM usually don't come close to MMIO ranges.

Anyway there is not reason to not fix such issues.

> 
> > 
> > > +
> > > +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> > 
> > Also intersting is we can add 0 sized iovec.
> > 
> 
> I added a check on len. This also makes sure the above '- 1' fix doesn't
> cause an 'addr + 0 - 1' to be done.
Yes that is what I was thinking, len=0 needs a special case here.


Best regards,
	Maxim Levitsky



