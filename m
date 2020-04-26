Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 07:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D97206D4
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 07:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="oaC2vcYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D97206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSbhr-00089c-6b
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 03:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jSbh3-0007UG-Pi
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jSbh2-0000Au-Do
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:27:13 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:46882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jSbh1-0008WV-Rd
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:27:12 -0400
Received: by mail-vk1-xa41.google.com with SMTP id q200so3943609vka.13
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b9tq02PxQwnmLG6+GC/6Wv0n9vdpOvTtw2Rhe8DNX6s=;
 b=oaC2vcYwANP8a+WIhknt/TFlsogrtnAuGBJvutBS2S5l86JYKapROisZ2qo+0pI3B1
 aayUgECW+0KQqzKWUoy6U9F2rgRI1Z7nXGNOuPLTAA78sFYLB6HjmQ88ZAfpGj8wlxro
 /Wb5q/gZH2ZJYqmkvlmmVySqFu4TlxIZSCJxqWCFHRYwHSS+WlpV5U2XPZH3CTD636FE
 YY/vFF4+RhlF/NMcXJhoci6fPL8WpUHA7dBu3bWJbLo9x329qoN/0Akm4dRlGyBtejHn
 3hlFwtzs80i/yXmCA7RhAFSGsJd2PbQTs4i0Jeb7cl9uk28MGKWvwc965EnGPlxvjyPS
 u3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b9tq02PxQwnmLG6+GC/6Wv0n9vdpOvTtw2Rhe8DNX6s=;
 b=dxx6pgb/lfy13MdL08MB+K7Y8PKCeeot3kKVgvFumfTAN1e7vsm4xGRbyZrBxKh+rh
 nm1YS0AH3dBPQx6DiQc9EtwksM/8Q5Nu59x1/VcrpcMy4WEzeoLvJldXs/nKtgyzFYd6
 3sWQxF7D4yc12MGtj+7O3z3WxS5Q4Xn1utONrQ+tPUmW8KQ7mTS/COXomqMB7j++70f3
 NnEzUfz7xykQBbXTO52/XgsuHe1dzzbweqOwuZobS06b7yWYSc/ccSxTuJh6FwhF4peA
 WnvFpQD5dGnS/GH5C8TTzQvT19lKSh18Qzn8HFXnIOw09dfXOtqSSOga9Gvsx39gFzM1
 D0nA==
X-Gm-Message-State: AGi0PuYMDQC91YqnvWgvGN/slZvFHC9VRA1DwqgOHOS/Htm82EUMmIAW
 9eCNKh1h5kHfF27uOgT9LqessPC84h7vZO+V4arIG9VL00j7twwjNH2qQg10KzWHMS3vyPjgPNQ
 KfYZfB0tC2DeYed+NV1gTXyBP
X-Google-Smtp-Source: APiQypJxxPjdWjQXX/gws8ipWjYCBke/Vr+kAfbb2/E6L0X7vD/xa5PJXuGHEuUdohNYWb78YB3nTOxOzLOLfAI6ofc=
X-Received: by 2002:a1f:c1:: with SMTP id 184mr10164812vka.62.1587886029723;
 Sun, 26 Apr 2020 00:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <23b36a73ce1150cc501f436684ca558608de3322.1587667007.git.dimastep@yandex-team.ru>
 <CAJ+F1CJgzqSDnU==Fi4-fQ3Fh97BgEnNd_GZOg8n9i1C4xsOmw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJgzqSDnU==Fi4-fQ3Fh97BgEnNd_GZOg8n9i1C4xsOmw@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Sun, 26 Apr 2020 15:26:58 +0800
Message-ID: <CAHckoCz7ZjKQu6XkFNA9DLH4RMbjGRTpZDAwyiRbUB2_Zw7+NQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/7] char-socket: initialize reconnect timer only
 if close is emitted
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::a41;
 envelope-from=fengli@smartx.com; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::a41
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Gonglei <arei.gonglei@huawei.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is trying to fix the same issue with me.
However, our fix is different.

I think that check the s->reconnect_timer is better.

Thanks,
Feng Li

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2020=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:16=E5=86=99=E9=
=81=93=EF=BC=9A


>
> Hi
>
> On Thu, Apr 23, 2020 at 8:41 PM Dima Stepanov <dimastep@yandex-team.ru> w=
rote:
> >
> > During vhost-user reconnect functionality testing the following assert
> > was hit:
> >   qemu-system-x86_64: chardev/char-socket.c:125:
> >   qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed=
.
> >   Aborted (core dumped)
>
> That looks related to "[PATCH 3/4] char-socket: avoid double call
> tcp_chr_free_connection"
>
> > This is observed only if the connection is closed by the vhost-user-blk
> > daemon during the initialization routine. In this case the
> > tcp_chr_disconnect_locked() routine is called twice. First time it is
> > called in the tcp_chr_write() routine, after getting the SIGPIPE signal=
.
> > Second time it is called when vhost_user_blk_connect() routine return
> > error. In general it looks correct, because the initialization routine
> > can return error in many cases.
> > The tcp_chr_disconnect_locked() routine could be fixed. The timer will
> > be restarted only if the close event is emitted.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  chardev/char-socket.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index c128cca..83ca4d9 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -476,7 +476,7 @@ static void update_disconnected_filename(SocketChar=
dev *s)
> >  static void tcp_chr_disconnect_locked(Chardev *chr)
> >  {
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > -    bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
> > +    bool was_connected =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED=
;
> >
> >      tcp_chr_free_connection(chr);
> >
> > @@ -485,11 +485,11 @@ static void tcp_chr_disconnect_locked(Chardev *ch=
r)
> >                                                chr, NULL, chr->gcontext=
);
> >      }
> >      update_disconnected_filename(s);
> > -    if (emit_close) {
> > +    if (was_connected) {
> >          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> > -    }
> > -    if (s->reconnect_time) {
> > -        qemu_chr_socket_restart_timer(chr);
> > +        if (s->reconnect_time) {
> > +            qemu_chr_socket_restart_timer(chr);
> > +        }
> >      }
> >  }
> >
> > --
> > 2.7.4
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

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



