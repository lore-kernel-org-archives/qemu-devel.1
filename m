Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A14C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D8B206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="UElX//Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D8B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2Lt-000638-Ch
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jg2L1-0005X8-5h; Tue, 02 Jun 2020 04:31:59 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:36210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jg2Kx-0002Kw-VH; Tue, 02 Jun 2020 04:31:57 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 149572E14E9;
 Tue,  2 Jun 2020 11:31:48 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 RBBMLzJglW-ViIC8I1S; Tue, 02 Jun 2020 11:31:47 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1591086707; bh=yAM+4v6mlK+V8ErYJuqAAMaevf2Gy71iXO4d8oG6LOs=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=UElX//NfD4iNVddzzKYZCfXRO182APodZKS/PQS/hFUUEnlXy26IRirs+FsX0rVWQ
 jNqBP+FsBBwC9hlQh7LwVnvoVp+hVzKEImAyDvvmodwaL6PbiQxAGObQ/2MnWgwoTP
 q1N0ApsEGX6U03dOIrlGHPA0wbjBPLFtvPs3JW0w=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8106::1:10])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 keUmRiPUWq-ViXu7U4Y; Tue, 02 Jun 2020 11:31:44 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 2 Jun 2020 11:31:42 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v4 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
Message-ID: <20200602083142.GA23620@dimastep-nix>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
 <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
 <CAFubqFvOU-ZFnhmCUNGH9gyuwa4us0UNPvZ6QTggDLwUr7y=RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFubqFvOU-ZFnhmCUNGH9gyuwa4us0UNPvZ6QTggDLwUr7y=RA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 30, 2020 at 08:55:30PM -0400, Raphael Norwitz wrote:
> On Thu, May 28, 2020 at 5:13 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
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
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> 
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
> Li Feng - would you also like to sign off here?
Raphael,

Will you take this patchset for merging or what is the next step? )

Thanks, Dima.

> 
> > ---
> >  hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9d8c0b3..76838e7 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -349,6 +349,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
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
> > @@ -363,7 +376,30 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
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
> > +            AioContext *ctx = qemu_get_current_aio_context();
> > +
> > +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
> > +                    NULL, NULL, false);
> > +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> > +        }
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:
> > --
> > 2.7.4
> >
> >

