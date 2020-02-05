Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71762C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347E5217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU0c/VEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347E5217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izDxc-0004s2-Am
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 01:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izDwc-0004TH-SD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izDwZ-0005Wx-NS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:13:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izDwZ-0005MG-CM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580883225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3FD21z2sFz8j6p2yK1HAc060ivpBZ91obFYNfxR33w=;
 b=KU0c/VEFYvjqFE5UJz1ALQnPgRJvJdqYzToWpHVKbJV8SvV/9TLkNuYnhXOXTHhZpPY/Kg
 kdXtxO9DL0n/PPJCwoS+Cfdw6UC+spBmURLO2Sd4Z7P4+qI+pdlLsK5q2zfSxrw/PrgsmS
 EVkaJUIDMM7+CAXmV8hnWrX+b3+P6SM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-S4gZ7-4XOoWDcFKzPmynUQ-1; Wed, 05 Feb 2020 01:13:43 -0500
Received: by mail-qv1-f71.google.com with SMTP id v3so880083qvm.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 22:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TS7tV2R1FNSQkWuPUm7jWSTrLFbVO1YP34tHQ94Q/Mw=;
 b=Wl5r4mZqHHlN4pdloPe6k3Yhq1MAuAfuehS0NXAM30eBHlhmy5IO+SJNZ5xEEB7Q52
 e+bylGvDUd8GTpSwHlKypebWHhi3nh0s0gUqKkLbr5Zkv5PH1z5gukQtmKcrqIh1FhBX
 n7/l7d5q7SnluQUHUXstQnhVZ1YJo0HjJx1JOp3rO1YMfQ+tA/n25Zz1wnNU71XeUac7
 6mlsJfC6zvC+2jwCVukmHjo/3rRlakZDnyIEVZ9pO+zUL4i+MxPXtIv8e2ey8DLB9/Bn
 VDnuNRFLUH3DrcjfUWGTTZSkmikubiuxdTjJz6RczSBT1Xx0dyJqce8sCbq/xPnvRptP
 n16g==
X-Gm-Message-State: APjAAAUmxs51yHe9X+QNw1SxuZzvKeUQzPuBWx8nth5EUstpbw7URIFv
 5KMMMGWf7OYol3jldS56aotCrfBRtrZl1Mbu/amRXR/ZCpErdXiZK9OtSvvPKGaCRLCy/yHzBDt
 M3XVIAj+vd+IknIk=
X-Received: by 2002:ac8:367b:: with SMTP id n56mr32659243qtb.258.1580883222790; 
 Tue, 04 Feb 2020 22:13:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyumtu292cUrDEyVW530qYPumnC3VVNOgFXmVJUfsNpmGqEy+kREdaHoumhZ5gPefzqc4Xynw==
X-Received: by 2002:ac8:367b:: with SMTP id n56mr32659223qtb.258.1580883222501; 
 Tue, 04 Feb 2020 22:13:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id y26sm13747864qtc.94.2020.02.04.22.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 22:13:41 -0800 (PST)
Date: Wed, 5 Feb 2020 01:13:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200205005605-mutt-send-email-mst@kernel.org>
References: <20200204151618.39296-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200204151618.39296-1-stefanha@redhat.com>
X-MC-Unique: S4gZ7-4XOoWDcFKzPmynUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 03:16:18PM +0000, Stefan Hajnoczi wrote:
> hw/virtio.c checks vq->vring.desc !=3D NULL to see if the vring has been
> set up successfully.
>=20
> When virtio_queue_set_rings() fails due to an invalid vring memory
> address it must clear vq->vring.desc (and related fields) so we don't
> treat this virtqueue as successfully initialized later on.
>=20
> This bug was found by device fuzzing and can be triggered as follows:
>=20
>   $ qemu -M pc -device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,addr=3D4.0=
 \
>          -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=3Draw,auto=
-read-only=3Doff \
>          -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=
=3Don,format=3Draw \
>          -display none \
>          -qtest stdio
>   endianness
>   outl 0xcf8 0x80002020
>   outl 0xcfc 0xe0000000
>   outl 0xcf8 0x80002004
>   outw 0xcfc 0x7
>   write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabfffff=
fabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffffff=
abffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabf=
fffffabffffffabffffffabffffffabffffffab0000000001
>   inb 0x4
>   writew 0xe000001c 0x1
>   write 0xe0000014 0x1 0x0d
>=20
> The following error message is produced:
>=20
>   qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring_g=
et_region_caches: Assertion `caches !=3D NULL' failed.
>=20
> The backtrace looks like this:
>=20
>   #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
>   #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
>   #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
>   #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
>   #4  0x00005555559073da in vring_get_region_caches (vq=3D<optimized out>=
) at qemu/hw/virtio/virtio.c:286
>   #5  vring_get_region_caches (vq=3D<optimized out>) at qemu/hw/virtio/vi=
rtio.c:283
>   #6  0x000055555590818d in vring_used_flags_set_bit (mask=3D1, vq=3D0x55=
55575ceea0) at qemu/hw/virtio/virtio.c:398
>   #7  virtio_queue_split_set_notification (enable=3D0, vq=3D0x5555575ceea=
0) at qemu/hw/virtio/virtio.c:398
>   #8  virtio_queue_set_notification (vq=3Dvq@entry=3D0x5555575ceea0, enab=
le=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:451
>   #9  0x0000555555908512 in virtio_queue_set_notification (vq=3Dvq@entry=
=3D0x5555575ceea0, enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:44=
4
>   #10 0x00005555558c697a in virtio_blk_handle_vq (s=3D0x5555575c57e0, vq=
=3D0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
>   #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=3D0x5555575cee=
a0) at qemu/hw/virtio/virtio.c:2244
>   #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=3Dctx@entry=3D0x55=
555671a420) at util/aio-posix.c:429
>   #13 0x0000555555cb67a8 in aio_dispatch (ctx=3D0x55555671a420) at util/a=
io-posix.c:460
>   #14 0x0000555555cb307e in aio_ctx_dispatch (source=3D<optimized out>, c=
allback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:260
>   #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
>   #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:219
>   #17 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loo=
p.c:242
>   #18 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:=
518
>   #19 0x00005555559b20c9 in main_loop () at vl.c:1683
>   #20 0x0000555555838115 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4441
>=20
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2c5410e981..5d7f619a1e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev, in=
t n, hwaddr desc,
>      vdev->vq[n].vring.avail =3D avail;
>      vdev->vq[n].vring.used =3D used;
>      virtio_init_region_cache(vdev, n);
> +    if (vdev->broken) {
> +        vdev->vq[n].vring.desc =3D 0;
> +        vdev->vq[n].vring.avail =3D 0;
> +        vdev->vq[n].vring.used =3D 0;
> +    }
>  }

OK but now that you mention it, guest can cause us to call
virtio_queue_set_rings at any time.
If device was running there's still a window when desc is set
but cache isn't.

Is this an issue?

I also worry desc is tested in a way that isn't safe for RCU ...

Should we convert most/all users to check the presence of region cache?

>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> --=20
> 2.24.1


