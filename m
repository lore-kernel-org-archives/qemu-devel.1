Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B753C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6693D20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXGa9a8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6693D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izaf9-00038g-Ik
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 01:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izaeQ-0002fV-Sf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izaeO-0007ah-7f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:28:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54036
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izaeN-0007Rp-Ti
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580970511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zV/b4NgDnSxxJRO2zKLogWzXxGQdfF5N0Yan42uc/io=;
 b=cXGa9a8CvcgstBY9DRSe+8JcpRevrAoSTNz3mAJ+OvP8+5Wy6EsItE85A26VpV+Mb4iwWk
 BVCsjqL//0Pf5DvL+aZQkbNJESZ9Xr7UHEPXdSN5lyF2JkyvoyjZ3oO+BCgdpSOP45UFS/
 IWANEdBJjwBCio2egZPu6Nfh0t+bX0A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286--f209g5eMjiAsr74lYVElw-1; Thu, 06 Feb 2020 01:28:29 -0500
Received: by mail-qt1-f198.google.com with SMTP id m8so3143220qta.20
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 22:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wg7Xc/ZHKn9HedibsGVp+f4Dzu38lf2eoRJKTeu/EBY=;
 b=bnGbctu2lN19xeFtiSMqCM6zTIwyvEQXnG/9XTbunzrlnaaANDw+OnH+VF9Quy7QLd
 z8qpoIZUKkHnFVZqiet3QOJs0a17rlwQFR05uigb7NLva33W8T4wHjGPa+Kfqx/+1VAn
 1GklP0FTD5Bc1rpk1SRcjG/SHx65sPUpGjWsMc7s0atDGVsg/Ddtt4Mk1PHPiKllXSkP
 ++n+TvajklmFW6+rwklG/ik+Dcd8ZUtVByFGxKe2Ea/K+Icp1u06niiVJ0CRI4r5Af6O
 Lq1TRZ6PWGqupclPsJH1AejxHk9zUCYs2e3Y1EFZQHSuOeWc/l9yC8Am/Ah/vqASUxxK
 SxnA==
X-Gm-Message-State: APjAAAWSM/gXmtYmKyeLu2tz1JbbaTdmVpAFaqGI/hg1Z4+Gr7fJiq4y
 nGmL2+EBnhuCAD37JnzDPJB56o2TYsWNrqicg6lWOx09t00LgiDzsHIG/lb+CKlFfcXlEP7JGky
 SLZjdvptmINK4/jg=
X-Received: by 2002:a05:620a:1005:: with SMTP id
 z5mr1207581qkj.26.1580970509186; 
 Wed, 05 Feb 2020 22:28:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqztTbaJk5Nzr7fPYUs7jrFfXAQq0yaqCfLGl0W034kIvesYHAzvuEctjvjafVDnrQLey38Vpw==
X-Received: by 2002:a05:620a:1005:: with SMTP id
 z5mr1207568qkj.26.1580970508910; 
 Wed, 05 Feb 2020 22:28:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id y26sm1201150qtc.94.2020.02.05.22.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 22:28:28 -0800 (PST)
Date: Thu, 6 Feb 2020 01:28:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200206012705-mutt-send-email-mst@kernel.org>
References: <20200204151618.39296-1-stefanha@redhat.com>
 <20200205005605-mutt-send-email-mst@kernel.org>
 <20200205145657.GI58062@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200205145657.GI58062@stefanha-x1.localdomain>
X-MC-Unique: -f209g5eMjiAsr74lYVElw-1
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 02:56:57PM +0000, Stefan Hajnoczi wrote:
> On Wed, Feb 05, 2020 at 01:13:37AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 04, 2020 at 03:16:18PM +0000, Stefan Hajnoczi wrote:
> > > hw/virtio.c checks vq->vring.desc !=3D NULL to see if the vring has b=
een
> > > set up successfully.
> > >=20
> > > When virtio_queue_set_rings() fails due to an invalid vring memory
> > > address it must clear vq->vring.desc (and related fields) so we don't
> > > treat this virtqueue as successfully initialized later on.
> > >=20
> > > This bug was found by device fuzzing and can be triggered as follows:
> > >=20
> > >   $ qemu -M pc -device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,addr=
=3D4.0 \
> > >          -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=3Draw,=
auto-read-only=3Doff \
> > >          -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zer=
oes=3Don,format=3Draw \
> > >          -display none \
> > >          -qtest stdio
> > >   endianness
> > >   outl 0xcf8 0x80002020
> > >   outl 0xcfc 0xe0000000
> > >   outl 0xcf8 0x80002004
> > >   outw 0xcfc 0x7
> > >   write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabf=
fffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cff=
ffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabfffff=
fabffffffabffffffabffffffabffffffabffffffab0000000001
> > >   inb 0x4
> > >   writew 0xe000001c 0x1
> > >   write 0xe0000014 0x1 0x0d
> > >=20
> > > The following error message is produced:
> > >=20
> > >   qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vri=
ng_get_region_caches: Assertion `caches !=3D NULL' failed.
> > >=20
> > > The backtrace looks like this:
> > >=20
> > >   #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
> > >   #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
> > >   #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so=
.6
> > >   #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so=
.6
> > >   #4  0x00005555559073da in vring_get_region_caches (vq=3D<optimized =
out>) at qemu/hw/virtio/virtio.c:286
> > >   #5  vring_get_region_caches (vq=3D<optimized out>) at qemu/hw/virti=
o/virtio.c:283
> > >   #6  0x000055555590818d in vring_used_flags_set_bit (mask=3D1, vq=3D=
0x5555575ceea0) at qemu/hw/virtio/virtio.c:398
> > >   #7  virtio_queue_split_set_notification (enable=3D0, vq=3D0x5555575=
ceea0) at qemu/hw/virtio/virtio.c:398
> > >   #8  virtio_queue_set_notification (vq=3Dvq@entry=3D0x5555575ceea0, =
enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:451
> > >   #9  0x0000555555908512 in virtio_queue_set_notification (vq=3Dvq@en=
try=3D0x5555575ceea0, enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c=
:444
> > >   #10 0x00005555558c697a in virtio_blk_handle_vq (s=3D0x5555575c57e0,=
 vq=3D0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
> > >   #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=3D0x555557=
5ceea0) at qemu/hw/virtio/virtio.c:2244
> > >   #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=3Dctx@entry=3D=
0x55555671a420) at util/aio-posix.c:429
> > >   #13 0x0000555555cb67a8 in aio_dispatch (ctx=3D0x55555671a420) at ut=
il/aio-posix.c:460
> > >   #14 0x0000555555cb307e in aio_ctx_dispatch (source=3D<optimized out=
>, callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c=
:260
> > >   #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libg=
lib-2.0.so.0
> > >   #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:=
219
> > >   #17 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main=
-loop.c:242
> > >   #18 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loo=
p.c:518
> > >   #19 0x00005555559b20c9 in main_loop () at vl.c:1683
> > >   #20 0x0000555555838115 in main (argc=3D<optimized out>, argv=3D<opt=
imized out>, envp=3D<optimized out>) at vl.c:4441
> > >=20
> > > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/virtio/virtio.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 2c5410e981..5d7f619a1e 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev=
, int n, hwaddr desc,
> > >      vdev->vq[n].vring.avail =3D avail;
> > >      vdev->vq[n].vring.used =3D used;
> > >      virtio_init_region_cache(vdev, n);
> > > +    if (vdev->broken) {
> > > +        vdev->vq[n].vring.desc =3D 0;
> > > +        vdev->vq[n].vring.avail =3D 0;
> > > +        vdev->vq[n].vring.used =3D 0;
> > > +    }
> > >  }
> >=20
> > OK but now that you mention it, guest can cause us to call
> > virtio_queue_set_rings at any time.
> > If device was running there's still a window when desc is set
> > but cache isn't.
> >=20
> > Is this an issue?
>=20
> Yes, this is an issue for devices that support iothreads because the
> virtqueue could be processed in the iothread while the vcpu thread
> enters the virtio.c code.
>=20
> > I also worry desc is tested in a way that isn't safe for RCU ...
> >=20
> > Should we convert most/all users to check the presence of region cache?
>=20
> Yes.
>=20
> I suspect there are additional issues because virtio.c doesn't use
> locking, except for vring.caches RCU. :(
>=20
> Stefan

OK so maybe convert checks of desc to checks of vring.caches,
wrapping it up in an API? And I guess virtio_init_region_cache
should return an error status, given it can fail ...

--=20
MST


