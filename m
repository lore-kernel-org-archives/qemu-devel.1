Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D77C2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="eTz/vbzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D77C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yhZ-0002Oq-GS
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2ygg-0001kz-It; Tue, 04 Aug 2020 11:17:11 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:44016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2yga-0005MB-UE; Tue, 04 Aug 2020 11:17:09 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B46E82E0997;
 Tue,  4 Aug 2020 18:16:57 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Tgy2S8yVQr-Gqs8P04b; Tue, 04 Aug 2020 18:16:57 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1596554217; bh=KlD+Zp4/5YdyVtvXTjyNlFbYW7s9AyMbfByDFVbm0Z0=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=eTz/vbzPrjvl7yFBZ94epic0dIPGsHhIjADwYr99soi1jGfb+CPeOzI1qVpgl0xog
 tT6lRLJXQ3mErZD4KFBIQvvVEs+EnWpAcydEu24hntMjuffCWOcRyoLJdZWG/qfNan
 f3fKfJeWn5gaU9Z0UbicDc+knuvWDYj4rxT8HmXg=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8202::1:4])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 R2Jvw30SKb-Gpiu08sM; Tue, 04 Aug 2020 18:16:52 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 4 Aug 2020 18:16:50 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <20200804151640.GA21533@dimastep-nix>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
 <20200804101820-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804101820-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 10:19:17AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 04, 2020 at 01:36:45PM +0300, Dima Stepanov wrote:
> > Reference e-mail threads:
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> > 
> > If vhost-user daemon is used as a backend for the vhost device, then we
> > should consider a possibility of disconnect at any moment. There was a general
> > question here: should we consider it as an error or okay state for the vhost-user
> > devices during migration process?
> > I think the disconnect event for the vhost-user devices should not break the
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
> > The first patch in the patchset fixes this issue by setting vhost device to the
> > stopped state in the disconnect handler and check it the vhost_migration_log()
> > routine before returning from the function.
> 
> So I'm a bit confused. Isn't the connected state sufficient for this?
> If not, adding some code comments explaining when is each flag
> set would be helpful.
> Thanks!
Well, not really. The "connected" field is used internally as the flag
in the _connect/_disconnect routines. Because we made oneshot_bh for the
disconnect routine we can't really use it. Also in general the
vhost_log_global_start() routine doesn't know anything about the device
type (in this case vhost-user), so it is not correct to use this
variable here. So what i want to reflect that vhost-user-blk code should
change the state of the device to stopped state and not the general vhost
code should check the connection status. Because of it i've update the general
(struct vhost_dev)->started field with the stopped state. But yes, it is
a good idea to update the comments in include/hw/virtio/vhost-user-blk.h.
Will do it in v2.

> > qtest framework was updated to test vhost-user-blk functionality. The
> > vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> > the original issue found.
> > 
> > Dima Stepanov (7):
> >   vhost: recheck dev state in the vhost_migration_log routine
> >   vhost: check queue state in the vhost_dev_set_log routine
> >   tests/qtest/vhost-user-test: prepare the tests for adding new dev
> >     class
> >   tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> >   tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> >   tests/qtest/vhost-user-test: add migrate_reconnect test
> >   tests/qtest/vhost-user-test: enable the reconnect tests
> > 
> >  hw/block/vhost-user-blk.c          |  13 +-
> >  hw/virtio/vhost.c                  |  39 ++++-
> >  include/hw/virtio/vhost-user-blk.h |   1 +
> >  tests/qtest/libqos/virtio-blk.c    |  14 ++
> >  tests/qtest/vhost-user-test.c      | 291 +++++++++++++++++++++++++++++++------
> >  5 files changed, 311 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.7.4
> 

