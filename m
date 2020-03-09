Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04329C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5262253D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKZhDFrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5262253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBRpk-0001Og-Uo
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jBRp8-0000x2-Tc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jBRp6-0006Mr-SV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:28:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jBRp6-0006M5-MJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583796515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNCFs20gRJc/Eccix8WCVHIumlM7NvhWIliHwve9lZQ=;
 b=SKZhDFrm3ErLSjKWl+W4/S6caW0g+rRyH9aALnyjycSKxnnPwn+E38clZ2t9dhsi7H/DKA
 3oewjBeLICZm0HT+sh4hsr9TMcilhrpktfBInDvi5SFiSv6ay/WA362vaOE+YeBs0JHE+K
 nAFZn/aEoFS7TLS/guYSbYyZynoYW+s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-34FFxNWQPGijemLjNE1rYw-1; Mon, 09 Mar 2020 19:28:31 -0400
X-MC-Unique: 34FFxNWQPGijemLjNE1rYw-1
Received: by mail-qt1-f199.google.com with SMTP id d2so7933428qtr.9
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 16:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OkzOhtgoH3VBloDnfObrw1elyYRtNC0sIM6fMnoPVrQ=;
 b=FmHPH7e5tyrmyBy9aAoB5orEmkCZk9XY9EF7+W/fTdOj9JzV6HhyRMQUF7WOZeAcHn
 cwLeKi49ijATrNukEEb19u20olKuRIjLix9VZrwTuygPNmGnmg02dGFxNBU6zQ/qq6zt
 4+PHMcu1ChWcVQoT+lqQSP7cHrYg5hKf4rl5OJ8im2WQt/vy+Z1CirEYl+ymiiPGJCuI
 xwN0qSgdV901693/nK3WQT4sxNZX9QnrM0I9wY27BDe1RrhL/3sBCJTzIcytBVtVsKZT
 ihehL5gryOaAMEwoc6KW589BNBA2EV0jZjCK1RKuL+q2tpwf7PIryKdH43Vdo49rk85N
 uVtQ==
X-Gm-Message-State: ANhLgQ0860CdbdyEYeopDNVs78IblJ/8XwTa817gkj3ZOdiFc+PAozV+
 WYhtM7+7/CvCucUW1qwQkENKyJ1PkIUeluFM5FN0CaJzvmI7mpFNa6RTf2hDsw5z9AaBvQNJSMh
 QTNk6DOWn/4Cq0PY=
X-Received: by 2002:ac8:7765:: with SMTP id h5mr16862655qtu.223.1583796511169; 
 Mon, 09 Mar 2020 16:28:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtGBoT7U0c7FIr+uKgE8NF52O4OGGp47+ebUwpyMpAysPxqixeKx5HO8H+r5eejjgf1QI1wbQ==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr16862639qtu.223.1583796510761; 
 Mon, 09 Mar 2020 16:28:30 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k50sm23657966qtc.90.2020.03.09.16.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 16:28:30 -0700 (PDT)
Date: Mon, 9 Mar 2020 19:28:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200309232828.GB326977@xz-x1>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
 <20200309161059.7c1cc49e@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200309161059.7c1cc49e@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 04:10:59PM -0600, Alex Williamson wrote:
> On Fri, 28 Feb 2020 11:15:02 -0500
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > This is majorly only for X86 because that's the only one that supports
> > split irqchip for now.
> >=20
> > When the irqchip is split, we face a dilemma that KVM irqfd will be
> > enabled, however the slow irqchip is still running in the userspace.
> > It means that the resamplefd in the kernel irqfds won't take any
> > effect and it will miss to ack INTx interrupts on EOIs.
> >=20
> > One example is split irqchip with VFIO INTx, which will break if we
> > use the VFIO INTx fast path.
> >=20
> > This patch can potentially supports the VFIO fast path again for INTx,
> > that the IRQ delivery will still use the fast path, while we don't
> > need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
> > callers of vfio_eoi() hook).  However the EOI of the INTx will still
> > need to be done from the userspace by caching all the resamplefds in
> > QEMU and kick properly for IOAPIC EOI broadcast.
> >=20
> > This is tricky because in this case the userspace ioapic irr &
> > remote-irr will be bypassed.  However such a change will greatly boost
> > performance for assigned devices using INTx irqs (TCP_RR boosts 46%
> > after this patch applied).
> >=20
> > When the userspace is responsible for the resamplefd kickup, don't
> > register it on the kvm_irqfd anymore, because on newer kernels (after
> > commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
> > irqchip and resamplefd.  This will make sure that the fast path will
> > work for all supported kernels.
> >=20
> > https://patchwork.kernel.org/patch/10738541/#22609933
> >=20
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c    | 85 +++++++++++++++++++++++++++++++++++++++++-
> >  accel/kvm/trace-events |  1 +
> >  hw/intc/ioapic.c       | 23 +++++++++++-
> >  include/sysemu/kvm.h   |  7 ++++
> >  4 files changed, 112 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index d49b74512a..89771ea114 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -159,9 +159,65 @@ static const KVMCapabilityInfo kvm_required_capabi=
lites[] =3D {
> >  static NotifierList kvm_irqchip_change_notifiers =3D
> >      NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
> > =20
> > +struct KVMResampleFd {
> > +    int gsi;
> > +    EventNotifier *resample_event;
> > +    QLIST_ENTRY(KVMResampleFd) node;
> > +};
> > +typedef struct KVMResampleFd KVMResampleFd;
> > +
> > +/*
> > + * Only used with split irqchip where we need to do the resample fd
> > + * kick for the kernel from userspace.
> > + */
> > +static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =3D
> > +    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
> > +
> >  #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
> >  #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
> > =20
> > +static inline void kvm_resample_fd_remove(int gsi)
> > +{
> > +    KVMResampleFd *rfd;
> > +
> > +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> > +        if (rfd->gsi =3D=3D gsi) {
> > +            QLIST_REMOVE(rfd, node);
> > +            g_free(rfd);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +static inline void kvm_resample_fd_insert(int gsi, EventNotifier *even=
t)
> > +{
> > +    KVMResampleFd *rfd =3D g_new0(KVMResampleFd, 1);
> > +
> > +    rfd->gsi =3D gsi;
> > +    rfd->resample_event =3D event;
> > +
> > +    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
> > +}
> > +
> > +bool kvm_resample_fd_notify(int gsi)
> > +{
> > +    KVMResampleFd *rfd;
> > +
> > +    if (!kvm_irqchip_is_split()) {
> > +        return false;
> > +    }
> > +
> > +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> > +        if (rfd->gsi =3D=3D gsi) {
> > +            event_notifier_set(rfd->resample_event);
> > +            trace_kvm_resample_fd_notify(gsi);
> > +            return true;
> > +        }
> > +    }
> > +
> > +    return false;
> > +}
> > +
> >  int kvm_get_max_memslots(void)
> >  {
> >      KVMState *s =3D KVM_STATE(current_accel());
> [snip] =20
> > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > index 15747fe2c2..13921b333d 100644
> > --- a/hw/intc/ioapic.c
> > +++ b/hw/intc/ioapic.c
> > @@ -236,8 +236,27 @@ void ioapic_eoi_broadcast(int vector)
> >          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> >              entry =3D s->ioredtbl[n];
> > =20
> > -            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D IO=
APIC_TRIGGER_LEVEL) {
> > +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
> > +                continue;
> > +            }
> > +
> > +            /*
> > +             * When IOAPIC is in the userspace while APIC is still in
> > +             * the kernel (i.e., split irqchip), we have a trick to
> > +             * kick the resamplefd logic for registered irqfds from
> > +             * userspace to deactivate the IRQ.  When that happens, it
> > +             * means the irq bypassed userspace IOAPIC (so the irr and
> > +             * remote-irr of the table entry should be bypassed too
> > +             * even if interrupt come), then we don't need to clear
> > +             * the remote-IRR and check irr again because they'll
> > +             * always be zeros.
> > +             */
> > +            if (kvm_resample_fd_notify(n)) {
> > +                continue;
> > +            }
>=20
> It seems the problem I reported is here.  In my configuration virtio-blk
> and an assigned e1000e share an interrupt.  virtio-blk is initializing
> and apparently triggers an interrupt.  The vfio-pci device is
> configured for INTx though not active yet, but kvm_resample_fd_notify()
> kicks the fd here, so we continue.  If I remove the continue here both
> devices seem to work, but I don't claim to understand the condition
> we're trying to continue for here yet.  This series needs more testing
> with shared interrupts.  Thanks,

Hi, Alex,

The "continue" was there only because I wanted to skip updating remote
IRR and so on, considering that it won't be useful after all if the
userspace irqchip is bypassed here.  However I totally overlooked the
fact that this exact IRQ can be shared by another device that is using
the same IRQ while it was not bypassed by the kernel instead.

Here's my guess on what should have happened...

  - The first IRQ of the virtio-blk device will work, which will set
    IRR bit, and at last it'll also set remote-irr of the IRQ, showing
    that it's in service

  - When the virtio-blk wants to EOI the irq, it noticed that it's
    registered with resamplefd (which is actually the nic's rather
    than the virtio-blk device), then it ignored the update to
    remote-irr assuming that it'll always be zero (but actually it's
    just set).

  - When the virtio-blk wants to send further IRQs (starting from the
    2nd one), it will try to set irr again, but this time since the
    remote-irr is still set, it'll ignore the interrupt because it
    thought the IRQ is still in service (while it's not).  This
    corresponds to where "coalesce=3D=3Dtrue" in ioapic_service():

        if (coalesce) {
                /* We are level triggered interrupts, and the
                * guest should be still working on previous one,
                * so skip it. */
                continue;
        }

With that, I think your proposed solution should be the right fix,
that we should still keep the whole IOAPIC EOI path even if the IRQ is
registered with resamplefd, because that can be used by the other device.

I'll also test this senario tomorrow.

Thanks!

--=20
Peter Xu


