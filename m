Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C60C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5718A2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGS6OBmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5718A2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSvu-0001MN-KD
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jBSuZ-0007ye-Mq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jBSuX-00057x-0B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jBSuW-00056J-Ie
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583800695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IViABhBgSe+7s8tHcQPilvhad6aOka4CDoUCQB78AGA=;
 b=KGS6OBmJGYvWa2LAts9nYCX7IOPDBBOSTG+QyRs3RJ9i/zLoOYU4eg6BtI1BreKH3u+EIm
 f9kyF3zyLvsXNzB0Enkwt02f6ejU2Pj+sZayIsr1NSo0BhSlFbg2WNAYpPDX5FS/GNMUvV
 bLZtl9hitlsdyR4vRbVjvwPQKq6fngM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-cme85-atMTqcJzJ8qqFCWw-1; Mon, 09 Mar 2020 20:38:12 -0400
X-MC-Unique: cme85-atMTqcJzJ8qqFCWw-1
Received: by mail-qt1-f198.google.com with SMTP id r16so8059305qtt.13
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 17:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lNoRhCf+TU6tqKIu9Np9WmyWeheG3lYhMX0BLVvm820=;
 b=KE4xr5pWoF/m10sfyksnDqHPuSkpApKm5W+FVmxGiTWbtOEZi9FCi77Wfqge9mym6y
 H7Zp9hyKYXio7eCXj8h7eHWDxARrKixOhrp0Igb6srm4OpUbqWcjYeVZdNQo9QQukoVh
 2DaPQt//n8p9ZKK+wCZP5IFsBX8P8msePYzOtp9kjOFcIn+VjEv24Wz7mZVzMHZ33ZH4
 65wl40h02+P37fPUn/4hAQA6l7xwZcb9FqKiiI+scS5VaSuZRiAnCxCoKh2J7wS48THA
 aNxHyl3DzU+4jdsM3QDse0XhX0SvNxbIVLKp08GzlFK3SbT8ltsJlZl6/49yodokUTWc
 wGQQ==
X-Gm-Message-State: ANhLgQ1d2gtnxBjtaeDuprHlq4ACqOtQLp02Qo8k/D41BUTl4htz+wAh
 sPokL0N6I6Qz2pUWQDcBgorDs/ZJ7VEKn8tTHs0iLKLtEH3cZ1tYYTi4srF/pUTK08PTLSc0gtE
 lY8w0CDLBCVhtjIM=
X-Received: by 2002:a05:620a:2208:: with SMTP id
 m8mr17043570qkh.236.1583800691564; 
 Mon, 09 Mar 2020 17:38:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUp3gqAf7VyvS3ql04evPmUF7v2LBl9rQEIst3dGLtuaesYfSCrkUsABjOaaK4Rx8HVDMWLQ==
X-Received: by 2002:a05:620a:2208:: with SMTP id
 m8mr17043552qkh.236.1583800691221; 
 Mon, 09 Mar 2020 17:38:11 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id w13sm16206175qtn.83.2020.03.09.17.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 17:38:10 -0700 (PDT)
Date: Mon, 9 Mar 2020 20:38:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200310003808.GC326977@xz-x1>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
 <20200309161059.7c1cc49e@w520.home>
 <20200309163359.45ac9c3e@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200309163359.45ac9c3e@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Mon, Mar 09, 2020 at 04:33:59PM -0600, Alex Williamson wrote:

[...]

> > > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > > index 15747fe2c2..13921b333d 100644
> > > --- a/hw/intc/ioapic.c
> > > +++ b/hw/intc/ioapic.c
> > > @@ -236,8 +236,27 @@ void ioapic_eoi_broadcast(int vector)
> > >          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> > >              entry =3D s->ioredtbl[n];
> > > =20
> > > -            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> > > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D =
IOAPIC_TRIGGER_LEVEL) {
> > > +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
> > > +                continue;
> > > +            }
> > > +
> > > +            /*
> > > +             * When IOAPIC is in the userspace while APIC is still i=
n
> > > +             * the kernel (i.e., split irqchip), we have a trick to
> > > +             * kick the resamplefd logic for registered irqfds from
> > > +             * userspace to deactivate the IRQ.  When that happens, =
it
> > > +             * means the irq bypassed userspace IOAPIC (so the irr a=
nd
> > > +             * remote-irr of the table entry should be bypassed too
> > > +             * even if interrupt come), then we don't need to clear
> > > +             * the remote-IRR and check irr again because they'll
> > > +             * always be zeros.
> > > +             */
> > > +            if (kvm_resample_fd_notify(n)) {
> > > +                continue;
> > > +            } =20
> >=20
> > It seems the problem I reported is here.  In my configuration virtio-bl=
k
> > and an assigned e1000e share an interrupt.  virtio-blk is initializing
> > and apparently triggers an interrupt.  The vfio-pci device is
> > configured for INTx though not active yet, but kvm_resample_fd_notify()
> > kicks the fd here, so we continue.  If I remove the continue here both
> > devices seem to work, but I don't claim to understand the condition
> > we're trying to continue for here yet.  This series needs more testing
> > with shared interrupts.  Thanks,
>=20
> I'm also curious how this ended up between testing whether the vector
> is masked and testing that it's level triggered.  We shouldn't have any
> edge triggered resamplers.

We had a similar discussion in V1 (with Paolo):

https://patchwork.kernel.org/patch/11407441/#23190891

So my understanding is that VFIO will unmask the intx IRQ when it
comes, and register the resamplefd too, no matter whether it's level
triggered (at least from what the code does).  Am I right?

> I find however that if I move the resampler
> notify to after the remote IRR test, my NIC gets starved of interrupts.
> So empirically, it seems kvm_resample_fd_notify() should be a void
> function called unconditionally between the original mask+level check
> removed above and the IRR check below.  Thanks,

Yes IMHO we can't move that notify() to be after the remote IRR check
because the IRR and remote IRR will be completely bypassed for the
assigned device.  In other words, even if the interrupt has arrived
for the assigned device, both IRR and remote IRR should always be zero
(assuming the virtio-blk device doesn't generate any IRQ).  So we
probably still need to do the notify even if remote-irr is not set.

Thanks,

--=20
Peter Xu


