Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9BC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A8C20838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="PDkGgEvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A8C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWibt-0002LX-Am
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWiYu-00077T-00; Thu, 07 May 2020 11:35:50 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWiYq-000581-6Q; Thu, 07 May 2020 11:35:45 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 281A92E14A2;
 Thu,  7 May 2020 18:35:37 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 LBSBtsIgWp-ZXAW05eQ; Thu, 07 May 2020 18:35:37 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588865737; bh=/5GXJG9eUCdGWb8cYyWbwzOnn6eoGYAZtBOUVc00AVQ=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=PDkGgEvrsgygRkIzarRQL6CUU+hSmV+8zbI8M1FbWqfFqpkF+7YJjXIp/Q0NitOnt
 WPfFBi9qBPu685nRvfnJfV4RzEAdxVSkdK+fUUrLcJJbJwrn0npiIfm5K1zlWDsTuM
 PoZg4VvCWetSlNYh89p9WEamJ2omjDzRpqLK1mjY=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6605::1:1])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 lKluwpfIBe-ZXW8BQZj; Thu, 07 May 2020 18:35:33 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Thu, 7 May 2020 18:35:32 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200507153530.GA6808@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 11:35:37
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 06:08:34PM -0400, Raphael Norwitz wrote:
> As you correctly point out, this code needs to be looked at more
> carefully so that
> if the device does disconnect in the background we can handle the migration path
> gracefully. In particular, we need to decide whether a migration
> should be allowed
> to continue if a device disconnects durning the migration stage.
From what i see from the code it is allowed. At the start of the
hw/virtio/vhost.c:vhost_migration_log() routine there is a check:
    if (!dev->started) {
        dev->log_enabled = enable;
        return 0;
    }
So our changes had the same idea. If device isn't started then 0 can be
returned. Please note, that if we want to return error here then the
following assert will be hit (hw/virtio/vhost.c)
    static void vhost_log_global_start(MemoryListener *listener)
    {
        int r;

        r = vhost_migration_log(listener, true);
        if (r < 0) {
            abort();
        }
    }
But as i mentioned we didn't change this logic, we just propogate it on
the whole migration start process during vhost handshake. After it our
tests passed successfully.

> 
> mst, any thoughts?
> 
> Have you looked at the suggestion I gave Li Feng to move vhost_dev_cleanup()
> into the connection path in vhost-user-blk? I’m not sure if he’s
> actively working on it,
> but I would prefer if we can find a way to keep some state around
> between reconnects
> so we aren’t constantly checking dev->started. A device can be stopped
> for reasons
> other than backend disconnect so I’d rather not reuse this field to
> check for backend
> disconnect failures.
In fact i didn't try to use >started field to signal about disconnect.
What i tried to follow is that if device not started (because of
disconnect or any other reason), there is no need to continue
initialization and we can proceed with the next migration step.

> 
> On Thu, Apr 30, 2020 at 9:57 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > If vhost-user daemon is used as a backend for the vhost device, then we
> > should consider a possibility of disconnect at any moment. If such
> > disconnect happened in the vhost_migration_log() routine the vhost
> > device structure will be clean up.
> > At the start of the vhost_migration_log() function there is a check:
> >   if (!dev->started) {
> >       dev->log_enabled = enable;
> >       return 0;
> >   }
> > To be consistent with this check add the same check after calling the
> > vhost_dev_set_log() routine. This in general help not to break a
> 
> Could you point to the specific asserts which are being triggered?
Just to be clear here. The assert message i mentioned is described
above. I wanted to explain why we followed the "(!dev->started) return 0"
logic. And in this case we didn't return error and return 0.

But the first error we hit during migration testing was SIGSEGV:
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000056354db0a74a in vhost_dev_has_iommu (dev=0x563550562b00)
    at hw/virtio/vhost.c:299
299         return vdev->dma_as != &address_space_memory &&
(gdb) p vdev
$1 = (VirtIODevice *) 0x0
(gdb) bt
#0  0x000056354db0a74a in vhost_dev_has_iommu (dev=0x563550562b00)
    at hw/virtio/vhost.c:299
#1  0x000056354db0bb76 in vhost_dev_set_features (dev=0x563550562b00, enable_log=true)
    at hw/virtio/vhost.c:777
#2  0x000056354db0bc1e in vhost_dev_set_log (dev=0x563550562b00, enable_log=true)
    at hw/virtio/vhost.c:790
    #3  0x000056354db0be58 in vhost_migration_log (listener=0x563550562b08, enable=1)
    at hw/virtio/vhost.c:834
#4  0x000056354db0be9b in vhost_log_global_start (listener=0x563550562b08)
    at hw/virtio/vhost.c:847
#5  0x000056354da72e7e in memory_global_dirty_log_start ()
    at memory.c:2611
...


> 
> > migration due the assert() message. But it looks like that this code
> > should be revised to handle these errors more carefully.
> >
> > In case of vhost-user device backend the fail paths should consider the
> > state of the device. In this case we should skip some function calls
> > during rollback on the error paths, so not to get the NULL dereference
> > errors.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 3ee50c4..d5ab96d 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> >  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >  {
> >      int r, i, idx;
> 
> A couple points here
> 
> 
> (1) This will fail the live migration if the device is disconnected.
> That my be the right thing
>       to do, but if there are cases where migrations can proceed with
> a disconnected device,
>       this may not be desirable.
I'm not sure that it is correct. VM could be migrated successfully
during device daemon disconnect.

> 
> (2) This looks racy. As far as I can tell vhost_dev_set_log() is only
> called by vhost_migration_log(),
>       and as you say one of the first things vhost_migration_log does
> is return if dev->started is not
>       set. What’s to stop a disconnect from clearing the vdev right
> after this check, just before
>       vhost_dev_set_features() is called?
Sorry, but i'm not sure that i've got your point here. We can't stop
disconnect just before vhost_dev_set_features() right now. Or do you
mean that it should be like don't make clean up if device is in the
migration step? Well, it is hard to say. If we can agree that
dev-started logic is correct, then there is no reason for it. But if we
think that this logic is wrong, then yes, we should change smth.

> 
> As stated above, I would prefer it if we could add some state which
> would persist between
> reconnects which could then be checked in the vhost-user code before
> interacting with
> the backend. I understand this will be a much more involved change and
> will require a lot
> of thought.
> 
> Also, regarding (1) above, if the original check in
> vhost_migration_log() returns success if the
> device is not started why return an error here? I imagine this could
> lead to some inconsistent
> behavior if the device disconnects before the first check verses
> before the second.
Yes, i agree with you. That is why i mentioned in the commit message
that maybe this code should be reviewed carefully. On the other side
our changes, as i see it:
  - following the same logic with the device state
  - fix the SIGSEGV error in case of disconnect
  - migration/disconnect test passed successfully
Some words about the test:
  - run src VM with vhost-usr-blk daemon used
  - run fio inside it
  - perform reconnect every X seconds (just kill and restart daemon),
    X is random
  - run dst VM
  - perform migration
  - fio should complete in dst VM
And we cycle this test like forever. SIGSEGV during vhost handshake is
hit once per ~30 tries. By adding an artificial delay in the QEMU source
code we were able to hit this SIGSEGV in 100% of times. After this patch
our test passed successfully.

What do you think?

No other comments mixed in below.

> 
> > +
> > +    if (!dev->started) {
> > +        /*
> > +         * If vhost-user daemon is used as a backend for the
> > +         * device and the connection is broken, then the vhost_dev
> > +         * structure will be reset all its values to 0.
> > +         * Add additional check for the device state.
> > +         */
> > +        return -1;
> > +    }
> > +
> >      r = vhost_dev_set_features(dev, enable_log);
> >      if (r < 0) {
> >          goto err_features;
> > @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >      }

