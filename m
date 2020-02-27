Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CBBC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFAA24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsOH2Qzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFAA24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Oiw-0004n9-Fv
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7Ogm-00025D-EQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7Ogj-0003iu-CM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:19:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7Ogj-0003i7-64
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582831150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eE1R76V1l53A7Z5pMmFn0Vf5UaqxbWuyXPPoBIz3sFI=;
 b=TsOH2QzlfqBXEuPxEpn92RwZ2gu3PQRKZWsqGM15zc/Fj4HpDBn89FA7tpQ5yLpbiSkkp4
 4CaoSBVh8qgrVzlIAkSdOS6GbXnpPleoUwtD0o/mZsOs9sCvRZusZzBkmevmGm5gXauY9P
 Pg8pLlHrGhSdF9680NHc+l+w3lE9BhU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-hApqPPTPNDybYE4HKbKJ7A-1; Thu, 27 Feb 2020 14:19:04 -0500
X-MC-Unique: hApqPPTPNDybYE4HKbKJ7A-1
Received: by mail-qk1-f199.google.com with SMTP id v189so271408qkb.16
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IB3EQmE4vMbcET/QuQHoIvhUc9hZSeomNG0vHCXUn5s=;
 b=NlPvpy0oeygaS7tb0bglNRVO1bVmBDpcVQ5KtLrLh4zykd2FQmChlqXC1XnLFg7eRB
 m2d/1wLxnD/7oGks+AcEleYhI5O8nEQw1PxH20S0Pxk57+TlMW71u1E+D7TQUdK1LV4Z
 vMvFc+gcXwzeZZSYIZcW2fsksZ1L3qMqKEtpEkymPYlrUh4uLSqGLvOQvs4iWBj031pD
 /mXBAl0g9GFcPtRyWx9GjYvGCJX6JYYmbA2fGDpmjoes3sROAJFgdrLWUK7BInkPsYyi
 MRJVVQMHbWaLGjRH+htfp6YCnVbWzKtM0GyKnF93aztEhR/NYDCZUz8I6lNfwiWSEvO5
 8YLA==
X-Gm-Message-State: APjAAAVZqhE/Y8iSaaWuGQZ7aBsqJWnlJzgIAgstL1ecMr42eyBE42+l
 wqv1fbBF7b9QDoc8LIDB9EnY41g8ib6pNbTyxwD0uB4AlCOvlcesox66Y0+FOGTYYrLuszaIgUV
 DDEmPfWxyTJSTQ1E=
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr445072qvz.100.1582831144027; 
 Thu, 27 Feb 2020 11:19:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhx6oYu3t1XhF8wLkEO6j3YdMzTLHtZThQGO87kapLzU0M9PLu82828rQn/eNY+5T61SfWMQ==
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr445025qvz.100.1582831143498; 
 Thu, 27 Feb 2020 11:19:03 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g62sm3596877qkd.25.2020.02.27.11.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 11:19:02 -0800 (PST)
Date: Thu, 27 Feb 2020 14:19:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200227191900.GK180973@xz-x1>
References: <20200227170048.236599-1-peterx@redhat.com>
 <5e69c385-b27c-61d4-5856-21bcf5e9c8f5@redhat.com>
 <20200227180003.GJ180973@xz-x1>
 <2852480c-89fe-4c4e-75be-7322592976b6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2852480c-89fe-4c4e-75be-7322592976b6@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 07:22:08PM +0100, Auger Eric wrote:
> Hi Peter,
>=20
> On 2/27/20 7:00 PM, Peter Xu wrote:
> > On Thu, Feb 27, 2020 at 06:42:09PM +0100, Auger Eric wrote:
> >> Hi Peter,
> >>
> >> On 2/27/20 6:00 PM, Peter Xu wrote:
> >>> This is majorly only for X86 because that's the only one that support=
s
> >>> split irqchip for now.
> >>>
> >>> When the irqchip is split, we face a dilemma that KVM irqfd will be
> >>> enabled, however the slow irqchip is still running in the userspace.
> >>> It means that the resamplefd in the kernel irqfds won't take any
> >>> effect and it can miss to ack INTx interrupts on EOIs.
> >> Won't it always fail to ack INTx? With the above sentence I understand
> >> it can work sometimes?
> >=20
> > I wanted to mean that it will fail.  How about s/can/will/?  Or even
> > better wordings that you'd suggest?
> yes: s/can/will
> >=20
> >>>
> >>> One example is split irqchip with VFIO INTx, which will break if we
> >>> use the VFIO INTx fast path.
> >>>
> >>> This patch can potentially supports the VFIO fast path again for INTx=
,
> >>> that the IRQ delivery will still use the fast path, while we don't
> >>> need to trap MMIOs in QEMU for the device to emulate the EIOs (see th=
e
> >>> callers of vfio_eoi() hook).  However the EOI of the INTx will still
> >>> need to be done from the userspace by caching all the resamplefds in
> >>> QEMU and kick properly for IOAPIC EOI broadcast.
> >> If I understand correctly this is a one way fast path? Fast path is on
> >> the trigger side only: VFIO -> KVM but not on the deactivation side,
> >> trapped by the userspace IOAPIC where you directly notify the UNMASK
> >> eventfd from userspace. Is that correct?
> >=20
> > Right, the injection is still using the whole fast path.  However
> > AFAIU even for the EOI path it should still be faster than the pure
> > slow path of vfio INTx EIO.  From what I got from reading the code,
> > the slow path will conditionally unmap MMIO regions (with a timer to
> > delay the recovery) so all MMIOs will be slowed down.  For what this
> > patch is doing, it will need to exit to userspace for sure for each
> > EOI (after all IOAPIC is in userspace), however for the whole
> > lifecycle of the device, the MMIO regions should always be mapped so
> > no unwanted MMIO traps.
> Yes the EOI is trapped on IOAPIC side and not at the BAR level. So it
> should be more efficient and more precise.

Yes.

> >=20
> >>>
> >>> When the userspace is responsible for the resamplefd kickup, don't
> >>> register it on the kvm_irqfd anymore, because on newer kernels (after
> >>> commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
> >>> irqchip and resamplefd.  This will make sure that the fast path will
> >>> work for all supported kernels.
> >>>
> >>> https://patchwork.kernel.org/patch/10738541/#22609933
> >>>
> >>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>> ---
> >>> v1.1 changelog:
> >>> - when resamplefd is going to be kicked from userspace, don't registe=
r
> >>>   it again in KVM_IRQFD.  Tested against upstream kernel.
> >>>
> >>>  accel/kvm/kvm-all.c    | 74 ++++++++++++++++++++++++++++++++++++++++=
--
> >>>  accel/kvm/trace-events |  1 +
> >>>  hw/intc/ioapic.c       | 11 +++++--
> >>>  include/sysemu/kvm.h   |  4 +++
> >>>  4 files changed, 86 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> >>> index d49b74512a..b766b6e93c 100644
> >>> --- a/accel/kvm/kvm-all.c
> >>> +++ b/accel/kvm/kvm-all.c
> >>> @@ -159,9 +159,62 @@ static const KVMCapabilityInfo kvm_required_capa=
bilites[] =3D {
> >>>  static NotifierList kvm_irqchip_change_notifiers =3D
> >>>      NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
> >>> =20
> >>> +struct KVMResampleFd {
> >>> +    int gsi;
> >>> +    EventNotifier *resample_event;
> >>> +    QLIST_ENTRY(KVMResampleFd) node;
> >>> +};
> >>> +typedef struct KVMResampleFd KVMResampleFd;
> >>> +
> >>> +/*
> >>> + * Only used with split irqchip where we need to do the resample fd
> >>> + * kick for the kernel from userspace.
> >>> + */
> >>> +static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =3D
> >>> +    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
> >>> +
> >>>  #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
> >>>  #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_loc=
k)
> >>> =20
> >>> +static inline void kvm_resample_fd_remove(int gsi)
> >>> +{
> >>> +    KVMResampleFd *rfd;
> >>> +
> >>> +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> >>> +        if (rfd->gsi =3D=3D gsi) {
> >>> +            QLIST_REMOVE(rfd, node);
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +static inline void kvm_resample_fd_insert(int gsi, EventNotifier *ev=
ent)
> >>> +{
> >>> +    KVMResampleFd *rfd =3D g_new0(KVMResampleFd, 1);
> >>> +
> >>> +    rfd->gsi =3D gsi;
> >>> +    rfd->resample_event =3D event;
> >>> +
> >>> +    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
> >>> +}
> >>> +
> >>> +void kvm_resample_fd_notify(int gsi)
> >>> +{
> >>> +    KVMResampleFd *rfd;
> >>> +
> >>> +    if (!kvm_irqchip_is_split()) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> >>> +        if (rfd->gsi =3D=3D gsi) {
> >>> +            event_notifier_set(rfd->resample_event);
> >>> +            trace_kvm_resample_fd_notify(gsi);
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>>  int kvm_get_max_memslots(void)
> >>>  {
> >>>      KVMState *s =3D KVM_STATE(current_accel());
> >>> @@ -1642,8 +1695,25 @@ static int kvm_irqchip_assign_irqfd(KVMState *=
s, EventNotifier *event,
> >>>      };
> >>> =20
> >>>      if (rfd !=3D -1) {
> >>> -        irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
> >>> -        irqfd.resamplefd =3D rfd;
> >>> +        assert(assign);
> >>> +        if (kvm_irqchip_is_split()) {
> >>> +            /*
> >>> +             * When the slow irqchip (e.g. IOAPIC) is in the
> >>> +             * userspace, resamplefd will not work because the EOI o=
f
> >>> +             * the interrupt will be delivered to userspace instead,
> >> s/delivered to userspace/handled in userspace
> >=20
> > It will be delivered to userspace by KVM_EXIT_IOAPIC_EOI, so
> > maybe... "delivered and handled"?
> ah ok. TBH I don't really know how the split irqchip works and that may
> explain below misunderstandings.
> >=20
> >>> +             * the KVM resample fd kick is skipped.  The userspace
> >>> +             * needs to remember the resamplefd and kick it when we
> >>> +             * receive EOI of this IRQ.
> >> Practically we now talk about a VFIO ACTION_UNMASK classical eventfd
> >> As such isn't it a bit weird to handle those normal UNMASK eventfds in
> >> the KVM code?
> >=20
> > I'm not sure I completely get the question, but this should be
> > something general to KVM resamplefd support.  In other words, this
> > should also fix other devices (besides VFIO) when they're using the
> > KVM resamplefd, because IMHO it's the resamplefd and split irqchip
> > which is really broken here.
> Here is my understanding (& memories): the KVM resamplefd is an eventfd
> you register to KVM so that KVM triggers the resamplefd when KVM traps
> the EOI. Here I understand this is the userspace IOAPIC that traps the
> EOI and not the in-kernel virtual interrupt controller. So I would have
> expected you just need to signal the VFIO UNMASK eventfd to re-enable
> the physical IRQ (which was automasked). This is no more a KVM
> resamplefd strictly speaking as KVM is not involved anymore in the
> deactivation process.

Yes KVM kernel side should not be involed when we're using split
irqchip in this case.  However it should still belongs to the work of
the userspace KVM module (kvm-all.c) so that it can still "mimic" the
resamplefd feature that KVM_IRQFD provides.

> >=20
> > With that in mind, I think KVM should not need to even know what's
> > behind the resamplefd (in VFIO's case, it's the UNMASK eventfd).  It
> > just needs to kick it when IOAPIC EOI comes for the specific IRQ
> But above the userspace directly calls
> event_notifier_set(rfd->resample_event);
>=20
> This is not KVM anymore that "kicks it". Or maybe I miss something. So
> my comment was, why is it handled in the QEMU KVM layer?

It's my fault to be unclear on using "KVM" above.  I should really say
it as kvm-all.c, say, the QEMU layer for the kernel KVM module.

Indeed this problem is complicated... let me try to summarize.

Firstly KVM split irqchip and resamplefd is not really going to work
in the kernel (I think we just overlooked that when introducing the
2nd feature, no matter which one comes first), because the resample
operation should be part of IOAPIC EOI, nevertheless when using split
irqchip IOAPIC is in userspace.

After we noticed this, Alex somewhere proposed to disable that in KVM,
which is actually the 1st kernel patch (654f1f13ea56).

We should (at the same time) propose patch 1 too in this series but I
guess everybody just forgot this afterwards (Paolo actually proposed
mostly the whole solution but I guess it got forgotten too)...

About the fast path speedup: the main logic should be to mimic the
same resamplefd feature as provided by KVM_IRQFD but this time only in
the userspace.  However now we're implementing the same logic only
within userspace kvm-all.c, and the kernel KVM should be totally not
aware of this.  Doing that benefits us in that the KVM interface in
QEMU does not need to be changed (majorly kvm_irqchip_assign_irqfd()).
What we need to do is just to wire up the userspace IOAPIC with these
resamplefds.  And the idea is actually the same too - someone (VFIO)
wants to have one fd (which is the resamplefd) kicked when EOI comes
when requesting for a KVM irqfd, no matter who's going to kick it
(kernel KVM or userspace).  That's all.

> .
> >=20
> >>
> >>
> >>> +             */
> >>> +            kvm_resample_fd_insert(virq, resample);
> >>> +        } else {
> >>> +            irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
> >>> +            irqfd.resamplefd =3D rfd;
> >>> +        }
> >>> +    } else if (!assign) {
> >>> +        if (kvm_irqchip_is_split()) {
> >>> +            kvm_resample_fd_remove(virq);
> >>> +        }
> >>>      }
> >>> =20
> >>>      if (!kvm_irqfds_enabled()) {
> >>> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> >>> index 4fb6e59d19..a68eb66534 100644
> >>> --- a/accel/kvm/trace-events
> >>> +++ b/accel/kvm/trace-events
> >>> @@ -16,4 +16,5 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint3=
2_t val, bool assign, uint32_
> >>>  kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assi=
gn, uint32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size=
: %d match: %d"
> >>>  kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_ph=
ys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d f=
lags=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D=
%d"
> >>>  kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "s=
lot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
> >>> +kvm_resample_fd_notify(int gsi) "gsi %d"
> >>> =20
> >>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> >>> index 15747fe2c2..8c75465c62 100644
> >>> --- a/hw/intc/ioapic.c
> >>> +++ b/hw/intc/ioapic.c
> >>> @@ -236,8 +236,15 @@ void ioapic_eoi_broadcast(int vector)
> >>>          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> >>>              entry =3D s->ioredtbl[n];
> >>> =20
> >>> -            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> >>> -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D =
IOAPIC_TRIGGER_LEVEL) {
> >>> +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
> >>> +                continue;
> >>> +            }
> >>> +
> >>> +            /* Kick resamplefd if KVM is bypassed */
> >>> +            kvm_resample_fd_notify(n);
> >> KVM is bypassed on the deactivation path but still we call
> >> kvm_resample_fd_notify().
> >=20
> > Yes I wanted to say that the kernel won't be able to kick the
> > resamplefd.  How about:
> >=20
> >   When IOAPIC is in the userspace (while APIC is still in the kernel),
> >   we need to kick the resamplefd to deactivate the IRQ for KVM.
> This fd "just" aims at unmasking the IRQ at physical level (UNMASK VFIO
> event)? Does it perform anything related to the virtual interrupt
> controller?

It should not.

Thanks,

--=20
Peter Xu


