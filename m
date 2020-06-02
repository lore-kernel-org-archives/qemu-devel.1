Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D437620671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="go83NRrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxRA-000791-4x
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jfxPd-0005mj-UT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:16:25 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:44681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jfxPb-0005xj-E7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:16:25 -0400
Received: by mail-vs1-xe41.google.com with SMTP id c1so1180975vsc.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MDQP7mTgcCXs1qtC9gQGAE0TFgnUXJJVU7QraOKMJsM=;
 b=go83NRrUaxfKMkoDNgnw691ogUoRU2EmHmYBFJY9MFrNCVUoCenzG4JFuiOaEmf7V8
 +9HXZR856QvwB9pmjdei5lk9uwpkCPT3vIPIFylMPfOg6j8CiZQn254g32Yl46fJxGBr
 bWL92BUL44HbYgED9pgeJsZCYKjEqylj2azwakvBBOCRbeIZ5wlLAeQVCtYIHx2EV+4N
 f6Z6fdNygRFS8vmNJjySDkTi1IEZ62yyBgzzsu1EiRiB6V9op5g82/nxUlArRpDCkxaV
 LmkN56hqlgqyk0Il3G/B5bgAQC8qQaywxGKAhXgk4N3pU0PAIJnyfZ+tcuUbV/Uwhipt
 4nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MDQP7mTgcCXs1qtC9gQGAE0TFgnUXJJVU7QraOKMJsM=;
 b=lBA4V+RiXbPG/06xIastesNXNHQi6VNTTZUYgmpwtCMOfzX0Tdz145FCR5Aef3fBeH
 eAEifwmDlfL75tg7w6fBsGmPbh9Ml/tmkZcdav7wtIJdSSSFZwEpcnjicf4hKjL0G0Ra
 455Mna3Jpn5sWfdLaLAeHzbHq6aGMyRRDd2J5wNGhXW2Wmg9LE7XM+OC3q5HXy6k0DCa
 q5f1qSa9EtcL8re4ILb33Uie2JXOrpit7zyQ7zYHyC1TT+9PIEB7+mpmG1tFjLGstsTh
 JxYafEQlIOsIr9C9S4T8x0U6BUdmn8mWF1Vb6CmbTvpFv5g91JxEFH0R++vBRGI2Qha+
 +zIw==
X-Gm-Message-State: AOAM531xDpKDM8InhPFd24fFX6HJakpmzYfL2+EkPhTCpHBowTQG8Vtb
 d3y9ZGF2JM+oX/gfsJh4iG3nWl3MlUeKHSy42N7s9Q==
X-Google-Smtp-Source: ABdhPJy/nzTkXv6O0QgBMagJK3I+ZT4C0CJ20oufnMwpjyTT6BvIYEQETgoG91zCO8wzMH8nbRafi4Njd9DDNz9O4mA=
X-Received: by 2002:a67:1703:: with SMTP id 3mr17080915vsx.169.1591067780924; 
 Mon, 01 Jun 2020 20:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590396396.git.dimastep@yandex-team.ru>
 <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
 <CAFubqFvOU-ZFnhmCUNGH9gyuwa4us0UNPvZ6QTggDLwUr7y=RA@mail.gmail.com>
In-Reply-To: <CAFubqFvOU-ZFnhmCUNGH9gyuwa4us0UNPvZ6QTggDLwUr7y=RA@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Tue, 2 Jun 2020 11:16:10 +0800
Message-ID: <CAHckoCxjW3Udm0YGdkRGj85b4jz+cvM9HWpbMuWkCrxL8Xv5VA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e41;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Raphael,
I'm sorry. I just end my journey today.

Yes, pls sign off me here.
this patch is nearly the same as my previous patch.

Thanks,
Feng Li

Raphael Norwitz <raphael.s.norwitz@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=
=8831=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=888:55=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, May 28, 2020 at 5:13 AM Dima Stepanov <dimastep@yandex-team.ru> w=
rote:
> >
> > A socket write during vhost-user communication may trigger a disconnect
> > event, calling vhost_user_blk_disconnect() and clearing all the
> > vhost_dev structures holding data that vhost-user functions expect to
> > remain valid to roll back initialization correctly. Delay the cleanup t=
o
> > keep vhost_dev structure valid.
> > There are two possible states to handle:
> > 1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
> > the caller routine.
> > 2. RUN_STATE_RUNNING: delay by using bh
> >
> > BH changes are based on the similar changes for the vhost-user-net
> > device:
> >   commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> >   "vhost-user: delay vhost_user_stop"
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> Li Feng - would you also like to sign off here?
>
> > ---
> >  hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9d8c0b3..76838e7 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -349,6 +349,19 @@ static void vhost_user_blk_disconnect(DeviceState =
*dev)
> >      vhost_dev_cleanup(&s->dev);
> >  }
> >
> > +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> > +
> > +static void vhost_user_blk_chr_closed_bh(void *opaque)
> > +{
> > +    DeviceState *dev =3D opaque;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> > +
> > +    vhost_user_blk_disconnect(dev);
> > +    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_e=
vent,
> > +            NULL, opaque, NULL, true);
> > +}
> > +
> >  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> >  {
> >      DeviceState *dev =3D opaque;
> > @@ -363,7 +376,30 @@ static void vhost_user_blk_event(void *opaque, QEM=
UChrEvent event)
> >          }
> >          break;
> >      case CHR_EVENT_CLOSED:
> > -        vhost_user_blk_disconnect(dev);
> > +        /*
> > +         * A close event may happen during a read/write, but vhost
> > +         * code assumes the vhost_dev remains setup, so delay the
> > +         * stop & clear. There are two possible paths to hit this
> > +         * disconnect event:
> > +         * 1. When VM is in the RUN_STATE_PRELAUNCH state. The
> > +         * vhost_user_blk_device_realize() is a caller.
> > +         * 2. In tha main loop phase after VM start.
> > +         *
> > +         * For p2 the disconnect event will be delayed. We can't
> > +         * do the same for p1, because we are not running the loop
> > +         * at this moment. So just skip this step and perform
> > +         * disconnect in the caller function.
> > +         *
> > +         * TODO: maybe it is a good idea to make the same fix
> > +         * for other vhost-user devices.
> > +         */
> > +        if (runstate_is_running()) {
> > +            AioContext *ctx =3D qemu_get_current_aio_context();
> > +
> > +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NU=
LL,
> > +                    NULL, NULL, false);
> > +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh,=
 opaque);
> > +        }
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:
> > --
> > 2.7.4
> >
> >

