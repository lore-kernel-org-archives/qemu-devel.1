Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3BC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2004A2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd5HHr/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6DwG-0001GL-4M
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6DvY-0000Y0-4J
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6DvW-00031m-3b
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:37:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6DvV-00031a-Tb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582551457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdtUZnIfIP+uOv/oqyrzPcWwXs+dAi51z2u1wGxrcyo=;
 b=Vd5HHr/CVVQvFXOAk2C1vtDjS6zau4qkdIXCwVJ96zvgbTUvQOWQBkiyuYX8u9vCjjDbcL
 miZveqASKH2lTVPMCDmwzc00qLtbhHAT9hfjskkN05IBz9Mg6AvBP2qjvN6ax7rPfZGVpe
 UXEu+2DpWbSCWTAwDj2xVmJJ2wjWc+4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-AZ45li1rOcqMjf9xqn3O7w-1; Mon, 24 Feb 2020 08:37:35 -0500
X-MC-Unique: AZ45li1rOcqMjf9xqn3O7w-1
Received: by mail-qv1-f69.google.com with SMTP id p3so8963590qvt.9
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 05:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aIav4Lg4gwyjFBGz7lyxrnlY7295NmXmqCuLpEBzFVA=;
 b=Do+spMFxmmFiwTD9JR1xgzOSBHzv5dtKLfjZTHe6NZ7vjle06FGfMD6otzX1685Pqy
 0j2gOe5ccR5Bd2i+wqOkDs7rnwX51VeCFAoLX04ONvHcx6XlRkrFURH7vX0u3onIDJhf
 RkZ2JaLLAqn07no/XJHo3jowD3dimpMpS7KG+i/hkwsbwdiwWgnhtEWkSqqZp6cgen+A
 j72fUOQmiJdvIs0Nt0grDXnjsVFwdje9FCo5Chde1CrPUWLb090w5KSeHCHTajitORp1
 WBRq+72V4F67nBVs+iRl290hRcS/OYgJkzEZY3LItEtNJE84xQw4miG6XIxpzuBthBDx
 kSpg==
X-Gm-Message-State: APjAAAWcT+Cc6MIGktJgxvjFj4xouTrCEQLbJ7lErhyFcb7Fn+sGFq22
 GlgKWHKoldAokWFWYVL/o1eP060bSDLg1nr7/Oe1nHuIYuAqSE5EAc99jeTg4tZcirqfO3gLCoh
 AI1tqAQquy4I/5d0=
X-Received: by 2002:aed:2047:: with SMTP id 65mr48495269qta.78.1582551455178; 
 Mon, 24 Feb 2020 05:37:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNTfzXsbHFQcTWTEw8xSXQ8w7iH0gwbx4Ju0dC1R1ToB/cC5sQYoMdGtlqmByDjEJrsKjPyQ==
X-Received: by 2002:aed:2047:: with SMTP id 65mr48495232qta.78.1582551454778; 
 Mon, 24 Feb 2020 05:37:34 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g185sm3521477qkd.16.2020.02.24.05.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 05:37:33 -0800 (PST)
Date: Mon, 24 Feb 2020 08:37:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio: gracefully handle invalid region caches
Message-ID: <20200224083650-mutt-send-email-mst@kernel.org>
References: <20200207104619.164892-1-stefanha@redhat.com>
 <20200224133554.GG1897982@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200224133554.GG1897982@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 01:35:54PM +0000, Stefan Hajnoczi wrote:
> On Fri, Feb 07, 2020 at 10:46:19AM +0000, Stefan Hajnoczi wrote:
> > The virtqueue code sets up MemoryRegionCaches to access the virtqueue
> > guest RAM data structures.  The code currently assumes that
> > VRingMemoryRegionCaches is initialized before device emulation code
> > accesses the virtqueue.  An assertion will fail in
> > vring_get_region_caches() when this is not true.  Device fuzzing found =
a
> > case where this assumption is false (see below).
> >=20
> > Virtqueue guest RAM addresses can also be changed from a vCPU thread
> > while an IOThread is accessing the virtqueue.  This breaks the same
> > assumption but this time the caches could become invalid partway throug=
h
> > the virtqueue code.  The code fetches the caches RCU pointer multiple
> > times so we will need to validate the pointer every time it is fetched.
> >=20
> > Add checks each time we call vring_get_region_caches() and treat invali=
d
> > caches as a nop: memory stores are ignored and memory reads return 0.
> >=20
> > The fuzz test failure is as follows:
> >=20
> >   $ qemu -M pc -device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,addr=3D4=
.0 \
> >          -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=3Draw,au=
to-read-only=3Doff \
> >          -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroe=
s=3Don,format=3Draw \
> >          -display none \
> >          -qtest stdio
> >   endianness
> >   outl 0xcf8 0x80002020
> >   outl 0xcfc 0xe0000000
> >   outl 0xcf8 0x80002004
> >   outw 0xcfc 0x7
> >   write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabfff=
fffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffff=
ffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffa=
bffffffabffffffabffffffabffffffabffffffab0000000001
> >   inb 0x4
> >   writew 0xe000001c 0x1
> >   write 0xe0000014 0x1 0x0d
> >=20
> > The following error message is produced:
> >=20
> >   qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring=
_get_region_caches: Assertion `caches !=3D NULL' failed.
> >=20
> > The backtrace looks like this:
> >=20
> >   #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
> >   #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
> >   #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
> >   #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
> >   #4  0x00005555559073da in vring_get_region_caches (vq=3D<optimized ou=
t>) at qemu/hw/virtio/virtio.c:286
> >   #5  vring_get_region_caches (vq=3D<optimized out>) at qemu/hw/virtio/=
virtio.c:283
> >   #6  0x000055555590818d in vring_used_flags_set_bit (mask=3D1, vq=3D0x=
5555575ceea0) at qemu/hw/virtio/virtio.c:398
> >   #7  virtio_queue_split_set_notification (enable=3D0, vq=3D0x5555575ce=
ea0) at qemu/hw/virtio/virtio.c:398
> >   #8  virtio_queue_set_notification (vq=3Dvq@entry=3D0x5555575ceea0, en=
able=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:451
> >   #9  0x0000555555908512 in virtio_queue_set_notification (vq=3Dvq@entr=
y=3D0x5555575ceea0, enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:4=
44
> >   #10 0x00005555558c697a in virtio_blk_handle_vq (s=3D0x5555575c57e0, v=
q=3D0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
> >   #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=3D0x5555575c=
eea0) at qemu/hw/virtio/virtio.c:2244
> >   #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=3Dctx@entry=3D0x=
55555671a420) at util/aio-posix.c:429
> >   #13 0x0000555555cb67a8 in aio_dispatch (ctx=3D0x55555671a420) at util=
/aio-posix.c:460
> >   #14 0x0000555555cb307e in aio_ctx_dispatch (source=3D<optimized out>,=
 callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:2=
60
> >   #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libgli=
b-2.0.so.0
> >   #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:21=
9
> >   #17 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-l=
oop.c:242
> >   #18 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.=
c:518
> >   #19 0x00005555559b20c9 in main_loop () at vl.c:1683
> >   #20 0x0000555555838115 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4441
> >=20
> > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > Cc: Michael Tsirkin <mst@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > An alternative solution is to keep the vring.caches pointer non-NULL al=
l
> > the time so no checks are necessary.  We would need to initialize it to
> > a VRingMemoryRegionCaches object that points to unassigned_mem.  This
> > way virtio.c never hits NULL pointers and all memory loads/stores becom=
e
> > nop when caches are invalid.
> >=20
> > I think this solution is cleaner but couldn't see a reasonable way of
> > initializing MemoryRegionCache objects so that they point to a 64-bit
> > unassigned_mem MemoryRegion.  Maybe someone who knows the memory API
> > better knows whether this is doable?
> >=20
> > Michael: We discussed changing vring.desc checks, but I think that's no
> > longer necessary with this patch.  If a guest gets past a vring.desc
> > check then it can no longer trigger the assertion failure.
> > ---
> >  hw/virtio/virtio.c | 99 ++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 91 insertions(+), 8 deletions(-)
>=20
> Ping?

Queued, thanks!

> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 2c5410e981..00d444699d 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -282,15 +282,19 @@ static void vring_packed_flags_write(VirtIODevice=
 *vdev,
> >  /* Called within rcu_read_lock().  */
> >  static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQue=
ue *vq)
> >  {
> > -    VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.cac=
hes);
> > -    assert(caches !=3D NULL);
> > -    return caches;
> > +    return atomic_rcu_read(&vq->vring.caches);
> >  }
> > +
> >  /* Called within rcu_read_lock().  */
> >  static inline uint16_t vring_avail_flags(VirtQueue *vq)
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingAvail, flags);
> > +
> > +    if (!caches) {
> > +        return 0;
> > +    }
> > +
> >      return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
> >  }
> > =20
> > @@ -299,6 +303,11 @@ static inline uint16_t vring_avail_idx(VirtQueue *=
vq)
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingAvail, idx);
> > +
> > +    if (!caches) {
> > +        return 0;
> > +    }
> > +
> >      vq->shadow_avail_idx =3D virtio_lduw_phys_cached(vq->vdev, &caches=
->avail, pa);
> >      return vq->shadow_avail_idx;
> >  }
> > @@ -308,6 +317,11 @@ static inline uint16_t vring_avail_ring(VirtQueue =
*vq, int i)
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingAvail, ring[i]);
> > +
> > +    if (!caches) {
> > +        return 0;
> > +    }
> > +
> >      return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
> >  }
> > =20
> > @@ -323,6 +337,11 @@ static inline void vring_used_write(VirtQueue *vq,=
 VRingUsedElem *uelem,
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingUsed, ring[i]);
> > +
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> >      virtio_tswap32s(vq->vdev, &uelem->id);
> >      virtio_tswap32s(vq->vdev, &uelem->len);
> >      address_space_write_cached(&caches->used, pa, uelem, sizeof(VRingU=
sedElem));
> > @@ -334,6 +353,11 @@ static uint16_t vring_used_idx(VirtQueue *vq)
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingUsed, idx);
> > +
> > +    if (!caches) {
> > +        return 0;
> > +    }
> > +
> >      return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> >  }
> > =20
> > @@ -342,8 +366,12 @@ static inline void vring_used_idx_set(VirtQueue *v=
q, uint16_t val)
> >  {
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      hwaddr pa =3D offsetof(VRingUsed, idx);
> > -    virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
> > -    address_space_cache_invalidate(&caches->used, pa, sizeof(val));
> > +
> > +    if (caches) {
> > +        virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
> > +        address_space_cache_invalidate(&caches->used, pa, sizeof(val))=
;
> > +    }
> > +
> >      vq->used_idx =3D val;
> >  }
> > =20
> > @@ -353,8 +381,13 @@ static inline void vring_used_flags_set_bit(VirtQu=
eue *vq, int mask)
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      VirtIODevice *vdev =3D vq->vdev;
> >      hwaddr pa =3D offsetof(VRingUsed, flags);
> > -    uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used=
, pa);
> > +    uint16_t flags;
> > =20
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> > +    flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> >      virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
> >      address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
> >  }
> > @@ -365,8 +398,13 @@ static inline void vring_used_flags_unset_bit(Virt=
Queue *vq, int mask)
> >      VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
> >      VirtIODevice *vdev =3D vq->vdev;
> >      hwaddr pa =3D offsetof(VRingUsed, flags);
> > -    uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used=
, pa);
> > +    uint16_t flags;
> > =20
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> > +    flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> >      virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
> >      address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
> >  }
> > @@ -381,6 +419,10 @@ static inline void vring_set_avail_event(VirtQueue=
 *vq, uint16_t val)
> >      }
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> >      pa =3D offsetof(VRingUsed, ring[vq->vring.num]);
> >      virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
> >      address_space_cache_invalidate(&caches->used, pa, sizeof(val));
> > @@ -410,7 +452,11 @@ static void virtio_queue_packed_set_notification(V=
irtQueue *vq, int enable)
> >      VRingMemoryRegionCaches *caches;
> > =20
> >      RCU_READ_LOCK_GUARD();
> > -    caches  =3D vring_get_region_caches(vq);
> > +    caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> >      vring_packed_event_read(vq->vdev, &caches->used, &e);
> > =20
> >      if (!enable) {
> > @@ -597,6 +643,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue=
 *vq)
> >      }
> > =20
> >      cache =3D vring_get_region_caches(vq);
> > +    if (!cache) {
> > +        return 1;
> > +    }
> > +
> >      vring_packed_desc_read_flags(vq->vdev, &desc.flags, &cache->desc,
> >                                   vq->last_avail_idx);
> > =20
> > @@ -777,6 +827,10 @@ static void virtqueue_packed_fill_desc(VirtQueue *=
vq,
> >      }
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        return;
> > +    }
> > +
> >      vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head, stri=
ct_order);
> >  }
> > =20
> > @@ -949,6 +1003,10 @@ static void virtqueue_split_get_avail_bytes(VirtQ=
ueue *vq,
> > =20
> >      max =3D vq->vring.num;
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        goto err;
> > +    }
> > +
> >      while ((rc =3D virtqueue_num_heads(vq, idx)) > 0) {
> >          MemoryRegionCache *desc_cache =3D &caches->desc;
> >          unsigned int num_bufs;
> > @@ -1089,6 +1147,9 @@ static void virtqueue_packed_get_avail_bytes(Virt=
Queue *vq,
> > =20
> >      max =3D vq->vring.num;
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        goto err;
> > +    }
> > =20
> >      for (;;) {
> >          unsigned int num_bufs =3D total_bufs;
> > @@ -1194,6 +1255,10 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, un=
signed int *in_bytes,
> >      }
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        goto err;
> > +    }
> > +
> >      desc_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACK=
ED) ?
> >                                  sizeof(VRingPackedDesc) : sizeof(VRing=
Desc);
> >      if (caches->desc.len < vq->vring.num * desc_size) {
> > @@ -1387,6 +1452,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, =
size_t sz)
> >      i =3D head;
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        virtio_error(vdev, "Region caches not initialized");
> > +        goto done;
> > +    }
> > +
> >      if (caches->desc.len < max * sizeof(VRingDesc)) {
> >          virtio_error(vdev, "Cannot map descriptor ring");
> >          goto done;
> > @@ -1509,6 +1579,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq,=
 size_t sz)
> >      i =3D vq->last_avail_idx;
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        virtio_error(vdev, "Region caches not initialized");
> > +        goto done;
> > +    }
> > +
> >      if (caches->desc.len < max * sizeof(VRingDesc)) {
> >          virtio_error(vdev, "Cannot map descriptor ring");
> >          goto done;
> > @@ -1628,6 +1703,10 @@ static unsigned int virtqueue_packed_drop_all(Vi=
rtQueue *vq)
> >      VRingPackedDesc desc;
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        return 0;
> > +    }
> > +
> >      desc_cache =3D &caches->desc;
> > =20
> >      virtio_queue_set_notification(vq, 0);
> > @@ -2412,6 +2491,10 @@ static bool virtio_packed_should_notify(VirtIODe=
vice *vdev, VirtQueue *vq)
> >      VRingMemoryRegionCaches *caches;
> > =20
> >      caches =3D vring_get_region_caches(vq);
> > +    if (!caches) {
> > +        return false;
> > +    }
> > +
> >      vring_packed_event_read(vdev, &caches->avail, &e);
> > =20
> >      old =3D vq->signalled_used;
> > --=20
> > 2.24.1
> >=20



