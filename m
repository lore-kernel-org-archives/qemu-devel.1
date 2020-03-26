Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C134C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F8C206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+IKItjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F8C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTIi-0005U0-8d
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHTHX-0004cg-UH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHTHV-0008He-Lz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:14:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHTHV-0008H7-HP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585232088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRtzwZhtwetC9vJFKWUYtF44fsh4fn1D4Hs64xOBHss=;
 b=T+IKItjIQSsTK3nw5/bekecy7DfKAkU2pwf0PvHnYjGTes05H4f940OAu+Jlq8Q/h3RVa7
 AxpguKSpYZyugsYUz6uadLX9mMJt0gXVZ4pXZ/boz5Wb3m90BkCtBQS2i7UpafSld+ljCd
 vTJTV9xWCT6vtKV9JKroMdRwkBBPd18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-2OG_HyF1MoK3SFR9ZmVwXQ-1; Thu, 26 Mar 2020 10:14:46 -0400
X-MC-Unique: 2OG_HyF1MoK3SFR9ZmVwXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D50EDB63
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:14:45 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F91310002A9;
 Thu, 26 Mar 2020 14:14:38 +0000 (UTC)
Date: Thu, 26 Mar 2020 14:14:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 9/9] KVM: Dirty ring support
Message-ID: <20200326141436.GD2713@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-10-peterx@redhat.com>
 <20200325204144.GI2635@work-vm> <20200325213237.GG404034@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200325213237.GG404034@xz-x1>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Mar 25, 2020 at 08:41:44PM +0000, Dr. David Alan Gilbert wrote:
>=20
> [...]
>=20
> > > +enum KVMReaperState {
> > > +    KVM_REAPER_NONE =3D 0,
> > > +    /* The reaper is sleeping */
> > > +    KVM_REAPER_WAIT,
> > > +    /* The reaper is reaping for dirty pages */
> > > +    KVM_REAPER_REAPING,
> > > +};
> >=20
> > That probably needs to be KVMDirtyRingReaperState
> > given there are many things that could be reaped.
>=20
> Sure.
>=20
> >=20
> > > +/*
> > > + * KVM reaper instance, responsible for collecting the KVM dirty bit=
s
> > > + * via the dirty ring.
> > > + */
> > > +struct KVMDirtyRingReaper {
> > > +    /* The reaper thread */
> > > +    QemuThread reaper_thr;
> > > +    /*
> > > +     * Telling the reaper thread to wakeup.  This should be used as =
a
> > > +     * generic interface to kick the reaper thread, like, in vcpu
> > > +     * threads where it gets a exit due to ring full.
> > > +     */
> > > +    EventNotifier reaper_event;
> >=20
> > I think I'd just used a simple semaphore for this type of thing.
>=20
> I'm actually uncertain on which is cheaper...
>=20
> At the meantime, I wanted to poll two handles at the same time below
> (in kvm_dirty_ring_reaper_thread).  I don't know how to do that with
> semaphore.  Could it?

If you're OK with EventNotifier stick with it;  it's just I'm used
to doing with it with a semaphore; e.g. a flag then the semaphore - but
that's fine.

> [...]
>=20
> > > @@ -412,6 +460,18 @@ int kvm_init_vcpu(CPUState *cpu)
> > >              (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
> > >      }
> > > =20
> > > +    if (s->kvm_dirty_gfn_count) {
> > > +        cpu->kvm_dirty_gfns =3D mmap(NULL, s->kvm_dirty_ring_size,
> > > +                                   PROT_READ | PROT_WRITE, MAP_SHARE=
D,
> >=20
> > Is the MAP_SHARED required?
>=20
> Yes it's required.  It's the same when we map the per-vcpu kvm_run.
>=20
> If we use MAP_PRIVATE, it'll be in a COW fashion - when the userspace
> writes to the dirty gfns the 1st time, it'll copy the current dirty
> ring page in the kernel and from now on QEMU will never be able to see
> what the kernel writes to the dirty gfn pages.  MAP_SHARED means the
> userspace and the kernel shares exactly the same page(s).

OK, worth a comment.

> >=20
> > > +                                   cpu->kvm_fd,
> > > +                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OF=
FSET);
> > > +        if (cpu->kvm_dirty_gfns =3D=3D MAP_FAILED) {
> > > +            ret =3D -errno;
> > > +            DPRINTF("mmap'ing vcpu dirty gfns failed\n");
> >=20
> > Include errno?
>=20
> Will do.
>=20
> [...]
>=20
> > > +static uint64_t kvm_dirty_ring_reap(KVMState *s)
> > > +{
> > > +    KVMMemoryListener *kml;
> > > +    int ret, i, locked_count =3D s->nr_as;
> > > +    CPUState *cpu;
> > > +    uint64_t total =3D 0;
> > > +
> > > +    /*
> > > +     * We need to lock all kvm slots for all address spaces here,
> > > +     * because:
> > > +     *
> > > +     * (1) We need to mark dirty for dirty bitmaps in multiple slots
> > > +     *     and for tons of pages, so it's better to take the lock he=
re
> > > +     *     once rather than once per page.  And more importantly,
> > > +     *
> > > +     * (2) We must _NOT_ publish dirty bits to the other threads
> > > +     *     (e.g., the migration thread) via the kvm memory slot dirt=
y
> > > +     *     bitmaps before correctly re-protect those dirtied pages.
> > > +     *     Otherwise we can have potential risk of data corruption i=
f
> > > +     *     the page data is read in the other thread before we do
> > > +     *     reset below.
> > > +     */
> > > +    for (i =3D 0; i < s->nr_as; i++) {
> > > +        kml =3D s->as[i].ml;
> > > +        if (!kml) {
> > > +            /*
> > > +             * This is tricky - we grow s->as[] dynamically now.  Ta=
ke
> > > +             * care of that case.  We also assumed the as[] will fil=
l
> > > +             * one by one starting from zero.  Without this, we race
> > > +             * with register_smram_listener.
> > > +             *
> > > +             * TODO: make all these prettier...
> > > +             */
> > > +            locked_count =3D i;
> > > +            break;
> > > +        }
> > > +        kvm_slots_lock(kml);
> > > +    }
> > > +
> > > +    CPU_FOREACH(cpu) {
> > > +        total +=3D kvm_dirty_ring_reap_one(s, cpu);
> > > +    }
> > > +
> > > +    if (total) {
> > > +        ret =3D kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
> > > +        assert(ret =3D=3D total);
> > > +    }
> > > +
> > > +    /* Unlock whatever locks that we have locked */
> > > +    for (i =3D 0; i < locked_count; i++) {
> > > +        kvm_slots_unlock(s->as[i].ml);
> > > +    }
> > > +
> > > +    CPU_FOREACH(cpu) {
> > > +        if (cpu->kvm_dirty_ring_full) {
> > > +            qemu_sem_post(&cpu->kvm_dirty_ring_avail);
> > > +        }
> >=20
> > Why do you need to wait until here - couldn't you release
> > each vcpu after you've reaped it?
>=20
> We probably still need to wait.  Even after we reaped all the dirty
> bits we only marked the pages as "collected", the buffers will only be
> available again until the kernel re-protect those pages (when the
> above KVM_RESET_DIRTY_RINGS completes).  Before that, continuing the
> vcpu could let it exit again with the same ring full event.

Ah OK.

> [...]
>=20
> > > +static int kvm_dirty_ring_reaper_init(KVMState *s)
> > > +{
> > > +    struct KVMDirtyRingReaper *r =3D &s->reaper;
> > > +    int ret;
> > > +
> > > +    ret =3D event_notifier_init(&r->reaper_event, false);
> > > +    assert(ret =3D=3D 0);
> > > +    ret =3D event_notifier_init(&r->reaper_flush_event, false);
> > > +    assert(ret =3D=3D 0);
> > > +    qemu_sem_init(&r->reaper_flush_sem, 0);
> > > +
> > > +    qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> > > +                       kvm_dirty_ring_reaper_thread,
> > > +                       s, QEMU_THREAD_JOINABLE);
> >=20
> > That's marked as joinable - does it ever get joined?
> > If the reaper thread does exit on error (I can only see the poll
> > failure?) - what happens elsewhere - will things still try and kick it?
>=20
> The reaper thread is not designed to fail for sure. If it fails, it'll
> exit without being joined, but otherwise I'll just abort() directly in
> the thread which seems to be not anything better...
>=20
> Regarding to "why not join() it": I think it's simply because we don't
> have corresponding operation to AccelClass.init_machine() and
> kvm_init(). :-) From that POV, I think I'll still use JOINABLE with
> the hope that someday the destroy_machine() hook will be ready and
> we'll be able to join it.

OK, that's fine.

Dave

> Thanks,
>=20
> --=20
> Peter Xu
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


