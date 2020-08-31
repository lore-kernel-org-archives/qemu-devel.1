Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19D120767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="iMYecPpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19D120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCf7o-0000Fz-SK
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kCf72-0007JP-29; Mon, 31 Aug 2020 04:24:24 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:59766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kCf6x-0005CM-GN; Mon, 31 Aug 2020 04:24:22 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0A1BD2E15F8;
 Mon, 31 Aug 2020 11:24:12 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 sb06DzYyyQ-OBwiQWkt; Mon, 31 Aug 2020 11:24:11 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598862251; bh=l3Xae3HgBQ87O8DrK0v6qYneV907Nu3YzzovUHqeOAE=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=iMYecPpz1yRFHyX1vcvsrnl2tbm/kZMc1lapWgCc7pgEppW9n5Ro1e+Q/1B/cPwWF
 ihzvnE+Q1l9sv5Ojb6x3UYYQN4aE7E14ofxrS6ezDRBIgdl+/kWksTAjdsb4ZK791N
 AImer6BzbHQEfcozf/uc+o7sz0uBXweNwZp8rlW4=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:216::1:a])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 UDIrRDQMut-OBlCGaK4; Mon, 31 Aug 2020 11:24:11 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 31 Aug 2020 11:24:09 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: recheck dev state in the
 vhost_migration_log routine
Message-ID: <20200831082400.GA5967@dimastep-nix>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
 <e63c6abf81084026da70990569e570b6b4720977.1598257838.git.dimastep@yandex-team.ru>
 <CAFubqFuE06frhZ3F_pVtWVFY6cQW9rxNGREy9WsEq59JG6Z_FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFuE06frhZ3F_pVtWVFY6cQW9rxNGREy9WsEq59JG6Z_FA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 04:24:12
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 09:44:22PM -0400, Raphael Norwitz wrote:
> Generally I’m happy with this. Some comments:
> 
> On Mon, Aug 24, 2020 at 4:40 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
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
> > Update the vhost-user-blk device with the internal started field which
> > will be used for initialization and clean up. The disconnect event will
> > set the overall VHOST device to the stopped state, so it can be used by
> > the vhost_migration_log routine.
> > Such approach could be propogated to the other vhost-user devices, but
> > better idea is just to make the same connect/disconnect code for all the
> > vhost-user devices.
> >
> > This migration issue was slightly discussed earlier:
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> >
> 
> What you’re doing here on a structural level is adding an additional
> flag “started” to VhostUserBlk to track whether the device really
> needs to be stopped and cleaned up on a vhost level on a disconnect.
> Can you make that more clear in the commit message as you have in the
> comments?
Sounds reasonable, will update the commit message.

> 
> 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
> >  hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
> >  include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
> >  3 files changed, 50 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index a00b854..5573e89 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
> >          error_report("Error starting vhost: %d", -ret);
> >          goto err_guest_notifiers;
> >      }
> > +    s->started = true;
> >
> >      /* guest_notifier_mask/pending not used yet, so just unmask
> >       * everything here. virtio-pci will do the right thing by
> > @@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> >      int ret;
> >
> > +    if (!s->started) {
> > +        return;
> > +    }
> > +    s->started = false;
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
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 1a1384e..ffef7ab 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -861,21 +861,42 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
> >          dev->log_enabled = enable;
> >          return 0;
> >      }
> > +
> > +    r = 0;
> >      if (!enable) {
> >          r = vhost_dev_set_log(dev, false);
> >          if (r < 0) {
> > -            return r;
> > +            goto check_dev_state;
> >          }
> >          vhost_log_put(dev, false);
> >      } else {
> >          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >          r = vhost_dev_set_log(dev, true);
> >          if (r < 0) {
> > -            return r;
> > +            goto check_dev_state;
> >          }
> >      }
> > +
> > +check_dev_state:
> >      dev->log_enabled = enable;
> > -    return 0;
> > +    /*
> > +     * vhost-user-* devices could change their state during log
> > +     * initialization due to disconnect. So check dev state after
> > +     * vhost communication.
> > +     */
> > +    if (!dev->started) {
> > +        /*
> > +         * Since device is in the stopped state, it is okay for
> > +         * migration. Return success.
> > +         */
> > +        r = 0;
> > +    }
> > +    if (r) {
> > +        /* An error is occured. */
> > +        dev->log_enabled = false;
> > +    }
> > +
> > +    return r;
> >  }
> >
> >  static void vhost_log_global_start(MemoryListener *listener)
> > diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> > index 34ad6f0..f4c0754 100644
> > --- a/include/hw/virtio/vhost-user-blk.h
> > +++ b/include/hw/virtio/vhost-user-blk.h
> > @@ -38,7 +38,17 @@ typedef struct VHostUserBlk {
> >      VhostUserState vhost_user;
> >      struct vhost_virtqueue *vhost_vqs;
> >      VirtQueue **virtqs;
> > +
> > +    /*
> > +     * There are at least two steps of initialization of the
> > +     * vhost-user device. The first is a "connect" step and
> > +     * second is a "start" step. Make a separation between
> > +     * those initialization phases by using two fields.
> > +     */
> > +    /* vhost_user_blk_connect/vhost_user_blk_disconnect */
> >      bool connected;
> > +    /* vhost_user_blk_start/vhost_user_blk_stop */
> 
> I don’t like the name “started” for the vhost-user-blk flag because
> it’s easy to get confused with the vhost_dev "started" field, and they
> are used for very different things. Maybe call it “needs_cleanup” or
> “started_internal”, or something to that effect?
Good point. In this case i like the "started_internal" or "started_vu"
just to show that it is only vhost-user start/stop routine flag.

No other comments mixed in below.

> 
> 
> > +    bool started;
> >  } VHostUserBlk;
> >
> >  #endif
> > --
> > 2.7.4
> >
> >

