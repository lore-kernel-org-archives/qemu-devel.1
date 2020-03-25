Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E3F2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wcx1HOKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E3F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDeq-0002GT-29
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHDdn-0001hW-F2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHDdl-00073X-Lg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:32:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHDdl-00072x-Gn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585171964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LroCjlSZ5yXVYOqc/ovGaSkfNhamBB7SdtL43Rcjc10=;
 b=Wcx1HOKATPmh7qaPnYnCa/IlofNpfU2rJvotaidoVHj4Tqg8nlJ9LzsVhbCFFGN4l75XxY
 dFm2IogmXyVh7EMp42ar7KJN0KLGg1KRiCeCquEa7RRCTX0IcOIpZSw8ltvWzYt7MPiXd+
 yCArNjQpCVwJ3qVLhVJtBOdnzqlrIBI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-hSyTismtO0Gyo9cX9EOBgg-1; Wed, 25 Mar 2020 17:32:42 -0400
X-MC-Unique: hSyTismtO0Gyo9cX9EOBgg-1
Received: by mail-wr1-f69.google.com with SMTP id o9so1893516wrw.14
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 14:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HzxDvQYQSnQiwWUYxvmWBoJakvESdKLye7igJm1ILBU=;
 b=UkLIZd7IgOCqqrIBMEhBe+sDn0KEk5m3upsRLZFVC2XzSl/6AKu/4yyzFNobAfGMM+
 LlzOhRIuGutOwEQA/8f1Hi0leajHg+07MDG4Tefcj9wjVvOyeyVMmbAArYmw2QUeCYPl
 Z39iRvM5uQEiga+egAA3Mivriy6ViQPMcl3q3MPpfTFDcs+i4dWZlq6UYq7h+vxiyo/T
 blmgAju7Y2cy8Mkj7TZwSvT+Ui4sgpE6hn1Fuu4OhWGGa2y90ZCT+/flhzzY3d8oPvmM
 xx/fVxCNi3WmodcXLrybRth89oUKASbx1KYgkbo/VL/MBwFRX8ClFd1nPcQUU2syNJV0
 6NqQ==
X-Gm-Message-State: ANhLgQ14w0uwh3ak6J0FXCqOnsoIZodUAJl+o341ZJ1w31EYI1YXW3pB
 sk6gcqCyXxd2pSn6+mxyGsGNmVnu6X3RXEz2uGwSZ/M8O2wFSC0tXSaY/DuWAK2E3fejY7TFGOk
 gYKY/WbGmfu4o1JM=
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr5217739wme.47.1585171961403; 
 Wed, 25 Mar 2020 14:32:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHFSssyaPM6RcsD0jyvYIlTwChEQsLI6U7nwjd5ixCiNxuHuRUlJUvNhiKnk5H5K4NgDJWjA==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr5217718wme.47.1585171961109; 
 Wed, 25 Mar 2020 14:32:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b203sm420428wmc.45.2020.03.25.14.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 14:32:40 -0700 (PDT)
Date: Wed, 25 Mar 2020 17:32:37 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 9/9] KVM: Dirty ring support
Message-ID: <20200325213237.GG404034@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-10-peterx@redhat.com>
 <20200325204144.GI2635@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200325204144.GI2635@work-vm>
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

On Wed, Mar 25, 2020 at 08:41:44PM +0000, Dr. David Alan Gilbert wrote:

[...]

> > +enum KVMReaperState {
> > +    KVM_REAPER_NONE =3D 0,
> > +    /* The reaper is sleeping */
> > +    KVM_REAPER_WAIT,
> > +    /* The reaper is reaping for dirty pages */
> > +    KVM_REAPER_REAPING,
> > +};
>=20
> That probably needs to be KVMDirtyRingReaperState
> given there are many things that could be reaped.

Sure.

>=20
> > +/*
> > + * KVM reaper instance, responsible for collecting the KVM dirty bits
> > + * via the dirty ring.
> > + */
> > +struct KVMDirtyRingReaper {
> > +    /* The reaper thread */
> > +    QemuThread reaper_thr;
> > +    /*
> > +     * Telling the reaper thread to wakeup.  This should be used as a
> > +     * generic interface to kick the reaper thread, like, in vcpu
> > +     * threads where it gets a exit due to ring full.
> > +     */
> > +    EventNotifier reaper_event;
>=20
> I think I'd just used a simple semaphore for this type of thing.

I'm actually uncertain on which is cheaper...

At the meantime, I wanted to poll two handles at the same time below
(in kvm_dirty_ring_reaper_thread).  I don't know how to do that with
semaphore.  Could it?

[...]

> > @@ -412,6 +460,18 @@ int kvm_init_vcpu(CPUState *cpu)
> >              (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
> >      }
> > =20
> > +    if (s->kvm_dirty_gfn_count) {
> > +        cpu->kvm_dirty_gfns =3D mmap(NULL, s->kvm_dirty_ring_size,
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
>=20
> Is the MAP_SHARED required?

Yes it's required.  It's the same when we map the per-vcpu kvm_run.

If we use MAP_PRIVATE, it'll be in a COW fashion - when the userspace
writes to the dirty gfns the 1st time, it'll copy the current dirty
ring page in the kernel and from now on QEMU will never be able to see
what the kernel writes to the dirty gfn pages.  MAP_SHARED means the
userspace and the kernel shares exactly the same page(s).

>=20
> > +                                   cpu->kvm_fd,
> > +                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFS=
ET);
> > +        if (cpu->kvm_dirty_gfns =3D=3D MAP_FAILED) {
> > +            ret =3D -errno;
> > +            DPRINTF("mmap'ing vcpu dirty gfns failed\n");
>=20
> Include errno?

Will do.

[...]

> > +static uint64_t kvm_dirty_ring_reap(KVMState *s)
> > +{
> > +    KVMMemoryListener *kml;
> > +    int ret, i, locked_count =3D s->nr_as;
> > +    CPUState *cpu;
> > +    uint64_t total =3D 0;
> > +
> > +    /*
> > +     * We need to lock all kvm slots for all address spaces here,
> > +     * because:
> > +     *
> > +     * (1) We need to mark dirty for dirty bitmaps in multiple slots
> > +     *     and for tons of pages, so it's better to take the lock here
> > +     *     once rather than once per page.  And more importantly,
> > +     *
> > +     * (2) We must _NOT_ publish dirty bits to the other threads
> > +     *     (e.g., the migration thread) via the kvm memory slot dirty
> > +     *     bitmaps before correctly re-protect those dirtied pages.
> > +     *     Otherwise we can have potential risk of data corruption if
> > +     *     the page data is read in the other thread before we do
> > +     *     reset below.
> > +     */
> > +    for (i =3D 0; i < s->nr_as; i++) {
> > +        kml =3D s->as[i].ml;
> > +        if (!kml) {
> > +            /*
> > +             * This is tricky - we grow s->as[] dynamically now.  Take
> > +             * care of that case.  We also assumed the as[] will fill
> > +             * one by one starting from zero.  Without this, we race
> > +             * with register_smram_listener.
> > +             *
> > +             * TODO: make all these prettier...
> > +             */
> > +            locked_count =3D i;
> > +            break;
> > +        }
> > +        kvm_slots_lock(kml);
> > +    }
> > +
> > +    CPU_FOREACH(cpu) {
> > +        total +=3D kvm_dirty_ring_reap_one(s, cpu);
> > +    }
> > +
> > +    if (total) {
> > +        ret =3D kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
> > +        assert(ret =3D=3D total);
> > +    }
> > +
> > +    /* Unlock whatever locks that we have locked */
> > +    for (i =3D 0; i < locked_count; i++) {
> > +        kvm_slots_unlock(s->as[i].ml);
> > +    }
> > +
> > +    CPU_FOREACH(cpu) {
> > +        if (cpu->kvm_dirty_ring_full) {
> > +            qemu_sem_post(&cpu->kvm_dirty_ring_avail);
> > +        }
>=20
> Why do you need to wait until here - couldn't you release
> each vcpu after you've reaped it?

We probably still need to wait.  Even after we reaped all the dirty
bits we only marked the pages as "collected", the buffers will only be
available again until the kernel re-protect those pages (when the
above KVM_RESET_DIRTY_RINGS completes).  Before that, continuing the
vcpu could let it exit again with the same ring full event.

[...]

> > +static int kvm_dirty_ring_reaper_init(KVMState *s)
> > +{
> > +    struct KVMDirtyRingReaper *r =3D &s->reaper;
> > +    int ret;
> > +
> > +    ret =3D event_notifier_init(&r->reaper_event, false);
> > +    assert(ret =3D=3D 0);
> > +    ret =3D event_notifier_init(&r->reaper_flush_event, false);
> > +    assert(ret =3D=3D 0);
> > +    qemu_sem_init(&r->reaper_flush_sem, 0);
> > +
> > +    qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> > +                       kvm_dirty_ring_reaper_thread,
> > +                       s, QEMU_THREAD_JOINABLE);
>=20
> That's marked as joinable - does it ever get joined?
> If the reaper thread does exit on error (I can only see the poll
> failure?) - what happens elsewhere - will things still try and kick it?

The reaper thread is not designed to fail for sure. If it fails, it'll
exit without being joined, but otherwise I'll just abort() directly in
the thread which seems to be not anything better...

Regarding to "why not join() it": I think it's simply because we don't
have corresponding operation to AccelClass.init_machine() and
kvm_init(). :-) From that POV, I think I'll still use JOINABLE with
the hope that someday the destroy_machine() hook will be ready and
we'll be able to join it.

Thanks,

--=20
Peter Xu


