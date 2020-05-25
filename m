Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F95C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4203206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="JfYCTJtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4203206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8sv-0006yY-6F
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jd8sE-0006OE-CM; Mon, 25 May 2020 04:54:18 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jd8sA-0007uY-Hl; Mon, 25 May 2020 04:54:16 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CD3B62E142F;
 Mon, 25 May 2020 11:54:09 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 yoBAqrYgDS-s62aBUjq; Mon, 25 May 2020 11:54:09 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590396849; bh=djfKV2KYi0Oy3hmBRbMvriEBCYdRbcoMpuxjmdftgjg=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=JfYCTJtIEnK0T6qtsgiaot+IlWxh951sADgU4fXChZqF3CeT15Fn/PXgB7AnyH6bf
 /oXic+z5XmffHrMHBnH/7LlPL3PWATHK3tqbjdKDU2RcfHa2kenyxNfjcInv5j74dq
 ESwuBw/E+lDy1ZxF2QOZmI15GgqcR0gTOz5Rrt+U=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:105::1:6])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 PywxxnupS0-s6Yej4ov; Mon, 25 May 2020 11:54:06 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 25 May 2020 11:54:05 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v3 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
Message-ID: <20200525085354.GA7592@dimastep-nix>
References: <cover.1589989075.git.dimastep@yandex-team.ru>
 <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
 <CAFubqFsqm+xo7uVSi6EfTvFdJ7dLm1+xfr9LvrUZK_nktDdiXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFsqm+xo7uVSi6EfTvFdJ7dLm1+xfr9LvrUZK_nktDdiXA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 04:54:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, dgilbert@redhat.com, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 12:00:10AM -0400, Raphael Norwitz wrote:
> I'm mostly happy with this. A couple comments.
> 
> On Wed, May 20, 2020 at 11:54 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > A socket write during vhost-user communication may trigger a disconnect
> > event, calling vhost_user_blk_disconnect() and clearing all the
> > vhost_dev structures holding data that vhost-user functions expect to
> > remain valid to roll back initialization correctly. Delay the cleanup to
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
> I'd also give credit to Li Feng here - he sent a similar patch:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg02255.html
Yes, thanks for pointing me to it.

> 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  hw/block/vhost-user-blk.c | 49 +++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 43 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9d8c0b3..447fc9c 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -337,11 +337,6 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >
> > -    if (!s->connected) {
> > -        return;
> > -    }
> > -    s->connected = false;
> > -
> >      if (s->dev.started) {
> >          vhost_user_blk_stop(vdev);
> >      }
> > @@ -349,6 +344,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
> >      vhost_dev_cleanup(&s->dev);
> >  }
> >
> > +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> > +
> > +static void vhost_user_blk_chr_closed_bh(void *opaque)
> > +{
> > +    DeviceState *dev = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > +
> > +    vhost_user_blk_disconnect(dev);
> > +    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
> > +            NULL, opaque, NULL, true);
> > +}
> > +
> >  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> >  {
> >      DeviceState *dev = opaque;
> > @@ -363,7 +371,28 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
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
> > +         */
> > +        if (s->connected && runstate_is_running()) {
> > +            AioContext *ctx = qemu_get_current_aio_context();
> > +
> > +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
> > +                    NULL, NULL, false);
> > +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> > +        }
> > +        s->connected = false;
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:
> > @@ -428,6 +457,14 @@ reconnect:
> >
> >      ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> >                                 sizeof(struct virtio_blk_config));
> 
> I find checking s->connected before ret a little confusing. I think we
> should also enforce a reconnect if s->connected is false. AFIK if
> s->connected is false, ret must also be less than 0, but to be safe
> I’d prefer something like:
> 
> if (ret < 0 || !s->connected) {
>     if (!s->connected) {
>         /*
>          * Perform disconnect before making reconnect. More detailed
>          * comment why it was delayed is in the vhost_user_blk_event()
>          * routine.
>          */
>           vhost_user_blk_disconnect(dev);
>     }
>     if (ret < 0) {
>            error_report(“vhost-user-blk: get block config failed”);
>     }
>     goto reconnect;
> }
> 
True. Thanks to Li Feng's patch i understood that i've overcomplicated the
logic. We don't need this disconnect call here at all.
I'll send a smaller reworked patch in this e-mail thread, just to
continue review and discussion.

> > +    if (!s->connected) {
> > +        /*
> > +         * Perform disconnect before making reconnect. More detailed
> > +         * comment why it was delayed is in the vhost_user_blk_event()
> > +         * routine.
> > +         */
> > +        vhost_user_blk_disconnect(dev);
> > +    }
> >      if (ret < 0) {
> >          error_report("vhost-user-blk: get block config failed");
> >          goto reconnect;
> > --
> > 2.7.4
> >
> >

