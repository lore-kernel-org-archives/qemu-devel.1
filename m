Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B170424649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcDl1Pzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B170424649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBU6r-00080F-Uz
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 21:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jBU6C-0007bf-Jp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jBU6B-0008BB-2D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:54:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jBU6A-0008AV-T1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583805262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3v1/aJnAwBaOGVd8qwLyx3qCTl0MjmDa90xPuSLaE=;
 b=bcDl1PzxFVtQxNesmkU896UQQpKqWefUkiZqLzQXlVtV4BeoTYjn84Ujl9OA6dcZZTuA75
 Hd7Fbtczxb0Rr/CMqSUXkjC3wTDukoHjh54dfD9IhvBsZjX+8q1/v6y4QtmbzB7recVF7P
 tbYplq7h9uQU5syOGaL0FX9Ctcnr1PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-OXgBBZgoNzSV1AZOb0jcJw-1; Mon, 09 Mar 2020 21:54:18 -0400
X-MC-Unique: OXgBBZgoNzSV1AZOb0jcJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38CE8017CC
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:54:17 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5038A5C1C3;
 Tue, 10 Mar 2020 01:54:11 +0000 (UTC)
Date: Mon, 9 Mar 2020 19:54:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200309195410.7946c02c@x1.home>
In-Reply-To: <20200310003808.GC326977@xz-x1>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
 <20200309161059.7c1cc49e@w520.home>
 <20200309163359.45ac9c3e@w520.home> <20200310003808.GC326977@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 20:38:08 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Mar 09, 2020 at 04:33:59PM -0600, Alex Williamson wrote:
> 
> [...]
> 
> > > > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > > > index 15747fe2c2..13921b333d 100644
> > > > --- a/hw/intc/ioapic.c
> > > > +++ b/hw/intc/ioapic.c
> > > > @@ -236,8 +236,27 @@ void ioapic_eoi_broadcast(int vector)
> > > >          for (n = 0; n < IOAPIC_NUM_PINS; n++) {
> > > >              entry = s->ioredtbl[n];
> > > >  
> > > > -            if ((entry & IOAPIC_VECTOR_MASK) != vector ||
> > > > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) != IOAPIC_TRIGGER_LEVEL) {
> > > > +            if ((entry & IOAPIC_VECTOR_MASK) != vector) {
> > > > +                continue;
> > > > +            }
> > > > +
> > > > +            /*
> > > > +             * When IOAPIC is in the userspace while APIC is still in
> > > > +             * the kernel (i.e., split irqchip), we have a trick to
> > > > +             * kick the resamplefd logic for registered irqfds from
> > > > +             * userspace to deactivate the IRQ.  When that happens, it
> > > > +             * means the irq bypassed userspace IOAPIC (so the irr and
> > > > +             * remote-irr of the table entry should be bypassed too
> > > > +             * even if interrupt come), then we don't need to clear
> > > > +             * the remote-IRR and check irr again because they'll
> > > > +             * always be zeros.
> > > > +             */
> > > > +            if (kvm_resample_fd_notify(n)) {
> > > > +                continue;
> > > > +            }    
> > > 
> > > It seems the problem I reported is here.  In my configuration virtio-blk
> > > and an assigned e1000e share an interrupt.  virtio-blk is initializing
> > > and apparently triggers an interrupt.  The vfio-pci device is
> > > configured for INTx though not active yet, but kvm_resample_fd_notify()
> > > kicks the fd here, so we continue.  If I remove the continue here both
> > > devices seem to work, but I don't claim to understand the condition
> > > we're trying to continue for here yet.  This series needs more testing
> > > with shared interrupts.  Thanks,  
> > 
> > I'm also curious how this ended up between testing whether the vector
> > is masked and testing that it's level triggered.  We shouldn't have any
> > edge triggered resamplers.  
> 
> We had a similar discussion in V1 (with Paolo):
> 
> https://patchwork.kernel.org/patch/11407441/#23190891
> 
> So my understanding is that VFIO will unmask the intx IRQ when it
> comes, and register the resamplefd too, no matter whether it's level
> triggered (at least from what the code does).  Am I right?

As Paolo replied in your previous discussion, INTx is always level
triggered.
 
> > I find however that if I move the resampler
> > notify to after the remote IRR test, my NIC gets starved of interrupts.
> > So empirically, it seems kvm_resample_fd_notify() should be a void
> > function called unconditionally between the original mask+level check
> > removed above and the IRR check below.  Thanks,  
> 
> Yes IMHO we can't move that notify() to be after the remote IRR check
> because the IRR and remote IRR will be completely bypassed for the
> assigned device.  In other words, even if the interrupt has arrived
> for the assigned device, both IRR and remote IRR should always be zero
> (assuming the virtio-blk device doesn't generate any IRQ).  So we
> probably still need to do the notify even if remote-irr is not set.

Yep.  Thanks,

Alex


