Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D4C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9030B20747
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="IZECPUID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9030B20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUTi-0006jh-NL
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36034 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jQUSJ-00069J-Dc
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:15 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jQUSG-0004Bc-7p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:14 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:42729)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jQUSE-000492-OT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:11 -0400
Received: by mail-vs1-xe44.google.com with SMTP id 1so5674628vsl.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q47NRYUxJeRYSyp/wRGsSTTHK+Zh1uG1zDMIr/20D40=;
 b=IZECPUIDUCQnsX3pTa8hvcXX7dMLlDcmnhWcHx1lRP+WzvepftUBXVQIHY4qXFk58i
 QDjdFHO3L5u9hocVCVCXtmWi9LJQPvz4wxEQrk/0U16TLW7RcjjWWyOmDCL1hZbWv5rU
 wbYPDCwe9s2DvtyK1QY16gywBxgG1fj3POlYWM1+m7Nj2cxa3+tLbTzGozmNnT+n/frK
 MbwJCZ73FleTruIL66mQw1jQ0JDfMvUvgMGiFhXap8CY+2TPcFPWvhUT+sXlqU6wB9nJ
 zIazZdo8tU05hIVZVGkPRxuahcOVWLSW0U+XantuoCiJFu0h+IzUnH58Ov5HRgMibkGb
 FSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q47NRYUxJeRYSyp/wRGsSTTHK+Zh1uG1zDMIr/20D40=;
 b=taAScQuQEZVPev6If23NNTfk9rG21Ijjx04oajwU5hFpKqLDRXSzcgjEI8HWO5NLnU
 s5LdnhGrERUPK+IVN2wDwJVIhHtiumC9hzhkOr4DDYhvRqsKpjQ3SlJXjTYAS+sPKgSD
 86UPqetfsPiAUth6Ax1zuIL3iCYVzyF+OfamAxcZaw4bNgF+vdF2Sea8W9uLeBWRanCs
 EKioPkvz8MSJFVL1N6l8a7HlsVyX3qu7kpgKLhG32QMxWKY/VbslqFH8OKLYpmzqQKkQ
 epfbTZScJk/Oi2QhiYxPTfBZZpl+UYCmNOlk1jLbVpSZKQXRPkN9KR7gZ5t0sTMQUVwQ
 dPKw==
X-Gm-Message-State: AGi0PuZa39q1ajgUtvE3IFbUsBaayd5gdzolUV9SznMhg9+/g+ATv7F1
 k8U5AkcGdTm09zl2Af5ZStf85Ov+apYFNBRlKbR7MsDtOaCZvtoRnT0dGBDjNBshAEx7zVhoBDk
 hdroy1CvaomtDLE2WCLDfJjEp
X-Google-Smtp-Source: APiQypIoAaoSWKTSM3RpL6tKfKTDiJiMH1FP6OWPrgpaRJ5KJKgvV5Dq0bk4pW3mrOVKmrEJc1uLexnWIce5M5Hf/qY=
X-Received: by 2002:a67:d61c:: with SMTP id n28mr11140549vsj.70.1587381548603; 
 Mon, 20 Apr 2020 04:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-2-fengli@smartx.com>
 <20200414012255.GA7710@localhost.localdomain>
In-Reply-To: <20200414012255.GA7710@localhost.localdomain>
From: Li Feng <fengli@smartx.com>
Date: Mon, 20 Apr 2020 19:18:56 +0800
Message-ID: <CAHckoCwqSgvpQA9WUVAVOtCtzSY7UHADh6fBgA+uE6CFHbWCww@mail.gmail.com>
Subject: Re: [PATCH 1/4] vhost-user-blk: delay vhost_user_blk_disconnect
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e44;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::e44
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
Cc: lifeng1519@gmail.com, Yang Fan <fanyang@smartx.com>,
 Kyle Zhang <kyle@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Norwitz =EF=BC=8C
Thanks for your good suggestion.

I got this fix from net/vhost-user.c, it has the same issue with this case.
Your suggestion is a good option.
I'm trying to do some work. but there is another crash issue ...
I need some time to make your idea be workable.

This is the net/vhost-user patch:

commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date: Mon Feb 27 14:49:56 2017 +0400

vhost-user: delay vhost_user_stop

Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
may trigger a disconnect events, calling vhost_user_stop() and clearing
all the vhost_dev strutures holding data that vhost.c functions expect
to remain valid. Delay the cleanup to keep the vhost_dev structure
valid during the vhost.c functions.



Feng Li

Raphael Norwitz <raphael.norwitz@nutanix.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:41=E5=86=99=E9=81=93=
=EF=BC=9A



>
> On Wed, Apr 15, 2020 at 11:28:23AM +0800, Li Feng wrote:
> >
> >      switch (event) {
> >      case CHR_EVENT_OPENED:
> > @@ -363,7 +376,16 @@ static void vhost_user_blk_event(void *opaque, QEM=
UChrEvent event)
> >          }
> >          break;
> >      case CHR_EVENT_CLOSED:
> > -        vhost_user_blk_disconnect(dev);
> > +        /*
> > +         * a close event may happen during a read/write, but vhost
> > +         * code assumes the vhost_dev remains setup, so delay the
> > +         * stop & clear to idle.
> > +         */
> > +        ctx =3D qemu_get_current_aio_context();
> > +
> > +        qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
> > +                                 NULL, NULL, NULL, false);
> > +        aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opa=
que);
>
> This seems a bit racy. What=E2=80=99s to stop the async operation from ex=
ecuting before
> the next read?
>
> If the issue is just that the vhost_dev state is being destroyed too earl=
y, why
> don=E2=80=99t we rather move the vhost_dev_cleanup() call from vhost_user=
_blk_disconnect()
> to vhost_user_blk_connect()? We may need to add some state to tell if thi=
s is the
> first connect or a reconnect so we don=E2=80=99t call vhost_dev_cleanup()=
 on initial
> connect, but as long as we call vhost_dev_cleanup() before vhost_dev_init=
()
> every time the device reconnects it shouldn=E2=80=99t matter that we keep=
 that state
> around.
>
> Thoughts?
>
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:

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



