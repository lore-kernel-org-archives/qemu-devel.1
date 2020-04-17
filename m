Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC0C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68252207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="qYk/97v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68252207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPPKN-00039m-FF
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jPPJg-0002fJ-2b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jPPJd-0003RB-6L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:37:51 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:43483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jPPJc-0003Qd-Tp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:37:49 -0400
Received: by mail-ua1-x943.google.com with SMTP id u12so518477uau.10
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A1nUTbTJDpLsdXWiJDMsUwKaYO+iV/1pqpBl1mWlS5I=;
 b=qYk/97v9USSZXOA+AOFfKZidn3mq03ukzWbB7tVH7ZXzYnkaNs6NoyM9EKRIRz/3hB
 ioxgvsC5+vT2owJ+kLYcJMDq+R7eHSNC2NCsboJtcYkB1X5cR0PWDKKQVHhnk+B9ZVz8
 RD4/6h2mWEnc8p8rNc8yBcS0xYCKFPU/Z3sAjdybIKeREunP/n51n1OT/E0BIE2sThlK
 krWsaOx8gWFWw0DfxfigvGIiUYKNxessQ0HH3R7MMyIxFRF7OmnHLhLS1GoSb/6guH94
 9aIE0wadp1slzsO3qYFwuRdtOKsr9dzD4VcPimJ+cmgDgKH/toX9kj+FJ386dv73MgKJ
 4+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A1nUTbTJDpLsdXWiJDMsUwKaYO+iV/1pqpBl1mWlS5I=;
 b=JI0B4tJO1vuashbsJSa/h/5W2t3lbLTc/crRkOeLwJezOtXN0p/GnXSIbgFVG4Tmgs
 ZRTQLisCPtgjnjP6Mb4RUynsmUMRldopoXA9p2Ss1X68x3L/pnFz3nopaFIwf/WkqGT5
 EjVdsm0p/edEohPmNZOWWhhwEtd2RRMwi3oUg8HG0O5JGDLYNqovVMiqVBuPWBM9z4jl
 N1cascCYX/OPJSn6Cp+Up+/jy4JlndahUkGKvLOfiGtRVThDPjjpBxZAx9+PTWC09bI3
 peOwhlfzWdRYV3UCvbe5HdpWUQt8voWMc+TY3AuxPj4YcrWyCr+qiEVaUHCSk9LtwpnY
 Se0g==
X-Gm-Message-State: AGi0PuZJ6uzrZimaUaQy4nhtxSkZgsKkeXzsa/Rd2kfpSui+MbUhzrLS
 pzO1Q/enwhcZzENBo5YsJYyaPHSZBAhdHhsVd4SFOVuFrrl2tpe/fTgl08V6SrcMcbNLhAnFOXK
 VhpWzMn+1WPanYUl5qinrupye
X-Google-Smtp-Source: APiQypK+jRrpbeihkvi6+c39r4jCY+7pjKCN6tL2M83JfvcZ4VV/AOVqWAETJh0qCzXDDOclXz9z/6ZiboXDFFA+nVs=
X-Received: by 2002:ab0:5ad1:: with SMTP id x17mr1919824uae.126.1587123468094; 
 Fri, 17 Apr 2020 04:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200417101707.14467-1-fengli@smartx.com>
 <6d3d5f4b-aa98-7b99-015a-0a3f541e8367@redhat.com>
In-Reply-To: <6d3d5f4b-aa98-7b99-015a-0a3f541e8367@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Fri, 17 Apr 2020 19:37:36 +0800
Message-ID: <CAHckoCw8Z+fz6Wx3_-7rroSUAgMrpLEOa9c2D12hdrHPypmd8w@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-blk: fix invalid memory access
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: Kevin Wolf <kwolf@redhat.com>, lifeng1519@gmail.com,
 Yang Fan <fanyang@smartx.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kyle Zhang <kyle@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nothing changed.
Just separate this patch from those patchset series.

Thanks,
Feng Li

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B44=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:55=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Li,
>
> On 4/17/20 12:17 PM, Li Feng wrote:
> > when s->inflight is freed, vhost_dev_free_inflight may try to access
> > s->inflight->addr, it will retrigger the following issue.
> >
> > =3D=3D7309=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x604001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
> > READ of size 8 at 0x604001020d18 thread T0
> >      #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7=
/qemu-test/hw/virtio/vhost.c:1473
> >      #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/=
hw/virtio/virtio.c:1214
> >      #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
> >      #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
> >      #4 0x5555561d572c in property_set_bool qom/object.c:1925
> >      #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c=
:27
> >      #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
> >      #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-te=
st/qdev-monitor.c:626
>
> Maybe cut <--
>
> >      #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-tes=
t/qdev-monitor.c:806
> >      #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-tes=
t/hmp.c:1951
> >      #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qem=
u-test/monitor.c:3404
> >      #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qem=
u-test/monitor.c:4296
> >      #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
> >      #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test=
/monitor.c:4279
> >      #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
> >      #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.=
so.0+0x4a968)
> >      #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
> >      #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
> >      #18 0x55555640727c in main_loop_wait util/main-loop.c:497
> >      #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl=
.c:2013
> >      #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:47=
76
> >      #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
> >      #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmm=
u/qemu-system-x86_64+0x5e367a)
>
> -->.
>
> >
> > 0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020=
d10,0x604001020d38)
> > freed by thread T0 here:
> >      #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde5=
08)
> >      #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)
> >
> > previously allocated by thread T0 here:
> >      #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xd=
ea88)
> >      #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)
> >
> > SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qe=
mu-test/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
> > Shadow bytes around the buggy address:
> >    0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
> >    0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
> >    0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
> >    0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
> >    0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
> > =3D>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
> >    0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
> >    0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
> >    0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
> >    0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
> >    0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
> > Shadow byte legend (one shadow byte represents 8 application bytes):
> >    Addressable:           00
> >    Partially addressable: 01 02 03 04 05 06 07
> >    Heap left redzone:       fa
> >    Freed heap region:       fd
>
> cut <--
>
> >    Stack left redzone:      f1
> >    Stack mid redzone:       f2
> >    Stack right redzone:     f3
> >    Stack after return:      f5
> >    Stack use after scope:   f8
> >    Global redzone:          f9
> >    Global init order:       f6
> >    Poisoned by user:        f7
> >    Container overflow:      fc
> >    Array cookie:            ac
> >    Intra object redzone:    bb
> >    ASan internal:           fe
> >    Left alloca redzone:     ca
> >    Right alloca redzone:    cb
>
> -->
>
> > =3D=3D7309=3D=3DABORTING
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
>
> What did you change since your previous version Raphael Norwitz already
> reviewed? The patch looks the same...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg696385.html
>
> > ---
> >   hw/block/vhost-user-blk.c | 4 ++++
> >   hw/virtio/vhost.c         | 2 +-
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 776b9af3eb..19e79b96e4 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -463,7 +463,9 @@ reconnect:
> >
> >   virtio_err:
> >       g_free(s->vhost_vqs);
> > +    s->vhost_vqs =3D NULL;
> >       g_free(s->inflight);
> > +    s->inflight =3D NULL;
> >       for (i =3D 0; i < s->num_queues; i++) {
> >           virtio_delete_queue(s->virtqs[i]);
> >       }
> > @@ -484,7 +486,9 @@ static void vhost_user_blk_device_unrealize(DeviceS=
tate *dev, Error **errp)
> >       vhost_dev_cleanup(&s->dev);
> >       vhost_dev_free_inflight(s->inflight);
> >       g_free(s->vhost_vqs);
> > +    s->vhost_vqs =3D NULL;
> >       g_free(s->inflight);
> > +    s->inflight =3D NULL;
> >
> >       for (i =3D 0; i < s->num_queues; i++) {
> >           virtio_delete_queue(s->virtqs[i]);
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 01ebe12f28..aff98a0ede 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_d=
ev *hdev,
> >
> >   void vhost_dev_free_inflight(struct vhost_inflight *inflight)
> >   {
> > -    if (inflight->addr) {
> > +    if (inflight && inflight->addr) {
> >           qemu_memfd_free(inflight->addr, inflight->size, inflight->fd)=
;
> >           inflight->addr =3D NULL;
> >           inflight->fd =3D -1;
> >
>

--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=E6=
=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=BC=
=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=AC=
=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=E5=
=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=E5=
=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=98=
=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.



