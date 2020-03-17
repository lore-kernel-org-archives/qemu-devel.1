Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ECDC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA01720714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYSEPgqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA01720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEKSa-0008Ru-21
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jEKRa-0007xX-IU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jEKRY-00066X-Q9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:12:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jEKRY-0005zw-Jz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584483132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+g5QQrfmAsq7Rgnc/wI0pMEsZN9NkiEt0oK5oWA/V9k=;
 b=UYSEPgqnE92W8hvXxRJg+X2DZMJDRo+fJN9JQCGaHJOlQftrHVPBklTI3fV//g5CiCR/vh
 h44BDh9RbsOrS4zz9DRMtdj4n419k5sbPek9YMapoNRUKaww+0zX7n43cmyCzjaY5ovc6M
 O9eYKYtH8CBKTS32Ahrb+xTy9tKhd2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-MzAk52h8MteLHrJwUHTfhA-1; Tue, 17 Mar 2020 18:12:07 -0400
X-MC-Unique: MzAk52h8MteLHrJwUHTfhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA1CC1005509
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 22:12:06 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3DD35C1BB;
 Tue, 17 Mar 2020 22:12:01 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:12:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200317161200.0c41fe60@w520.home>
In-Reply-To: <20200317214108.GD233068@xz-x1>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-5-peterx@redhat.com>
 <20200317150646.2718d3a6@w520.home> <20200317214108.GD233068@xz-x1>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Tue, 17 Mar 2020 17:41:08 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Mar 17, 2020 at 03:06:46PM -0600, Alex Williamson wrote:
> 
> [...]
> 
> > > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > > index 15747fe2c2..81a17cc2b8 100644
> > > --- a/hw/intc/ioapic.c
> > > +++ b/hw/intc/ioapic.c
> > > @@ -236,8 +236,29 @@ void ioapic_eoi_broadcast(int vector)
> > >          for (n = 0; n < IOAPIC_NUM_PINS; n++) {
> > >              entry = s->ioredtbl[n];
> > >  
> > > -            if ((entry & IOAPIC_VECTOR_MASK) != vector ||
> > > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) != IOAPIC_TRIGGER_LEVEL) {
> > > +            if ((entry & IOAPIC_VECTOR_MASK) != vector) {
> > > +                continue;
> > > +            }
> > > +
> > > +            /*
> > > +             * When IOAPIC is in the userspace while APIC is still in
> > > +             * the kernel (i.e., split irqchip), we have a trick to
> > > +             * kick the resamplefd logic for registered irqfds from
> > > +             * userspace to deactivate the IRQ.  When that happens, it
> > > +             * means the irq bypassed userspace IOAPIC (so the irr and
> > > +             * remote-irr of the table entry should be bypassed too
> > > +             * even if interrupt come).  Still kick the resamplefds if
> > > +             * they're bound to the IRQ, to make sure to EOI the
> > > +             * interrupt for the hardware correctly.
> > > +             *
> > > +             * Note: We still need to go through the irr & remote-irr
> > > +             * operations below because we don't know whether there're
> > > +             * emulated devices that are using/sharing the same IRQ.
> > > +             */
> > > +            kvm_resample_fd_notify(n);
> > > +
> > > +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
> > > +                IOAPIC_TRIGGER_LEVEL) {
> > >                  continue;
> > >              }
> > >    
> > 
> > What's the logic for sending resampler notifies before testing if the
> > ioapic entry is in level triggered mode?  vfio won't use this for
> > anything other than level triggered.  Inserting it between these checks
> > confused me and in my testing wasn't necessary.  Thanks,  
> 
> I put it there to match the kernel implementation, and IIUC Paolo
> agreed with that too:
> 
> https://patchwork.kernel.org/patch/11407441/#23190969
> 
> Since we've discussed a few times here, I think I can talk a bit more
> on how I understand this in case I was wrong...
> 
> Even if we have the fact that all the existing devices that use this
> code should be using level-triggered IRQs, however... *If* there comes
> an edge-triggered INTx device and we assign it using vfio-pci, vfio
> should also mask the IRQ after it generates (according to
> vfio_intx_handler), is that right?  Then we still need to kick the
> resamplefd for that does-not-exist device too to make sure it'll work?

"edge-triggered INTx" is not a thing that exists.  The PCI spec defines
interrupt pins as:

  2.2.6. Interrupt Pins (Optional)

  Interrupts on PCI are optional and defined as "level sensitive,"
  asserted low (negative true), using open drain output drivers.

Masking of interrupts while they're in-service is not done for edge
triggered interrupts, we assume that being a discrete interrupt is a
sufficient rate limiter versus a level triggered interrupt, which is
continuous and can saturate the host.

If it exists before the level check only to match the kernel, maybe a
comment or todo item to check whether it's the optimal approach for
both cases should be in order.  I can't think of any reason why we'd
need it for the sake of edge triggered vfio interrupts in either place.
Thanks,

Alex


