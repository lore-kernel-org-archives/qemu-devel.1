Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32637C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F250B206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpH/FkUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F250B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOwG-0003Lt-6a
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPOuf-0001JB-RX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPOue-0004P8-Dt
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:12:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPOue-0004Op-9O
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587121919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJRZW/2iBUgNYLYRb0aSdhaDrjuYsqWXkSjhMT4X9AA=;
 b=TpH/FkUM77qdCdhlyaYXaAF+E1soRKwX6ENfQ/mXPwTqUWUlKIzoEn6NxC3CdNZ7RA8v3M
 MV4DnpLj3bMUolHEv9WKuIhnCk++j7KUUI/5Bcem4EXhXSeoCmHIaCBdeWrVkHARktS3U+
 usmSkkjr/w2ta+otVCrg5G8NvhQbIso=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-F3O22jMxPyeBaRYMYdZGNQ-1; Fri, 17 Apr 2020 07:11:58 -0400
X-MC-Unique: F3O22jMxPyeBaRYMYdZGNQ-1
Received: by mail-wr1-f71.google.com with SMTP id a3so821810wro.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+cbNn/nsx6Lglz6yNMqiGc2TKmbRT028HkLWvE7303Y=;
 b=WzoaXDUfy8U6PKH8JteT0Rveh6d7TKCLLHBqz9JPbMlJUaWI/fsWPTtweLK4h369TY
 SUq783d0GE4QKfr2QTlJg8XWZVoWQqEFaMUBOt210xXVj9Ib05Kb3+OHsnmP1h+hjpj8
 N0i0FJA7FC5hTmSdvpvut6QAu0H+vF29gVbWH6faPCUkdio//qchc5zZ2EZMB4FkyxjF
 1fdCw6KBFpnX3M19ZnTwnJzAeNoo2ell9qbGM26UB+6Tf6kPiAoGKSBoDrdk5+WPyi5p
 DmfqlVG482GfGD/ecBgQbXGclhtsgulr2IEz8WD7MN1BzR9jmnytd2R61oLThE6dTCR9
 Jc8w==
X-Gm-Message-State: AGi0PuYsuCV8BtsAP4UfkABsbEvdVLjlGLpkU8rCf/3bCCHJZHrUYlUp
 lWZs3SkmFZlnUv31xbcY3K/L2GnO1XJ3Rm0euhkGM6N+wXAG6W1YAb/kQfHE4dpmC+SmJ2pDZz4
 Ov86x92Iw87sC1Co=
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr2756789wmk.97.1587121917176;
 Fri, 17 Apr 2020 04:11:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypLPky8L+/y3r355NoJMJ+FXM4XO0I2CSrIdXMguhG/SPcHelN6IPyKXMUKVM3ySrAqNa2C0mQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr2756763wmk.97.1587121916867;
 Fri, 17 Apr 2020 04:11:56 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id y7sm7716676wmb.43.2020.04.17.04.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 04:11:56 -0700 (PDT)
Date: Fri, 17 Apr 2020 07:11:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH] vhost-user-blk: fix invalid memory access
Message-ID: <20200417071117-mutt-send-email-mst@kernel.org>
References: <20200417101707.14467-1-fengli@smartx.com>
MIME-Version: 1.0
In-Reply-To: <20200417101707.14467-1-fengli@smartx.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, lifeng1519@gmail.com, fanyang@smartx.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, peter.maydell@linaro.org,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, kyle@smartx.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 06:17:07PM +0800, Li Feng wrote:
> when s->inflight is freed, vhost_dev_free_inflight may try to access
> s->inflight->addr, it will retrigger the following issue.
>=20
> =3D=3D7309=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x604001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
> READ of size 8 at 0x604001020d18 thread T0
>     #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7/qe=
mu-test/hw/virtio/vhost.c:1473
>     #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/hw/=
virtio/virtio.c:1214
>     #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
>     #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
>     #4 0x5555561d572c in property_set_bool qom/object.c:1925
>     #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c:27
>     #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
>     #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-test/=
qdev-monitor.c:626
>     #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-test/q=
dev-monitor.c:806
>     #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-test/h=
mp.c:1951
>     #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qemu-t=
est/monitor.c:3404
>     #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qemu-t=
est/monitor.c:4296
>     #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
>     #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test/mo=
nitor.c:4279
>     #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
>     #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x4a968)
>     #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
>     #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
>     #18 0x55555640727c in main_loop_wait util/main-loop.c:497
>     #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl.c:=
2013
>     #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:4776
>     #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
>     #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmmu/q=
emu-system-x86_64+0x5e367a)
>=20
> 0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020d1=
0,0x604001020d38)
> freed by thread T0 here:
>     #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde508)
>     #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)
>=20
> previously allocated by thread T0 here:
>     #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xdea8=
8)
>     #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)
>=20
> SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qemu=
-test/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
> Shadow bytes around the buggy address:
>   0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
>   0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
>   0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
>   0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
>   0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
> =3D>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
>   0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
>   0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
>   0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
>   0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
>   0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> =3D=3D7309=3D=3DABORTING
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Pater do you want to pick this up now?
If not I'll pick it up beginning next week ...

> ---
>  hw/block/vhost-user-blk.c | 4 ++++
>  hw/virtio/vhost.c         | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 776b9af3eb..19e79b96e4 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -463,7 +463,9 @@ reconnect:
> =20
>  virtio_err:
>      g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
>      g_free(s->inflight);
> +    s->inflight =3D NULL;
>      for (i =3D 0; i < s->num_queues; i++) {
>          virtio_delete_queue(s->virtqs[i]);
>      }
> @@ -484,7 +486,9 @@ static void vhost_user_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
>      vhost_dev_cleanup(&s->dev);
>      vhost_dev_free_inflight(s->inflight);
>      g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
>      g_free(s->inflight);
> +    s->inflight =3D NULL;
> =20
>      for (i =3D 0; i < s->num_queues; i++) {
>          virtio_delete_queue(s->virtqs[i]);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 01ebe12f28..aff98a0ede 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_dev=
 *hdev,
> =20
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight)
>  {
> -    if (inflight->addr) {
> +    if (inflight && inflight->addr) {
>          qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
>          inflight->addr =3D NULL;
>          inflight->fd =3D -1;
> --=20
> 2.11.0
>=20
>=20
> --=20
> The SmartX email address is only for business purpose. Any sent message=
=20
> that is not related to the business is not authorized or permitted by=20
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>=20


