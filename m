Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB7C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5101206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcFeGICx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5101206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXPy-0008G5-0b
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47026 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jQXPJ-0007qP-Sw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:28:22 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jQXPI-0001fh-Ng
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:28:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43817)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jQXPI-0001ba-AD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:28:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id i10so12405958wrv.10
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X9Ioq958DHujc2j03+CozLrc8dDjH4UldJzusmKP3No=;
 b=CcFeGICx9o77cwTmi9XVPgjOONe4AtH1INSAlHtEszaRz85mJGnkhyp5+zD4NohGpL
 Zqr1tXAxHAc2sXpdAPIx451rS1qxLwdIwaf+7JOwOoo1OcgEuywBDvlXSCmmIhDjzF91
 N+ZX4pAs9G4EhWXOKY9rf8RQ/LUt6yhpjScIC0n6kNHkuNgbrx/MkOvaLAXwzOJp4Uqp
 muzteOqDRpU+cpfDFDHyU0na3AB65o/hDgShsLEVfgCx9d+MerNDpuPi7oLEYZOQaFoJ
 mQJl7yoD8+2u4lt91NeisbkheTXM74SUPjAnCaWOXJmYTlqYienmvVW5nyb+kBtz/rYp
 x2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X9Ioq958DHujc2j03+CozLrc8dDjH4UldJzusmKP3No=;
 b=I6lQJZEHcizH7aCX/kwp1P3PKubmUwBaqfe9qwqg0+DT98olnYu7Y6Ml81BZXOLo2t
 JZCYDYcUw7fW6w7jXzoJjx2XxBJxm9OTfQeoGVZK3Tdn+hGbA83WyBbScawRqyUzuSOf
 qOsPNw+w+538XJaZQvNU7cpU1SGnB9sic/OQM5evIqKEBif0Jts138wI7WLGZb+iVwvk
 iuCVCcVQ4kaKPl0fTw5jps8sdzGmMcgtLE+8LTTfHsiqxIjmC++LGXqgE9wemhEwiFM1
 zMFU0i6dZcaC718eEOABd5NkHt5N5WkZESgCxGDc5qWzcixUmESudlHtsnAjO7hZ8cC9
 CC7Q==
X-Gm-Message-State: AGi0PuYqRS3wMHd2gDTyU5c3HqTxuXQ4/fIBiBoEWZx2m8+bUE5HruVW
 /90ZS+OCUL1qF8IPgvzIzigF38lfAy7g3tJvRf4=
X-Google-Smtp-Source: APiQypLRM2/hJsecLq/wMyIqAumkxaJjqajHnVrmaHC3BwN0bcp1K7LMQ/ChWm2ULoPa5qWQtWdKetR4iPHEoOzg0wc=
X-Received: by 2002:a05:6000:114c:: with SMTP id
 d12mr3965548wrx.381.1587392898145; 
 Mon, 20 Apr 2020 07:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-4-fengli@smartx.com>
 <CAJ+F1C+y-UXH=KARXtTK+aFFb58umRDna_jk2XjHsjDeaxkWYQ@mail.gmail.com>
 <CAHckoCziWv_QBZtoJ8+qBXPD4T4UUZARU5ES9e5ZPcSNAo0UgQ@mail.gmail.com>
In-Reply-To: <CAHckoCziWv_QBZtoJ8+qBXPD4T4UUZARU5ES9e5ZPcSNAo0UgQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Apr 2020 16:28:05 +0200
Message-ID: <CAJ+F1CKjouQiJcNQCd4yYKAy3jdd4jD=vBe39uo-ssrk-p8ZaA@mail.gmail.com>
Subject: Re: [PATCH 3/4] char-socket: avoid double call tcp_chr_free_connection
To: Li Feng <fengli@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Li Feng <lifeng1519@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Fan <fanyang@smartx.com>, Kyle Zhang <kyle@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Apr 20, 2020 at 5:10 AM Li Feng <fengli@smartx.com> wrote:
>
> Hi Lureau,
>
> Thanks for your comment.
> I have spent some time to reproduce this crash, so that delay my
> reply, apologies.
>
> This is the description of this bug using gdb:
> 1. Set break points using gdb;
> b chardev/char-socket.c:410 if s->state =3D=3D TCP_CHARDEV_STATE_DISCONNE=
CTED
> b break vhost_user_write
>
> 2. hotplug a vhost-blk device:
> echo "chardev-add
> socket,id=3Dspdk_vhost_blk2,path=3D/vhost-blk.0,reconnect=3D1 "| nc -U
> /tmp/a.socket
> echo "device_add
> vhost-user-blk-pci,chardev=3Dspdk_vhost_blk2,id=3Dspdk_vhost_blk2,num-que=
ues=3D4"
> | nc -U /tmp/a.socket
>
> 3. Gdb will stop at vhost_user_write, and CTRL-C the vhost target.
> 4. Put 'c' to let gdb continue.
> You will see a crash:
>
> 192 login: qemu-system-x86_64: chardev/char-socket.c:125:
> qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.
>
> The related code:
> 394 static void tcp_chr_free_connection(Chardev *chr)
>  395 {
>  396     SocketChardev *s =3D SOCKET_CHARDEV(chr);
>  397     int i;
>  398
>  399     if (s->read_msgfds_num) {
>  400         for (i =3D 0; i < s->read_msgfds_num; i++) {
>  401             close(s->read_msgfds[i]);
>  402         }
>  403         g_free(s->read_msgfds);
>  404         s->read_msgfds =3D NULL;
>  405         s->read_msgfds_num =3D 0;
>  406     }
>  407
>  408     remove_hup_source(s);
>  409
>  410     tcp_set_msgfds(chr, NULL, 0);
>  411     remove_fd_in_watch(chr);
>  412     object_unref(OBJECT(s->sioc));
>  413     s->sioc =3D NULL;
>  414     object_unref(OBJECT(s->ioc));
>  415     s->ioc =3D NULL;
>  416     g_free(chr->filename);
>  417     chr->filename =3D NULL;
>  418     tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>  419 }
>
> #0  0x0000555555c1aae8 in tcp_chr_free_connection
> (chr=3Dchr@entry=3D0x55555751ee00) at chardev/char-socket.c:410
> #1  0x0000555555c1aec8 in tcp_chr_disconnect_locked
> (chr=3D0x55555751ee00) at chardev/char-socket.c:479
> #2  0x0000555555c1af5d in tcp_chr_disconnect (chr=3D0x55555751ee00) at
> chardev/char-socket.c:497
> #3  0x0000555555c16715 in qemu_chr_fe_set_handlers
> (b=3Db@entry=3D0x5555575f3b48, fd_can_read=3Dfd_can_read@entry=3D0x0,
> fd_read=3Dfd_
> read@entry=3D0x0, fd_event=3Dfd_event@entry=3D0x55555588e740
> <vhost_user_blk_event>, be_change=3Dbe_change@entry=3D0x0, opaque=3Dopaqu=
e@
> entry=3D0x5555575f3990, context=3D0x0, set_open=3Dtrue) at chardev/char-f=
e.c:304
> #4  0x000055555588e5c0 in vhost_user_blk_device_realize
> (dev=3D0x5555575f3990, errp=3D<optimized out>)
>     at /root/qemu-master/hw/block/vhost-user-blk.c:447
> #5  0x00005555558ca478 in virtio_device_realize (dev=3D0x5555575f3990,
> errp=3D0x7fffffffbb90)
>     at /root/qemu-master/hw/virtio/virtio.c:3615
> #6  0x00005555559dc842 in device_set_realized (obj=3D<optimized out>,
> value=3D<optimized out>, errp=3D0x7fffffffbd20)
>     at hw/core/qdev.c:891
> #7  0x0000555555b78e07 in property_set_bool (obj=3D0x5555575f3990,
> v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x555556453
> 040, errp=3D0x7fffffffbd20) at qom/object.c:2238
> #8  0x0000555555b7db3f in object_property_set_qobject
> (obj=3Dobj@entry=3D0x5555575f3990, value=3Dvalue@entry=3D0x555556ab89c0, =
name=3D
> name@entry=3D0x555555d15308 "realized", errp=3Derrp@entry=3D0x7fffffffbd2=
0)
> at qom/qom-qobject.c:26
> #9  0x0000555555b7b2c5 in object_property_set_bool
> (obj=3D0x5555575f3990, value=3D<optimized out>, name=3D0x555555d15308
> "realized
> ", errp=3D0x7fffffffbd20) at qom/object.c:1390
> #10 0x0000555555af13b2 in virtio_pci_realize (pci_dev=3D0x5555575eb800,
> errp=3D0x7fffffffbd20) at hw/virtio/virtio-pci.c:1807
> #11 0x0000555555a7a14b in pci_qdev_realize (qdev=3D<optimized out>,
> errp=3D<optimized out>) at hw/pci/pci.c:2098
> #12 0x00005555559dc842 in device_set_realized (obj=3D<optimized out>,
> value=3D<optimized out>, errp=3D0x7fffffffbef8)
>     at hw/core/qdev.c:891
>
> (gdb) p s
> $23 =3D (SocketChardev *) 0x55555751ee00
> (gdb) p s->state
> $24 =3D TCP_CHARDEV_STATE_DISCONNECTED
>
> At 410 line of char-socket.c, the state has been changed to
> TCP_CHARDEV_STATE_DISCONNECTED before tcp_chr_change_state(s,
> TCP_CHARDEV_STATE_DISCONNECTED);
> It means the tcp_chr_disconnect_locked is called by more than one
> times, and the tcp socket has been freed before.
>
> The crash reason is s->reconnect_timer is set in the previous call of
> tcp_chr_disconnect_locked.
> The another approach fix maybe like this:
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38dda..94957de367 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
> if (emit_close) {
> qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> }
> - if (s->reconnect_time) {
> + if (s->reconnect_time && !s->reconnect_timer) {
> qemu_chr_socket_restart_timer(chr);
> }
> }
>
> The base code is here:
> 474 static void tcp_chr_disconnect_locked(Chardev *chr)
> 475 {
> 476 SocketChardev *s =3D SOCKET_CHARDEV(chr);
> 477 bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
> 478
> 479 tcp_chr_free_connection(chr);
> 480
> 481 if (s->listener) {
> 482 qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
> 483 chr, NULL, chr->gcontext);
> 484 }
> 485 update_disconnected_filename(s);
> 486 if (emit_close) {
> 487 qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> 488 }
> 489 if (s->reconnect_time) {
> 490 qemu_chr_socket_restart_timer(chr);
> 491 }
> 492 }
>
> Which one is better?

+ if (s->reconnect_time && !s->reconnect_timer)

Looks like a good solution to me.

>
> I don't know how to inject an error at socket write when writing tests
> code(tests/test-char.c ).
> Any tips?

You could check the patch I just sent fixing a related issue:
https://patchew.org/QEMU/20200420112012.567284-1-marcandre.lureau@redhat.co=
m/

In your case, it might be as easy as calling qemu_chr_fe_disconnect()
2 times on a reconnect socket, I'll let you figure out.

Thanks!

>
> Thanks,
> Feng Li
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2020=E5=B9=
=B44=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:35=E5=86=99=
=E9=81=93=EF=BC=9A
>
> >
> > Hi
> >
> > On Wed, Apr 15, 2020 at 5:31 AM Li Feng <fengli@smartx.com> wrote:
> > >
> > > double call tcp_chr_free_connection generates a crash.
> > >
> > > Signed-off-by: Li Feng <fengli@smartx.com>
> >
> > Could you describe how you reach the "double call".
> >
> > Even better would be to write a test for it in tests/test-char.c
> >
> > thanks
> >
> > > ---
> > >  chardev/char-socket.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index 185fe38dda..43aab8f24b 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -476,6 +476,11 @@ static void tcp_chr_disconnect_locked(Chardev *c=
hr)
> > >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > >      bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
> > >
> > > +    /* avoid re-enter when socket read/write error and disconnect ev=
ent. */
> > > +    if (s->state =3D=3D TCP_CHARDEV_STATE_DISCONNECTED) {
> > > +        return;
> > > +    }
> > > +
> > >      tcp_chr_free_connection(chr);
> > >
> > >      if (s->listener) {
> > > --
> > > 2.11.0
> > >
> > >
> > > --
> > > The SmartX email address is only for business purpose. Any sent messa=
ge
> > > that is not related to the business is not authorized or permitted by
> > > SmartX.
> > > =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=
=8C=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=
=EF=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=
=9C=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=
=8E=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=
=AA=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=
=E6=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
> > >
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
> --
> The SmartX email address is only for business purpose. Any sent message
> that is not related to the business is not authorized or permitted by
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>
>


--=20
Marc-Andr=C3=A9 Lureau

