Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E64AC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C72B2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xcm2FS7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C72B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1CU-00068K-Hs
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iz1Bp-0005Vh-WD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iz1Bo-0007tY-Md
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:36:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iz1Bo-0007q0-II
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580834199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPln3pKzQwpSG1lyHtwF7dMsNgH+pz1HCgnFaR89h3A=;
 b=Xcm2FS7fhI6L++suTtPVuIdSNAhNkA25FCmuxaXzvNgZtb88N2uDrRJ5PIcCfx46AmWO2a
 T+2h7rA8fdZ3ifyn0xXCI2PTfzpVoSorSG5bBEVTEUo3nP2QiiA3aKTlarxhUINQJQGfF+
 6yLE1fdBDNEziY4b9u9kfI5ATaoER08=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-M84-gTrRPraPH-cYah5Ukg-1; Tue, 04 Feb 2020 11:36:37 -0500
Received: by mail-qt1-f197.google.com with SMTP id o18so12698439qtt.19
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cDWQCQ/S1S7T7k29R7GPnGMp5ZqT3HG8zjx3wtcKAgw=;
 b=MUzrnPTIQxBZVB5etWbtFjGn5eWHQfUTCnFaAk/tsXcOJ+Rr4KUXOb6Gn1myzNvGd8
 AxRpRX2pdv8gpSzHKLMrAl0SlhAxs5j5sm4TYcR/fTNVSCAw3wZAAJnuqnDe5fHYv12N
 BZr5OsEnNnHFtP3EJcr4YVOuERuj2QHjBu25KSBLVXEFCGTpWIS32kCwOf81VdtbPLgt
 J5LLzoaK/frAscTlOT05STQKtPbtb5lTiMFZAwppuM77ghc1aHKeiDBv51E2KavzIsqF
 DrgmxlHzzDDNI58i7tU5ObKLuZxe1iGEcZMlqvHj8unoOtxx0ZZ7fChLLuJbatGEzJhr
 a8Ug==
X-Gm-Message-State: APjAAAVl/dSzRdzqSI0HERPmvX2OdJTkYIkmuUkrXqdSjH6D7Dqgm4qH
 0xnHTtZZxlmWeZrVnLpmPdDvKeTqcsmsCy3NyANUwnXesGm/8sTThWrNsPD0qZGrtjunbiSFG25
 fOlJwJfLaGgBwYSk=
X-Received: by 2002:aed:3f70:: with SMTP id q45mr13415957qtf.310.1580834197071; 
 Tue, 04 Feb 2020 08:36:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo6+jTPka252Lia598Nq8rnFjSLCA698myoTHhZoQRlN9zmQjzKhRVJp2VFKdUzpA+sfjaAA==
X-Received: by 2002:aed:3f70:: with SMTP id q45mr13415934qtf.310.1580834196802; 
 Tue, 04 Feb 2020 08:36:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id n20sm11157669qkk.54.2020.02.04.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:36:36 -0800 (PST)
Date: Tue, 4 Feb 2020 11:36:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200204113625-mutt-send-email-mst@kernel.org>
References: <20200204151618.39296-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200204151618.39296-1-stefanha@redhat.com>
X-MC-Unique: M84-gTrRPraPH-cYah5Ukg-1
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
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

Fixes: ???

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
> =20
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> --=20
> 2.24.1


