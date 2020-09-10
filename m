Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C08C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49E42074B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="m6ENsihf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49E42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGLY1-00037j-Ue
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGLWu-0002Gk-7k; Thu, 10 Sep 2020 08:18:20 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:53448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGLWo-0007xH-O0; Thu, 10 Sep 2020 08:18:18 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C9AE62E14D7;
 Thu, 10 Sep 2020 15:18:04 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 1fZAh1M1ws-I3wWr21i; Thu, 10 Sep 2020 15:18:04 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599740284; bh=VU7W4E9NMFZfNHUyK5DYUhYN+Ntk0a6HIlqhx4vtOp0=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=m6ENsihf7Qe7j+wtRjTUCg2RB1CUWVi5rDBngk3Qqiecc2DUWnCiHSlG87R7EWugQ
 BOAJCUv8boC3TgOkA0bIP/r+B/zIOdJfrt7SVMqMvdlUjGLmF+PDI9B/FoAilblWCk
 A2sNuDnKvBD7iq6fOfdkgHhHybCtw14hVJ4k54kw=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8008::1:e])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 jeEfcVEErX-I3l8m9vx; Thu, 10 Sep 2020 15:18:03 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Thu, 10 Sep 2020 15:18:02 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v4 1/7] vhost: recheck dev state in the
 vhost_migration_log routine
Message-ID: <20200910121802.GA7201@dimastep-nix>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <a1b11c7dcad14542d0f313e3eddd57656dc4a6c8.1599211479.git.dimastep@yandex-team.ru>
 <20200908142520.GC7154@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908142520.GC7154@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:18:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 03:25:20PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 04, 2020 at 12:31:13PM +0300, Dima Stepanov wrote:
> > vhost-user devices can get a disconnect in the middle of the VHOST-USER
> > handshake on the migration start. If disconnect event happened right
> > before sending next VHOST-USER command, then the vhost_dev_set_log()
> > call in the vhost_migration_log() function will return error. This error
> > will lead to the assert() and close the QEMU migration source process.
> > For the vhost-user devices the disconnect event should not break the
> > migration process, because:
> >   - the device will be in the stopped state, so it will not be changed
> >     during migration
> >   - if reconnect will be made the migration log will be reinitialized as
> >     part of reconnect/init process:
> >     #0  vhost_log_global_start (listener=0x563989cf7be0)
> >     at hw/virtio/vhost.c:920
> >     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
> >         as=0x563986ea4340 <address_space_memory>)
> >     at softmmu/memory.c:2664
> >     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
> >         as=0x563986ea4340 <address_space_memory>)
> >     at softmmu/memory.c:2740
> >     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
> >         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
> >         busyloop_timeout=0)
> >     at hw/virtio/vhost.c:1385
> >     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
> >     at hw/block/vhost-user-blk.c:315
> >     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
> >         event=CHR_EVENT_OPENED)
> >     at hw/block/vhost-user-blk.c:379
> > Update the vhost-user-blk device with the internal started_vu field which
> > will be used for initialization (vhost_user_blk_start) and clean up
> > (vhost_user_blk_stop). This additional flag in the VhostUserBlk structure
> > will be used to track whether the device really needs to be stopped and
> > cleaned up on a vhost-user level.
> > The disconnect event will set the overall VHOST device (not vhost-user) to
> > the stopped state, so it can be used by the general vhost_migration_log
> > routine.
> > Such approach could be propogated to the other vhost-user devices, but
> > better idea is just to make the same connect/disconnect code for all the
> > vhost-user devices.
> > 
> > This migration issue was slightly discussed earlier:
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> > 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > ---
> >  hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
> >  hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
> >  include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
> >  3 files changed, 50 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 39aec42..a076b1e 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
> >          error_report("Error starting vhost: %d", -ret);
> >          goto err_guest_notifiers;
> >      }
> > +    s->started_vu = true;
> >  
> >      /* guest_notifier_mask/pending not used yet, so just unmask
> >       * everything here. virtio-pci will do the right thing by
> > @@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> >      int ret;
> >  
> > +    if (!s->started_vu) {
> > +        return;
> > +    }
> > +    s->started_vu = false;
> > +
> >      if (!k->set_guest_notifiers) {
> >          return;
> >      }
> > @@ -341,9 +347,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
> >      }
> >      s->connected = false;
> >  
> > -    if (s->dev.started) {
> > -        vhost_user_blk_stop(vdev);
> > -    }
> > +    vhost_user_blk_stop(vdev);
> >  
> >      vhost_dev_cleanup(&s->dev);
> >  }
> > @@ -399,6 +403,15 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> >                      NULL, NULL, false);
> >              aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> >          }
> > +
> > +        /*
> > +         * Move vhost device to the stopped state. The vhost-user device
> > +         * will be clean up and disconnected in BH. This can be useful in
> > +         * the vhost migration code. If disconnect was caught there is an
> > +         * option for the general vhost code to get the dev state without
> > +         * knowing its type (in this case vhost-user).
> > +         */
> > +        s->dev.started = false;
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:
> 
> Hi Dima,
> Is it possible to move this logic into the vhost_*() API so that all
> devices benefit from it? This seems like a generic vhost-user issue
> rather than a vhost-user-blk issue.
> 
> In other words, it would be great if the vhost APIs in QEMU are designed
> in a way so that the user doesn't need to think about this.
> 
> Stefan

Hi Stefan,

Yes, i also think that it is a right direction, to have some
vhost/vhost-user API here. In this case we will be able to share the
code between all the vhost-user devices, which is important.

We had the same conclusion in this e-mail thread:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06955.html
When we backported the fix from the vhost-user-net device to
vhost-user-blk and also provided some additional logic only for the
vhost-user-blk device.
So my idea is, first fix two issues:
- vhost-user-blk reconnect issue (already merged)
- vhost-user-blk migration issue (this patchset)
After it try to review current implementation, so for example the unix
socket logic could be shared between all the vhost-user devices. Maybe
something else could be done here.

Dima.

