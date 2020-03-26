Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD12C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260CA2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjXRZoxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260CA2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHV6Z-00050j-B3
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHV5w-0004XV-5v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHV5v-00029b-36
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:11:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHV5u-00029U-Vk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585239058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/6dMmTUHcOGbvZRaSUfWOFgvnXoVoxTfNRm44mzTpg=;
 b=JjXRZoxJgjE9e/p2eIJQmh0h4FlOUh8TBffVxrRFW8zv3uLnQ7b1jAuj+g5N+CkYz7Cw3T
 IELSHLmQOYhFpl5xessKLehjg84AjYsSrxEHF1erKLrXX7kmnpdVU+cwii9chxhALNaE+9
 T94PzqWKg0l+J2wsUmAAqwdb4zKbUl0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-9iqvGYLGPyGsApbRSHAOrg-1; Thu, 26 Mar 2020 12:10:56 -0400
X-MC-Unique: 9iqvGYLGPyGsApbRSHAOrg-1
Received: by mail-wr1-f71.google.com with SMTP id i18so3247834wrx.17
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 09:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p1vLvFGHZhQwUHXA3L5NSv/VYyLctfYLqvwdJaLjZJU=;
 b=HlUYhTfcdtH5QZmlkUykh+0wX3+DvTrfy2xP1590AZgG3WBjq1zN9whp6NrAYko619
 DglzFSeYELl+NYRKYP2oXy+GFLDmFSKk5Asehs7R3SkILBTjfEoTVzsFgf0kCKjRgXem
 b+V0myiwTB90GuO/jculvrjwKa7nRfDcjKlLXrg4YSKbJMAk1XnKNmyiTGtqusPg1Ecu
 NVdHCnZOTsZVEv/Dofnj3G8wracnLWirUb4sH8u8ed8NHysNaoUsD9zpRcHIDM3Lwc/t
 sCqkTKE868TgNu80Uq5j7n/f4DRTcsURrVAW+q0ny3YG7XQ+hbMJ56j6QnELGMfDgQSR
 fhnw==
X-Gm-Message-State: ANhLgQ2FPPWKSNzZhidSxD/p+d5/mTaVIAB71ztcZ1mM5lEqzoeKxONL
 ZhC787nytbtPN+Ne4h9AYx6ZUUENgjCnYR8B99HuGyHYuVu9/Cdjm6jbm0iZrGkUNjrWmWAN3ez
 G9guTlo4z7JbuIvQ=
X-Received: by 2002:a5d:4305:: with SMTP id h5mr9781307wrq.69.1585239055178;
 Thu, 26 Mar 2020 09:10:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtO20wU13qsrj6AmT+I4IM935el+mQ75+ux3d/I4cJVQq0OkXAqvQ5ZfxM1RFZi/HIPWrZ3sw==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr9781284wrq.69.1585239054939;
 Thu, 26 Mar 2020 09:10:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u131sm4288068wmg.41.2020.03.26.09.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 09:10:54 -0700 (PDT)
Date: Thu, 26 Mar 2020 12:10:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 9/9] KVM: Dirty ring support
Message-ID: <20200326161050.GG422390@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-10-peterx@redhat.com>
 <20200325204144.GI2635@work-vm> <20200325213237.GG404034@xz-x1>
 <20200326141436.GD2713@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200326141436.GD2713@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 02:14:36PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Mar 25, 2020 at 08:41:44PM +0000, Dr. David Alan Gilbert wrote:
> >=20
> > [...]
> >=20
> > > > +enum KVMReaperState {
> > > > +    KVM_REAPER_NONE =3D 0,
> > > > +    /* The reaper is sleeping */
> > > > +    KVM_REAPER_WAIT,
> > > > +    /* The reaper is reaping for dirty pages */
> > > > +    KVM_REAPER_REAPING,
> > > > +};
> > >=20
> > > That probably needs to be KVMDirtyRingReaperState
> > > given there are many things that could be reaped.
> >=20
> > Sure.
> >=20
> > >=20
> > > > +/*
> > > > + * KVM reaper instance, responsible for collecting the KVM dirty b=
its
> > > > + * via the dirty ring.
> > > > + */
> > > > +struct KVMDirtyRingReaper {
> > > > +    /* The reaper thread */
> > > > +    QemuThread reaper_thr;
> > > > +    /*
> > > > +     * Telling the reaper thread to wakeup.  This should be used a=
s a
> > > > +     * generic interface to kick the reaper thread, like, in vcpu
> > > > +     * threads where it gets a exit due to ring full.
> > > > +     */
> > > > +    EventNotifier reaper_event;
> > >=20
> > > I think I'd just used a simple semaphore for this type of thing.
> >=20
> > I'm actually uncertain on which is cheaper...
> >=20
> > At the meantime, I wanted to poll two handles at the same time below
> > (in kvm_dirty_ring_reaper_thread).  I don't know how to do that with
> > semaphore.  Could it?
>=20
> If you're OK with EventNotifier stick with it;  it's just I'm used
> to doing with it with a semaphore; e.g. a flag then the semaphore - but
> that's fine.

Ah yes flags could work, though we probably need to be careful with
flags and use atomic accesses to avoid race conditions of flag lost.

Then I'll keep it, thanks.

>=20
> > [...]
> >=20
> > > > @@ -412,6 +460,18 @@ int kvm_init_vcpu(CPUState *cpu)
> > > >              (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
> > > >      }
> > > > =20
> > > > +    if (s->kvm_dirty_gfn_count) {
> > > > +        cpu->kvm_dirty_gfns =3D mmap(NULL, s->kvm_dirty_ring_size,
> > > > +                                   PROT_READ | PROT_WRITE, MAP_SHA=
RED,
> > >=20
> > > Is the MAP_SHARED required?
> >=20
> > Yes it's required.  It's the same when we map the per-vcpu kvm_run.
> >=20
> > If we use MAP_PRIVATE, it'll be in a COW fashion - when the userspace
> > writes to the dirty gfns the 1st time, it'll copy the current dirty
> > ring page in the kernel and from now on QEMU will never be able to see
> > what the kernel writes to the dirty gfn pages.  MAP_SHARED means the
> > userspace and the kernel shares exactly the same page(s).
>=20
> OK, worth a comment.

Sure.

--=20
Peter Xu


